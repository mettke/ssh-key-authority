use crate::{
    helper::http::{method_not_allowed, redirect},
    middleware::oauth2::OAuth2,
};
use iron::{
    headers::SetCookie, method::Method, IronResult, Request,
    Response,
};
use oauth2::CsrfToken;

pub fn index(req: &mut Request) -> IronResult<Response> {
    match &req.method {
        Method::Get => index_get(req),
        _ => method_not_allowed(vec![Method::Get]),
    }
}

fn index_get(req: &mut Request) -> IronResult<Response> {
    let client = OAuth2::get_oauth2_client(req);
    let (auth_url, csrf_token) =
        client.authorize_url(CsrfToken::new_random);

    let mut res = Response::new();
    res = redirect(req, res, auth_url.as_str(), false, false)?;
    res.headers.set(SetCookie(vec![
        client.create_state_token(req, csrf_token)
    ]));
    Ok(res)
}
