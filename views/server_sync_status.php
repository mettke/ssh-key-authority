<?php
try {
	$server = $server_dir->get_server_by_hostname($router->vars['hostname']);
} catch(ServerNotFoundException $e) {
	require('views/error404.php');
	die;
}
$page = new PageSection('server_sync_status_json');
$page->set('sync_status', $server->sync_status);
$page->set('last_sync', $server->get_last_sync_event());
$page->set('pending', count($server->list_sync_requests()) > 0);
$page->set('accounts', $server->list_accounts());
header('Content-type: application/json; charset=utf-8');
echo $page->generate();
