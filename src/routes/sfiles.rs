use crate::{
    helper::http::not_found, middleware::sfiles::SFiles,
};
use iron::{
    headers::{CacheControl, CacheDirective},
    middleware::Handler,
    IronResult, Request, Response,
};

pub fn index(req: &mut Request) -> IronResult<Response> {
    let path = req.url.path()[1..].join("/");
    req.url.as_mut().set_path(&path);

    let sfiles = req.extensions.remove::<SFiles>().unwrap();
    let mut res = sfiles.handle(req).or_else(|_| not_found());

    if let Ok(ref mut res) = res {
        res.headers.set(CacheControl(vec![
            CacheDirective::Public,
            CacheDirective::MaxAge(60 * 60 * 24),
        ]));
    }
    res
}
