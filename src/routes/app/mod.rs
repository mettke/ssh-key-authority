mod home;
mod publickeys;

use crate::{helper::check_auth, routes::route_at};
use iron::{status, IronResult, Request, Response};

pub fn index(req: &mut Request) -> IronResult<Response> {
    if let Err(res) = check_auth(req)? {
        return Ok(res);
    }

    match route_at(req, 1) {
        "" => home::index(req),
        "publickeys" => publickeys::index(req),
        _ => Ok(Response::with(status::NotFound)),
    }
}
