// https://github.com/iron/logger

use iron::{
    headers, status::Status, typemap::Key, AfterMiddleware,
    BeforeMiddleware, IronError, IronResult, Request, Response,
};
use time::OffsetDateTime;

pub struct Logger;

impl Logger {
    pub fn new() -> (Logger, Logger) {
        (Logger {}, Logger {})
    }
}

struct StartTime;
impl Key for StartTime {
    type Value = OffsetDateTime;
}

impl Logger {
    fn initialise(&self, req: &mut Request) {
        req.extensions.insert::<StartTime>(OffsetDateTime::now());
    }

    fn log(
        &self,
        req: &mut Request,
        res: &Response,
    ) -> IronResult<()> {
        let entry_time =
            *req.extensions.get::<StartTime>().unwrap();

        let response_time = OffsetDateTime::now() - entry_time;
        let response_time_ms = (response_time.whole_seconds()
            * 1000) as f64
            + (response_time.whole_nanoseconds() as f64)
                / 1_000_000.0;
        log::info!(
            "{} - {} [{}] \"{} {} {}\" {} {} \"{}\" \"{}\" ({} ms)",
            req.remote_addr.ip(),
            req.url.username().unwrap_or_else(|| "-"),
            entry_time
                .format("%Y-%m-%dT%H:%M:%SZ%z"),
            req.method,
            req.url,
            req.version,
            res.status
                .map(|c| c.to_u16().to_string())
                .unwrap_or_else(|| String::from("-")),
            req.headers
                .get::<headers::ContentLength>()
                .map(|l| l.0.to_string())
                .unwrap_or_else(|| String::from("-")),
            req.headers
                .get::<headers::Referer>()
                .map(|l| l.0.clone())
                .unwrap_or_else(|| String::from("-")),
            req.headers
                .get::<headers::UserAgent>()
                .map(|l| l.0.clone())
                .unwrap_or_else(|| String::from("-")),
            response_time_ms,
        );
        log::trace!("Responding with: {:?}", res);

        Ok(())
    }
}

impl BeforeMiddleware for Logger {
    fn before(&self, req: &mut Request) -> IronResult<()> {
        self.initialise(req);
        Ok(())
    }

    fn catch(
        &self,
        req: &mut Request,
        err: IronError,
    ) -> IronResult<()> {
        self.initialise(req);
        Err(err)
    }
}

impl AfterMiddleware for Logger {
    fn after(
        &self,
        req: &mut Request,
        res: Response,
    ) -> IronResult<Response> {
        self.log(req, &res)?;
        Ok(res)
    }

    fn catch(
        &self,
        req: &mut Request,
        err: IronError,
    ) -> IronResult<Response> {
        let status = err
            .response
            .status
            .as_ref()
            .map(Status::is_server_error);
        if status.is_none() || status == Some(true) {
            log::error!(
                "Catched Internal Server Error: {}",
                err.error
            );
        } else {
            log::warn!("Catched Warning: {}", err.error);
        }
        self.log(req, &err.response)?;
        Err(err)
    }
}
