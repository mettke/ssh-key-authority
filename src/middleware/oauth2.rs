use crate::{
    helper::convert_url,
    types::{data::BaseData, token::Token},
};
use failure::Fail;
use iron::{
    headers::SetCookie, status, typemap::Key, BeforeMiddleware,
    Chain, IronError, IronResult, Request,
};
use jsonwebtoken::{decode, Algorithm, DecodingKey, Validation};
use oauth2::{
    basic::BasicClient,
    basic::BasicErrorResponseType,
    basic::BasicTokenType,
    prelude::{NewType, SecretNewType},
    AuthUrl, AuthorizationCode, ClientId, ClientSecret,
    CsrfToken, EmptyExtraTokenFields, RedirectUrl, RefreshToken,
    RequestTokenError, ResourceOwnerPassword,
    ResourceOwnerUsername, Scope, StandardTokenResponse,
    TokenResponse, TokenUrl,
};
use serde_json::Value;
use std::{ops::Deref, sync::Arc};

pub struct OAuth2 {
    ioauth: Arc<InnerOAuth2>,
}

pub struct InnerOAuth2 {
    client: BasicClient,
    certificate: &'static [u8],
    pub username: &'static str,
    pub email: &'static str,
    pub oauth_secret: &'static [u8],
}

impl Key for OAuth2 {
    type Value = Arc<InnerOAuth2>;
}

impl OAuth2 {
    #[allow(clippy::too_many_arguments)]
    pub fn new(
        client_id: String,
        client_secret: Option<String>,
        auth_url: &str,
        token_url: &str,
        redirect_url: &str,
        certificate: &'static [u8],
        username: &'static str,
        email: &'static str,
        oauth_secret: &'static [u8],
    ) -> IronResult<Self> {
        let client_secret = client_secret.map(ClientSecret::new);
        let client = BasicClient::new(
            ClientId::new(client_id),
            client_secret,
            AuthUrl::new(convert_url(auth_url)?),
            Some(TokenUrl::new(convert_url(token_url)?)),
        )
        .add_scope(Scope::new("openid".to_string()))
        .add_scope(Scope::new("profile".to_string()))
        .add_scope(Scope::new("email".to_string()))
        .set_redirect_url(RedirectUrl::new(convert_url(
            redirect_url,
        )?));
        Ok(Self {
            ioauth: Arc::new(InnerOAuth2 {
                client,
                certificate,
                username,
                email,
                oauth_secret,
            }),
        })
    }

    pub fn setup(chain: &mut Chain) -> IronResult<()> {
        let client_id = "test_client";
        let secret = "cec217b2-977a-4a26-a75b-d458d4cc03b6";
        let auth_url = "http://localhost:8000/auth/realms/master/protocol/openid-connect/auth";
        let token_url = "http://localhost:8000/auth/realms/master/protocol/openid-connect/token";
        let redirect_url = "http://localhost:8080/auth/callback";
        let certificate = b"-----BEGIN PUBLIC KEY-----MIICmzCCAYMCBgFwuS2vRjANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjAwMzA4MDgwNDAzWhcNMzAwMzA4MDgwNTQzWjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCTDe8odsxyBbUsYsBDKCXQoDpYwV0emHt0MMTLVvG1LjDdJVTXtrwbxeOhE7wM1yagpdxs+FJ4/5RTJHzYKvtciQ6afjNFyFo7qGqc6k9IiFIJ+MQ3TiXF18pEgO7TcdD044MHaM+ZgvA55AEEID/Z/JkIQ/tCyBIQQwIQoyQMxWy992ras3GHvK7vefBc7YQKfPRqYaZ6Ot1c5uuHSvxpDi+YUBw5sJfm9DbPIq9/d/cEE6r2rndj7PT8CMzQpoiQdKME5JXRgCEYOLBNmN7RbBwQDKwm9sCU7PNbc8ALdKUE45/eqABj/kuGs6X2h6JsyfiJbNaSitqFozwH2OGDAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAFs2gPSII//ar4Cd3bp4XPD2j8ZzTbOKXfCFK8z7qtGrpMkEXZ9NR9wPYhL4fnqMTib+pEu+yZDUafLjOXVUXscpvMMPY5pXqgFnw3y5yPSwpJm+JJcXctM+iZVblPsI4XoDAerAcKuFWPMWH7cyKaeLVpnsvcv3js2nS8Yt8tAKoTAAeTNOPZHw+PD0HyNS952glllLYRqLQFzNtolvEfq03G699DMEhpD9zS2Z/5E5sKkF90Srgx2TxXXcVHFc2tAF3iJ85C7YbCQ8o8SchETKGbVVLaYI7DJVPYMHmquIbvk5omUrWu14ZOspu1pQhJR21MXh7EWABVHBkhAY0IU=-----END PUBLIC KEY-----";
        let username = "preferred_username";
        let email = "email";
        let oauth2 = OAuth2::new(
            client_id.to_string(),
            Some(secret.to_string()),
            auth_url,
            token_url,
            redirect_url,
            certificate,
            username,
            email,
            b"rcjmZOZeQbO9Fg5RTcmBoCeiDiMksDZu",
        )?;
        chain.link_before(oauth2);
        Ok(())
    }

