use crate::{
    helper::http::method_not_allowed, routes::serve_html,
    types::data::HomeData,
};
use iron::{method::Method, IronResult, Request, Response};

pub fn index(req: &mut Request) -> IronResult<Response> {
    match &req.method {
        Method::Get => index_get(req),
        _ => method_not_allowed(vec![Method::Get]),
    }
}

fn index_get(req: &mut Request) -> IronResult<Response> {
    let data = HomeData::fetch_for(req)?;
    serve_html("home", req, &data, None)
}
