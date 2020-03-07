// https://github.com/darayus/iron-diesel-middleware

use diesel::r2d2::{ConnectionManager, Pool, PooledConnection};
use iron::{prelude::*, typemap, BeforeMiddleware};
use std::{error::Error, fmt};

#[derive(Debug, Clone, Copy)]
pub enum DBType {
    MYSQL,
    POSTGRES,
    SQLITE,
}

impl DBType {
    pub fn parse(db_type: &str) -> Option<DBType> {
        match db_type {
            "mysql" => Some(DBType::MYSQL),
            "postgres" => Some(DBType::POSTGRES),
            "sqlite" => Some(DBType::SQLITE),
            _ => None,
        }
    }
}

impl fmt::Display for DBType {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        match self {
            DBType::MYSQL => write!(f, "mysql"),
            DBType::POSTGRES => write!(f, "postgres"),
            DBType::SQLITE => write!(f, "sqlite"),
        }
    }
}

impl typemap::Key for DBType {
    type Value = DBType;
}

/// The type of the pool stored in `DieselMiddleware`.
pub type DieselPool<T> = Pool<ConnectionManager<T>>;

#[allow(dead_code)]
pub type DieselPooledConnection<T> =
    PooledConnection<ConnectionManager<T>>;

/// Iron middleware that allows for diesel connections within requests.
pub struct DieselMiddleware<T: 'static + diesel::Connection> {
    /// A pool of diesel connections that are shared between requests.
    pub pool: DieselPool<T>,
    pub db_type: DBType,
}

pub struct Value<T: 'static + diesel::Connection>(DieselPool<T>);

impl<T: diesel::Connection> typemap::Key for DieselMiddleware<T> {
    type Value = Value<T>;
}

impl<T: diesel::Connection> DieselMiddleware<T> {
    /// Creates a new pooled connection to the given sql server. The URL is in the format:
    ///
    /// ```{none}
    /// postgresql://user[:password]@host[:port][/database][?param1=val1[[&param2=val2]...]]
    /// ```
    ///
    /// Returns `Err(err)` if there are any errors connecting to the sql database.
    pub fn new(
        connection_str: &str,
        db_type: DBType,
    ) -> Result<DieselMiddleware<T>, Box<dyn Error>> {
        let manager = ConnectionManager::<T>::new(connection_str);
        Ok(Self::new_with_pool(
            Pool::builder().build(manager)?,
            db_type,
        ))
    }
    /// Creates a instance of the middleware with the ability to provide a preconfigured pool.
    pub fn new_with_pool(
        pool: Pool<ConnectionManager<T>>,
        db_type: DBType,
    ) -> DieselMiddleware<T> {
        DieselMiddleware { pool, db_type }
    }
}

impl<T: diesel::Connection> BeforeMiddleware
    for DieselMiddleware<T>
{
    fn before(&self, req: &mut Request) -> IronResult<()> {
        req.extensions.insert::<DBType>(self.db_type);
        req.extensions.insert::<DieselMiddleware<T>>(Value(
            self.pool.clone(),
        ));
        Ok(())
    }
}

/// Adds a method to requests to get a database connection.
///
/// ## Example
///
/// ```ignore
/// use iron_diesel_middleware::{DieselPooledConnection, DieselReqExt};
///
/// fn handler(req: &mut Request) -> IronResult<Response> {
///   let connection: DieselPooledConnection<diesel::pg::PgConnection> = req.db_conn();
///
///   let new_user = NewUser::new("John Smith", 25);
///   diesel::insert(&new_user).into(users::table).execute(&*connection);
///
///   Ok(Response::with((status::Ok, "Added User")))
/// }
/// ```
pub trait DieselReqExt<T: 'static + diesel::Connection> {
    /// Returns a pooled connection to the sql database. The connection is returned to
    /// the pool when the pooled connection is dropped.
    ///
    /// **Panics** if a `DieselMiddleware` has not been registered with Iron, or if retrieving
    /// a connection to the database times out.
    fn db_conn(
        &self,
    ) -> Result<PooledConnection<ConnectionManager<T>>, r2d2::Error>;
}

pub trait DieselTypeExt {
    fn db_type(&self) -> DBType;
}

impl<'a, 'b, T: 'static + diesel::Connection> DieselReqExt<T>
    for Request<'a, 'b>
{
    fn db_conn(
        &self,
    ) -> Result<PooledConnection<ConnectionManager<T>>, r2d2::Error>
    {
        let poll_value =
            self.extensions.get::<DieselMiddleware<T>>().unwrap();
        let &Value(ref poll) = poll_value;
        poll.get()
    }
}

impl<'a, 'b> DieselTypeExt for Request<'a, 'b> {
    fn db_type(&self) -> DBType {
        *self.extensions.get::<DBType>().unwrap()
    }
}
