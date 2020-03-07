mod callback;
mod oauth;
mod token;

use crate::{
    helper::http::method_not_allowed,
    routes::{redirect_home, route_at},
};
use iron::{
    method::Method, status, IronResult, Request, Response,
};

pub fn index(req: &mut Request) -> IronResult<Response> {
    match route_at(req, 1) {
        "" => index_method(req),
        "callback" => callback::index(req),
        "oauth2" => oauth::index(req),
        "token" => token::index(req),
        _ => Ok(Response::with(status::NotFound)),
    }
}

pub fn index_method(req: &mut Request) -> IronResult<Response> {
    match &req.method {
        Method::Get => redirect_home(req, true),
        _ => method_not_allowed(vec![Method::Get]),
    }
}
