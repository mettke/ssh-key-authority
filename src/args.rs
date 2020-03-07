use crate::middleware::diesel::DBType;
use clap::{
    app_from_crate, crate_authors, crate_description, crate_name,
    crate_version, Arg, ArgMatches,
};
use std::process::exit;

const ARGS_LISTEN: &str = "listen";
const ARGS_LISTEN_DEFAULT: &str = "::";
const ARGS_PORT: &str = "port";
const ARGS_PORT_DEFAULT: &str = "8080";
const ARGS_PORT_DEFAULT_U16: u16 = 8080;
const ARGS_VERBOSE: &str = "verbose";
const ARGS_SILENT: &str = "silent";

const ARGS_DATABASE_TYPE: &str = "db-type";
const ARGS_DATABASE_HOST: &str = "db-host";
const ARGS_DATABASE_PORT: &str = "db-port";
const ARGS_DATABASE_NAME: &str = "db-name";
const ARGS_DATABASE_USER: &str = "db-user";
const ARGS_DATABASE_PASS: &str = "db-pass";
const ARGS_DATABASE_PATH: &str = "db-path";

#[derive(Debug, Clone)]
pub struct CliArguments {
    pub listen: String,
    pub port: u16,
    pub log_level: Option<log::Level>,

    pub db_type: DBType,
    pub db_host: String,
    pub db_port: u16,
    pub db_name: String,
    pub db_user: String,
    pub db_pass: String,
    pub db_path: String,
}

pub fn get_arguments() -> CliArguments {
    let matches = get_cli_config();
    let listen = matches
        .value_of(ARGS_LISTEN)
        .unwrap_or(ARGS_LISTEN_DEFAULT)
        .into();
    let port: u16 = matches
        .value_of(ARGS_PORT)
        .and_then(|port| port.parse().ok())
        .unwrap_or(ARGS_PORT_DEFAULT_U16);
    let log_level = match (
        matches.occurrences_of(ARGS_SILENT),
        matches.occurrences_of(ARGS_VERBOSE),
    ) {
        (0, 1) => Some(log::Level::Debug),
        (0, v) if v > 1 => Some(log::Level::Trace),
        (1, 0) => Some(log::Level::Warn),
        (2, 0) => Some(log::Level::Error),
        (s, 0) if s > 2 => None,
        _ => Some(log::Level::Info),
    };

    let db_type = match matches
        .value_of(ARGS_DATABASE_TYPE)
        .and_then(|t| DBType::parse(t))
    {
        Some(v) => v,
        None => {
            log::error!("Database Type is required");
            exit(1);
        }
    };
    let db_host = match matches.value_of(ARGS_DATABASE_HOST) {
        Some(v) => v.into(),
        None => {
            log::error!("Database Host is required");
            exit(1);
        }
    };
    let db_port = match matches
        .value_of(ARGS_DATABASE_PORT)
        .and_then(|port| port.parse().ok())
    {
        Some(v) => v,
        None => {
            log::error!("Database Port is required");
            exit(1);
        }
    };
    let db_name = match matches.value_of(ARGS_DATABASE_NAME) {
        Some(v) => v.into(),
        None => {
            log::error!("Database Name is required");
            exit(1);
        }
    };
    let db_user = match matches.value_of(ARGS_DATABASE_USER) {
        Some(v) => v.into(),
        None => {
            log::error!("Database User is required");
            exit(1);
        }
    };
    let db_pass = match matches.value_of(ARGS_DATABASE_PASS) {
        Some(v) => v.into(),
        None => {
            log::error!("Database Password is required");
            exit(1);
        }
    };
    let db_path = match matches.value_of(ARGS_DATABASE_PATH) {
        Some(v) => v.into(),
        None => {
            log::error!("Database Path is required");
            exit(1);
        }
    };

    CliArguments {
        listen,
        port,
        log_level,
        db_type,
        db_host,
        db_port,
        db_name,
        db_user,
        db_pass,
        db_path,
    }
}

