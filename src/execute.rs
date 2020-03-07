use crate::{
    args::CliArguments,
    helper::{
        get_filetime,
        handlebars::{transform_mgmnt, transform_sync},
    },
    middleware::{
        auth::Auth,
        base::Base,
        diesel::{DBType, DieselMiddleware, DieselPool},
        logger::Logger,
        oauth2::OAuth2,
        sfiles::SFiles,
    },
    routes::request,
    types::data::BaseData,
};
use clokwerk::{ScheduleHandle, Scheduler, TimeUnits};
use handlebars_iron::{DirectorySource, HandlebarsEngine};
use iron::{Chain, Iron};
use std::{process::exit, time::Duration};

#[cfg(feature = "watch")]
use handlebars_iron::Watchable;
#[cfg(feature = "watch")]
use std::sync::Arc;

pub fn execute(args: &CliArguments) {
    let mut chain = Chain::new(request);
    let (logger_before, logger_after) = Logger::new();

    chain.link_before(logger_before);
    let scheduler = setup_diesel_and_schedular(&args, &mut chain);
    setup_handlebars(&mut chain);
    SFiles::setup(&mut chain);
    if let Err(err) = OAuth2::setup(&mut chain) {
        log::error!("Unable to start Server: {}", err);
        std::process::exit(1);
    }
    chain.link_before(Auth::new());
    chain.link_after(Auth::new());
    chain.link_after(logger_after);

    log::info!(
        "Starting server on {}:{}",
        args.listen,
        args.port
    );
    if let Err(err) = Iron::new(chain)
        .http(format!("{}:{}", args.listen, args.port))
    {
        log::error!("Unable to start Server: {}", err);
    }
    scheduler.stop();
}

fn setup_diesel_and_schedular(
    args: &CliArguments,
    chain: &mut Chain,
) -> ScheduleHandle {
    let url = format!(
        "{}://{}:{}@{}:{}/{}",
        args.db_type,
        args.db_user,
        args.db_pass,
        args.db_host,
        args.db_port,
        args.db_name
    );
    match args.db_type {
        DBType::POSTGRES => {
            let conn = create_database_connection::<
                diesel::pg::PgConnection,
            >(&url, args.db_type);
            let pool = conn.pool.clone();
            chain.link_before(conn);
            setup_scheduler(args, pool, args.db_type)
        }
        DBType::MYSQL => {
            let conn = create_database_connection::<
                diesel::mysql::MysqlConnection,
            >(&url, args.db_type);
            let pool = conn.pool.clone();
            chain.link_before(conn);
            setup_scheduler(args, pool, args.db_type)
        }
        DBType::SQLITE => {
            let conn = create_database_connection::<
                diesel::sqlite::SqliteConnection,
            >(&args.db_path, args.db_type);
            let pool = conn.pool.clone();
            chain.link_before(conn);
            setup_scheduler(args, pool, args.db_type)
        }
    }
}

fn create_database_connection<T: diesel::Connection>(
    url: &str,
    db_type: DBType,
) -> DieselMiddleware<T> {
    match DieselMiddleware::new(url, db_type) {
        Err(err) => {
            log::error!("Unable to connect to database: {}", err);
            exit(4);
        }
        Ok(dm) => dm,
    }
}

fn setup_scheduler<T: 'static + diesel::Connection>(
    _args: &CliArguments,
    _db_pool: DieselPool<T>,
    _db_type: DBType,
) -> ScheduleHandle {
    let mut scheduler = Scheduler::new();
    scheduler.every(1.day()).at("12:00 am").run(move || {});
    scheduler.watch_thread(Duration::from_secs(60))
}

fn setup_handlebars(chain: &mut Chain) {
    let data = BaseData {
        title: "SSH Key Authority".into(),
        style_mtime: get_filetime("style.css"),
        js_mtime: get_filetime("extra.js"),
        jsh_mtime: get_filetime("header.js"),
        version: env!("CARGO_PKG_VERSION"),
    };
    let base = Base::new(data);
    let mut hbse = HandlebarsEngine::new();
    hbse.handlebars_mut().register_helper(
        "transform_sync",
        Box::new(transform_sync),
    );
    hbse.handlebars_mut().register_helper(
        "transform_mgmnt",
        Box::new(transform_mgmnt),
    );
    hbse.add(Box::new(DirectorySource::new(
        "./templates/",
        ".hbs",
    )));
    if let Err(err) = hbse.reload() {
        log::error!("Unable to load templates. Does the ./templates folder exist?: {}", err);
    }
    chain.link_before(base);

    #[cfg(feature = "watch")]
    {
        let hbse_ref = Arc::new(hbse);
        hbse_ref.watch("./templates/");
        chain.link_after(hbse_ref);
    }
    #[cfg(not(feature = "watch"))]
    chain.link_after(hbse);
}
