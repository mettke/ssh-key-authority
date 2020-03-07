// https://github.com/iron/logger

use crate::types::data::BaseData;
use iron::{BeforeMiddleware, IronResult, Request};
use std::sync::Arc;

pub struct Base {
    data: Arc<BaseData>,
}

impl Base {
    pub fn new(data: BaseData) -> Self {
        Base {
            data: Arc::new(data),
        }
    }
}

impl BeforeMiddleware for Base {
    fn before(&self, req: &mut Request) -> IronResult<()> {
        req.extensions.insert::<BaseData>(self.data.clone());
        Ok(())
    }
}
