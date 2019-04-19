<?php
$migration_name = 'Add additional ssh key access options';

function free_results_006($database) {
    do {
        if ($res = $database->store_result()) {
            $res->free();
        }
    } while ($database->more_results() && $database->next_result()); 
}

$this->database->autocommit(FALSE);

$this->database->multi_query("
CREATE TABLE `access_option_2` (
    `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
    `access_id` int(10) unsigned NOT NULL,
    `option` enum('command', 'from', 'environment', 'no-agent-forwarding', 'no-port-forwarding', 'no-pty', 'no-X11-forwarding', 'no-user-rc') NOT NULL,
    `value` text,
    PRIMARY KEY (`id`),
    UNIQUE KEY `access_id_option` (`access_id`, `option`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT access_option_2 SELECT * FROM access_option;

DROP TABLE access_option;
RENAME TABLE access_option_2 TO access_option;

ALTER TABLE `access_option`
ADD CONSTRAINT `FK_access_option_access` FOREIGN KEY (`access_id`) REFERENCES `access` (`id`) ON DELETE CASCADE
");
free_results_006($this->database);

$this->database->multi_query("
CREATE TABLE `server_ldap_access_option_2` (
    `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
    `server_id` int(10) unsigned NOT NULL,
    `option` enum('command', 'from', 'environment', 'no-agent-forwarding', 'no-port-forwarding', 'no-pty', 'no-X11-forwarding', 'no-user-rc') NOT NULL,
    `value` text,
    PRIMARY KEY (`id`),
    UNIQUE KEY `server_id_option` (`server_id`, `option`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT server_ldap_access_option_2 SELECT * FROM server_ldap_access_option;

DROP TABLE server_ldap_access_option;
RENAME TABLE server_ldap_access_option_2 TO server_ldap_access_option;

ALTER TABLE `server_ldap_access_option`
ADD CONSTRAINT `FK_server_ldap_access_option_server` FOREIGN KEY (`server_id`) REFERENCES `server` (`id`) ON DELETE CASCADE
");
free_results_006($this->database);

$this->database->commit();

$this->database->autocommit(TRUE);
