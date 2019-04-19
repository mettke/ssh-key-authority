<?php
$server = $this->get('server');
$last_sync_event = $this->get('last_sync_event');
$json = new StdClass;
$json->uuid = $server->uuid;
$json->hostname = $server->hostname;
$json->key_management = $server->key_management;
$json->sync_status = $server->sync_status;
$json->rsa_key_fingerprint = $server->rsa_key_fingerprint;
if($last_sync_event) {
	$json->last_sync_event = new StdClass;
	$json->last_sync_event->details = $last_sync_event->details;
	$json->last_sync_event->date = $last_sync_event->date;
} else {
	$json->last_sync_event = null;
}
out(json_encode($json), ESC_NONE);
