--
-- PostgreSQL database dump
--

-- Dumped from database version 12.2
-- Dumped by pg_dump version 12.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64)
);


ALTER TABLE public.admin_event_entity OWNER TO keycloak;

--
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE public.associated_policy OWNER TO keycloak;

--
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


ALTER TABLE public.authentication_execution OWNER TO keycloak;

--
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


ALTER TABLE public.authentication_flow OWNER TO keycloak;

--
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.authenticator_config OWNER TO keycloak;

--
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.authenticator_config_entry OWNER TO keycloak;

--
-- Name: broker_link; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


ALTER TABLE public.broker_link OWNER TO keycloak;

--
-- Name: client; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    always_display_in_console boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client OWNER TO keycloak;

--
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    value character varying(4000),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_attributes OWNER TO keycloak;

--
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


ALTER TABLE public.client_auth_flow_bindings OWNER TO keycloak;

--
-- Name: client_default_roles; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_default_roles (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.client_default_roles OWNER TO keycloak;

--
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


ALTER TABLE public.client_initial_access OWNER TO keycloak;

--
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_node_registrations OWNER TO keycloak;

--
-- Name: client_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


ALTER TABLE public.client_scope OWNER TO keycloak;

--
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_scope_attributes OWNER TO keycloak;

--
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope_client (
    client_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client_scope_client OWNER TO keycloak;

--
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.client_scope_role_mapping OWNER TO keycloak;

--
-- Name: client_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session (
    id character varying(36) NOT NULL,
    client_id character varying(36),
    redirect_uri character varying(255),
    state character varying(255),
    "timestamp" integer,
    session_id character varying(36),
    auth_method character varying(255),
    realm_id character varying(255),
    auth_user_id character varying(36),
    current_action character varying(36)
);


ALTER TABLE public.client_session OWNER TO keycloak;

--
-- Name: client_session_auth_status; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session_auth_status (
    authenticator character varying(36) NOT NULL,
    status integer,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_auth_status OWNER TO keycloak;

--
-- Name: client_session_note; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session_note (
    name character varying(255) NOT NULL,
    value character varying(255),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_note OWNER TO keycloak;

--
-- Name: client_session_prot_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session_prot_mapper (
    protocol_mapper_id character varying(36) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_prot_mapper OWNER TO keycloak;

--
-- Name: client_session_role; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session_role (
    role_id character varying(255) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_role OWNER TO keycloak;

--
-- Name: client_user_session_note; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_user_session_note (
    name character varying(255) NOT NULL,
    value character varying(2048),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_user_session_note OWNER TO keycloak;

--
-- Name: component; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


ALTER TABLE public.component OWNER TO keycloak;

--
-- Name: component_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(4000)
);


ALTER TABLE public.component_config OWNER TO keycloak;

--
-- Name: composite_role; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE public.composite_role OWNER TO keycloak;

--
-- Name: credential; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    user_id character varying(36),
    created_date bigint,
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.credential OWNER TO keycloak;

--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.databasechangelog OWNER TO keycloak;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO keycloak;

--
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.default_client_scope OWNER TO keycloak;

--
-- Name: event_entity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255)
);


ALTER TABLE public.event_entity OWNER TO keycloak;

--
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024)
);


ALTER TABLE public.fed_user_attribute OWNER TO keycloak;

--
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.fed_user_consent OWNER TO keycloak;

--
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.fed_user_consent_cl_scope OWNER TO keycloak;

--
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    created_date bigint,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.fed_user_credential OWNER TO keycloak;

--
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_group_membership OWNER TO keycloak;

--
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_required_action OWNER TO keycloak;

--
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_role_mapping OWNER TO keycloak;

--
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_identity OWNER TO keycloak;

--
-- Name: federated_user; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_user OWNER TO keycloak;

--
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_attribute OWNER TO keycloak;

--
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_role_mapping OWNER TO keycloak;

--
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL
);


ALTER TABLE public.identity_provider OWNER TO keycloak;

--
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.identity_provider_config OWNER TO keycloak;

--
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.identity_provider_mapper OWNER TO keycloak;

--
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.idp_mapper_config OWNER TO keycloak;

--
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36),
    realm_id character varying(36)
);


ALTER TABLE public.keycloak_group OWNER TO keycloak;

--
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(255),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


ALTER TABLE public.keycloak_role OWNER TO keycloak;

--
-- Name: migration_model; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.migration_model OWNER TO keycloak;

--
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(255) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL
);


ALTER TABLE public.offline_client_session OWNER TO keycloak;

--
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.offline_user_session OWNER TO keycloak;

--
-- Name: policy_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.policy_config OWNER TO keycloak;

--
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


ALTER TABLE public.protocol_mapper OWNER TO keycloak;

--
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.protocol_mapper_config OWNER TO keycloak;

--
-- Name: realm; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL,
    sso_max_lifespan_remember_me integer DEFAULT 0 NOT NULL,
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.realm OWNER TO keycloak;

--
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_attribute OWNER TO keycloak;

--
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_groups OWNER TO keycloak;

--
-- Name: realm_default_roles; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_default_roles (
    realm_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_roles OWNER TO keycloak;

--
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_enabled_event_types OWNER TO keycloak;

--
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_events_listeners OWNER TO keycloak;

--
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_required_credential OWNER TO keycloak;

--
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.realm_smtp_config OWNER TO keycloak;

--
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_supported_locales OWNER TO keycloak;

--
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.redirect_uris OWNER TO keycloak;

--
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.required_action_config OWNER TO keycloak;

--
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255),
    priority integer
);


ALTER TABLE public.required_action_provider OWNER TO keycloak;

--
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_attribute OWNER TO keycloak;

--
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_policy OWNER TO keycloak;

--
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_scope OWNER TO keycloak;

--
-- Name: resource_server; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode character varying(15) NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.resource_server OWNER TO keycloak;

--
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(255) NOT NULL,
    requester character varying(255) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


ALTER TABLE public.resource_server_perm_ticket OWNER TO keycloak;

--
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy character varying(20),
    logic character varying(20),
    resource_server_id character varying(36) NOT NULL,
    owner character varying(255)
);


ALTER TABLE public.resource_server_policy OWNER TO keycloak;

--
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(255) NOT NULL,
    resource_server_id character varying(36) NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_resource OWNER TO keycloak;

--
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_scope OWNER TO keycloak;

--
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.resource_uris OWNER TO keycloak;

--
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


ALTER TABLE public.role_attribute OWNER TO keycloak;

--
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_mapping OWNER TO keycloak;

--
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_policy OWNER TO keycloak;

--
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL
);


ALTER TABLE public.user_attribute OWNER TO keycloak;

--
-- Name: user_consent; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.user_consent OWNER TO keycloak;

--
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.user_consent_client_scope OWNER TO keycloak;

--
-- Name: user_entity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(255),
    not_before integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.user_entity OWNER TO keycloak;

--
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_config OWNER TO keycloak;

--
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.user_federation_mapper OWNER TO keycloak;

--
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_mapper_config OWNER TO keycloak;

--
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.user_federation_provider OWNER TO keycloak;

--
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_group_membership OWNER TO keycloak;

--
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE public.user_required_action OWNER TO keycloak;

--
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_role_mapping OWNER TO keycloak;

--
-- Name: user_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_session (
    id character varying(36) NOT NULL,
    auth_method character varying(255),
    ip_address character varying(255),
    last_session_refresh integer,
    login_username character varying(255),
    realm_id character varying(255),
    remember_me boolean DEFAULT false NOT NULL,
    started integer,
    user_id character varying(255),
    user_session_state integer,
    broker_session_id character varying(255),
    broker_user_id character varying(255)
);


ALTER TABLE public.user_session OWNER TO keycloak;

--
-- Name: user_session_note; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_session_note (
    user_session character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(2048)
);


ALTER TABLE public.user_session_note OWNER TO keycloak;

--
-- Name: username_login_failure; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.username_login_failure (
    realm_id character varying(36) NOT NULL,
    username character varying(255) NOT NULL,
    failed_login_not_before integer,
    last_failure bigint,
    last_ip_failure character varying(255),
    num_failures integer
);


ALTER TABLE public.username_login_failure OWNER TO keycloak;

--
-- Name: web_origins; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.web_origins OWNER TO keycloak;

--
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.admin_event_entity (id, admin_event_time, realm_id, operation_type, auth_realm_id, auth_client_id, auth_user_id, ip_address, resource_path, representation, error, resource_type) FROM stdin;
\.


--
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.associated_policy (policy_id, associated_policy_id) FROM stdin;
\.


