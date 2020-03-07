use crate::{
    helper::http::{method_not_allowed, not_found},
    routes::{iter_mimes, route_at, serve_json},
    types::{
        data::{BaseData, ServerData},
        objects::Server,
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
            server_method(req, v)
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
    let values = ServerData::fetch_all(req, Some(&parameters))?;
    serve_json(&values.entries)
}

pub fn server_method(
    req: &mut Request,
    value: String,
) -> IronResult<Response> {
    match &req.method {
        Method::Get => server_get(req, value),
        _ => method_not_allowed(vec![Method::Get]),
    }
}

fn server_get(
    req: &mut Request,
    value: String,
) -> IronResult<Response> {
    for mime in iter_mimes(req) {
        match mime.item {
            Mime(TopLevel::Application, SubLevel::Json, _)
            | Mime(TopLevel::Application, SubLevel::Star, _)
            | Mime(TopLevel::Star, _, _) => {
                return server_get_json(req, value)
            }
            _ => {}
        }
    }
    server_get_default(req, value)
}

fn server_get_default(
    req: &mut Request,
    value: String,
) -> IronResult<Response> {
    server_get_json(req, value)
}

fn server_get_json(
    req: &mut Request,
    value: String,
) -> IronResult<Response> {
    if let Some(data) = Server::fetch(req, value)? {
        serve_json(&data)
    } else {
        not_found()
    }
}
