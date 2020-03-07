mod publickey;
mod server;

use crate::{helper::check_auth, routes::route_at};
use iron::{status, IronResult, Request, Response};

pub fn index(req: &mut Request) -> IronResult<Response> {
    if let Err(res) = check_auth(req)? {
        return Ok(res);
    }

    #[allow(clippy::map_clone)]
    match route_at(req, 1) {
        "publickeys" => publickey::index(req),
        "servers" => server::index(req),
        _ => Ok(Response::with(status::NotFound)),
    }
}
