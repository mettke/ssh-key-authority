use crate::{
    middleware::diesel::{
        DBType, DieselPooledConnection, DieselReqExt,
        DieselTypeExt,
    },
    req_db_op,
    schema::{self, public_key, server},
    types::database,
};
use diesel::{QueryDsl, RunQueryDsl};
use iron::{status, IronError, IronResult, Request};
use serde::Serialize;

#[derive(
    Debug, Clone, Hash, Queryable, Identifiable, Serialize,
)]
#[table_name = "public_key"]
#[primary_key(id)]
pub struct PublicKey {
    pub id: i32,
    pub entity_id: i32,
    pub type_: String,
    pub keydata: String,
    pub comment: String,
    pub keysize: Option<i32>,
    pub fingerprint_md5: Option<String>,
    pub fingerprint_sha256: Option<String>,
    pub randomart_md5: Option<String>,
    pub randomart_sha256: Option<String>,
    pub upload_date: chrono::NaiveDateTime,
    pub active: bool,
}

impl PublicKey {
    pub fn to_plain(&self) -> String {
        format!(
            "{} {} {}",
            self.type_, self.keydata, self.comment
        )
    }

    pub fn fetch(
        req: &mut Request,
        id: String,
    ) -> IronResult<Option<Self>> {
        if let Ok(id) = id.parse::<i32>() {
            let publickey_query =
                schema::public_key::dsl::public_key.find(id);
            Ok(Some(req_db_op!(req, publickey_query, first)))
        } else {
            Ok(None)
        }
    }
}

#[derive(Debug, Clone, Queryable, Identifiable, Serialize)]
#[table_name = "server"]
#[primary_key(ip)]
pub struct Server {
    pub ip: i32,
    pub uuid: Option<String>,
    pub hostname: String,
    pub ip_address: Option<String>,
    pub deleted: i32,
    pub key_management: database::KeyManagement,
    pub authorization: database::AuthorizationType,
    pub use_sync_client: database::UseClientSync,
    pub sync_status: database::SyncStatusType,
    pub configuration_system: database::ConfigurationSystem,
    pub custom_keys: database::CustomKeys,
    pub rsa_key_fingerprint: Option<String>,
    pub port: i32,
}

impl Server {
    pub fn fetch(
        req: &mut Request,
        id: String,
    ) -> IronResult<Option<Self>> {
        if let Ok(id) = id.parse::<i32>() {
            let publickey_query =
                schema::server::dsl::server.find(id);
            Ok(Some(req_db_op!(req, publickey_query, first)))
        } else {
            Ok(None)
        }
    }
}
