use crate::{
    helper::http::{method_not_allowed, not_found},
    routes::{route_at, serve_html},
    types::{
        data::{BaseData, PublicKeyData},
        objects::PublicKey,
    },
};
use iron::{method::Method, IronResult, Request, Response};

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
    let parameters = BaseData::get_parameters(req);
    let data = PublicKeyData::fetch_all(req, Some(&parameters))?;
    serve_html("publickeys", req, &data, Some(parameters))
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
    if let Some(data) = PublicKey::fetch(req, value)? {
        serve_html("publickeys", req, &data, None)
    } else {
        not_found()
    }
}
