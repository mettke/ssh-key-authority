FROM alpine AS builder

RUN : && \
    # dependencies for building
    apk add --no-cache \
        cargo \
        mariadb-dev \
        openssl \
        openssl-dev \
        postgresql-dev \
        rust \
        sqlite-dev && \
    : && \
    # central dependency storage for reuse
    mkdir -p "/root/.cargo" && \
    echo -ne '[build]\n\
target-dir = "/root/.cargo/target"\n' \
        >> "/root/.cargo/config" && \
    mkdir -p /tmp/blacklistd

RUN : && \
    # diesel_cli for migration
    cargo install \
        diesel_cli \
        --root /tmp/ \
        --color never

COPY ./src /tmp/blacklistd/src
COPY ./Cargo.toml /tmp/blacklistd

# building blacklistd
WORKDIR /tmp/blacklistd
RUN cargo install \
        --path /tmp/blacklistd \
        --root /tmp/ \
        --color never

FROM alpine

# transferring diesel_cli
COPY --from=builder /tmp/bin/diesel /usr/bin/
# transferring blacklistd
COPY --from=builder /tmp/bin/blacklistd /usr/bin
COPY ./migrations.mysql /usr/share/blacklistd/migrations.mysql
COPY ./migrations.postgres /usr/share/blacklistd/migrations.postgres
COPY ./migrations.sqlite /usr/share/blacklistd/migrations.sqlite
COPY ./LICENSE /usr/share/blacklistd/LICENSE

# transferring entrypoint and healtcheck
COPY ./docker/entrypoint.sh /usr/bin/entrypoint
COPY ./docker/healthcheck.sh /usr/bin/healthcheck

RUN : && \
    # blacklistd dependencies
    apk add --no-cache \
        curl \
        libgcc \
        libpq \
        mariadb-connector-c \
        sqlite-libs && \
    : && \
    # user to execute blacklistd
    addgroup blacklistd && \
    adduser blacklistd \
        -D -S -H \
        -G blacklistd \
        -s /bin/ash && \
    mkdir -p /data && \
    chown blacklistd:blacklistd \
        /usr/share/blacklistd \
        /data && \
    chmod +x \
        /usr/bin/entrypoint \
        /usr/bin/healthcheck

WORKDIR /usr/share/blacklistd
USER blacklistd
CMD [ "/usr/bin/entrypoint" ]
HEALTHCHECK CMD [ "/usr/bin/healthcheck" ]
