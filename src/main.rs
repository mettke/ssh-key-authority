#[allow(unused_imports)]
#[macro_use]
extern crate diesel;

mod args;
mod execute;
mod helper;
mod middleware;
mod routes;
mod schema;
mod types;

use crate::{args::get_arguments, execute::execute};

fn main() {
    let args = get_arguments();
    if let Some(log_level) = args.log_level {
        simple_logger::init_with_level(log_level).unwrap();
    }
    execute(&args);
}
