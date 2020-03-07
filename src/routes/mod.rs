mod api;
mod app;
mod auth;
mod sfiles;

use crate::{helper, types::data::BaseData};
use iron::{
    headers::ContentType,
    headers::{Accept, QualityItem},
    method::Method,
    mime::Mime,
    modifier::Set,
    status, IronError, IronResult, Request, Response,
};
use serde::Serialize;
use std::collections::HashMap;

pub fn request(req: &mut Request) -> IronResult<Response> {
    log::trace!("Handling request: {:?}", req);
    match route_at(req, 0) {
        "" => index_method(req),
        "api" => api::index(req),
        "app" => app::index(req),
        "static" => sfiles::index(req),
        "auth" => auth::index(req),
        _ => Ok(Response::with(status::NotFound)),
    }
}

pub fn index_method(req: &mut Request) -> IronResult<Response> {
    match &req.method {
        Method::Get => redirect_home(req, true),
        _ => helper::http::method_not_allowed(vec![Method::Get]),
    }
}

pub fn redirect_home(
    req: &Request,
    permanent: bool,
) -> IronResult<Response> {
    let res = Response::new();
    helper::http::redirect(req, res, "/app", permanent, true)
}

pub fn route_at<'a>(req: &'a Request, i: usize) -> &'a str {
    req.url.path().get(i).copied().unwrap_or("")
}

pub fn iter_mimes(
    req: &Request,
) -> impl Iterator<Item = QualityItem<Mime>> {
    if let Some(Accept(mimes)) = req.headers.get() {
        let mut mimes = mimes.clone();
        mimes.sort_by(|a, b| b.quality.cmp(&a.quality));
        mimes.into_iter()
    } else {
        vec![].into_iter()
    }
}

pub fn serve_json<T: Serialize>(
    data: &T,
) -> IronResult<Response> {
    let json = serde_json::to_string(&data).map_err(|err| {
        IronError::new(err, status::InternalServerError)
    })?;
    let mut response = Response::with((status::Ok, json));
    response.headers.set(ContentType::json());
    Ok(response)
}

pub fn serve_plain(data: &str) -> IronResult<Response> {
    let mut response = Response::with((status::Ok, data));
    response.headers.set(ContentType::plaintext());
    Ok(response)
}

pub fn serve_html<T: Serialize>(
    template: &str,
    req: &Request,
    sub: &T,
    parameters: Option<HashMap<String, String>>,
) -> IronResult<Response> {
    let mut response = BaseData::create_template(
        template, req, sub, parameters,
    )?;
    response.set_mut(status::Ok);
    response.headers.set(ContentType::html());
    Ok(response)
}
