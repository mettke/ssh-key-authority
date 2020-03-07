#!/usr/bin/env ash
if [ -z "${PORT}" ]; then
    echo "Using 8080 as listening port"
    PORT="8080"
fi
if [ -z "${API_ABUSEIPDB}" ]; then
    echo "API Key for abuseipdb is required"
    exit 1
fi
if [ -z "${EXPIRATION_TIME}" ]; then
    EXPIRATION_TIME="14"
fi
if [ -z "${STALE_TIME}" ]; then
    STALE_TIME="28"
fi
case ${LOG_LEVEL} in
    "0")
    LOG_LEVEL="-vv"
    ;;
    "1")
    LOG_LEVEL="-v"
    ;;
    "3")
    LOG_LEVEL="-s"
    ;;
    "4")
    LOG_LEVEL="-ss"
    ;;
    "5")
    LOG_LEVEL="-sss"
    ;;
    *)
    LOG_LEVEL=""
    ;;
esac
if [ "${DB_TYPE}" == "mysql" ]; then
    echo "Using mysql as database backend."
    if [ -z "${DB_USER}" ] || [ -z "${DB_PASS}" ] || 
        [ -z "${DB_HOST}" ] || [ -z "${DB_PORT}" ] || 
        [ -z "${DB_NAME}" ]; then
        echo "The following env variables are required to use mysql as backend:"
        echo "DB_USER, DB_PASS, DB_HOST, DB_PORT, DB_NAME"
        exit 1
    fi

    diesel migration run \
        --migration-dir='/usr/share/blacklistd/migrations.mysql' \
        --database-url="mysql://${DB_USER}:${DB_PASS}@${DB_HOST}:${DB_PORT}/${DB_NAME}"
    blacklistd --api-abuseipdb "${API_ABUSEIPDB}" --port "${PORT}" ${LOG_LEVEL} \
        --db-type mysql --db-host "${DB_HOST}" --db-port "${DB_PORT}" \
        --db-name "${DB_NAME}" --db-user "${DB_USER}" --db-pass "${DB_PASS}" \
        --expiration-days "${EXPIRATION_TIME}" --stale-days "${STALE_TIME}"
elif [ "${DB_TYPE}" == "postgres" ]; then 
    echo "Using postgres as database backend."
    if [ -z "${DB_USER}" ] || [ -z "${DB_PASS}" ] || 
        [ -z "${DB_HOST}" ] || [ -z "${DB_PORT}" ] || 
        [ -z "${DB_NAME}" ]; then
        echo "The following env variables are required to use postgres as backend:"
        echo "DB_USER, DB_PASS, DB_HOST, DB_PORT, DB_NAME"
        exit 1
    fi

    diesel migration run \
        --migration-dir='/usr/share/blacklistd/migrations.postgres' \
        --database-url="postgres://${DB_USER}:${DB_PASS}@${DB_HOST}:${DB_PORT}/${DB_NAME}"
    blacklistd --api-abuseipdb "${API_ABUSEIPDB}" --port "${PORT}" ${LOG_LEVEL} \
        --db-type postgres --db-host "${DB_HOST}" --db-port "${DB_PORT}" \
        --db-name "${DB_NAME}" --db-user "${DB_USER}" --db-pass "${DB_PASS}" \
        --expiration-days "${EXPIRATION_TIME}" --stale-days "${STALE_TIME}"
else
    echo "Using sqlite as database backend."
    echo "Consider using a different backend to improve performance"
    if [ -z "${DB_PATH}" ]; then
        echo "Using /data/db.sqlite as default path"
        DB_PATH="/data/db.sqlite"
    fi
    DB_DIR=$(dirname "${DB_PATH}")
    mkdir -p "${DB_DIR}"

    diesel migration run \
        --migration-dir='/usr/share/blacklistd/migrations.sqlite' \
        --database-url="${DB_PATH}"
    blacklistd --api-abuseipdb "${API_ABUSEIPDB}" --port "${PORT}" ${LOG_LEVEL} \
        --db-type sqlite --db-path "${DB_PATH}" \
        --expiration-days "${EXPIRATION_TIME}" --stale-days "${STALE_TIME}"
fi
