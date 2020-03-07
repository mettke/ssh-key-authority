table! {
    access (id) {
        id -> Integer,
        source_entity_id -> Integer,
        dest_entity_id -> Integer,
        grant_date -> Timestamp,
        granted_by -> Integer,
    }
}

table! {
    access_option (id) {
        id -> Integer,
        access_id -> Integer,
        option -> crate::types::database::AccessOptionMapping,
        value -> Nullable<Text>,
    }
}

table! {
    access_request (id) {
        id -> Integer,
        source_entity_id -> Integer,
        dest_entity_id -> Integer,
        request_date -> Timestamp,
        requested_by -> Integer,
    }
}

table! {
    entity (id) {
        id -> Integer,
        #[sql_name = "type"]
        type_ -> crate::types::database::EntityTypesMapping,
    }
}

table! {
    entity_admin (entity_id, admin) {
        entity_id -> Integer,
        admin -> Integer,
    }
}

table! {
    entity_event (id) {
        id -> Integer,
        entity_id -> Integer,
        actor_id -> Nullable<Integer>,
        date -> Timestamp,
        details -> Mediumtext,
    }
}

table! {
    group (entity_id) {
        entity_id -> Integer,
        name -> Varchar,
        active -> Integer,
        system -> Integer,
    }
}

table! {
    group_event (id) {
        id -> Integer,
        group -> Integer,
        entity_id -> Nullable<Integer>,
        date -> Timestamp,
        details -> Mediumtext,
    }
}

table! {
    group_member (id) {
        id -> Integer,
        group -> Integer,
        entity_id -> Integer,
        add_date -> Timestamp,
        added_by -> Nullable<Integer>,
    }
}

table! {
    public_key (id) {
        id -> Integer,
        entity_id -> Integer,
        #[sql_name = "type"]
        type_ -> Varchar,
        keydata -> Mediumtext,
        comment -> Mediumtext,
        keysize -> Nullable<Integer>,
        fingerprint_md5 -> Nullable<Char>,
        fingerprint_sha256 -> Nullable<Varchar>,
        randomart_md5 -> Nullable<Text>,
        randomart_sha256 -> Nullable<Text>,
        upload_date -> Timestamp,
        active -> Bool,
    }
}

table! {
    public_key_dest_rule (id) {
        id -> Integer,
        public_key_id -> Integer,
        account_name_filter -> Varchar,
        hostname_filter -> Varchar,
    }
}

table! {
    public_key_signature (id) {
        id -> Integer,
        public_key_id -> Integer,
        signature -> Blob,
        upload_date -> Timestamp,
        fingerprint -> Varchar,
        sign_date -> Timestamp,
    }
}

table! {
    server (id) {
        id -> Integer,
        uuid -> Nullable<Varchar>,
        hostname -> Varchar,
        ip_address -> Nullable<Varchar>,
        deleted -> Integer,
        key_management -> crate::types::database::KeyManagementMapping,
        authorization -> crate::types::database::AuthorizationTypeMapping,
        use_sync_client -> crate::types::database::UseClientSyncMapping,
        sync_status -> crate::types::database::SyncStatusTypeMapping,
        configuration_system -> crate::types::database::ConfigurationSystemMapping,
        custom_keys -> crate::types::database::CustomKeysMapping,
        rsa_key_fingerprint -> Nullable<Char>,
        port -> Integer,
    }
}

table! {
    server_account (entity_id) {
        entity_id -> Integer,
        server_id -> Integer,
        name -> Nullable<Varchar>,
        sync_status -> crate::types::database::SyncStatusTypeAccountMapping,
        active -> Integer,
    }
}

table! {
    server_admin (server_id, entity_id) {
        server_id -> Integer,
        entity_id -> Integer,
    }
}

table! {
    server_event (id) {
        id -> Integer,
        server_id -> Integer,
        actor_id -> Nullable<Integer>,
        date -> Timestamp,
        details -> Mediumtext,
    }
}

table! {
    server_ldap_access_option (id) {
        id -> Integer,
        server_id -> Integer,
        option -> crate::types::database::LdapAccessOptionsMapping,
        value -> Nullable<Text>,
    }
}

table! {
    server_note (id) {
        id -> Integer,
        server_id -> Integer,
        entity_id -> Nullable<Integer>,
        date -> Timestamp,
        note -> Mediumtext,
    }
}

table! {
    sync_request (id) {
        id -> Integer,
        server_id -> Integer,
        account_name -> Nullable<Varchar>,
        processing -> Integer,
    }
}

table! {
    user (entity_id) {
        entity_id -> Integer,
        uid -> Varchar,
        name -> Varchar,
        email -> Varchar,
        superior_entity_id -> Nullable<Integer>,
        auth_realm -> crate::types::database::AuthRealmMapping,
        active -> Integer,
        admin -> Integer,
        developer -> Integer,
        force_disable -> Integer,
        csrf_token -> Nullable<Binary>,
    }
}

table! {
    user_alert (id) {
        id -> Integer,
        entity_id -> Integer,
        class -> Varchar,
        content -> Mediumtext,
        escaping -> Integer,
    }
}

joinable!(access_option -> access (access_id));
joinable!(group -> entity (entity_id));
joinable!(group_event -> entity (entity_id));
joinable!(group_event -> group (group));
joinable!(group_member -> group (group));
joinable!(public_key -> entity (entity_id));
joinable!(public_key_dest_rule -> public_key (public_key_id));
joinable!(public_key_signature -> public_key (public_key_id));
joinable!(server_account -> entity (entity_id));
joinable!(server_account -> server (server_id));
joinable!(server_admin -> entity (entity_id));
joinable!(server_admin -> server (server_id));
joinable!(server_event -> entity (actor_id));
joinable!(server_event -> server (server_id));
joinable!(server_ldap_access_option -> server (server_id));
joinable!(server_note -> entity (entity_id));
joinable!(server_note -> server (server_id));
joinable!(sync_request -> server (server_id));
joinable!(user -> entity (entity_id));
joinable!(user_alert -> entity (entity_id));

allow_tables_to_appear_in_same_query!(
    access,
    access_option,
    access_request,
    entity,
    entity_admin,
    entity_event,
    group,
    group_event,
    group_member,
    public_key,
    public_key_dest_rule,
    public_key_signature,
    server,
    server_account,
    server_admin,
    server_event,
    server_ldap_access_option,
    server_note,
    sync_request,
    user,
    user_alert,
);
