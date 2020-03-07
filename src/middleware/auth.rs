use crate::types::token::Token;
use iron::{
    headers::SetCookie, typemap::Key, AfterMiddleware,
    BeforeMiddleware, IronError, IronResult, Request, Response,
};
use std::sync::Arc;

pub struct Auth {}

impl Key for Auth {
    type Value = Arc<Option<Token>>;
}

pub struct RefreshCookies {}

impl Key for RefreshCookies {
    type Value = SetCookie;
}

impl Auth {
    pub fn new() -> Self {
        Self {}
    }

    pub fn get<'d>(req: &'d Request) -> Option<&'d Token> {
        req.extensions.get::<Auth>().unwrap().as_ref().as_ref()
    }
}

impl BeforeMiddleware for Auth {
    fn before(&self, req: &mut Request) -> IronResult<()> {
        let mut token = Token::decode_token_cookie(req);
        if token.is_none() {
            token = Token::decode_bearer(req);
        }
        if token.is_none() {
            if let Some((cookies, new_token)) =
                Token::handle_refresh_token(req)
            {
                req.extensions.insert::<RefreshCookies>(cookies);
                token = Some(new_token);
            }
        }
        req.extensions.insert::<Auth>(Arc::new(token));
        Ok(())
    }
}

impl AfterMiddleware for Auth {
    fn after(
        &self,
        req: &mut Request,
        mut res: Response,
    ) -> IronResult<Response> {
        setup_response(req, &mut res);
        Ok(res)
    }

    fn catch(
        &self,
        req: &mut Request,
        mut err: IronError,
    ) -> IronResult<Response> {
        setup_response(req, &mut err.response);
        Err(err)
    }
}

fn setup_response(req: &mut Request, res: &mut Response) {
    if let Some(cookies) =
        req.extensions.remove::<RefreshCookies>()
    {
        if let Some(header) = res.headers.get_mut::<SetCookie>() {
            header.0.extend(cookies.0);
        } else {
            res.headers.set(cookies);
        }
    }
}
