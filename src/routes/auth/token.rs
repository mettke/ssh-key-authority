use crate::{
    helper::http::{
        bad_request, get_basic_auth, method_not_allowed,
    },
    middleware::oauth2::OAuth2,
    routes::serve_plain,
    types::token::Token,
};
use iron::{method::Method, IronResult, Request, Response};
use oauth2::{prelude::SecretNewType, TokenResponse};
use serde_json::Value;

pub fn index(req: &mut Request) -> IronResult<Response> {
    match &req.method {
        Method::Get => index_get(req),
        _ => method_not_allowed(vec![Method::Get]),
    }
}

fn index_get(req: &mut Request) -> IronResult<Response> {
    let auth = get_basic_auth(req);
    let client = OAuth2::get_oauth2_client(req);
    match auth {
        Some((username, password)) => {
            let token_result = client.get_token_by_password(
                username.clone(),
                password,
            )?;

            let scopes = token_result.scopes();
            let access_token = token_result.access_token();
            let claims =
                client.validate(access_token.secret())?;
            let exp = claims.get("exp").and_then(Value::as_u64);
            let (data, _) = Token::create_token_string(
                req, scopes, None, &username, exp,
            )?;
            serve_plain(&data)
        }
        _ => bad_request(),
    }
}
