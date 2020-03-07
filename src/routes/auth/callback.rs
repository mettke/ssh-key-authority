use crate::{
    helper::http::{method_not_allowed, redirect},
    middleware::oauth2::OAuth2,
    types::data::BaseData,
};
use iron::{
    method::Method, url::Url, IronResult, Request, Response,
};

pub fn index(req: &mut Request) -> IronResult<Response> {
    match &req.method {
        Method::Get => index_get(req),
        _ => method_not_allowed(vec![Method::Get]),
    }
}

fn index_get(req: &mut Request) -> IronResult<Response> {
    let red_url = req.url.clone();
    let mut red_url: Url = red_url.into();
    red_url.set_fragment(None);
    red_url.set_query(None);

    let parameters = BaseData::get_parameters(req);
    let mut response = Response::new();
    if let (Some(code), Some(state)) =
        (parameters.get("code"), parameters.get("state"))
    {
        let state_cookie = BaseData::get_cookie(req, "state=");
        if Some(&state[..]) == state_cookie {
            let client = OAuth2::get_oauth2_client(req);
            let token_result =
                client.get_token(code.to_string())?;
            let (mut cookies, _) =
                OAuth2::handle_token(client, token_result, req)?;
            cookies.0.push(client.delete_state_token(req));
            response.headers.set(cookies);
            red_url.set_path("/app");
        } else {
            red_url.set_path("/app");
            red_url.set_query(Some("error=2"));
        }
    } else {
        red_url.set_path("/app");
        red_url.set_query(Some("error=1"));
    }
    redirect(req, response, red_url.as_str(), false, false)
}
