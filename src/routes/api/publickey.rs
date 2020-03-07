use crate::{
    helper::http::{method_not_allowed, not_found},
    routes::{iter_mimes, route_at, serve_json, serve_plain},
    types::{
        data::{BaseData, PublicKeyData},
        objects::PublicKey,
    },
};
use iron::{
    method::Method,
    mime::{Mime, SubLevel, TopLevel},
    IronResult, Request, Response,
};

pub fn index(req: &mut Request) -> IronResult<Response> {
    match route_at(req, 2) {
        "" => index_method(req),
        v => {
            let v = v.to_string();
            key_method(req, v)
        }
    }
}

pub fn index_method(req: &mut Request) -> IronResult<Response> {
    match &req.method {
        Method::Get => index_get(req),
        _ => method_not_allowed(vec![Method::Get]),
    }
}

fn index_get(req: &mut Request) -> IronResult<Response> {
    for mime in iter_mimes(req) {
        match mime.item {
            Mime(TopLevel::Application, SubLevel::Json, _)
            | Mime(TopLevel::Application, SubLevel::Star, _)
            | Mime(TopLevel::Star, _, _) => {
                return index_get_json(req)
            }
            Mime(TopLevel::Text, SubLevel::Plain, _)
            | Mime(TopLevel::Text, SubLevel::Star, _) => {
                return index_get_text(req)
            }
            _ => {}
        }
    }
    index_get_default(req)
}

fn index_get_default(req: &mut Request) -> IronResult<Response> {
    index_get_json(req)
}

fn index_get_json(req: &mut Request) -> IronResult<Response> {
    let parameters = BaseData::get_parameters(req);
    let values =
        PublicKeyData::fetch_all(req, Some(&parameters))?;
    serve_json(&values.entries)
}

fn index_get_text(req: &mut Request) -> IronResult<Response> {
    let parameters = BaseData::get_parameters(req);
    let values =
        PublicKeyData::fetch_all(req, Some(&parameters))?;
    let plain = values
        .entries
        .iter()
        .map(PublicKey::to_plain)
        .collect::<Vec<String>>()
        .join("\n");
    serve_plain(&plain)
}

pub fn key_method(
    req: &mut Request,
    value: String,
) -> IronResult<Response> {
    match &req.method {
        Method::Get => key_get(req, value),
        _ => method_not_allowed(vec![Method::Get]),
    }
}

fn key_get(
    req: &mut Request,
    value: String,
) -> IronResult<Response> {
    for mime in iter_mimes(req) {
        match mime.item {
            Mime(TopLevel::Application, SubLevel::Json, _)
            | Mime(TopLevel::Application, SubLevel::Star, _)
            | Mime(TopLevel::Star, _, _) => {
                return key_get_json(req, value)
            }
            Mime(TopLevel::Text, SubLevel::Plain, _)
            | Mime(TopLevel::Text, SubLevel::Star, _) => {
                return key_get_text(req, value)
            }
            _ => {}
        }
    }
    key_get_default(req, value)
}

fn key_get_default(
    req: &mut Request,
    value: String,
) -> IronResult<Response> {
    key_get_json(req, value)
}

fn key_get_json(
    req: &mut Request,
    value: String,
) -> IronResult<Response> {
    if let Some(data) = PublicKey::fetch(req, value)? {
        serve_json(&data)
    } else {
        not_found()
    }
}

fn key_get_text(
    req: &mut Request,
    value: String,
) -> IronResult<Response> {
    if let Some(data) = PublicKey::fetch(req, value)? {
        let plain = data.to_plain();
        serve_plain(&plain)
    } else {
        not_found()
    }
}
