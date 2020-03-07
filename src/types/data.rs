use crate::{
    helper::read_body_string,
    middleware::diesel::{
        DBType, DieselPooledConnection, DieselReqExt,
        DieselTypeExt,
    },
    req_db_query,
    schema::{
        self,
        public_key::columns::{
            fingerprint_md5, fingerprint_sha256, keysize, type_,
        },
        server::columns::{
            authorization, deleted, hostname, ip_address,
            key_management, rsa_key_fingerprint, sync_status,
        },
    },
    types::{
        database::{
            AuthorizationType, KeyManagement, SyncStatusType,
        },
        objects::{PublicKey, Server},
    },
};
use chrono::{naive::NaiveDateTime, DateTime, Utc};
use diesel::{
    ExpressionMethods, QueryDsl, RunQueryDsl,
    TextExpressionMethods,
};
use handlebars_iron::Template;
use iron::{
    headers::Cookie, modifier::Set, status, typemap::Key,
    IronError, IronResult, Request, Response,
};
use percent_encoding::percent_decode_str;
use serde::Serialize;
use serde_json::{to_value, Value};
use std::{
    collections::HashMap, convert::TryFrom, sync::Arc,
    time::SystemTime,
};

#[derive(Debug, Clone, Serialize)]
pub struct BaseData {
    pub title: String,
    pub style_mtime: u64,
    pub js_mtime: u64,
    pub jsh_mtime: u64,
    pub version: &'static str,
}
impl Key for BaseData {
    type Value = Arc<BaseData>;
}

impl BaseData {
    pub fn create_template<T: Serialize>(
        template: &str,
        req: &Request,
        sub: &T,
        parameters: Option<HashMap<String, String>>,
    ) -> IronResult<Response> {
        let mut resp = Response::new();
        let data = Self::from_req(req, sub, parameters)?;
        resp.set_mut(Template::new(template, data));
        Ok(resp)
    }

    fn from_req<T: Serialize>(
        req: &Request,
        sub: &T,
        parameters: Option<HashMap<String, String>>,
    ) -> IronResult<Value> {
        let data = req.extensions.get::<BaseData>().unwrap();
        Self::to_data(data, sub, parameters)
    }

    fn to_data<T: Serialize>(
        &self,
        sub: &T,
        parameters: Option<HashMap<String, String>>,
    ) -> IronResult<Value> {
        match (
            to_value(self),
            to_value(sub),
            to_value(parameters),
        ) {
            (Ok(mut v1), Ok(v2), Ok(v3)) => {
                if let Some(map) = v1.as_object_mut() {
                    map.insert("sub".into(), v2);
                    map.insert("param".into(), v3);
                }
                Ok(v1)
            }
            (Err(err), _, _)
            | (_, Err(err), _)
            | (_, _, Err(err)) => Err(IronError::new(
                err,
                status::InternalServerError,
            )),
        }
    }

    pub fn get_parameters(
        req: &Request,
    ) -> HashMap<String, String> {
        let mut obj = HashMap::new();
        if let Some(params) = req.url.query() {
            params.split('&').for_each(|kv| {
                Self::parse_key_value(kv, &mut obj);
            });
        }
        obj
    }

    #[allow(dead_code)]
    pub fn parse_x_www_form_urlencoded(
        req: &mut Request,
    ) -> IronResult<HashMap<String, String>> {
        let body = read_body_string(req)?;
        let mut obj = HashMap::new();
        body.split('&').for_each(|kv| {
            Self::parse_key_value(kv, &mut obj);
        });
        Ok(obj)
    }

    pub fn get_cookie<'a>(
        req: &'a Request,
        starts_with: &str,
    ) -> Option<&'a str> {
        req.headers.get::<Cookie>().and_then(|cookies| {
            cookies
                .iter()
                .filter(|cookie| cookie.starts_with(starts_with))
                .filter_map(|cookie| cookie.splitn(2, '=').nth(1))
                .next()
        })
    }

    pub fn get_current_time_and_add(extend: u64) -> u64 {
        SystemTime::now()
            .duration_since(SystemTime::UNIX_EPOCH)
            .unwrap()
            .as_secs()
            + extend
    }

    pub fn convert_to_cookie_time(unix: u64) -> String {
        let time = NaiveDateTime::from_timestamp(unix as i64, 0);
        let dt: DateTime<Utc> = DateTime::from_utc(time, Utc);
        dt.format("%a, %d %b %Y %H:%M:%S GMT").to_string()
    }

    pub fn create_cookie(
        req: &Request,
        name: &str,
        content: &str,
        max_date: Option<u64>,
        expiration: Option<u64>,
        path: Option<&str>,
    ) -> String {
        let secure = if req.url.scheme() == "https" {
            "Secure;"
        } else {
            ""
        };
        let path = path
            .map_or_else(String::new, |v| format!("Path={};", v));
        let max_date = max_date.map_or_else(String::new, |v| {
            format!("Max-Age={};", v)
        });
        let expiration = expiration
            .map(Self::convert_to_cookie_time)
            .map_or_else(String::new, |v| {
                format!("Expires={};", v)
            });
        format!(
            "{}={}; {} {} {} {} HttpOnly; SameSite=Lax;",
            name, content, max_date, expiration, path, secure
        )
    }

    pub fn delete_cookie(
        req: &Request,
        name: &str,
        path: Option<&str>,
    ) -> String {
        let secure = if req.url.scheme() == "https" {
            "Secure;"
        } else {
            ""
        };
        let path = path
            .map_or_else(String::new, |v| format!("Path={};", v));
        format!(
            "{}=; Max-Age=0; {} {} HttpOnly; SameSite=Lax;",
            name, path, secure
        )
    }

    fn parse_key_value(
        key_value: &str,
        obj: &mut HashMap<String, String>,
    ) {
        let mut val = key_value.splitn(2, '=');
        let key = percent_decode_str(val.next().unwrap_or(""))
            .decode_utf8_lossy();
        let value = percent_decode_str(val.next().unwrap_or(""))
            .decode_utf8_lossy();
        obj.insert(key.to_string(), value.to_string());
    }
}

