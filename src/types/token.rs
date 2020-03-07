use crate::{middleware::oauth2::OAuth2, types::data::BaseData};
use aes::Aes128;
use block_modes::{block_padding::Pkcs7, BlockMode, Cbc};
use iron::{
    headers::{Authorization, Bearer, SetCookie},
    status, IronError, IronResult, Request,
};
use jsonwebtoken::{
    decode, encode, Algorithm, DecodingKey, EncodingKey, Header,
    Validation,
};
use oauth2::Scope;
use rand::{rngs::OsRng, RngCore};
use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Token {
    pub iss: String,
    pub exp: u64,
    pub username: String,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub scopes: Option<Vec<Scope>>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub groups: Option<Vec<String>>,
}

impl Token {
    pub fn create_token_string(
        req: &Request,
        scopes: Option<&Vec<Scope>>,
        groups: Option<&Vec<String>>,
        username: &str,
        exp: Option<u64>,
    ) -> IronResult<(String, Token)> {
        let client = OAuth2::get_oauth2_client(req);
        // let t_exp = BaseData::get_current_time_and_add(15 * 60);
        // let t_exp =
        //     exp.map_or(t_exp, |v| std::cmp::max(v, t_exp));
        let t_exp = exp.unwrap_or_else(|| {
            BaseData::get_current_time_and_add(15 * 60)
        });
        let token = Token {
            iss: "SSH Key Authority".to_string(),
            exp: t_exp,
            username: username.to_string(),
            scopes: scopes.cloned(),
            groups: groups.cloned(),
        };
        let header = Header::new(Algorithm::HS256);
        let data = encode(
            &header,
            &token,
            &EncodingKey::from_secret(client.oauth_secret),
        )
        .map_err(|err| {
            IronError::new(err, status::InternalServerError)
        })?;
        let data = Self::encrypt(&data, client.oauth_secret)?;
        Ok((data, token))
    }

    fn encrypt(data: &str, key: &[u8]) -> IronResult<String> {
        let mut rng = OsRng::default();
        if key.len() >= 16 {
            let mut iv = [0u8; 16];
            rng.try_fill_bytes(&mut iv).map_err(|err| {
                IronError::new(err, status::InternalServerError)
            })?;
            let cvc: Cbc<Aes128, Pkcs7> =
                Cbc::new_var(&key[..16], &iv).map_err(|err| {
                    IronError::new(
                        err,
                        status::InternalServerError,
                    )
                })?;
            let mut data = cvc.encrypt_vec(data.as_bytes());
            data.extend_from_slice(&iv);
            let data = base64::encode(data);
            Ok(data)
        } else {
            Err(IronError::new(
                failure::err_msg(
                    "OAuth Secret must be at least 128 bit",
                )
                .compat(),
                status::InternalServerError,
            ))
        }
    }

    fn decrypt(data: &str, key: &[u8]) -> IronResult<String> {
        let data =
            base64::decode(data.as_bytes()).map_err(|err| {
                IronError::new(err, status::BadRequest)
            })?;

        if key.len() >= 16 {
            if let (Some(data), Some(iv)) = (
                data.get(..data.len() - 16),
                data.get(data.len() - 16..),
            ) {
                assert_eq!(iv.len(), 16);
                let cvc: Cbc<Aes128, Pkcs7> = Cbc::new_var(
                    &key[..16],
                    iv,
                )
                .map_err(|err| {
                    IronError::new(err, status::BadRequest)
                })?;
                let data =
                    cvc.decrypt_vec(data).map_err(|err| {
                        IronError::new(err, status::BadRequest)
                    })?;
                String::from_utf8(data).map_err(|err| {
                    IronError::new(err, status::BadRequest)
                })
            } else {
                Err(IronError::new(
                    failure::err_msg("Token misaligned").compat(),
                    status::BadRequest,
                ))
            }
        } else {
            Err(IronError::new(
                failure::err_msg(
                    "OAuth Secret must be at least 128 bit",
                )
                .compat(),
                status::InternalServerError,
            ))
        }
    }

    pub fn create_token_cookie(
        req: &Request,
        scopes: Option<&Vec<Scope>>,
        groups: Option<&Vec<String>>,
        username: &str,
        exp: Option<u64>,
    ) -> IronResult<(String, Token)> {
        let (data, token) = Self::create_token_string(
            req, scopes, groups, username, exp,
        )?;
        Ok((
            BaseData::create_cookie(
                req,
                "token",
                &data,
                None,
                None,
                Some("/"),
            ),
            token,
        ))
    }

    pub fn decode_token_cookie(req: &Request) -> Option<Self> {
        BaseData::get_cookie(req, "token=").and_then(|token| {
            Self::decode_token_string(req, token)
        })
    }

    pub fn decode_bearer(req: &Request) -> Option<Self> {
        req.headers.get::<Authorization<Bearer>>().and_then(|a| {
            Self::decode_token_string(req, &a.token)
        })
    }

    fn decode_token_string(
        req: &Request,
        token: &str,
    ) -> Option<Self> {
        let client = OAuth2::get_oauth2_client(req);
        let validation = Validation {
            algorithms: vec![Algorithm::HS256],
            ..Default::default()
        };
        let key = DecodingKey::from_secret(client.oauth_secret);
        Self::decrypt(token, client.oauth_secret)
            .ok()
            .and_then(|token| {
                decode(&token, &key, &validation).ok()
            })
            .map(|token| token.claims)
    }

    pub fn handle_refresh_token(
        req: &Request,
    ) -> Option<(SetCookie, Self)> {
        BaseData::get_cookie(req, "refresh_token=").and_then(
            |refresh_token| {
                let client = OAuth2::get_oauth2_client(req);
                client
                    .get_token_by_refresh_token(
                        refresh_token.to_string(),
                    )
                    .and_then(|new_token| {
                        OAuth2::handle_token(
                            &client, new_token, req,
                        )
                    })
                    .ok()
            },
        )
    }
}
