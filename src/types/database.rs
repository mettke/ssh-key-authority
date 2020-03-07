use diesel_derive_enum::DbEnum;
use serde::Serialize;
use std::convert::TryFrom;

#[derive(DbEnum, Debug, Serialize, Clone, Copy)]
pub enum AccessOption {
    Command,
    From,
    NoAgentForwarding,
    NoPortForwarding,
    NoPty,
    NoX11Forwarding,
}

impl TryFrom<&str> for AccessOption {
    type Error = ();

    fn try_from(value: &str) -> Result<Self, Self::Error> {
        match value {
            "Command" => Ok(AccessOption::Command),
            "From" => Ok(AccessOption::From),
            "NoAgentForwarding" => {
                Ok(AccessOption::NoAgentForwarding)
            }
            "NoPortForwarding" => {
                Ok(AccessOption::NoPortForwarding)
            }
            "NoPty" => Ok(AccessOption::NoPty),
            "NoX11Forwarding" => {
                Ok(AccessOption::NoX11Forwarding)
            }
            _ => Err(()),
        }
    }
}

#[derive(DbEnum, Debug, Serialize, Clone, Copy)]
pub enum EntityTypes {
    User,
    ServerAccount,
    Group,
}

#[derive(DbEnum, Debug, Serialize, Clone, Copy)]
pub enum KeyManagement {
    None,
    Keys,
    Other,
    Decomissioned,
}

impl TryFrom<&str> for KeyManagement {
    type Error = ();

    fn try_from(value: &str) -> Result<Self, Self::Error> {
        match value {
            "None" => Ok(KeyManagement::None),
            "Keys" => Ok(KeyManagement::Keys),
            "Other" => Ok(KeyManagement::Other),
            "Decomissioned" => Ok(KeyManagement::Decomissioned),
            _ => Err(()),
        }
    }
}

#[derive(DbEnum, Debug, Serialize, Clone, Copy)]
pub enum AuthorizationType {
    Manual,
    AutomaticLdap,
    ManualLdap,
}

impl TryFrom<&str> for AuthorizationType {
    type Error = ();

    fn try_from(value: &str) -> Result<Self, Self::Error> {
        match value {
            "Manual" => Ok(AuthorizationType::Manual),
            "AutomaticLdap" => {
                Ok(AuthorizationType::AutomaticLdap)
            }
            "ManualLdap" => Ok(AuthorizationType::ManualLdap),
            _ => Err(()),
        }
    }
}

#[derive(DbEnum, Debug, Serialize, Clone, Copy)]
pub enum UseClientSync {
    Yes,
    No,
}

#[derive(DbEnum, Debug, Serialize, Clone, Copy)]
pub enum SyncStatusType {
    NotSyncedYet,
    #[db_rename = "sync success"]
    SyncSuccess,
    SyncFailure,
    SyncWarning,
}

impl TryFrom<&str> for SyncStatusType {
    type Error = ();

    fn try_from(value: &str) -> Result<Self, Self::Error> {
        match value {
            "NotSyncedYet" => Ok(SyncStatusType::NotSyncedYet),
            "SyncSuccess" => Ok(SyncStatusType::SyncSuccess),
            "SyncFailure" => Ok(SyncStatusType::SyncFailure),
            "SyncWarning" => Ok(SyncStatusType::SyncWarning),
            _ => Err(()),
        }
    }
}

#[derive(DbEnum, Debug, Serialize, Clone, Copy)]
pub enum SyncStatusTypeAccount {
    NotSyncedYet,
    #[db_rename = "sync success"]
    SyncSuccess,
    SyncFailure,
    SyncWarning,
    Proposed,
}

#[derive(DbEnum, Debug, Serialize, Clone, Copy)]
pub enum ConfigurationSystem {
    Unknown,
    CfSysadmin,
    PuppetDevops,
    PuppetMiniops,
    PuppetTvStore,
    None,
}

#[derive(DbEnum, Debug, Serialize, Clone, Copy)]
pub enum CustomKeys {
    #[db_rename = "not allowed"]
    NotAllowed,
    Allowed,
}

#[derive(DbEnum, Debug, Serialize, Clone, Copy)]
pub enum LdapAccessOptions {
    Command,
    From,
    Environment,
    NoAgentForwarding,
    NoPortForwarding,
    NoPty,
    NoX11Forwarding,
    NoUserRc,
}

#[derive(DbEnum, Debug, Serialize, Clone, Copy)]
pub enum AuthRealm {
    Ldap,
    Local,
    External,
}