--
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) FROM stdin;
fcc173ee-7568-4dd7-821b-134ca67072c2	\N	auth-cookie	master	001e3b57-69c6-4d73-a469-7ec168f5f815	2	10	f	\N	\N
e0fd71c0-6523-402c-bbce-eb01d2f91041	\N	auth-spnego	master	001e3b57-69c6-4d73-a469-7ec168f5f815	3	20	f	\N	\N
e9249d4e-d876-4921-aeee-462173c075f3	\N	identity-provider-redirector	master	001e3b57-69c6-4d73-a469-7ec168f5f815	2	25	f	\N	\N
2661afe9-9dbb-41cc-979b-277c580ba423	\N	\N	master	001e3b57-69c6-4d73-a469-7ec168f5f815	2	30	t	367c01a0-c1ad-4a6d-925d-010a6677bd2d	\N
4534bb0d-132b-4542-9fef-b20a482f281b	\N	auth-username-password-form	master	367c01a0-c1ad-4a6d-925d-010a6677bd2d	0	10	f	\N	\N
d3c2d434-c524-4a25-a7a9-8a7328f9ec9a	\N	\N	master	367c01a0-c1ad-4a6d-925d-010a6677bd2d	1	20	t	58c59787-8133-43e4-b801-7499271ab9a9	\N
c78100c2-7067-4b65-a75a-0cb1b1a15de1	\N	conditional-user-configured	master	58c59787-8133-43e4-b801-7499271ab9a9	0	10	f	\N	\N
33a537fd-f407-4fcc-8dfb-d5fbe2649313	\N	auth-otp-form	master	58c59787-8133-43e4-b801-7499271ab9a9	0	20	f	\N	\N
602ed5e8-6ab6-4949-9abb-c7145c860e8b	\N	direct-grant-validate-username	master	dd002e15-c64b-40e7-ad1b-9fad447d68ee	0	10	f	\N	\N
8179cce1-c098-4f99-94ef-b9e11b63b8c4	\N	direct-grant-validate-password	master	dd002e15-c64b-40e7-ad1b-9fad447d68ee	0	20	f	\N	\N
a03f6ba2-c9ba-4c85-916f-3607a399502c	\N	\N	master	dd002e15-c64b-40e7-ad1b-9fad447d68ee	1	30	t	a4edff37-9f30-429c-a19e-9aff2b711eb9	\N
fb6975ae-f06f-4a1d-8508-02f2d34eadbc	\N	conditional-user-configured	master	a4edff37-9f30-429c-a19e-9aff2b711eb9	0	10	f	\N	\N
5627bb75-4ad6-437d-af04-26280c6808be	\N	direct-grant-validate-otp	master	a4edff37-9f30-429c-a19e-9aff2b711eb9	0	20	f	\N	\N
6a241154-6f36-426e-a8bd-d38cef897bfa	\N	registration-page-form	master	009c4ea2-a4bb-42a5-99db-8fb0dc1a73da	0	10	t	5dd2c4e8-7e6d-41f3-96b3-bfe2061f7fc4	\N
b621c6e0-c528-48c1-88dc-183763a5c25b	\N	registration-user-creation	master	5dd2c4e8-7e6d-41f3-96b3-bfe2061f7fc4	0	20	f	\N	\N
e186ef67-80cb-449a-ac1c-b764aa8b1def	\N	registration-profile-action	master	5dd2c4e8-7e6d-41f3-96b3-bfe2061f7fc4	0	40	f	\N	\N
cae55d65-83ac-48d7-ab1a-4c6b6ec186e1	\N	registration-password-action	master	5dd2c4e8-7e6d-41f3-96b3-bfe2061f7fc4	0	50	f	\N	\N
fabc089c-1fbb-4255-b2b6-66f6d2d7e567	\N	registration-recaptcha-action	master	5dd2c4e8-7e6d-41f3-96b3-bfe2061f7fc4	3	60	f	\N	\N
d64dea53-e641-417a-a6c0-b423522160c0	\N	reset-credentials-choose-user	master	54cd42c0-bb58-40a3-a464-db96a865a9dd	0	10	f	\N	\N
01aec6c8-6aa1-4810-a6b7-911366275977	\N	reset-credential-email	master	54cd42c0-bb58-40a3-a464-db96a865a9dd	0	20	f	\N	\N
82704a86-87da-41ea-b905-d703866e0a52	\N	reset-password	master	54cd42c0-bb58-40a3-a464-db96a865a9dd	0	30	f	\N	\N
d652c9bb-02e2-4549-91e9-1305cec3af4c	\N	\N	master	54cd42c0-bb58-40a3-a464-db96a865a9dd	1	40	t	a79abe63-6837-49cd-8fc6-f9aa1382e376	\N
21c84be5-b8ff-4370-a139-aa34e60cd954	\N	conditional-user-configured	master	a79abe63-6837-49cd-8fc6-f9aa1382e376	0	10	f	\N	\N
624cf3b6-d87e-4508-9d24-441d904feb0d	\N	reset-otp	master	a79abe63-6837-49cd-8fc6-f9aa1382e376	0	20	f	\N	\N
04eb9a81-0470-4de1-985e-28bdbc8e5237	\N	client-secret	master	08929cec-b160-4d9c-aa58-355908736dc7	2	10	f	\N	\N
8048c608-f80c-4430-a43d-ae736d84a739	\N	client-jwt	master	08929cec-b160-4d9c-aa58-355908736dc7	2	20	f	\N	\N
d20f8b59-b89b-4a60-acea-2607899bcab1	\N	client-secret-jwt	master	08929cec-b160-4d9c-aa58-355908736dc7	2	30	f	\N	\N
10c7e937-16b5-41a2-9aaa-bd474d7d1d16	\N	client-x509	master	08929cec-b160-4d9c-aa58-355908736dc7	2	40	f	\N	\N
d14e0a7b-6525-4459-8be3-e8d7253abae2	\N	idp-review-profile	master	a4d69f46-8744-4b6f-88f6-aa64f99d4cb7	0	10	f	\N	04503bd5-d837-4e3e-a5b2-207c272e63ca
a1fe1a0b-2711-488a-b0c5-eb8db2e091ad	\N	\N	master	a4d69f46-8744-4b6f-88f6-aa64f99d4cb7	0	20	t	764fb12e-0f5a-483d-9f58-64b605c61438	\N
00619cca-a6f7-419a-a29c-e5b8a410c1c9	\N	idp-create-user-if-unique	master	764fb12e-0f5a-483d-9f58-64b605c61438	2	10	f	\N	618df05e-7983-40bc-b4d8-21135b3fe6eb
1e6ebc84-aff4-4317-965f-3fbb3863d4f8	\N	\N	master	764fb12e-0f5a-483d-9f58-64b605c61438	2	20	t	f3a367d9-6fd6-45f7-b918-361261366d27	\N
f456efd9-08cc-4917-bdd8-9e4450173a67	\N	idp-confirm-link	master	f3a367d9-6fd6-45f7-b918-361261366d27	0	10	f	\N	\N
ddcc4d33-42f1-4b7e-b11c-602797e4ede2	\N	\N	master	f3a367d9-6fd6-45f7-b918-361261366d27	0	20	t	23b996b2-997d-4b7c-ac2a-c8d8ee6fa23f	\N
76e6973c-cbd9-423b-8cb1-0956e5dda36c	\N	idp-email-verification	master	23b996b2-997d-4b7c-ac2a-c8d8ee6fa23f	2	10	f	\N	\N
b490302e-fce0-4ae0-9249-3ef9e90e5751	\N	\N	master	23b996b2-997d-4b7c-ac2a-c8d8ee6fa23f	2	20	t	685db914-660a-4a14-9d1b-56ddf603c913	\N
37ff1f7c-1b17-48eb-8526-60eeb9316c4a	\N	idp-username-password-form	master	685db914-660a-4a14-9d1b-56ddf603c913	0	10	f	\N	\N
e391ad60-9615-4747-ad75-97b33ead904f	\N	\N	master	685db914-660a-4a14-9d1b-56ddf603c913	1	20	t	1e1d3e37-55b2-4f86-b633-008da89b926d	\N
159c34a7-d3bd-4363-9181-b65a73d66b23	\N	conditional-user-configured	master	1e1d3e37-55b2-4f86-b633-008da89b926d	0	10	f	\N	\N
d87c182f-acef-4448-af4e-a63e7fd1c9a3	\N	auth-otp-form	master	1e1d3e37-55b2-4f86-b633-008da89b926d	0	20	f	\N	\N
aae14b30-3b2b-4ce2-8943-5a1e456ca837	\N	http-basic-authenticator	master	475be67a-6b48-462e-a4b7-9de4ca4a6748	0	10	f	\N	\N
fd944784-cfe1-46a9-9e8a-0767b5be9d2c	\N	docker-http-basic-authenticator	master	ab1971d1-f02f-49b1-8d36-831b75e6c90f	0	10	f	\N	\N
05472397-1490-42d5-9ceb-0ca194b134e9	\N	no-cookie-redirect	master	363d4daa-bb10-4673-aaa1-5019cf53e084	0	10	f	\N	\N
121c7bc8-608c-4725-b61a-a1b80b4734f7	\N	\N	master	363d4daa-bb10-4673-aaa1-5019cf53e084	0	20	t	16bc1415-9c0f-4371-80ce-d1ee19f35812	\N
23c673db-d953-40c9-a584-65e9597d3e50	\N	basic-auth	master	16bc1415-9c0f-4371-80ce-d1ee19f35812	0	10	f	\N	\N
a2b03806-eb37-4889-8d40-991e1df0b57f	\N	basic-auth-otp	master	16bc1415-9c0f-4371-80ce-d1ee19f35812	3	20	f	\N	\N
4adb6416-36be-4fd9-a610-8e11e8bbae3f	\N	auth-spnego	master	16bc1415-9c0f-4371-80ce-d1ee19f35812	3	30	f	\N	\N
\.


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
001e3b57-69c6-4d73-a469-7ec168f5f815	browser	browser based authentication	master	basic-flow	t	t
367c01a0-c1ad-4a6d-925d-010a6677bd2d	forms	Username, password, otp and other auth forms.	master	basic-flow	f	t
58c59787-8133-43e4-b801-7499271ab9a9	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	master	basic-flow	f	t
dd002e15-c64b-40e7-ad1b-9fad447d68ee	direct grant	OpenID Connect Resource Owner Grant	master	basic-flow	t	t
a4edff37-9f30-429c-a19e-9aff2b711eb9	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	master	basic-flow	f	t
009c4ea2-a4bb-42a5-99db-8fb0dc1a73da	registration	registration flow	master	basic-flow	t	t
5dd2c4e8-7e6d-41f3-96b3-bfe2061f7fc4	registration form	registration form	master	form-flow	f	t
54cd42c0-bb58-40a3-a464-db96a865a9dd	reset credentials	Reset credentials for a user if they forgot their password or something	master	basic-flow	t	t
a79abe63-6837-49cd-8fc6-f9aa1382e376	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	master	basic-flow	f	t
08929cec-b160-4d9c-aa58-355908736dc7	clients	Base authentication for clients	master	client-flow	t	t
a4d69f46-8744-4b6f-88f6-aa64f99d4cb7	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	master	basic-flow	t	t
764fb12e-0f5a-483d-9f58-64b605c61438	User creation or linking	Flow for the existing/non-existing user alternatives	master	basic-flow	f	t
f3a367d9-6fd6-45f7-b918-361261366d27	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	master	basic-flow	f	t
23b996b2-997d-4b7c-ac2a-c8d8ee6fa23f	Account verification options	Method with which to verity the existing account	master	basic-flow	f	t
685db914-660a-4a14-9d1b-56ddf603c913	Verify Existing Account by Re-authentication	Reauthentication of existing account	master	basic-flow	f	t
1e1d3e37-55b2-4f86-b633-008da89b926d	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	master	basic-flow	f	t
475be67a-6b48-462e-a4b7-9de4ca4a6748	saml ecp	SAML ECP Profile Authentication Flow	master	basic-flow	t	t
ab1971d1-f02f-49b1-8d36-831b75e6c90f	docker auth	Used by Docker clients to authenticate against the IDP	master	basic-flow	t	t
363d4daa-bb10-4673-aaa1-5019cf53e084	http challenge	An authentication flow based on challenge-response HTTP Authentication Schemes	master	basic-flow	t	t
16bc1415-9c0f-4371-80ce-d1ee19f35812	Authentication Options	Authentication options.	master	basic-flow	f	t
\.


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authenticator_config (id, alias, realm_id) FROM stdin;
04503bd5-d837-4e3e-a5b2-207c272e63ca	review profile config	master
618df05e-7983-40bc-b4d8-21135b3fe6eb	create unique user config	master
\.


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
04503bd5-d837-4e3e-a5b2-207c272e63ca	missing	update.profile.on.first.login
618df05e-7983-40bc-b4d8-21135b3fe6eb	false	require.password.update.after.registration
\.


--
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.broker_link (identity_provider, storage_provider_id, realm_id, broker_user_id, broker_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) FROM stdin;
424fffef-ec10-46fe-88f6-4d91caa2b885	t	t	master-realm	0	f	34051cad-7c7e-44a9-a963-7a449c107526	\N	t	\N	f	master	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	f
4f7365a9-8d15-4e92-a47a-9e7708aa6957	t	f	account	0	f	3102cdf9-c66a-485a-8e31-2196f8586b11	/realms/master/account/	f	\N	f	master	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
c506d2fc-b7ca-43c2-8850-844800fd97ac	t	f	account-console	0	t	94d73fa9-fb89-4798-ad41-1f9bdd444f5d	/realms/master/account/	f	\N	f	master	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
93d27599-f1b8-4e6c-9183-a460436682a6	t	f	broker	0	f	992e4491-c5a6-43b2-8eac-1e84118d9584	\N	f	\N	f	master	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
df8928e5-088d-485f-b8d0-37e364492cb3	t	f	security-admin-console	0	t	09dae2df-e535-4c5a-9d23-3cb5d1d75943	/admin/master/console/	f	\N	f	master	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
466c07ae-2aff-4e01-a1b0-f4701f4760b1	t	f	admin-cli	0	t	adb2fa76-6858-49d4-9c63-e999f21966a2	\N	f	\N	f	master	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
c0b92108-6cf9-48e8-8492-ca9aeeee477c	t	t	test_client	0	f	cec217b2-977a-4a26-a75b-d458d4cc03b6	\N	f	\N	f	master	openid-connect	-1	f	t	\N	f	client-secret	\N	\N	\N	t	f	t	f
\.


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_attributes (client_id, value, name) FROM stdin;
c506d2fc-b7ca-43c2-8850-844800fd97ac	S256	pkce.code.challenge.method
df8928e5-088d-485f-b8d0-37e364492cb3	S256	pkce.code.challenge.method
c0b92108-6cf9-48e8-8492-ca9aeeee477c	false	saml.server.signature
c0b92108-6cf9-48e8-8492-ca9aeeee477c	false	saml.server.signature.keyinfo.ext
c0b92108-6cf9-48e8-8492-ca9aeeee477c	false	saml.assertion.signature
c0b92108-6cf9-48e8-8492-ca9aeeee477c	false	saml.client.signature
c0b92108-6cf9-48e8-8492-ca9aeeee477c	false	saml.encrypt
c0b92108-6cf9-48e8-8492-ca9aeeee477c	false	saml.authnstatement
c0b92108-6cf9-48e8-8492-ca9aeeee477c	false	saml.onetimeuse.condition
c0b92108-6cf9-48e8-8492-ca9aeeee477c	false	saml_force_name_id_format
c0b92108-6cf9-48e8-8492-ca9aeeee477c	false	saml.multivalued.roles
c0b92108-6cf9-48e8-8492-ca9aeeee477c	false	saml.force.post.binding
c0b92108-6cf9-48e8-8492-ca9aeeee477c	false	exclude.session.state.from.auth.response
c0b92108-6cf9-48e8-8492-ca9aeeee477c	false	tls.client.certificate.bound.access.tokens
c0b92108-6cf9-48e8-8492-ca9aeeee477c	false	display.on.consent.screen
\.


--
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_auth_flow_bindings (client_id, flow_id, binding_name) FROM stdin;
\.


--
-- Data for Name: client_default_roles; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_default_roles (client_id, role_id) FROM stdin;
4f7365a9-8d15-4e92-a47a-9e7708aa6957	e9582359-ecee-4c4e-b3a7-a84c52ac5c2c
4f7365a9-8d15-4e92-a47a-9e7708aa6957	2fadc715-6d70-4231-98b2-5238fd2ff60f
\.


--
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_initial_access (id, realm_id, "timestamp", expiration, count, remaining_count) FROM stdin;
\.


--
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_node_registrations (client_id, value, name) FROM stdin;
\.


--
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope (id, name, realm_id, description, protocol) FROM stdin;
2b3eca9f-044e-45e2-baef-c5c9a7f1ca5e	offline_access	master	OpenID Connect built-in scope: offline_access	openid-connect
16fb38ca-3eef-4f97-bc8e-3510a480eaff	role_list	master	SAML role list	saml
7476aa2c-595f-4011-8ed7-663c6f4d2f38	profile	master	OpenID Connect built-in scope: profile	openid-connect
1bf45c6f-647d-4063-963d-aa60d4ff7c71	email	master	OpenID Connect built-in scope: email	openid-connect
b0b86228-ec8b-44fd-880a-a7764a1f84c7	address	master	OpenID Connect built-in scope: address	openid-connect
d7fae07e-3a2a-455b-9393-72af0acb9f83	phone	master	OpenID Connect built-in scope: phone	openid-connect
b8d084e3-f815-4840-b0d0-3d7c8657519e	roles	master	OpenID Connect scope for add user roles to the access token	openid-connect
f2a9fffe-741d-42ac-a7ca-dbbf358d820b	web-origins	master	OpenID Connect scope for add allowed web origins to the access token	openid-connect
87a09492-95e1-4fef-b534-bb6e095cb004	microprofile-jwt	master	Microprofile - JWT built-in scope	openid-connect
a5363de2-e9ce-4196-be19-66f90cde5f4d	test-admin	master	\N	openid-connect
34bb9d18-9b9e-44dc-b9d4-cba9bf9f858c	test-user	master	\N	openid-connect
\.


--
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope_attributes (scope_id, value, name) FROM stdin;
2b3eca9f-044e-45e2-baef-c5c9a7f1ca5e	true	display.on.consent.screen
2b3eca9f-044e-45e2-baef-c5c9a7f1ca5e	${offlineAccessScopeConsentText}	consent.screen.text
16fb38ca-3eef-4f97-bc8e-3510a480eaff	true	display.on.consent.screen
16fb38ca-3eef-4f97-bc8e-3510a480eaff	${samlRoleListScopeConsentText}	consent.screen.text
7476aa2c-595f-4011-8ed7-663c6f4d2f38	true	display.on.consent.screen
7476aa2c-595f-4011-8ed7-663c6f4d2f38	${profileScopeConsentText}	consent.screen.text
7476aa2c-595f-4011-8ed7-663c6f4d2f38	true	include.in.token.scope
1bf45c6f-647d-4063-963d-aa60d4ff7c71	true	display.on.consent.screen
1bf45c6f-647d-4063-963d-aa60d4ff7c71	${emailScopeConsentText}	consent.screen.text
1bf45c6f-647d-4063-963d-aa60d4ff7c71	true	include.in.token.scope
b0b86228-ec8b-44fd-880a-a7764a1f84c7	true	display.on.consent.screen
b0b86228-ec8b-44fd-880a-a7764a1f84c7	${addressScopeConsentText}	consent.screen.text
b0b86228-ec8b-44fd-880a-a7764a1f84c7	true	include.in.token.scope
d7fae07e-3a2a-455b-9393-72af0acb9f83	true	display.on.consent.screen
d7fae07e-3a2a-455b-9393-72af0acb9f83	${phoneScopeConsentText}	consent.screen.text
d7fae07e-3a2a-455b-9393-72af0acb9f83	true	include.in.token.scope
b8d084e3-f815-4840-b0d0-3d7c8657519e	true	display.on.consent.screen
b8d084e3-f815-4840-b0d0-3d7c8657519e	${rolesScopeConsentText}	consent.screen.text
b8d084e3-f815-4840-b0d0-3d7c8657519e	false	include.in.token.scope
f2a9fffe-741d-42ac-a7ca-dbbf358d820b	false	display.on.consent.screen
f2a9fffe-741d-42ac-a7ca-dbbf358d820b		consent.screen.text
f2a9fffe-741d-42ac-a7ca-dbbf358d820b	false	include.in.token.scope
87a09492-95e1-4fef-b534-bb6e095cb004	false	display.on.consent.screen
87a09492-95e1-4fef-b534-bb6e095cb004	true	include.in.token.scope
a5363de2-e9ce-4196-be19-66f90cde5f4d	false	display.on.consent.screen
a5363de2-e9ce-4196-be19-66f90cde5f4d	true	include.in.token.scope
34bb9d18-9b9e-44dc-b9d4-cba9bf9f858c	false	display.on.consent.screen
34bb9d18-9b9e-44dc-b9d4-cba9bf9f858c	true	include.in.token.scope
\.


