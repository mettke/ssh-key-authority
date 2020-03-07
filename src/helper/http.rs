use crate::helper::convert_iurl;
use iron::{
    headers::{Allow, Authorization, Basic},
    method::Method,
    modifier::Set,
    modifiers::Redirect,
    status,
    url::Url,
    IronResult, Request, Response,
};

pub fn redirect(
    req: &Request,
    mut res: Response,
    url: &str,
    permanent: bool,
    path_only: bool,
) -> IronResult<Response> {
    let mut rurl: Url;
    let url = if path_only {
        let red_url = req.url.clone();
        rurl = red_url.into();
        rurl.set_fragment(None);
        rurl.set_query(None);
        rurl.set_path(url);
        rurl.as_str()
    } else {
        url
    };
    let red_url = convert_iurl(url)?;
    if permanent {
        res.set_mut(status::PermanentRedirect);
    } else {
        res.set_mut(status::TemporaryRedirect);
    }
    Ok(res.set(Redirect(red_url)))
}

pub fn method_not_allowed(
    allowed_methods: Vec<Method>,
) -> IronResult<Response> {
    let mut response = Response::with(status::MethodNotAllowed);
    response.headers.set(Allow(allowed_methods));
    Ok(response)
}

pub fn not_found() -> IronResult<Response> {
    Ok(Response::with(status::NotFound))
}

pub fn bad_request() -> IronResult<Response> {
    Ok(Response::with(status::BadRequest))
}

pub fn get_basic_auth(req: &Request) -> Option<(String, String)> {
    req.headers.get::<Authorization<Basic>>().and_then(|ref a| {
        a.password.clone().map(|p| (a.username.clone(), p))
    })
}