    pub fn get_oauth2_client<'d>(
        req: &'d Request,
    ) -> &'d InnerOAuth2 {
        &req.extensions.get::<OAuth2>().unwrap()
    }

    pub fn handle_token(
        client: &InnerOAuth2,
        token_result: StandardTokenResponse<
            EmptyExtraTokenFields,
            BasicTokenType,
        >,
        req: &Request,
    ) -> IronResult<(SetCookie, Token)> {
        let scopes = token_result.scopes();
        let access_token = token_result.access_token();
        let claims = client.validate(access_token.secret())?;
        let a_exp = claims.get("exp").and_then(Value::as_u64);

        let mut cookies = OAuth2::create_token_cookies(
            SetCookie(Vec::with_capacity(4)),
            req,
            &token_result,
        )?;
        let username = claims
            .get(client.username)
            .and_then(|v| v.as_str())
            .ok_or_else(|| {
                IronError::new(
                    failure::err_msg(
                        "Username is missing in Token",
                    )
                    .compat(),
                    status::InternalServerError,
                )
            })?;

        let (token_cookie, token) = Token::create_token_cookie(
            req, scopes, None, username, a_exp,
        )?;
        cookies.0.push(token_cookie);
        Ok((cookies, token))
    }

    fn create_token_cookies(
        mut cookies: SetCookie,
        req: &Request,
        token: &StandardTokenResponse<
            EmptyExtraTokenFields,
            BasicTokenType,
        >,
    ) -> IronResult<SetCookie> {
        let access_token = token.access_token();
        let access_cookie = BaseData::create_cookie(
            req,
            "access_token",
            access_token.secret(),
            None,
            None,
            Some("/"),
        );
        cookies.0.push(access_cookie);

        if let Some(refresh_token) = token.refresh_token() {
            let refresh_cookie = BaseData::create_cookie(
                req,
                "refresh_token",
                refresh_token.secret(),
                None,
                None,
                Some("/"),
            );
            cookies.0.push(refresh_cookie);
        }
        Ok(cookies)
    }
}

impl InnerOAuth2 {
    pub fn get_token(
        &self,
        code: String,
    ) -> IronResult<
        StandardTokenResponse<
            EmptyExtraTokenFields,
            BasicTokenType,
        >,
    > {
        self.client
            .exchange_code(AuthorizationCode::new(code))
            .map_err(|err| {
                IronError::new(
                    err.compat(),
                    status::InternalServerError,
                )
            })
    }

    pub fn get_token_by_refresh_token(
        &self,
        refresh_token: String,
    ) -> IronResult<
        StandardTokenResponse<
            EmptyExtraTokenFields,
            BasicTokenType,
        >,
    > {
        self.client
            .exchange_refresh_token(&RefreshToken::new(
                refresh_token,
            ))
            .map_err(|err| {
                IronError::new(
                    err.compat(),
                    status::InternalServerError,
                )
            })
    }

    pub fn get_token_by_password(
        &self,
        username: String,
        password: String,
    ) -> IronResult<
        StandardTokenResponse<
            EmptyExtraTokenFields,
            BasicTokenType,
        >,
    > {
        self.client
            .exchange_password(
                &ResourceOwnerUsername::new(username),
                &ResourceOwnerPassword::new(password),
            )
            .map_err(|err| {
                match err {
                    RequestTokenError::ServerResponse(ref inner) if inner.error() == &BasicErrorResponseType::InvalidGrant => {
                        IronError::new(
                            err.compat(),
                            status::Unauthorized,
                        )
                    },
                    _ => {
                        IronError::new(
                            err.compat(),
                            status::InternalServerError,
                        )
                    }
                }
            })
    }

    pub fn validate(&self, token: &str) -> IronResult<Value> {
        let validation = Validation {
            algorithms: vec![
                Algorithm::RS256,
                Algorithm::RS384,
                Algorithm::RS512,
            ],
            ..Default::default()
        };
        DecodingKey::from_rsa_pem(self.certificate)
            .and_then(|key| {
                decode::<Value>(token, &key, &validation)
            })
            .map(|token| token.claims)
            .map_err(|err| {
                IronError::new(err, status::InternalServerError)
            })
    }

    pub fn create_state_token(
        &self,
        req: &Request,
        csrf_token: CsrfToken,
    ) -> String {
        BaseData::create_cookie(
            req,
            "state",
            csrf_token.secret(),
            Some(300),
            None,
            Some("/"),
        )
    }

    pub fn delete_state_token(&self, req: &Request) -> String {
        BaseData::delete_cookie(req, "state", Some("/"))
    }
}

impl Deref for InnerOAuth2 {
    type Target = BasicClient;

    fn deref(&self) -> &Self::Target {
        &self.client
    }
}

impl BeforeMiddleware for OAuth2 {
    fn before(&self, req: &mut Request) -> IronResult<()> {
        req.extensions.insert::<OAuth2>(self.ioauth.clone());
        Ok(())
    }
}