--
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope_client (client_id, scope_id, default_scope) FROM stdin;
4f7365a9-8d15-4e92-a47a-9e7708aa6957	16fb38ca-3eef-4f97-bc8e-3510a480eaff	t
c506d2fc-b7ca-43c2-8850-844800fd97ac	16fb38ca-3eef-4f97-bc8e-3510a480eaff	t
466c07ae-2aff-4e01-a1b0-f4701f4760b1	16fb38ca-3eef-4f97-bc8e-3510a480eaff	t
93d27599-f1b8-4e6c-9183-a460436682a6	16fb38ca-3eef-4f97-bc8e-3510a480eaff	t
424fffef-ec10-46fe-88f6-4d91caa2b885	16fb38ca-3eef-4f97-bc8e-3510a480eaff	t
df8928e5-088d-485f-b8d0-37e364492cb3	16fb38ca-3eef-4f97-bc8e-3510a480eaff	t
4f7365a9-8d15-4e92-a47a-9e7708aa6957	7476aa2c-595f-4011-8ed7-663c6f4d2f38	t
4f7365a9-8d15-4e92-a47a-9e7708aa6957	1bf45c6f-647d-4063-963d-aa60d4ff7c71	t
4f7365a9-8d15-4e92-a47a-9e7708aa6957	b8d084e3-f815-4840-b0d0-3d7c8657519e	t
4f7365a9-8d15-4e92-a47a-9e7708aa6957	f2a9fffe-741d-42ac-a7ca-dbbf358d820b	t
4f7365a9-8d15-4e92-a47a-9e7708aa6957	2b3eca9f-044e-45e2-baef-c5c9a7f1ca5e	f
4f7365a9-8d15-4e92-a47a-9e7708aa6957	b0b86228-ec8b-44fd-880a-a7764a1f84c7	f
4f7365a9-8d15-4e92-a47a-9e7708aa6957	d7fae07e-3a2a-455b-9393-72af0acb9f83	f
4f7365a9-8d15-4e92-a47a-9e7708aa6957	87a09492-95e1-4fef-b534-bb6e095cb004	f
c506d2fc-b7ca-43c2-8850-844800fd97ac	7476aa2c-595f-4011-8ed7-663c6f4d2f38	t
c506d2fc-b7ca-43c2-8850-844800fd97ac	1bf45c6f-647d-4063-963d-aa60d4ff7c71	t
c506d2fc-b7ca-43c2-8850-844800fd97ac	b8d084e3-f815-4840-b0d0-3d7c8657519e	t
c506d2fc-b7ca-43c2-8850-844800fd97ac	f2a9fffe-741d-42ac-a7ca-dbbf358d820b	t
c506d2fc-b7ca-43c2-8850-844800fd97ac	2b3eca9f-044e-45e2-baef-c5c9a7f1ca5e	f
c506d2fc-b7ca-43c2-8850-844800fd97ac	b0b86228-ec8b-44fd-880a-a7764a1f84c7	f
c506d2fc-b7ca-43c2-8850-844800fd97ac	d7fae07e-3a2a-455b-9393-72af0acb9f83	f
c506d2fc-b7ca-43c2-8850-844800fd97ac	87a09492-95e1-4fef-b534-bb6e095cb004	f
466c07ae-2aff-4e01-a1b0-f4701f4760b1	7476aa2c-595f-4011-8ed7-663c6f4d2f38	t
466c07ae-2aff-4e01-a1b0-f4701f4760b1	1bf45c6f-647d-4063-963d-aa60d4ff7c71	t
466c07ae-2aff-4e01-a1b0-f4701f4760b1	b8d084e3-f815-4840-b0d0-3d7c8657519e	t
466c07ae-2aff-4e01-a1b0-f4701f4760b1	f2a9fffe-741d-42ac-a7ca-dbbf358d820b	t
466c07ae-2aff-4e01-a1b0-f4701f4760b1	2b3eca9f-044e-45e2-baef-c5c9a7f1ca5e	f
466c07ae-2aff-4e01-a1b0-f4701f4760b1	b0b86228-ec8b-44fd-880a-a7764a1f84c7	f
466c07ae-2aff-4e01-a1b0-f4701f4760b1	d7fae07e-3a2a-455b-9393-72af0acb9f83	f
466c07ae-2aff-4e01-a1b0-f4701f4760b1	87a09492-95e1-4fef-b534-bb6e095cb004	f
93d27599-f1b8-4e6c-9183-a460436682a6	7476aa2c-595f-4011-8ed7-663c6f4d2f38	t
93d27599-f1b8-4e6c-9183-a460436682a6	1bf45c6f-647d-4063-963d-aa60d4ff7c71	t
93d27599-f1b8-4e6c-9183-a460436682a6	b8d084e3-f815-4840-b0d0-3d7c8657519e	t
93d27599-f1b8-4e6c-9183-a460436682a6	f2a9fffe-741d-42ac-a7ca-dbbf358d820b	t
93d27599-f1b8-4e6c-9183-a460436682a6	2b3eca9f-044e-45e2-baef-c5c9a7f1ca5e	f
93d27599-f1b8-4e6c-9183-a460436682a6	b0b86228-ec8b-44fd-880a-a7764a1f84c7	f
93d27599-f1b8-4e6c-9183-a460436682a6	d7fae07e-3a2a-455b-9393-72af0acb9f83	f
93d27599-f1b8-4e6c-9183-a460436682a6	87a09492-95e1-4fef-b534-bb6e095cb004	f
424fffef-ec10-46fe-88f6-4d91caa2b885	7476aa2c-595f-4011-8ed7-663c6f4d2f38	t
424fffef-ec10-46fe-88f6-4d91caa2b885	1bf45c6f-647d-4063-963d-aa60d4ff7c71	t
424fffef-ec10-46fe-88f6-4d91caa2b885	b8d084e3-f815-4840-b0d0-3d7c8657519e	t
424fffef-ec10-46fe-88f6-4d91caa2b885	f2a9fffe-741d-42ac-a7ca-dbbf358d820b	t
424fffef-ec10-46fe-88f6-4d91caa2b885	2b3eca9f-044e-45e2-baef-c5c9a7f1ca5e	f
424fffef-ec10-46fe-88f6-4d91caa2b885	b0b86228-ec8b-44fd-880a-a7764a1f84c7	f
424fffef-ec10-46fe-88f6-4d91caa2b885	d7fae07e-3a2a-455b-9393-72af0acb9f83	f
424fffef-ec10-46fe-88f6-4d91caa2b885	87a09492-95e1-4fef-b534-bb6e095cb004	f
df8928e5-088d-485f-b8d0-37e364492cb3	7476aa2c-595f-4011-8ed7-663c6f4d2f38	t
df8928e5-088d-485f-b8d0-37e364492cb3	1bf45c6f-647d-4063-963d-aa60d4ff7c71	t
df8928e5-088d-485f-b8d0-37e364492cb3	b8d084e3-f815-4840-b0d0-3d7c8657519e	t
df8928e5-088d-485f-b8d0-37e364492cb3	f2a9fffe-741d-42ac-a7ca-dbbf358d820b	t
df8928e5-088d-485f-b8d0-37e364492cb3	2b3eca9f-044e-45e2-baef-c5c9a7f1ca5e	f
df8928e5-088d-485f-b8d0-37e364492cb3	b0b86228-ec8b-44fd-880a-a7764a1f84c7	f
df8928e5-088d-485f-b8d0-37e364492cb3	d7fae07e-3a2a-455b-9393-72af0acb9f83	f
df8928e5-088d-485f-b8d0-37e364492cb3	87a09492-95e1-4fef-b534-bb6e095cb004	f
c0b92108-6cf9-48e8-8492-ca9aeeee477c	16fb38ca-3eef-4f97-bc8e-3510a480eaff	t
c0b92108-6cf9-48e8-8492-ca9aeeee477c	7476aa2c-595f-4011-8ed7-663c6f4d2f38	t
c0b92108-6cf9-48e8-8492-ca9aeeee477c	1bf45c6f-647d-4063-963d-aa60d4ff7c71	t
c0b92108-6cf9-48e8-8492-ca9aeeee477c	f2a9fffe-741d-42ac-a7ca-dbbf358d820b	t
c0b92108-6cf9-48e8-8492-ca9aeeee477c	2b3eca9f-044e-45e2-baef-c5c9a7f1ca5e	f
c0b92108-6cf9-48e8-8492-ca9aeeee477c	b0b86228-ec8b-44fd-880a-a7764a1f84c7	f
c0b92108-6cf9-48e8-8492-ca9aeeee477c	d7fae07e-3a2a-455b-9393-72af0acb9f83	f
c0b92108-6cf9-48e8-8492-ca9aeeee477c	87a09492-95e1-4fef-b534-bb6e095cb004	f
c0b92108-6cf9-48e8-8492-ca9aeeee477c	34bb9d18-9b9e-44dc-b9d4-cba9bf9f858c	t
c0b92108-6cf9-48e8-8492-ca9aeeee477c	a5363de2-e9ce-4196-be19-66f90cde5f4d	f
\.


--
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope_role_mapping (scope_id, role_id) FROM stdin;
2b3eca9f-044e-45e2-baef-c5c9a7f1ca5e	6954cf7c-3069-4aaf-8730-1b0362e0105d
a5363de2-e9ce-4196-be19-66f90cde5f4d	1253b37d-b1ec-4517-a760-818b7d92303c
34bb9d18-9b9e-44dc-b9d4-cba9bf9f858c	c6b8d21d-bd9f-4743-a669-e4aa45b6a6c9
\.


--
-- Data for Name: client_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session (id, client_id, redirect_uri, state, "timestamp", session_id, auth_method, realm_id, auth_user_id, current_action) FROM stdin;
\.


