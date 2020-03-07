#[macro_export]
macro_rules! req_db_op {
    ($req:expr, $query:expr, $func:ident) => {
        match $req.db_type() {
            DBType::MYSQL => {
                let conn: DieselPooledConnection<
                    diesel::mysql::MysqlConnection,
                > = $req.db_conn().map_err(|err| {
                    IronError::new(
                        err,
                        status::InternalServerError,
                    )
                })?;
                $query.$func(&conn).map_err(|err| {
                    IronError::new(
                        err,
                        status::InternalServerError,
                    )
                })?
            }
            DBType::POSTGRES => {
                let conn: DieselPooledConnection<
                    diesel::pg::PgConnection,
                > = $req.db_conn().map_err(|err| {
                    IronError::new(
                        err,
                        status::InternalServerError,
                    )
                })?;
                $query.$func(&conn).map_err(|err| {
                    IronError::new(
                        err,
                        status::InternalServerError,
                    )
                })?
            }
            DBType::SQLITE => {
                let conn: DieselPooledConnection<
                    diesel::sqlite::SqliteConnection,
                > = $req.db_conn().map_err(|err| {
                    IronError::new(
                        err,
                        status::InternalServerError,
                    )
                })?;
                $query.$func(&conn).map_err(|err| {
                    IronError::new(
                        err,
                        status::InternalServerError,
                    )
                })?
            }
        }
    };
}

#[macro_export]
macro_rules! req_db_query {
    ($req:expr, $query:expr, $func:ident, $bquery:ident $op: block) => {
        match $req.db_type() {
            DBType::MYSQL => {
                let conn: DieselPooledConnection<
                    diesel::mysql::MysqlConnection,
                > = $req.db_conn().map_err(|err| {
                    IronError::new(
                        err,
                        status::InternalServerError,
                    )
                })?;
                let mut $bquery =
                    $query.into_boxed::<diesel::mysql::Mysql>();

                $op
                $bquery.$func(&conn).map_err(|err| {
                    IronError::new(
                        err,
                        status::InternalServerError,
                    )
                })?
            }
            DBType::POSTGRES => {
                let conn: DieselPooledConnection<
                    diesel::pg::PgConnection,
                > = $req.db_conn().map_err(|err| {
                    IronError::new(
                        err,
                        status::InternalServerError,
                    )
                })?;
                let mut $bquery =
                    $query.into_boxed::<diesel::pg::Pg>();

                $op
                $bquery.$func(&conn).map_err(|err| {
                    IronError::new(
                        err,
                        status::InternalServerError,
                    )
                })?
            }
            DBType::SQLITE => {
                let conn: DieselPooledConnection<
                    diesel::sqlite::SqliteConnection,
                > = $req.db_conn().map_err(|err| {
                    IronError::new(
                        err,
                        status::InternalServerError,
                    )
                })?;
                let mut $bquery =
                    $query.into_boxed::<diesel::sqlite::Sqlite>();

                $op
                $bquery.$func(&conn).map_err(|err| {
                    IronError::new(
                        err,
                        status::InternalServerError,
                    )
                })?
            }
        }
    };
}

#[macro_export]
macro_rules! db_op {
    ($req:expr, $query:expr, $conn:ident $bquery:ident $op: block) => {
        match $req.db_type() {
            DBType::MYSQL => {
                let $conn: DieselPooledConnection<
                    diesel::mysql::MysqlConnection,
                > = $req.db_conn().map_err(|err| {
                    IronError::new(
                        err,
                        status::InternalServerError,
                    )
                })?;
                let mut $bquery =
                    $query.into_boxed::<diesel::mysql::Mysql>();

                $op
            }
            DBType::POSTGRES => {
                let $conn: DieselPooledConnection<
                    diesel::pg::PgConnection,
                > = $req.db_conn().map_err(|err| {
                    IronError::new(
                        err,
                        status::InternalServerError,
                    )
                })?;
                let mut $bquery =
                    $query.into_boxed::<diesel::pg::Pg>();

                $op
            }
            DBType::SQLITE => {
                let $conn: DieselPooledConnection<
                    diesel::sqlite::SqliteConnection,
                > = $req.db_conn().map_err(|err| {
                    IronError::new(
                        err,
                        status::InternalServerError,
                    )
                })?;
                let mut $bquery =
                    $query.into_boxed::<diesel::sqlite::Sqlite>();

                $op
            }
        }
    };
}