fn get_cli_config<'a>() -> ArgMatches<'a> {
    app_from_crate!()
        .arg(
            Arg::with_name(ARGS_LISTEN)
                .short("l")
                .long(ARGS_LISTEN)
                .value_name("hostname/ip")
                .help("Set the listening ip/hostname")
                .default_value(ARGS_LISTEN_DEFAULT)
                .takes_value(true),
        )
        .arg(
            Arg::with_name(ARGS_PORT)
                .short("p")
                .long(ARGS_PORT)
                .value_name("port")
                .help("Set the port to bind to")
                .default_value(ARGS_PORT_DEFAULT)
                .takes_value(true),
        )
        .arg(
            Arg::with_name(ARGS_VERBOSE)
                .short("v")
                .long(ARGS_VERBOSE)
                .conflicts_with(ARGS_SILENT)
                .multiple(true)
                .help("Increase verbosity. Once for debug, twice for trace")
        )
        .arg(
            Arg::with_name(ARGS_SILENT)
                .short("s")
                .long(ARGS_SILENT)
                .conflicts_with(ARGS_VERBOSE)
                .multiple(true)
                .help("Decrease verbosity. Once for warning, twice for error, thrice for none")
        )
        .arg(
            Arg::with_name(ARGS_DATABASE_TYPE)
                .long(ARGS_DATABASE_TYPE)
                .value_name("type")
                .possible_values(&["postgres", "mysql", "sqlite"])
                .help("Database Type")
                .takes_value(true)
                .required(true),
        )
        .arg(
            Arg::with_name(ARGS_DATABASE_HOST)
                .long(ARGS_DATABASE_HOST)
                .value_name("hostname/ip")
                .help("Database Hostname or Ip")
                .takes_value(true)
                .required_ifs(&[
                    (ARGS_DATABASE_TYPE, "postgres"),
                    (ARGS_DATABASE_TYPE, "mysql"),
                ])
                .default_value_if(
                    ARGS_DATABASE_TYPE,
                    Some("sqlite"),
                    "",
                ),
        )
        .arg(
            Arg::with_name(ARGS_DATABASE_PORT)
                .long(ARGS_DATABASE_PORT)
                .value_name("port")
                .help("Database Port")
                .takes_value(true)
                .required_ifs(&[
                    (ARGS_DATABASE_TYPE, "postgres"),
                    (ARGS_DATABASE_TYPE, "mysql"),
                ])
                .default_value_if(
                    ARGS_DATABASE_TYPE,
                    Some("sqlite"),
                    "0",
                ),
        )
        .arg(
            Arg::with_name(ARGS_DATABASE_NAME)
                .long(ARGS_DATABASE_NAME)
                .value_name("name")
                .help("Database Name")
                .takes_value(true)
                .required_ifs(&[
                    (ARGS_DATABASE_TYPE, "postgres"),
                    (ARGS_DATABASE_TYPE, "mysql"),
                ])
                .default_value_if(
                    ARGS_DATABASE_TYPE,
                    Some("sqlite"),
                    "",
                ),
        )
        .arg(
            Arg::with_name(ARGS_DATABASE_USER)
                .long(ARGS_DATABASE_USER)
                .value_name("username")
                .help("Database Username")
                .takes_value(true)
                .required_ifs(&[
                    (ARGS_DATABASE_TYPE, "postgres"),
                    (ARGS_DATABASE_TYPE, "mysql"),
                ])
                .default_value_if(
                    ARGS_DATABASE_TYPE,
                    Some("sqlite"),
                    "",
                ),
        )
        .arg(
            Arg::with_name(ARGS_DATABASE_PASS)
                .long(ARGS_DATABASE_PASS)
                .value_name("password")
                .help("Database Password")
                .takes_value(true)
                .required_ifs(&[
                    (ARGS_DATABASE_TYPE, "postgres"),
                    (ARGS_DATABASE_TYPE, "mysql"),
                ])
                .default_value_if(
                    ARGS_DATABASE_TYPE,
                    Some("sqlite"),
                    "",
                ),
        )
        .arg(
            Arg::with_name(ARGS_DATABASE_PATH)
                .long(ARGS_DATABASE_PATH)
                .value_name("path")
                .help("Database Path")
                .takes_value(true)
                .required_ifs(&[(ARGS_DATABASE_TYPE, "sqlite")])
                .default_value_ifs(&[
                    (ARGS_DATABASE_TYPE, Some("postgres"), ""),
                    (ARGS_DATABASE_TYPE, Some("mysql"), ""),
                ]),
        )
        .get_matches()
}