--
-- Data for Name: client_session_auth_status; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session_auth_status (authenticator, status, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_note; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_prot_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session_prot_mapper (protocol_mapper_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session_role (role_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_user_session_note; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_user_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
505b88e2-fdc0-4914-abb4-7ce4fc1579a4	Trusted Hosts	master	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
d242805c-7105-408b-a7a2-e3c7346ae659	Consent Required	master	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
6dcb9089-98a2-491c-a508-049154540fb5	Full Scope Disabled	master	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
0c9d128a-b40a-47e8-a18f-71ae611b9cce	Max Clients Limit	master	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
78642d10-ea52-4404-8089-49b73424a577	Allowed Protocol Mapper Types	master	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
df4bfd64-50fa-462e-8991-ea7ddb06487c	Allowed Client Scopes	master	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
cb6b9247-25b1-48b1-bb5b-acfdd45e58dc	Allowed Protocol Mapper Types	master	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	authenticated
19224f5f-936c-4787-8aec-2d41b18cbc99	Allowed Client Scopes	master	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	authenticated
d0580433-7d0e-48e5-9b7b-35b37e28bf9b	rsa-generated	master	rsa-generated	org.keycloak.keys.KeyProvider	master	\N
985a5605-d956-4007-89b7-405cdcdf3958	hmac-generated	master	hmac-generated	org.keycloak.keys.KeyProvider	master	\N
e8ea68eb-68de-4b39-b9d5-9f2c666c2087	aes-generated	master	aes-generated	org.keycloak.keys.KeyProvider	master	\N
\.


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.component_config (id, component_id, name, value) FROM stdin;
7b99e785-ac12-42f4-9443-3415a7b046ea	cb6b9247-25b1-48b1-bb5b-acfdd45e58dc	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
876614fb-295c-4dcb-819b-38ede3630d4b	cb6b9247-25b1-48b1-bb5b-acfdd45e58dc	allowed-protocol-mapper-types	saml-user-attribute-mapper
07792eab-89d2-40fe-a003-f425c6d834dc	cb6b9247-25b1-48b1-bb5b-acfdd45e58dc	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
825b2187-675e-430d-bfb2-f6297b7fb472	cb6b9247-25b1-48b1-bb5b-acfdd45e58dc	allowed-protocol-mapper-types	oidc-address-mapper
d153cbf4-c6c4-4bae-a472-5d87f74b1edb	cb6b9247-25b1-48b1-bb5b-acfdd45e58dc	allowed-protocol-mapper-types	saml-user-property-mapper
40b3cd6e-e01f-4eb8-adcc-3ad97ae0792e	cb6b9247-25b1-48b1-bb5b-acfdd45e58dc	allowed-protocol-mapper-types	saml-role-list-mapper
690157a9-af0b-49ca-94b2-04b722ea83b8	cb6b9247-25b1-48b1-bb5b-acfdd45e58dc	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
8b21f4d2-d980-4438-a61c-d321e7cb4ab0	cb6b9247-25b1-48b1-bb5b-acfdd45e58dc	allowed-protocol-mapper-types	oidc-full-name-mapper
dd432811-5834-47f8-9482-dbc6bbe6afe8	19224f5f-936c-4787-8aec-2d41b18cbc99	allow-default-scopes	true
5336c5b7-1edf-44f3-8a35-fe4e5caf5f43	505b88e2-fdc0-4914-abb4-7ce4fc1579a4	client-uris-must-match	true
1e7b9b4f-b66a-4f7e-99c1-d390b3eb6717	505b88e2-fdc0-4914-abb4-7ce4fc1579a4	host-sending-registration-request-must-match	true
5350fd89-b5e6-415c-99f6-f09fcb544ab2	df4bfd64-50fa-462e-8991-ea7ddb06487c	allow-default-scopes	true
2d669a60-f275-4092-8aa9-69e5847d6e47	0c9d128a-b40a-47e8-a18f-71ae611b9cce	max-clients	200
b338d80a-2932-41a4-9d04-f2f48784076b	78642d10-ea52-4404-8089-49b73424a577	allowed-protocol-mapper-types	oidc-full-name-mapper
faf4789b-b5bc-4cf4-8cff-f187801bf6df	78642d10-ea52-4404-8089-49b73424a577	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
ce9d0f86-9be8-447c-a92f-dbe48634c01a	78642d10-ea52-4404-8089-49b73424a577	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
cff9bf0b-a014-4615-9bd2-605a5136804c	78642d10-ea52-4404-8089-49b73424a577	allowed-protocol-mapper-types	oidc-address-mapper
b4b84ca4-69ea-4b02-bf60-fa7c22331d8f	78642d10-ea52-4404-8089-49b73424a577	allowed-protocol-mapper-types	saml-role-list-mapper
3b72f071-1c09-4bba-aed6-b948abc6da14	78642d10-ea52-4404-8089-49b73424a577	allowed-protocol-mapper-types	saml-user-attribute-mapper
69f97af0-f45f-4cef-89a2-e4b029a23e87	78642d10-ea52-4404-8089-49b73424a577	allowed-protocol-mapper-types	saml-user-property-mapper
245259a1-3ebf-404e-a55a-142572d294cd	78642d10-ea52-4404-8089-49b73424a577	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
2c3efa3c-a1a1-41cf-848a-fc5645808bd5	985a5605-d956-4007-89b7-405cdcdf3958	kid	b5b8638d-a4e5-49f0-9d41-f97108451161
e37c02e1-6132-4f2f-83c7-5f35a6879938	985a5605-d956-4007-89b7-405cdcdf3958	priority	100
f70e85f1-2813-478b-aa6c-f0f56330866a	985a5605-d956-4007-89b7-405cdcdf3958	secret	zgRjP3aW3uMK-9wo59YaEV-ULepCDNBLuhUvZPuSdg9nlh2RqxAUv9VO0FEB1oRi428tIzECwgPl7slVY8Jw8A
2f37c82d-e71d-447b-8ef7-e2d45d189a80	985a5605-d956-4007-89b7-405cdcdf3958	algorithm	HS256
1575ba60-6c8a-4db1-8e71-88c1544a5e8d	e8ea68eb-68de-4b39-b9d5-9f2c666c2087	priority	100
9cd70d36-ed8b-4c50-b538-05587b75ce1e	e8ea68eb-68de-4b39-b9d5-9f2c666c2087	secret	IQtZC_ywlijFIe60LAx2JA
c489bb8c-b7a4-412d-bd2a-28ddaededc40	e8ea68eb-68de-4b39-b9d5-9f2c666c2087	kid	7fdec9ec-68fa-481d-85d9-52ab59510414
cd501a71-d55f-4c6e-899b-6b12b71d4afa	d0580433-7d0e-48e5-9b7b-35b37e28bf9b	priority	100
8254d5fd-587d-4a7a-b47a-a3d4a919319e	d0580433-7d0e-48e5-9b7b-35b37e28bf9b	certificate	MIICmzCCAYMCBgFwuS2vRjANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjAwMzA4MDgwNDAzWhcNMzAwMzA4MDgwNTQzWjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCTDe8odsxyBbUsYsBDKCXQoDpYwV0emHt0MMTLVvG1LjDdJVTXtrwbxeOhE7wM1yagpdxs+FJ4/5RTJHzYKvtciQ6afjNFyFo7qGqc6k9IiFIJ+MQ3TiXF18pEgO7TcdD044MHaM+ZgvA55AEEID/Z/JkIQ/tCyBIQQwIQoyQMxWy992ras3GHvK7vefBc7YQKfPRqYaZ6Ot1c5uuHSvxpDi+YUBw5sJfm9DbPIq9/d/cEE6r2rndj7PT8CMzQpoiQdKME5JXRgCEYOLBNmN7RbBwQDKwm9sCU7PNbc8ALdKUE45/eqABj/kuGs6X2h6JsyfiJbNaSitqFozwH2OGDAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAFs2gPSII//ar4Cd3bp4XPD2j8ZzTbOKXfCFK8z7qtGrpMkEXZ9NR9wPYhL4fnqMTib+pEu+yZDUafLjOXVUXscpvMMPY5pXqgFnw3y5yPSwpJm+JJcXctM+iZVblPsI4XoDAerAcKuFWPMWH7cyKaeLVpnsvcv3js2nS8Yt8tAKoTAAeTNOPZHw+PD0HyNS952glllLYRqLQFzNtolvEfq03G699DMEhpD9zS2Z/5E5sKkF90Srgx2TxXXcVHFc2tAF3iJ85C7YbCQ8o8SchETKGbVVLaYI7DJVPYMHmquIbvk5omUrWu14ZOspu1pQhJR21MXh7EWABVHBkhAY0IU=
8c9d8405-fd8f-432e-ba4d-ac2c43f30be3	d0580433-7d0e-48e5-9b7b-35b37e28bf9b	privateKey	MIIEpAIBAAKCAQEAkw3vKHbMcgW1LGLAQygl0KA6WMFdHph7dDDEy1bxtS4w3SVU17a8G8XjoRO8DNcmoKXcbPhSeP+UUyR82Cr7XIkOmn4zRchaO6hqnOpPSIhSCfjEN04lxdfKRIDu03HQ9OODB2jPmYLwOeQBBCA/2fyZCEP7QsgSEEMCEKMkDMVsvfdq2rNxh7yu73nwXO2ECnz0amGmejrdXObrh0r8aQ4vmFAcObCX5vQ2zyKvf3f3BBOq9q53Y+z0/AjM0KaIkHSjBOSV0YAhGDiwTZje0WwcEAysJvbAlOzzW3PAC3SlBOOf3qgAY/5LhrOl9oeibMn4iWzWkorahaM8B9jhgwIDAQABAoIBAAC8aR4CujM35Bg8xkmPweCxbJlVHmowyS1jsRhzbvJBMO1qampJ99cLvn/n4WEPEpprOhcxhvgkD1H7NMTAMlHcPb54Mzl+LzVtOltesNbkF8UFAbZlJbs/wTtmict1Hl6bZOR8mc1i4mDnyzmCD8+/e+SWsoM7DRwXucLrjhqiQF/AQZ/yV+VdCs2XlHPJ+eDXaa91HB2VLsgQT1W4NA4Tz/Df/3bnRPn31DbJsjGcYmvzHDovaS1BEo5M0pQQQDdvsQKiI0lkZy6Z2l/zWKqAMJxNqVfBdb97mEOiVm9O9aK350/SN2bF5d4b3kQL6NejseTmmCKBbw/rG/bV6IECgYEAxo9ytOe5V+OwzvZLwUfUwj6ItDM2wvfvMAT+e8AM0gX3rOtbMXLwEUzGQmaBPGzsUonIvQvaYU0CYjZoWRKCs5zOOpFmDfZy6Is7TILVQq8auvu9gBWxZs58khUedOKwC6VqF9mqz0jEuUFudZwX7EJpF7/z0GzP13+6HaA/26kCgYEAvZgsOOmizvFc6me19EIH2JLAU9Q0lnsJ1PS29HAwSvLNIVvVbsF/DwCTRqizaj9cya4rkl6fgta4xTaAjAbbzvO4yooDRqlXsxWMPOvDIO+y2nNRAmBBDhzOPGnEEa3scpmXKpNn8eUjN7qMs4qwlC0UwRpDJIIqLazNHOMDr0sCgYEAk1oC+wN4BSRAouYeg9oFpvz3QBs9iWSrSUx7emSkXvv0uIuUilbMl1oNS1t8jtYaboo3wStZrZmTqkTMHUXiXt6AIPCj9rqsvawNnpL9JlaCFL8a+0Gd/DhCM7qedol/sbTYzchHvTo4W26WRYtIKZmDGg/mJQeLGlZ8TN4OZbkCgYEArHoXIN9KwUBJ6uTWXpMDWD6IwLo37P2ZgCXvmofFJymi+0nz7IIS+K7pTEqEjY9+9eqAsPNr4Tc9eAuQ/dHvfWGzJm5PdKTxp3Ve0r0YEop9BsYJWEQAarpB1CvTttGmXMrk/lKDKUfute/7uAnfga1RSCqAEmJnxI2DO1g6LekCgYB7FB6JOjq2WzWcsJgRxzi/QYwECB9DxiV1uiJsYSCF39capDztnYM2jrLu5ZxF0CsUx3P/bdzWVwpkKkjuC1cukuNWD7Chir0aRhY4HBQ/CQTgn5fEiMOZDN1QFKscjjqz0ZQC976Q9ut9QLq7hm8fQA1UXB1e/rmldzCPUSF1iA==
\.


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.composite_role (composite, child_role) FROM stdin;
d74f88e3-f626-4133-92ed-570abfcd9f09	bc1f4f91-bb00-4434-a99e-82dec51523bb
d74f88e3-f626-4133-92ed-570abfcd9f09	70599704-e626-4906-bef9-54e4b083a444
d74f88e3-f626-4133-92ed-570abfcd9f09	757ac25d-99a7-4d2b-adfb-35d357889cde
d74f88e3-f626-4133-92ed-570abfcd9f09	991d35a6-62f8-4a1b-b941-7b33c6efacf9
d74f88e3-f626-4133-92ed-570abfcd9f09	5d28a4ad-aedd-404a-a337-2552b2b5c3fc
d74f88e3-f626-4133-92ed-570abfcd9f09	99756a68-8dcd-4ae7-9e0b-83c63418c46f
d74f88e3-f626-4133-92ed-570abfcd9f09	b35bb2de-e4bf-4b89-9e70-f86b3f336562
d74f88e3-f626-4133-92ed-570abfcd9f09	afcd7ecf-8cab-4f78-bb46-54f1950b764a
d74f88e3-f626-4133-92ed-570abfcd9f09	da09cf02-809b-4a00-a9b7-14e9b5a2b8ea
d74f88e3-f626-4133-92ed-570abfcd9f09	6527c21c-84c0-4985-8bf7-cd09d33e39cb
d74f88e3-f626-4133-92ed-570abfcd9f09	bcaa6b2a-cf26-40b2-882b-338e8d27b81e
d74f88e3-f626-4133-92ed-570abfcd9f09	b19e94bf-2f5f-495d-9a8f-d2913a54bb9c
d74f88e3-f626-4133-92ed-570abfcd9f09	cd42c89e-d9d7-4d34-9624-690201536750
d74f88e3-f626-4133-92ed-570abfcd9f09	dca90be2-3c13-4187-aa6d-20565a458c7d
d74f88e3-f626-4133-92ed-570abfcd9f09	4f81400e-2180-437a-b66b-3910095fa478
d74f88e3-f626-4133-92ed-570abfcd9f09	e52f9bf9-d104-42dd-b79b-6518bf9bcfc9
d74f88e3-f626-4133-92ed-570abfcd9f09	421223da-7e83-4bb3-ac55-12b02a9c688d
d74f88e3-f626-4133-92ed-570abfcd9f09	318823c6-e72c-40aa-9a27-b8be9d810e64
991d35a6-62f8-4a1b-b941-7b33c6efacf9	4f81400e-2180-437a-b66b-3910095fa478
991d35a6-62f8-4a1b-b941-7b33c6efacf9	318823c6-e72c-40aa-9a27-b8be9d810e64
5d28a4ad-aedd-404a-a337-2552b2b5c3fc	e52f9bf9-d104-42dd-b79b-6518bf9bcfc9
2fadc715-6d70-4231-98b2-5238fd2ff60f	5105339a-caee-4941-827a-fa4671e0a9f2
e9318cb5-1360-4492-be00-9d02748f7ce4	ae2fa261-f094-4368-8873-3e32b1f1e18f
d74f88e3-f626-4133-92ed-570abfcd9f09	4875f454-a832-4daa-bde6-2e14c6f44609
\.


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) FROM stdin;
a5e8db7d-9326-439a-93d1-e3d16a039958	\N	password	156a9ddd-f0eb-479a-9bb5-2aa308447f4f	1583654744601	\N	{"value":"hQStmEBOi0gK3yFHFMZSqmmOxowiL34OssuAuCYE1Gfb5VJ0hVI7j7ML4uAJzkXn0iBmRVDzkMUqeqbB1bRaQg==","salt":"9t/aWB6d5GqPZ8ruy6Gj1A=="}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256"}	10
0db8f558-a49a-4c98-b001-32d5676d804a	\N	password	87ad209a-e02e-42a7-9020-8fd1c04fb384	1583655207244	\N	{"value":"JQuwK8gATCKsFosAvC5jesleqNxOxPp/mot40PZpCJhvw9Ql648Rrj9Ha78vKGIxwEhK75IJvqMu+TqQKW81pg==","salt":"83ysbJASrEzuDP2i8zdnpA=="}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256"}	10
05aabf54-e011-4ee3-b8fb-2ad0939e9399	\N	password	98f54b1f-e715-457b-9e24-4aaf8636239e	1583660518404	\N	{"value":"q7ilCMYd3DB8O8oaj0z7HpaE2rhLOVxCwlLm7mawJBeHZ9mzvuXmM3gDVMGT/H6j1a+Bn4mpQ6l1vqoszcwCwA==","salt":"sFqbWqKIQM04nVGWCeKNuQ=="}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256"}	10
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2020-03-08 08:05:33.189116	1	EXECUTED	7:4e70412f24a3f382c82183742ec79317	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	3.5.4	\N	\N	3654731977
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2020-03-08 08:05:33.208481	2	MARK_RAN	7:cb16724583e9675711801c6875114f28	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	3.5.4	\N	\N	3654731977
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2020-03-08 08:05:33.349424	3	EXECUTED	7:0310eb8ba07cec616460794d42ade0fa	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	3.5.4	\N	\N	3654731977
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2020-03-08 08:05:33.358544	4	EXECUTED	7:5d25857e708c3233ef4439df1f93f012	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	3.5.4	\N	\N	3654731977
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2020-03-08 08:05:33.825797	5	EXECUTED	7:c7a54a1041d58eb3817a4a883b4d4e84	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	3.5.4	\N	\N	3654731977
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2020-03-08 08:05:33.83023	6	MARK_RAN	7:2e01012df20974c1c2a605ef8afe25b7	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	3.5.4	\N	\N	3654731977
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2020-03-08 08:05:34.130966	7	EXECUTED	7:0f08df48468428e0f30ee59a8ec01a41	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	3.5.4	\N	\N	3654731977
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2020-03-08 08:05:34.138518	8	MARK_RAN	7:a77ea2ad226b345e7d689d366f185c8c	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	3.5.4	\N	\N	3654731977
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2020-03-08 08:05:34.237829	9	EXECUTED	7:a3377a2059aefbf3b90ebb4c4cc8e2ab	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	3.5.4	\N	\N	3654731977
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2020-03-08 08:05:34.656185	10	EXECUTED	7:04c1dbedc2aa3e9756d1a1668e003451	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	3.5.4	\N	\N	3654731977
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2020-03-08 08:05:34.943207	11	EXECUTED	7:36ef39ed560ad07062d956db861042ba	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	3.5.4	\N	\N	3654731977
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2020-03-08 08:05:34.949398	12	MARK_RAN	7:d909180b2530479a716d3f9c9eaea3d7	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	3.5.4	\N	\N	3654731977
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2020-03-08 08:05:34.973845	13	EXECUTED	7:cf12b04b79bea5152f165eb41f3955f6	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	3.5.4	\N	\N	3654731977
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2020-03-08 08:05:35.011846	14	EXECUTED	7:7e32c8f05c755e8675764e7d5f514509	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	3.5.4	\N	\N	3654731977
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2020-03-08 08:05:35.016935	15	MARK_RAN	7:980ba23cc0ec39cab731ce903dd01291	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	3.5.4	\N	\N	3654731977
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2020-03-08 08:05:35.021632	16	MARK_RAN	7:2fa220758991285312eb84f3b4ff5336	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	3.5.4	\N	\N	3654731977
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2020-03-08 08:05:35.026706	17	EXECUTED	7:d41d8cd98f00b204e9800998ecf8427e	empty		\N	3.5.4	\N	\N	3654731977
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2020-03-08 08:05:35.095659	18	EXECUTED	7:91ace540896df890cc00a0490ee52bbc	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	3.5.4	\N	\N	3654731977
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2020-03-08 08:05:35.155348	19	EXECUTED	7:c31d1646dfa2618a9335c00e07f89f24	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	3.5.4	\N	\N	3654731977
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2020-03-08 08:05:35.161969	20	EXECUTED	7:df8bc21027a4f7cbbb01f6344e89ce07	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	3.5.4	\N	\N	3654731977
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2020-03-08 08:05:36.176346	45	EXECUTED	7:6a48ce645a3525488a90fbf76adf3bb3	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	3.5.4	\N	\N	3654731977
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2020-03-08 08:05:35.164958	21	MARK_RAN	7:f987971fe6b37d963bc95fee2b27f8df	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	3.5.4	\N	\N	3654731977
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2020-03-08 08:05:35.170665	22	MARK_RAN	7:df8bc21027a4f7cbbb01f6344e89ce07	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	3.5.4	\N	\N	3654731977
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2020-03-08 08:05:35.203014	23	EXECUTED	7:ed2dc7f799d19ac452cbcda56c929e47	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	3.5.4	\N	\N	3654731977
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2020-03-08 08:05:35.213306	24	EXECUTED	7:80b5db88a5dda36ece5f235be8757615	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	3.5.4	\N	\N	3654731977
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2020-03-08 08:05:35.218147	25	MARK_RAN	7:1437310ed1305a9b93f8848f301726ce	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	3.5.4	\N	\N	3654731977
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2020-03-08 08:05:35.280445	26	EXECUTED	7:b82ffb34850fa0836be16deefc6a87c4	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	3.5.4	\N	\N	3654731977
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2020-03-08 08:05:35.392205	27	EXECUTED	7:9cc98082921330d8d9266decdd4bd658	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	3.5.4	\N	\N	3654731977
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2020-03-08 08:05:35.400212	28	EXECUTED	7:03d64aeed9cb52b969bd30a7ac0db57e	update tableName=RESOURCE_SERVER_POLICY		\N	3.5.4	\N	\N	3654731977
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2020-03-08 08:05:35.515008	29	EXECUTED	7:f1f9fd8710399d725b780f463c6b21cd	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	3.5.4	\N	\N	3654731977
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2020-03-08 08:05:35.545396	30	EXECUTED	7:53188c3eb1107546e6f765835705b6c1	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	3.5.4	\N	\N	3654731977
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2020-03-08 08:05:35.569761	31	EXECUTED	7:d6e6f3bc57a0c5586737d1351725d4d4	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	3.5.4	\N	\N	3654731977
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2020-03-08 08:05:35.575175	32	EXECUTED	7:454d604fbd755d9df3fd9c6329043aa5	customChange		\N	3.5.4	\N	\N	3654731977
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2020-03-08 08:05:35.582297	33	EXECUTED	7:57e98a3077e29caf562f7dbf80c72600	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	3.5.4	\N	\N	3654731977
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2020-03-08 08:05:35.585284	34	MARK_RAN	7:e4c7e8f2256210aee71ddc42f538b57a	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	3.5.4	\N	\N	3654731977
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2020-03-08 08:05:35.63128	35	EXECUTED	7:09a43c97e49bc626460480aa1379b522	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	3.5.4	\N	\N	3654731977
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2020-03-08 08:05:35.646814	36	EXECUTED	7:26bfc7c74fefa9126f2ce702fb775553	addColumn tableName=REALM		\N	3.5.4	\N	\N	3654731977
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2020-03-08 08:05:35.669288	37	EXECUTED	7:a161e2ae671a9020fff61e996a207377	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	3.5.4	\N	\N	3654731977
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2020-03-08 08:05:35.691238	38	EXECUTED	7:37fc1781855ac5388c494f1442b3f717	addColumn tableName=FED_USER_CONSENT		\N	3.5.4	\N	\N	3654731977
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2020-03-08 08:05:35.704508	39	EXECUTED	7:13a27db0dae6049541136adad7261d27	addColumn tableName=IDENTITY_PROVIDER		\N	3.5.4	\N	\N	3654731977
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2020-03-08 08:05:35.715061	40	MARK_RAN	7:550300617e3b59e8af3a6294df8248a3	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	3.5.4	\N	\N	3654731977
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2020-03-08 08:05:35.72103	41	MARK_RAN	7:e3a9482b8931481dc2772a5c07c44f17	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	3.5.4	\N	\N	3654731977
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2020-03-08 08:05:35.737636	42	EXECUTED	7:72b07d85a2677cb257edb02b408f332d	customChange		\N	3.5.4	\N	\N	3654731977
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2020-03-08 08:05:36.134348	43	EXECUTED	7:a72a7858967bd414835d19e04d880312	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	3.5.4	\N	\N	3654731977
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2020-03-08 08:05:36.151673	44	EXECUTED	7:94edff7cf9ce179e7e85f0cd78a3cf2c	addColumn tableName=USER_ENTITY		\N	3.5.4	\N	\N	3654731977
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2020-03-08 08:05:36.196718	46	EXECUTED	7:e64b5dcea7db06077c6e57d3b9e5ca14	customChange		\N	3.5.4	\N	\N	3654731977
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2020-03-08 08:05:36.209634	47	MARK_RAN	7:fd8cf02498f8b1e72496a20afc75178c	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	3.5.4	\N	\N	3654731977
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2020-03-08 08:05:36.312408	48	EXECUTED	7:542794f25aa2b1fbabb7e577d6646319	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	3.5.4	\N	\N	3654731977
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2020-03-08 08:05:36.326999	49	EXECUTED	7:edad604c882df12f74941dac3cc6d650	addColumn tableName=REALM		\N	3.5.4	\N	\N	3654731977
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2020-03-08 08:05:36.469087	50	EXECUTED	7:0f88b78b7b46480eb92690cbf5e44900	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	3.5.4	\N	\N	3654731977
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2020-03-08 08:05:36.580372	51	EXECUTED	7:d560e43982611d936457c327f872dd59	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	3.5.4	\N	\N	3654731977
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2020-03-08 08:05:36.585492	52	EXECUTED	7:c155566c42b4d14ef07059ec3b3bbd8e	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	3.5.4	\N	\N	3654731977
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2020-03-08 08:05:36.592972	53	EXECUTED	7:b40376581f12d70f3c89ba8ddf5b7dea	update tableName=REALM		\N	3.5.4	\N	\N	3654731977
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2020-03-08 08:05:36.606137	54	EXECUTED	7:a1132cc395f7b95b3646146c2e38f168	update tableName=CLIENT		\N	3.5.4	\N	\N	3654731977
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2020-03-08 08:05:36.628563	55	EXECUTED	7:d8dc5d89c789105cfa7ca0e82cba60af	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	3.5.4	\N	\N	3654731977
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2020-03-08 08:05:36.638341	56	EXECUTED	7:7822e0165097182e8f653c35517656a3	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	3.5.4	\N	\N	3654731977
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2020-03-08 08:05:36.681811	57	EXECUTED	7:c6538c29b9c9a08f9e9ea2de5c2b6375	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	3.5.4	\N	\N	3654731977
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2020-03-08 08:05:36.868894	58	EXECUTED	7:6d4893e36de22369cf73bcb051ded875	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	3.5.4	\N	\N	3654731977
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2020-03-08 08:05:36.919433	59	EXECUTED	7:57960fc0b0f0dd0563ea6f8b2e4a1707	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	3.5.4	\N	\N	3654731977
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2020-03-08 08:05:36.931162	60	EXECUTED	7:2b4b8bff39944c7097977cc18dbceb3b	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	3.5.4	\N	\N	3654731977
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2020-03-08 08:05:36.950635	61	EXECUTED	7:2aa42a964c59cd5b8ca9822340ba33a8	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	3.5.4	\N	\N	3654731977
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2020-03-08 08:05:36.972555	62	EXECUTED	7:9ac9e58545479929ba23f4a3087a0346	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	3.5.4	\N	\N	3654731977
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2020-03-08 08:05:36.983931	63	EXECUTED	7:14d407c35bc4fe1976867756bcea0c36	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	3.5.4	\N	\N	3654731977
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2020-03-08 08:05:36.991916	64	EXECUTED	7:241a8030c748c8548e346adee548fa93	update tableName=REQUIRED_ACTION_PROVIDER		\N	3.5.4	\N	\N	3654731977
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2020-03-08 08:05:36.997707	65	EXECUTED	7:7d3182f65a34fcc61e8d23def037dc3f	update tableName=RESOURCE_SERVER_RESOURCE		\N	3.5.4	\N	\N	3654731977
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2020-03-08 08:05:37.031163	66	EXECUTED	7:b30039e00a0b9715d430d1b0636728fa	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	3.5.4	\N	\N	3654731977
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2020-03-08 08:05:37.041302	67	EXECUTED	7:3797315ca61d531780f8e6f82f258159	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	3.5.4	\N	\N	3654731977
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2020-03-08 08:05:37.050683	68	EXECUTED	7:c7aa4c8d9573500c2d347c1941ff0301	addColumn tableName=REALM		\N	3.5.4	\N	\N	3654731977
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2020-03-08 08:05:37.079628	69	EXECUTED	7:b207faee394fc074a442ecd42185a5dd	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	3.5.4	\N	\N	3654731977
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2020-03-08 08:05:37.096605	70	EXECUTED	7:ab9a9762faaba4ddfa35514b212c4922	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	3.5.4	\N	\N	3654731977
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2020-03-08 08:05:37.111064	71	EXECUTED	7:b9710f74515a6ccb51b72dc0d19df8c4	addColumn tableName=RESOURCE_SERVER		\N	3.5.4	\N	\N	3654731977
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2020-03-08 08:05:37.124056	72	EXECUTED	7:ec9707ae4d4f0b7452fee20128083879	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	3.5.4	\N	\N	3654731977
8.0.0-updating-credential-data-not-oracle	keycloak	META-INF/jpa-changelog-8.0.0.xml	2020-03-08 08:05:37.13875	73	EXECUTED	7:03b3f4b264c3c68ba082250a80b74216	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	3.5.4	\N	\N	3654731977
8.0.0-updating-credential-data-oracle	keycloak	META-INF/jpa-changelog-8.0.0.xml	2020-03-08 08:05:37.144466	74	MARK_RAN	7:64c5728f5ca1f5aa4392217701c4fe23	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	3.5.4	\N	\N	3654731977
8.0.0-credential-cleanup	keycloak	META-INF/jpa-changelog-8.0.0.xml	2020-03-08 08:05:37.185456	75	EXECUTED	7:41f3566ac5177459e1ed3ce8f0ad35d2	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	3.5.4	\N	\N	3654731977
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2020-03-08 08:05:37.204107	76	EXECUTED	7:a73379915c23bfad3e8f5c6d5c0aa4bd	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	3.5.4	\N	\N	3654731977
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2020-03-08 08:05:37.215966	77	EXECUTED	7:39e0073779aba192646291aa2332493d	addColumn tableName=CLIENT		\N	3.5.4	\N	\N	3654731977
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2020-03-08 08:05:37.221315	78	MARK_RAN	7:81f87368f00450799b4bf42ea0b3ec34	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	3.5.4	\N	\N	3654731977
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2020-03-08 08:05:37.254462	79	EXECUTED	7:20b37422abb9fb6571c618148f013a15	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	3.5.4	\N	\N	3654731977
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2020-03-08 08:05:37.25755	80	MARK_RAN	7:1970bb6cfb5ee800736b95ad3fb3c78a	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	3.5.4	\N	\N	3654731977
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
1000	f	\N	\N
1001	f	\N	\N
\.


--
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.default_client_scope (realm_id, scope_id, default_scope) FROM stdin;
master	2b3eca9f-044e-45e2-baef-c5c9a7f1ca5e	f
master	16fb38ca-3eef-4f97-bc8e-3510a480eaff	t
master	7476aa2c-595f-4011-8ed7-663c6f4d2f38	t
master	1bf45c6f-647d-4063-963d-aa60d4ff7c71	t
master	b0b86228-ec8b-44fd-880a-a7764a1f84c7	f
master	d7fae07e-3a2a-455b-9393-72af0acb9f83	f
master	b8d084e3-f815-4840-b0d0-3d7c8657519e	t
master	f2a9fffe-741d-42ac-a7ca-dbbf358d820b	t
master	87a09492-95e1-4fef-b534-bb6e095cb004	f
\.


--
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.event_entity (id, client_id, details_json, error, ip_address, realm_id, session_id, event_time, type, user_id) FROM stdin;
\.


--
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_attribute (id, name, user_id, realm_id, storage_provider_id, value) FROM stdin;
\.


--
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_consent (id, client_id, user_id, realm_id, storage_provider_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_consent_cl_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_credential (id, salt, type, created_date, user_id, realm_id, storage_provider_id, user_label, secret_data, credential_data, priority) FROM stdin;
\.


--
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_group_membership (group_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_required_action (required_action, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_role_mapping (role_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.federated_identity (identity_provider, realm_id, federated_user_id, federated_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.federated_user (id, storage_provider_id, realm_id) FROM stdin;
\.


--
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.group_attribute (id, name, value, group_id) FROM stdin;
\.


--
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.group_role_mapping (role_id, group_id) FROM stdin;
\.


--
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.identity_provider (internal_id, enabled, provider_alias, provider_id, store_token, authenticate_by_default, realm_id, add_token_role, trust_email, first_broker_login_flow_id, post_broker_login_flow_id, provider_display_name, link_only) FROM stdin;
\.


--
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.identity_provider_config (identity_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.identity_provider_mapper (id, name, idp_alias, idp_mapper_name, realm_id) FROM stdin;
\.


--
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.idp_mapper_config (idp_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.keycloak_group (id, name, parent_group, realm_id) FROM stdin;
\.


--
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) FROM stdin;
d74f88e3-f626-4133-92ed-570abfcd9f09	master	f	${role_admin}	admin	master	\N	master
bc1f4f91-bb00-4434-a99e-82dec51523bb	master	f	${role_create-realm}	create-realm	master	\N	master
70599704-e626-4906-bef9-54e4b083a444	424fffef-ec10-46fe-88f6-4d91caa2b885	t	${role_create-client}	create-client	master	424fffef-ec10-46fe-88f6-4d91caa2b885	\N
757ac25d-99a7-4d2b-adfb-35d357889cde	424fffef-ec10-46fe-88f6-4d91caa2b885	t	${role_view-realm}	view-realm	master	424fffef-ec10-46fe-88f6-4d91caa2b885	\N
991d35a6-62f8-4a1b-b941-7b33c6efacf9	424fffef-ec10-46fe-88f6-4d91caa2b885	t	${role_view-users}	view-users	master	424fffef-ec10-46fe-88f6-4d91caa2b885	\N
5d28a4ad-aedd-404a-a337-2552b2b5c3fc	424fffef-ec10-46fe-88f6-4d91caa2b885	t	${role_view-clients}	view-clients	master	424fffef-ec10-46fe-88f6-4d91caa2b885	\N
99756a68-8dcd-4ae7-9e0b-83c63418c46f	424fffef-ec10-46fe-88f6-4d91caa2b885	t	${role_view-events}	view-events	master	424fffef-ec10-46fe-88f6-4d91caa2b885	\N
b35bb2de-e4bf-4b89-9e70-f86b3f336562	424fffef-ec10-46fe-88f6-4d91caa2b885	t	${role_view-identity-providers}	view-identity-providers	master	424fffef-ec10-46fe-88f6-4d91caa2b885	\N
afcd7ecf-8cab-4f78-bb46-54f1950b764a	424fffef-ec10-46fe-88f6-4d91caa2b885	t	${role_view-authorization}	view-authorization	master	424fffef-ec10-46fe-88f6-4d91caa2b885	\N
da09cf02-809b-4a00-a9b7-14e9b5a2b8ea	424fffef-ec10-46fe-88f6-4d91caa2b885	t	${role_manage-realm}	manage-realm	master	424fffef-ec10-46fe-88f6-4d91caa2b885	\N
6527c21c-84c0-4985-8bf7-cd09d33e39cb	424fffef-ec10-46fe-88f6-4d91caa2b885	t	${role_manage-users}	manage-users	master	424fffef-ec10-46fe-88f6-4d91caa2b885	\N
bcaa6b2a-cf26-40b2-882b-338e8d27b81e	424fffef-ec10-46fe-88f6-4d91caa2b885	t	${role_manage-clients}	manage-clients	master	424fffef-ec10-46fe-88f6-4d91caa2b885	\N
b19e94bf-2f5f-495d-9a8f-d2913a54bb9c	424fffef-ec10-46fe-88f6-4d91caa2b885	t	${role_manage-events}	manage-events	master	424fffef-ec10-46fe-88f6-4d91caa2b885	\N
cd42c89e-d9d7-4d34-9624-690201536750	424fffef-ec10-46fe-88f6-4d91caa2b885	t	${role_manage-identity-providers}	manage-identity-providers	master	424fffef-ec10-46fe-88f6-4d91caa2b885	\N
dca90be2-3c13-4187-aa6d-20565a458c7d	424fffef-ec10-46fe-88f6-4d91caa2b885	t	${role_manage-authorization}	manage-authorization	master	424fffef-ec10-46fe-88f6-4d91caa2b885	\N
4f81400e-2180-437a-b66b-3910095fa478	424fffef-ec10-46fe-88f6-4d91caa2b885	t	${role_query-users}	query-users	master	424fffef-ec10-46fe-88f6-4d91caa2b885	\N
e52f9bf9-d104-42dd-b79b-6518bf9bcfc9	424fffef-ec10-46fe-88f6-4d91caa2b885	t	${role_query-clients}	query-clients	master	424fffef-ec10-46fe-88f6-4d91caa2b885	\N
421223da-7e83-4bb3-ac55-12b02a9c688d	424fffef-ec10-46fe-88f6-4d91caa2b885	t	${role_query-realms}	query-realms	master	424fffef-ec10-46fe-88f6-4d91caa2b885	\N
318823c6-e72c-40aa-9a27-b8be9d810e64	424fffef-ec10-46fe-88f6-4d91caa2b885	t	${role_query-groups}	query-groups	master	424fffef-ec10-46fe-88f6-4d91caa2b885	\N
e9582359-ecee-4c4e-b3a7-a84c52ac5c2c	4f7365a9-8d15-4e92-a47a-9e7708aa6957	t	${role_view-profile}	view-profile	master	4f7365a9-8d15-4e92-a47a-9e7708aa6957	\N
2fadc715-6d70-4231-98b2-5238fd2ff60f	4f7365a9-8d15-4e92-a47a-9e7708aa6957	t	${role_manage-account}	manage-account	master	4f7365a9-8d15-4e92-a47a-9e7708aa6957	\N
5105339a-caee-4941-827a-fa4671e0a9f2	4f7365a9-8d15-4e92-a47a-9e7708aa6957	t	${role_manage-account-links}	manage-account-links	master	4f7365a9-8d15-4e92-a47a-9e7708aa6957	\N
b6b2e436-6d26-461b-965c-5b5b560cb824	4f7365a9-8d15-4e92-a47a-9e7708aa6957	t	${role_view-applications}	view-applications	master	4f7365a9-8d15-4e92-a47a-9e7708aa6957	\N
ae2fa261-f094-4368-8873-3e32b1f1e18f	4f7365a9-8d15-4e92-a47a-9e7708aa6957	t	${role_view-consent}	view-consent	master	4f7365a9-8d15-4e92-a47a-9e7708aa6957	\N
e9318cb5-1360-4492-be00-9d02748f7ce4	4f7365a9-8d15-4e92-a47a-9e7708aa6957	t	${role_manage-consent}	manage-consent	master	4f7365a9-8d15-4e92-a47a-9e7708aa6957	\N
b491ddb3-e88e-47b4-ac02-61d3d3a3a584	93d27599-f1b8-4e6c-9183-a460436682a6	t	${role_read-token}	read-token	master	93d27599-f1b8-4e6c-9183-a460436682a6	\N
4875f454-a832-4daa-bde6-2e14c6f44609	424fffef-ec10-46fe-88f6-4d91caa2b885	t	${role_impersonation}	impersonation	master	424fffef-ec10-46fe-88f6-4d91caa2b885	\N
6954cf7c-3069-4aaf-8730-1b0362e0105d	master	f	${role_offline-access}	offline_access	master	\N	master
ec3e50d6-685a-4c1a-9d8f-4a72fdeaec40	master	f	${role_uma_authorization}	uma_authorization	master	\N	master
1253b37d-b1ec-4517-a760-818b7d92303c	c0b92108-6cf9-48e8-8492-ca9aeeee477c	t	\N	admin	master	c0b92108-6cf9-48e8-8492-ca9aeeee477c	\N
c6b8d21d-bd9f-4743-a669-e4aa45b6a6c9	c0b92108-6cf9-48e8-8492-ca9aeeee477c	t	\N	user	master	c0b92108-6cf9-48e8-8492-ca9aeeee477c	\N
\.


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.migration_model (id, version, update_time) FROM stdin;
inxn8	9.0.0	1583654741
\.


--
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.offline_user_session (user_session_id, user_id, realm_id, created_on, offline_flag, data, last_session_refresh) FROM stdin;
\.


--
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.policy_config (policy_id, name, value) FROM stdin;
\.


--
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) FROM stdin;
e274fba8-e423-4266-9e1b-63bedc0a36f6	audience resolve	openid-connect	oidc-audience-resolve-mapper	c506d2fc-b7ca-43c2-8850-844800fd97ac	\N
9300f1b3-1684-42c4-a029-98076c82616c	locale	openid-connect	oidc-usermodel-attribute-mapper	df8928e5-088d-485f-b8d0-37e364492cb3	\N
19298c2c-1de1-49ab-8b7c-0a8cd634fed0	role list	saml	saml-role-list-mapper	\N	16fb38ca-3eef-4f97-bc8e-3510a480eaff
82fb4a97-6220-4066-913a-3ee16f26e212	full name	openid-connect	oidc-full-name-mapper	\N	7476aa2c-595f-4011-8ed7-663c6f4d2f38
ef9396c8-f6bf-4a53-b301-2ac7fe440261	family name	openid-connect	oidc-usermodel-property-mapper	\N	7476aa2c-595f-4011-8ed7-663c6f4d2f38
8cc56f90-6de7-49af-8fa8-db9b9026a7ea	given name	openid-connect	oidc-usermodel-property-mapper	\N	7476aa2c-595f-4011-8ed7-663c6f4d2f38
75d4dfdd-b1e3-4b74-89b2-148e08a03ea3	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	7476aa2c-595f-4011-8ed7-663c6f4d2f38
f596cf9d-c63b-4517-9f36-c9d75f3f52a7	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	7476aa2c-595f-4011-8ed7-663c6f4d2f38
0fabb901-e6b9-4b71-b1ac-88c11a2e1f28	username	openid-connect	oidc-usermodel-property-mapper	\N	7476aa2c-595f-4011-8ed7-663c6f4d2f38
3bed6ffe-f366-400f-8611-43cafe6b9478	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	7476aa2c-595f-4011-8ed7-663c6f4d2f38
ee995d3b-7d5f-4a88-ae8f-f6f5c4dd26f9	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	7476aa2c-595f-4011-8ed7-663c6f4d2f38
e8818ac1-0319-4ad3-a5c4-bc4f86e9a2c3	website	openid-connect	oidc-usermodel-attribute-mapper	\N	7476aa2c-595f-4011-8ed7-663c6f4d2f38
04ef8e1b-f532-447d-bf5c-6008f221e629	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	7476aa2c-595f-4011-8ed7-663c6f4d2f38
aa1548d9-a45c-42f2-8b51-cbc8b461585b	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	7476aa2c-595f-4011-8ed7-663c6f4d2f38
d058ed81-e275-4dc7-a277-bf2bc3d8dc90	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	7476aa2c-595f-4011-8ed7-663c6f4d2f38
07abc718-d076-419b-b799-39dfebfab8ee	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	7476aa2c-595f-4011-8ed7-663c6f4d2f38
38239546-9253-4aad-9f03-29adfd0f9c26	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	7476aa2c-595f-4011-8ed7-663c6f4d2f38
3948db7d-3513-40b0-8f28-b90c194cbdac	email	openid-connect	oidc-usermodel-property-mapper	\N	1bf45c6f-647d-4063-963d-aa60d4ff7c71
fbc91190-e52a-4183-bdce-4c1465b08004	email verified	openid-connect	oidc-usermodel-property-mapper	\N	1bf45c6f-647d-4063-963d-aa60d4ff7c71
e191e166-b66b-4dad-893e-a8bb6bcf2dbe	address	openid-connect	oidc-address-mapper	\N	b0b86228-ec8b-44fd-880a-a7764a1f84c7
6ebf46f4-4801-4119-a6b1-bdde80cbe50b	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	d7fae07e-3a2a-455b-9393-72af0acb9f83
62d5c7ed-11a2-4079-bc3a-1b978322dd2f	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	d7fae07e-3a2a-455b-9393-72af0acb9f83
596f7df9-f17c-4c81-ba8e-9801b89e5617	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	b8d084e3-f815-4840-b0d0-3d7c8657519e
84b755f0-0926-4e25-a28f-d76de8b1353e	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	b8d084e3-f815-4840-b0d0-3d7c8657519e
a73b5a3e-58c6-4916-b019-386b4a90215e	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	b8d084e3-f815-4840-b0d0-3d7c8657519e
a53a8530-1076-463f-b2c6-ca237a7c4038	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	f2a9fffe-741d-42ac-a7ca-dbbf358d820b
e4900671-d8f3-4bc9-ae35-5e66050909c5	upn	openid-connect	oidc-usermodel-property-mapper	\N	87a09492-95e1-4fef-b534-bb6e095cb004
0c7ac2ee-30ff-40d1-9e00-4c356c5c2e47	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	87a09492-95e1-4fef-b534-bb6e095cb004
\.


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
9300f1b3-1684-42c4-a029-98076c82616c	true	userinfo.token.claim
9300f1b3-1684-42c4-a029-98076c82616c	locale	user.attribute
9300f1b3-1684-42c4-a029-98076c82616c	true	id.token.claim
9300f1b3-1684-42c4-a029-98076c82616c	true	access.token.claim
9300f1b3-1684-42c4-a029-98076c82616c	locale	claim.name
9300f1b3-1684-42c4-a029-98076c82616c	String	jsonType.label
19298c2c-1de1-49ab-8b7c-0a8cd634fed0	false	single
19298c2c-1de1-49ab-8b7c-0a8cd634fed0	Basic	attribute.nameformat
19298c2c-1de1-49ab-8b7c-0a8cd634fed0	Role	attribute.name
82fb4a97-6220-4066-913a-3ee16f26e212	true	userinfo.token.claim
82fb4a97-6220-4066-913a-3ee16f26e212	true	id.token.claim
82fb4a97-6220-4066-913a-3ee16f26e212	true	access.token.claim
ef9396c8-f6bf-4a53-b301-2ac7fe440261	true	userinfo.token.claim
ef9396c8-f6bf-4a53-b301-2ac7fe440261	lastName	user.attribute
ef9396c8-f6bf-4a53-b301-2ac7fe440261	true	id.token.claim
ef9396c8-f6bf-4a53-b301-2ac7fe440261	true	access.token.claim
ef9396c8-f6bf-4a53-b301-2ac7fe440261	family_name	claim.name
ef9396c8-f6bf-4a53-b301-2ac7fe440261	String	jsonType.label
8cc56f90-6de7-49af-8fa8-db9b9026a7ea	true	userinfo.token.claim
8cc56f90-6de7-49af-8fa8-db9b9026a7ea	firstName	user.attribute
8cc56f90-6de7-49af-8fa8-db9b9026a7ea	true	id.token.claim
8cc56f90-6de7-49af-8fa8-db9b9026a7ea	true	access.token.claim
8cc56f90-6de7-49af-8fa8-db9b9026a7ea	given_name	claim.name
8cc56f90-6de7-49af-8fa8-db9b9026a7ea	String	jsonType.label
75d4dfdd-b1e3-4b74-89b2-148e08a03ea3	true	userinfo.token.claim
75d4dfdd-b1e3-4b74-89b2-148e08a03ea3	middleName	user.attribute
75d4dfdd-b1e3-4b74-89b2-148e08a03ea3	true	id.token.claim
75d4dfdd-b1e3-4b74-89b2-148e08a03ea3	true	access.token.claim
75d4dfdd-b1e3-4b74-89b2-148e08a03ea3	middle_name	claim.name
75d4dfdd-b1e3-4b74-89b2-148e08a03ea3	String	jsonType.label
f596cf9d-c63b-4517-9f36-c9d75f3f52a7	true	userinfo.token.claim
f596cf9d-c63b-4517-9f36-c9d75f3f52a7	nickname	user.attribute
f596cf9d-c63b-4517-9f36-c9d75f3f52a7	true	id.token.claim
f596cf9d-c63b-4517-9f36-c9d75f3f52a7	true	access.token.claim
f596cf9d-c63b-4517-9f36-c9d75f3f52a7	nickname	claim.name
f596cf9d-c63b-4517-9f36-c9d75f3f52a7	String	jsonType.label
0fabb901-e6b9-4b71-b1ac-88c11a2e1f28	true	userinfo.token.claim
0fabb901-e6b9-4b71-b1ac-88c11a2e1f28	username	user.attribute
0fabb901-e6b9-4b71-b1ac-88c11a2e1f28	true	id.token.claim
0fabb901-e6b9-4b71-b1ac-88c11a2e1f28	true	access.token.claim
0fabb901-e6b9-4b71-b1ac-88c11a2e1f28	preferred_username	claim.name
0fabb901-e6b9-4b71-b1ac-88c11a2e1f28	String	jsonType.label
3bed6ffe-f366-400f-8611-43cafe6b9478	true	userinfo.token.claim
3bed6ffe-f366-400f-8611-43cafe6b9478	profile	user.attribute
3bed6ffe-f366-400f-8611-43cafe6b9478	true	id.token.claim
3bed6ffe-f366-400f-8611-43cafe6b9478	true	access.token.claim
3bed6ffe-f366-400f-8611-43cafe6b9478	profile	claim.name
3bed6ffe-f366-400f-8611-43cafe6b9478	String	jsonType.label
ee995d3b-7d5f-4a88-ae8f-f6f5c4dd26f9	true	userinfo.token.claim
ee995d3b-7d5f-4a88-ae8f-f6f5c4dd26f9	picture	user.attribute
ee995d3b-7d5f-4a88-ae8f-f6f5c4dd26f9	true	id.token.claim
ee995d3b-7d5f-4a88-ae8f-f6f5c4dd26f9	true	access.token.claim
ee995d3b-7d5f-4a88-ae8f-f6f5c4dd26f9	picture	claim.name
ee995d3b-7d5f-4a88-ae8f-f6f5c4dd26f9	String	jsonType.label
e8818ac1-0319-4ad3-a5c4-bc4f86e9a2c3	true	userinfo.token.claim
e8818ac1-0319-4ad3-a5c4-bc4f86e9a2c3	website	user.attribute
e8818ac1-0319-4ad3-a5c4-bc4f86e9a2c3	true	id.token.claim
e8818ac1-0319-4ad3-a5c4-bc4f86e9a2c3	true	access.token.claim
e8818ac1-0319-4ad3-a5c4-bc4f86e9a2c3	website	claim.name
e8818ac1-0319-4ad3-a5c4-bc4f86e9a2c3	String	jsonType.label
04ef8e1b-f532-447d-bf5c-6008f221e629	true	userinfo.token.claim
04ef8e1b-f532-447d-bf5c-6008f221e629	gender	user.attribute
04ef8e1b-f532-447d-bf5c-6008f221e629	true	id.token.claim
04ef8e1b-f532-447d-bf5c-6008f221e629	true	access.token.claim
04ef8e1b-f532-447d-bf5c-6008f221e629	gender	claim.name
04ef8e1b-f532-447d-bf5c-6008f221e629	String	jsonType.label
aa1548d9-a45c-42f2-8b51-cbc8b461585b	true	userinfo.token.claim
aa1548d9-a45c-42f2-8b51-cbc8b461585b	birthdate	user.attribute
aa1548d9-a45c-42f2-8b51-cbc8b461585b	true	id.token.claim
aa1548d9-a45c-42f2-8b51-cbc8b461585b	true	access.token.claim
aa1548d9-a45c-42f2-8b51-cbc8b461585b	birthdate	claim.name
aa1548d9-a45c-42f2-8b51-cbc8b461585b	String	jsonType.label
d058ed81-e275-4dc7-a277-bf2bc3d8dc90	true	userinfo.token.claim
d058ed81-e275-4dc7-a277-bf2bc3d8dc90	zoneinfo	user.attribute
d058ed81-e275-4dc7-a277-bf2bc3d8dc90	true	id.token.claim
d058ed81-e275-4dc7-a277-bf2bc3d8dc90	true	access.token.claim
d058ed81-e275-4dc7-a277-bf2bc3d8dc90	zoneinfo	claim.name
d058ed81-e275-4dc7-a277-bf2bc3d8dc90	String	jsonType.label
07abc718-d076-419b-b799-39dfebfab8ee	true	userinfo.token.claim
07abc718-d076-419b-b799-39dfebfab8ee	locale	user.attribute
07abc718-d076-419b-b799-39dfebfab8ee	true	id.token.claim
07abc718-d076-419b-b799-39dfebfab8ee	true	access.token.claim
07abc718-d076-419b-b799-39dfebfab8ee	locale	claim.name
07abc718-d076-419b-b799-39dfebfab8ee	String	jsonType.label
38239546-9253-4aad-9f03-29adfd0f9c26	true	userinfo.token.claim
38239546-9253-4aad-9f03-29adfd0f9c26	updatedAt	user.attribute
38239546-9253-4aad-9f03-29adfd0f9c26	true	id.token.claim
38239546-9253-4aad-9f03-29adfd0f9c26	true	access.token.claim
38239546-9253-4aad-9f03-29adfd0f9c26	updated_at	claim.name
38239546-9253-4aad-9f03-29adfd0f9c26	String	jsonType.label
3948db7d-3513-40b0-8f28-b90c194cbdac	true	userinfo.token.claim
3948db7d-3513-40b0-8f28-b90c194cbdac	email	user.attribute
3948db7d-3513-40b0-8f28-b90c194cbdac	true	id.token.claim
3948db7d-3513-40b0-8f28-b90c194cbdac	true	access.token.claim
3948db7d-3513-40b0-8f28-b90c194cbdac	email	claim.name
3948db7d-3513-40b0-8f28-b90c194cbdac	String	jsonType.label
fbc91190-e52a-4183-bdce-4c1465b08004	true	userinfo.token.claim
fbc91190-e52a-4183-bdce-4c1465b08004	emailVerified	user.attribute
fbc91190-e52a-4183-bdce-4c1465b08004	true	id.token.claim
fbc91190-e52a-4183-bdce-4c1465b08004	true	access.token.claim
fbc91190-e52a-4183-bdce-4c1465b08004	email_verified	claim.name
fbc91190-e52a-4183-bdce-4c1465b08004	boolean	jsonType.label
e191e166-b66b-4dad-893e-a8bb6bcf2dbe	formatted	user.attribute.formatted
e191e166-b66b-4dad-893e-a8bb6bcf2dbe	country	user.attribute.country
e191e166-b66b-4dad-893e-a8bb6bcf2dbe	postal_code	user.attribute.postal_code
e191e166-b66b-4dad-893e-a8bb6bcf2dbe	true	userinfo.token.claim
e191e166-b66b-4dad-893e-a8bb6bcf2dbe	street	user.attribute.street
e191e166-b66b-4dad-893e-a8bb6bcf2dbe	true	id.token.claim
e191e166-b66b-4dad-893e-a8bb6bcf2dbe	region	user.attribute.region
e191e166-b66b-4dad-893e-a8bb6bcf2dbe	true	access.token.claim
e191e166-b66b-4dad-893e-a8bb6bcf2dbe	locality	user.attribute.locality
6ebf46f4-4801-4119-a6b1-bdde80cbe50b	true	userinfo.token.claim
6ebf46f4-4801-4119-a6b1-bdde80cbe50b	phoneNumber	user.attribute
6ebf46f4-4801-4119-a6b1-bdde80cbe50b	true	id.token.claim
6ebf46f4-4801-4119-a6b1-bdde80cbe50b	true	access.token.claim
6ebf46f4-4801-4119-a6b1-bdde80cbe50b	phone_number	claim.name
6ebf46f4-4801-4119-a6b1-bdde80cbe50b	String	jsonType.label
62d5c7ed-11a2-4079-bc3a-1b978322dd2f	true	userinfo.token.claim
62d5c7ed-11a2-4079-bc3a-1b978322dd2f	phoneNumberVerified	user.attribute
62d5c7ed-11a2-4079-bc3a-1b978322dd2f	true	id.token.claim
62d5c7ed-11a2-4079-bc3a-1b978322dd2f	true	access.token.claim
62d5c7ed-11a2-4079-bc3a-1b978322dd2f	phone_number_verified	claim.name
62d5c7ed-11a2-4079-bc3a-1b978322dd2f	boolean	jsonType.label
596f7df9-f17c-4c81-ba8e-9801b89e5617	true	multivalued
596f7df9-f17c-4c81-ba8e-9801b89e5617	foo	user.attribute
596f7df9-f17c-4c81-ba8e-9801b89e5617	true	access.token.claim
596f7df9-f17c-4c81-ba8e-9801b89e5617	realm_access.roles	claim.name
596f7df9-f17c-4c81-ba8e-9801b89e5617	String	jsonType.label
84b755f0-0926-4e25-a28f-d76de8b1353e	true	multivalued
84b755f0-0926-4e25-a28f-d76de8b1353e	foo	user.attribute
84b755f0-0926-4e25-a28f-d76de8b1353e	true	access.token.claim
84b755f0-0926-4e25-a28f-d76de8b1353e	resource_access.${client_id}.roles	claim.name
84b755f0-0926-4e25-a28f-d76de8b1353e	String	jsonType.label
e4900671-d8f3-4bc9-ae35-5e66050909c5	true	userinfo.token.claim
e4900671-d8f3-4bc9-ae35-5e66050909c5	username	user.attribute
e4900671-d8f3-4bc9-ae35-5e66050909c5	true	id.token.claim
e4900671-d8f3-4bc9-ae35-5e66050909c5	true	access.token.claim
e4900671-d8f3-4bc9-ae35-5e66050909c5	upn	claim.name
e4900671-d8f3-4bc9-ae35-5e66050909c5	String	jsonType.label
0c7ac2ee-30ff-40d1-9e00-4c356c5c2e47	true	multivalued
0c7ac2ee-30ff-40d1-9e00-4c356c5c2e47	foo	user.attribute
0c7ac2ee-30ff-40d1-9e00-4c356c5c2e47	true	id.token.claim
0c7ac2ee-30ff-40d1-9e00-4c356c5c2e47	true	access.token.claim
0c7ac2ee-30ff-40d1-9e00-4c356c5c2e47	groups	claim.name
0c7ac2ee-30ff-40d1-9e00-4c356c5c2e47	String	jsonType.label
\.


--
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me) FROM stdin;
master	60	300	60	\N	\N	\N	t	f	0	\N	master	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	424fffef-ec10-46fe-88f6-4d91caa2b885	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	001e3b57-69c6-4d73-a469-7ec168f5f815	009c4ea2-a4bb-42a5-99db-8fb0dc1a73da	dd002e15-c64b-40e7-ad1b-9fad447d68ee	54cd42c0-bb58-40a3-a464-db96a865a9dd	08929cec-b160-4d9c-aa58-355908736dc7	2592000	f	900	t	f	ab1971d1-f02f-49b1-8d36-831b75e6c90f	0	f	0	0
\.


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_attribute (name, value, realm_id) FROM stdin;
_browser_header.contentSecurityPolicyReportOnly		master
_browser_header.xContentTypeOptions	nosniff	master
_browser_header.xRobotsTag	none	master
_browser_header.xFrameOptions	SAMEORIGIN	master
_browser_header.contentSecurityPolicy	frame-src 'self'; frame-ancestors 'self'; object-src 'none';	master
_browser_header.xXSSProtection	1; mode=block	master
_browser_header.strictTransportSecurity	max-age=31536000; includeSubDomains	master
bruteForceProtected	false	master
permanentLockout	false	master
maxFailureWaitSeconds	900	master
minimumQuickLoginWaitSeconds	60	master
waitIncrementSeconds	60	master
quickLoginCheckMilliSeconds	1000	master
maxDeltaTimeSeconds	43200	master
failureFactor	30	master
displayName	Keycloak	master
displayNameHtml	<div class="kc-logo-text"><span>Keycloak</span></div>	master
offlineSessionMaxLifespanEnabled	false	master
offlineSessionMaxLifespan	5184000	master
\.


--
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_default_groups (realm_id, group_id) FROM stdin;
\.


--
-- Data for Name: realm_default_roles; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_default_roles (realm_id, role_id) FROM stdin;
master	6954cf7c-3069-4aaf-8730-1b0362e0105d
master	ec3e50d6-685a-4c1a-9d8f-4a72fdeaec40
\.


--
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_enabled_event_types (realm_id, value) FROM stdin;
\.


--
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_events_listeners (realm_id, value) FROM stdin;
master	jboss-logging
\.


--
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_required_credential (type, form_label, input, secret, realm_id) FROM stdin;
password	password	t	t	master
\.


--
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_smtp_config (realm_id, value, name) FROM stdin;
\.


--
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_supported_locales (realm_id, value) FROM stdin;
\.


--
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.redirect_uris (client_id, value) FROM stdin;
4f7365a9-8d15-4e92-a47a-9e7708aa6957	/realms/master/account/*
c506d2fc-b7ca-43c2-8850-844800fd97ac	/realms/master/account/*
df8928e5-088d-485f-b8d0-37e364492cb3	/admin/master/console/*
c0b92108-6cf9-48e8-8492-ca9aeeee477c	http://localhost/auth/callback
c0b92108-6cf9-48e8-8492-ca9aeeee477c	http://ska.local:8080/auth/callback
c0b92108-6cf9-48e8-8492-ca9aeeee477c	http://ska.local/auth/callback
c0b92108-6cf9-48e8-8492-ca9aeeee477c	http://localhost:8080/auth/callback
\.


--
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.required_action_config (required_action_id, value, name) FROM stdin;
\.


--
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) FROM stdin;
b0223f0f-20b8-49d5-b3ed-8ff9ee319f60	VERIFY_EMAIL	Verify Email	master	t	f	VERIFY_EMAIL	50
19d459af-8b35-49c6-91b7-ae79bc6beb5b	UPDATE_PROFILE	Update Profile	master	t	f	UPDATE_PROFILE	40
ccac94f4-3db6-4abe-83ed-b61e42bcdca5	CONFIGURE_TOTP	Configure OTP	master	t	f	CONFIGURE_TOTP	10
c5a7ee44-c666-4505-b85a-c37e77171fb4	UPDATE_PASSWORD	Update Password	master	t	f	UPDATE_PASSWORD	30
372a9252-a5d3-4802-80a5-8226f2cc8c4b	terms_and_conditions	Terms and Conditions	master	f	f	terms_and_conditions	20
3a793cf1-da87-44af-af8b-e6ec1534576c	update_user_locale	Update User Locale	master	t	f	update_user_locale	1000
\.


--
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_attribute (id, name, value, resource_id) FROM stdin;
\.


--
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_policy (resource_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_scope (resource_id, scope_id) FROM stdin;
\.


--
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server (id, allow_rs_remote_mgmt, policy_enforce_mode, decision_strategy) FROM stdin;
\.


--
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_perm_ticket (id, owner, requester, created_timestamp, granted_timestamp, resource_id, scope_id, resource_server_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) FROM stdin;
\.


--
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
\.


--
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_scope (id, name, icon_uri, resource_server_id, display_name) FROM stdin;
\.


--
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_uris (resource_id, value) FROM stdin;
\.


--
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.role_attribute (id, role_id, name, value) FROM stdin;
\.


--
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.scope_mapping (client_id, role_id) FROM stdin;
c506d2fc-b7ca-43c2-8850-844800fd97ac	2fadc715-6d70-4231-98b2-5238fd2ff60f
\.


--
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.scope_policy (scope_id, policy_id) FROM stdin;
\.


--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_attribute (name, value, user_id, id) FROM stdin;
\.


--
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_consent (id, client_id, user_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
cc6a59e8-ca7c-41fd-8c2b-934b4799f2b9	c0b92108-6cf9-48e8-8492-ca9aeeee477c	156a9ddd-f0eb-479a-9bb5-2aa308447f4f	1583659093278	1583659093303	\N	\N
f05cdbbc-33fa-492d-99ca-e1e573296928	c0b92108-6cf9-48e8-8492-ca9aeeee477c	87ad209a-e02e-42a7-9020-8fd1c04fb384	1583659661344	1583659661363	\N	\N
0588f216-8af5-4570-b8a2-249680a3622b	c0b92108-6cf9-48e8-8492-ca9aeeee477c	98f54b1f-e715-457b-9e24-4aaf8636239e	1583660519821	1583660519847	\N	\N
\.


--
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_consent_client_scope (user_consent_id, scope_id) FROM stdin;
cc6a59e8-ca7c-41fd-8c2b-934b4799f2b9	7476aa2c-595f-4011-8ed7-663c6f4d2f38
cc6a59e8-ca7c-41fd-8c2b-934b4799f2b9	1bf45c6f-647d-4063-963d-aa60d4ff7c71
cc6a59e8-ca7c-41fd-8c2b-934b4799f2b9	b8d084e3-f815-4840-b0d0-3d7c8657519e
f05cdbbc-33fa-492d-99ca-e1e573296928	7476aa2c-595f-4011-8ed7-663c6f4d2f38
f05cdbbc-33fa-492d-99ca-e1e573296928	1bf45c6f-647d-4063-963d-aa60d4ff7c71
f05cdbbc-33fa-492d-99ca-e1e573296928	b8d084e3-f815-4840-b0d0-3d7c8657519e
0588f216-8af5-4570-b8a2-249680a3622b	7476aa2c-595f-4011-8ed7-663c6f4d2f38
0588f216-8af5-4570-b8a2-249680a3622b	1bf45c6f-647d-4063-963d-aa60d4ff7c71
\.


--
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) FROM stdin;
87ad209a-e02e-42a7-9020-8fd1c04fb384	user@localhost	user@localhost	t	t	\N	User	User	master	user	1583655196271	\N	0
156a9ddd-f0eb-479a-9bb5-2aa308447f4f	admin@localhost	admin@localhost	t	t	\N	Admin	Admin	master	admin	1583654744383	\N	0
98f54b1f-e715-457b-9e24-4aaf8636239e	unauth@localhost	unauth@localhost	t	t	\N	Unauth	Unauth	master	unauth	1583660489532	\N	0
\.


--
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_config (user_federation_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_mapper (id, name, federation_provider_id, federation_mapper_type, realm_id) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_mapper_config (user_federation_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_provider (id, changed_sync_period, display_name, full_sync_period, last_sync, priority, provider_name, realm_id) FROM stdin;
\.


--
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_group_membership (group_id, user_id) FROM stdin;
\.


--
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_required_action (user_id, required_action) FROM stdin;
\.


--
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_role_mapping (role_id, user_id) FROM stdin;
ec3e50d6-685a-4c1a-9d8f-4a72fdeaec40	156a9ddd-f0eb-479a-9bb5-2aa308447f4f
e9582359-ecee-4c4e-b3a7-a84c52ac5c2c	156a9ddd-f0eb-479a-9bb5-2aa308447f4f
6954cf7c-3069-4aaf-8730-1b0362e0105d	156a9ddd-f0eb-479a-9bb5-2aa308447f4f
2fadc715-6d70-4231-98b2-5238fd2ff60f	156a9ddd-f0eb-479a-9bb5-2aa308447f4f
d74f88e3-f626-4133-92ed-570abfcd9f09	156a9ddd-f0eb-479a-9bb5-2aa308447f4f
ec3e50d6-685a-4c1a-9d8f-4a72fdeaec40	87ad209a-e02e-42a7-9020-8fd1c04fb384
e9582359-ecee-4c4e-b3a7-a84c52ac5c2c	87ad209a-e02e-42a7-9020-8fd1c04fb384
6954cf7c-3069-4aaf-8730-1b0362e0105d	87ad209a-e02e-42a7-9020-8fd1c04fb384
2fadc715-6d70-4231-98b2-5238fd2ff60f	87ad209a-e02e-42a7-9020-8fd1c04fb384
1253b37d-b1ec-4517-a760-818b7d92303c	156a9ddd-f0eb-479a-9bb5-2aa308447f4f
c6b8d21d-bd9f-4743-a669-e4aa45b6a6c9	156a9ddd-f0eb-479a-9bb5-2aa308447f4f
c6b8d21d-bd9f-4743-a669-e4aa45b6a6c9	87ad209a-e02e-42a7-9020-8fd1c04fb384
ec3e50d6-685a-4c1a-9d8f-4a72fdeaec40	98f54b1f-e715-457b-9e24-4aaf8636239e
e9582359-ecee-4c4e-b3a7-a84c52ac5c2c	98f54b1f-e715-457b-9e24-4aaf8636239e
6954cf7c-3069-4aaf-8730-1b0362e0105d	98f54b1f-e715-457b-9e24-4aaf8636239e
2fadc715-6d70-4231-98b2-5238fd2ff60f	98f54b1f-e715-457b-9e24-4aaf8636239e
\.


--
-- Data for Name: user_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_session (id, auth_method, ip_address, last_session_refresh, login_username, realm_id, remember_me, started, user_id, user_session_state, broker_session_id, broker_user_id) FROM stdin;
\.


--
-- Data for Name: user_session_note; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_session_note (user_session, name, value) FROM stdin;
\.


--
-- Data for Name: username_login_failure; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.username_login_failure (realm_id, username, failed_login_not_before, last_failure, last_ip_failure, num_failures) FROM stdin;
\.


--
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.web_origins (client_id, value) FROM stdin;
df8928e5-088d-485f-b8d0-37e364492cb3	+
\.


--
-- Name: username_login_failure CONSTRAINT_17-2; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.username_login_failure
    ADD CONSTRAINT "CONSTRAINT_17-2" PRIMARY KEY (realm_id, username);


--
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- Name: client_user_session_note constr_cl_usr_ses_note; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT constr_cl_usr_ses_note PRIMARY KEY (client_session, name);


--
-- Name: client_default_roles constr_client_default_roles; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_default_roles
    ADD CONSTRAINT constr_client_default_roles PRIMARY KEY (client_id, role_id);


--
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- Name: client_session_role constraint_5; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT constraint_5 PRIMARY KEY (client_session, role_id);


--
-- Name: user_session constraint_57; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_session
    ADD CONSTRAINT constraint_57 PRIMARY KEY (id);


--
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- Name: client_session_note constraint_5e; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT constraint_5e PRIMARY KEY (client_session, name);


--
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- Name: client_session constraint_8; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT constraint_8 PRIMARY KEY (id);


--
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- Name: client_session_auth_status constraint_auth_status_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT constraint_auth_status_pk PRIMARY KEY (client_session, authenticator);


--
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- Name: client_session_prot_mapper constraint_cs_pmp_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT constraint_cs_pmp_pk PRIMARY KEY (client_session, protocol_mapper_id);


--
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- Name: realm_default_roles constraint_realm_default_roles; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_roles
    ADD CONSTRAINT constraint_realm_default_roles PRIMARY KEY (realm_id, role_id);


--
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: user_session_note constraint_usn_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT constraint_usn_pk PRIMARY KEY (user_session, name);


--
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- Name: databasechangeloglock pk_databasechangeloglock; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT pk_databasechangeloglock PRIMARY KEY (id);


--
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- Name: client_default_roles uk_8aelwnibji49avxsrtuf6xjow; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_default_roles
    ADD CONSTRAINT uk_8aelwnibji49avxsrtuf6xjow UNIQUE (role_id);


--
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: realm_default_roles uk_h4wpd7w4hsoolni3h0sw7btje; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_roles
    ADD CONSTRAINT uk_h4wpd7w4hsoolni3h0sw7btje UNIQUE (role_id);


--
-- Name: user_consent uk_jkuwuvd56ontgsuhogm8uewrt; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_jkuwuvd56ontgsuhogm8uewrt UNIQUE (client_id, client_storage_provider, external_client_id, user_id);


--
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- Name: idx_client_def_roles_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_def_roles_client ON public.client_default_roles USING btree (client_id);


--
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- Name: idx_client_session_session; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_session_session ON public.client_session USING btree (session_id);


--
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- Name: idx_offline_uss_createdon; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_offline_uss_createdon ON public.offline_user_session USING btree (created_on);


--
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- Name: idx_realm_def_roles_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_def_roles_realm ON public.realm_default_roles USING btree (realm_id);


--
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- Name: idx_us_sess_id_on_cl_sess; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_us_sess_id_on_cl_sess ON public.offline_client_session USING btree (user_session_id);


--
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- Name: client_session_auth_status auth_status_constraint; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT auth_status_constraint FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: client_session_note fk5edfb00ff51c2736; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT fk5edfb00ff51c2736 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: user_session_note fk5edfb00ff51d3472; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT fk5edfb00ff51d3472 FOREIGN KEY (user_session) REFERENCES public.user_session(id);


--
-- Name: client_session_role fk_11b7sgqw18i532811v7o2dv76; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT fk_11b7sgqw18i532811v7o2dv76 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session_prot_mapper fk_33a8sgqw18i532811v7o2dk89; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT fk_33a8sgqw18i532811v7o2dk89 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_default_roles fk_8aelwnibji49avxsrtuf6xjow; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_default_roles
    ADD CONSTRAINT fk_8aelwnibji49avxsrtuf6xjow FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session fk_b4ao2vcvat6ukau74wbwtfqo1; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT fk_b4ao2vcvat6ukau74wbwtfqo1 FOREIGN KEY (session_id) REFERENCES public.user_session(id);


--
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_scope_client fk_c_cli_scope_client; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT fk_c_cli_scope_client FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: client_scope_client fk_c_cli_scope_scope; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT fk_c_cli_scope_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope_role_mapping fk_cl_scope_rm_role; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_role FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_user_session_note fk_cl_usr_ses_note; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT fk_cl_usr_ses_note FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_default_groups fk_def_groups_group; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_default_roles fk_evudb1ppw84oxfax2drs03icc; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_roles
    ADD CONSTRAINT fk_evudb1ppw84oxfax2drs03icc FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: keycloak_group fk_group_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT fk_group_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: group_role_mapping fk_group_role_role; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_role FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_default_roles fk_h4wpd7w4hsoolni3h0sw7btje; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_roles
    ADD CONSTRAINT fk_h4wpd7w4hsoolni3h0sw7btje FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- Name: keycloak_role fk_kjho5le2c0ral09fl8cm9wfw9; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_kjho5le2c0ral09fl8cm9wfw9 FOREIGN KEY (client) REFERENCES public.client(id);


--
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: client_default_roles fk_nuilts7klwqw2h8m2b5joytky; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_default_roles
    ADD CONSTRAINT fk_nuilts7klwqw2h8m2b5joytky FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: scope_mapping fk_p3rh9grku11kqfrs4fltt7rnq; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_p3rh9grku11kqfrs4fltt7rnq FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: client fk_p56ctinxxb9gsk57fo49f9tac; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT fk_p56ctinxxb9gsk57fo49f9tac FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_scope; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope fk_realm_cli_scope; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT fk_realm_cli_scope FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: realm fk_traf444kk6qrkms7n56aiwq5y; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT fk_traf444kk6qrkms7n56aiwq5y FOREIGN KEY (master_admin_client) REFERENCES public.client(id);


--
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


--
-- PostgreSQL database dump complete
--

