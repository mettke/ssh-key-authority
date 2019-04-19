<?php
$json = new StdClass;
$json->servers = array();
foreach($this->get('servers') as $server) {
	$last_sync_event = $server->get_last_sync_event();
	$jsonserver = new StdClass;
	$jsonserver->uuid = $server->uuid;
	$jsonserver->hostname = $server->hostname;
	$jsonserver->key_management = $server->key_management;
	$jsonserver->sync_status = $server->sync_status;
	if($this->get('active_user')->admin) {
		$jsonserver->admins = array();
		foreach($server->list_effective_admins() as $admin) {
			$jsonserver->admins[] = $admin->uid;
		}
	}
	if($last_sync_event) {
		$jsonserver->last_sync_event = new StdClass;
		$jsonserver->last_sync_event->details = $last_sync_event->details;
		$jsonserver->last_sync_event->date = $last_sync_event->date;
	} else {
		$jsonserver->last_sync_event = null;
	}
	$json->servers[] = $jsonserver;
}
out(json_encode($json), ESC_NONE);
