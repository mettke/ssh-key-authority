use iron::{
    typemap::Key, BeforeMiddleware, Chain, IronResult, Request,
};
use staticfile::Static;
use std::{path::Path, sync::Arc};

pub struct SFiles {
    sfiles: Arc<Static>,
}

impl Key for SFiles {
    type Value = Arc<Static>;
}

impl SFiles {
    pub fn new(sfiles: Static) -> Self {
        Self {
            sfiles: Arc::new(sfiles),
        }
    }

    pub fn setup(chain: &mut Chain) {
        let sfiles =
            Self::new(Static::new(Path::new("./static")));
        chain.link_before(sfiles);
    }
}

impl BeforeMiddleware for SFiles {
    fn before(&self, req: &mut Request) -> IronResult<()> {
        req.extensions.insert::<SFiles>(self.sfiles.clone());
        Ok(())
    }
}