#[derive(Debug, Clone, Serialize)]
pub struct HomeData {
    pub keys: PublicKeyData,
    pub servers: ServerData,
}

impl HomeData {
    pub fn fetch_for(req: &mut Request) -> IronResult<Self> {
        Ok(Self {
            keys: PublicKeyData::fetch_all_for(req, None)?,
            servers: ServerData::fetch_all_admined_by(req, None)?,
        })
    }
}

#[derive(Debug, Clone, Serialize)]
pub struct PublicKeyData {
    pub count: usize,
    pub entries: Vec<PublicKey>,
}

impl PublicKeyData {
    #[allow(clippy::cognitive_complexity)]
    pub fn fetch_all(
        req: &mut Request,
        filter: Option<&HashMap<String, String>>,
    ) -> IronResult<Self> {
        let publickey_query = schema::public_key::dsl::public_key;
        let values: Vec<PublicKey> = req_db_query!(req, publickey_query, load, bquery {
            if let Some(filter) = filter {
                if let Some(fp) = filter.get("fingerprint") {
                    if !fp.is_empty() {
                        bquery = bquery.filter(fingerprint_md5.eq(fp));
                        bquery = bquery.or_filter(fingerprint_sha256.eq(fp));
                    }
                }
                if let Some(ty) = filter.get("type") {
                    if !ty.is_empty() {
                        bquery = bquery.filter(type_.eq(ty));
                    }
                }
                if let Some(km) = filter.get("keysize-min") {
                    if let Ok(km) = km.parse::<i32>() {
                        bquery = bquery.filter(keysize.ge(km));
                    }
                }
                if let Some(km) = filter.get("keysize-max") {
                    if let Ok(km) = km.parse::<i32>() {
                        bquery = bquery.filter(keysize.le(km));
                    }
                }
            }
        });
        Ok(Self {
            count: values.len(),
            entries: values,
        })
    }

    pub fn fetch_all_for(
        req: &mut Request,
        filter: Option<&HashMap<String, String>>,
    ) -> IronResult<Self> {
        // ToDo: Fetch only keys for current user
        Self::fetch_all(req, filter)
    }
}

#[derive(Debug, Clone, Serialize)]
pub struct ServerData {
    pub count: usize,
    pub entries: Vec<Server>,
}

impl ServerData {
    #[allow(clippy::cognitive_complexity)]
    pub fn fetch_all(
        req: &mut Request,
        filter: Option<&HashMap<String, String>>,
    ) -> IronResult<Self> {
        let server_query =
            schema::server::dsl::server.filter(deleted.eq(0));
        let values: Vec<Server> = req_db_query!(req, server_query, load, bquery {
            if let Some(filter) = filter {
                if let Some(value) = filter.get("hostname") {
                    if !value.is_empty() {
                        bquery = bquery.filter(hostname.like(value));
                    }
                }
                if let Some(value) = filter.get("ip_address") {
                    if !value.is_empty() {
                        bquery = bquery.filter(ip_address.eq(value));
                    }
                }
                if let Some(value) = filter.get("rsa_key_fingerprint") {
                    if !value.is_empty() {
                        bquery = bquery.filter(rsa_key_fingerprint.eq(value));
                    }
                }
                if let Some(value) = filter.get("authorization") {
                    let values = value.split(';')
                        .filter(|s| s.is_empty())
                        .filter_map(|v| {
                            AuthorizationType::try_from(v).ok()
                        })
                        .collect::<Vec<AuthorizationType>>();
                    if !values.is_empty() {
                        bquery = bquery.filter(authorization.eq_any(values));
                    }
                }
                if let Some(value) = filter.get("key_management") {
                    let values = value.split(';')
                        .filter(|s| s.is_empty())
                        .filter_map(|v| {
                            KeyManagement::try_from(v).ok()
                        })
                        .collect::<Vec<KeyManagement>>();
                    if !value.is_empty() {
                        bquery = bquery.filter(key_management.eq_any(values));
                    }
                }
                if let Some(value) = filter.get("sync_status") {
                    let values = value.split(';')
                        .filter(|s| s.is_empty())
                        .filter_map(|v| {
                            SyncStatusType::try_from(v).ok()
                        })
                        .collect::<Vec<SyncStatusType>>();
                    if !value.is_empty() {
                        bquery = bquery.filter(sync_status.eq_any(values));
                    }
                }
            }
        });
        Ok(Self {
            count: values.len(),
            entries: values,
        })
    }

    #[allow(dead_code)]
    pub fn fetch_all_for(
        req: &mut Request,
        filter: Option<&HashMap<String, String>>,
    ) -> IronResult<Self> {
        // ToDo: Fetch only servers for current user
        Self::fetch_all(req, filter)
    }

    pub fn fetch_all_admined_by(
        req: &mut Request,
        filter: Option<&HashMap<String, String>>,
    ) -> IronResult<Self> {
        // ToDo: Fetch only servers current user is admin for
        Self::fetch_all(req, filter)
    }
}
