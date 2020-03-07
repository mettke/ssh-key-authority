use handlebars::handlebars_helper;

handlebars_helper!(transform_sync: |sync_status: str, key_mgmnt: str| {
    if key_mgmnt != "Keys" {
        ""
    } else {
        match sync_status {
            "NotSyncedYet" | "Sync warning" => "warning",
            "SyncFailure" => "danger",
            "SyncSuccess" => "success",
            _ => ""
        }
    }
});

handlebars_helper!(transform_mgmnt: |key_mgmnt: str, auth: str| {
    match key_mgmnt {
        "Keys" => match auth {
            "Manual" => "Manual account management",
            "Automatic LDAP" => "LDAP accounts - automatic",
            "Manual LDAP" => "LDAP accounts - manual",
            _ => "",
        },
        "Other" => "Managed by another system",
        "None" => "Unmanaged",
        "Decommissioned" => "Decommissioned",
        _ => "",
    }
});
