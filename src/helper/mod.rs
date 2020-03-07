pub mod database;
pub mod handlebars;
pub mod http;

use crate::{
    middleware::auth::Auth,
    types::{data::BaseData, token::Token},
};
use failure::Fail;
use iron::{
    headers::ContentType, modifier::Set, status, url::Url,
    IronError, IronResult, Request, Response,
};
use std::{fs, io::Read, time::SystemTime};

#[allow(dead_code)]
pub fn is_auth(req: &Request) -> bool {
    Auth::get(req).is_some()
}

pub fn check_auth<'a>(
    req: &'a Request,
) -> IronResult<Result<&'a Token, Response>> {
    if let Some(token) = Auth::get(req) {
        Ok(Ok(token))
    } else {
        let mut response =
            BaseData::create_template("login", req, &(), None)?;
        response.headers.set(ContentType::html());
        Ok(Err(response.set(status::Unauthorized)))
    }
}

pub fn read_body_string(req: &mut Request) -> IronResult<String> {
    let body = read_body(req)?;
    String::from_utf8(body).map_err(|err| {
        IronError::new(err.compat(), status::BadRequest)
    })
}

pub fn read_body(req: &mut Request) -> IronResult<Vec<u8>> {
    let mut buffer = [0; 10240];
    req.body.read(&mut buffer).map_err(|err| {
        IronError::new(err.compat(), status::InternalServerError)
    })?;
    let mut buffer = (&buffer).to_vec();
    if let Some(i) = buffer.iter().rposition(|x| *x != 0) {
        let new_len = i + 1;
        buffer.truncate(new_len);
    }
    buffer.shrink_to_fit();
    Ok(buffer)
}

pub fn convert_url(url: &str) -> IronResult<Url> {
    Url::parse(url).map_err(|err| {
        IronError::new(err, status::InternalServerError)
    })
}

pub fn convert_iurl(url: &str) -> IronResult<iron::Url> {
    iron::Url::parse(url).map_err(|err| {
        IronError::new(
            failure::err_msg(err).compat(),
            status::InternalServerError,
        )
    })
}

pub fn get_filetime(file: &str) -> u64 {
    get_filetime_inner(file)
        .map_err(|err| {
            log::error!(
                "Unable to get modification time of {}: {}",
                file,
                err
            );
        })
        .unwrap_or(0)
}

fn get_filetime_inner(
    file: &str,
) -> Result<u64, Box<dyn std::error::Error>> {
    let mtime =
        fs::metadata(format!("./static/{}", file))?.modified()?;
    Ok(mtime.duration_since(SystemTime::UNIX_EPOCH)?.as_secs())
}
