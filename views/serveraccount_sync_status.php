<?php
try {
	$server = $server_dir->get_server_by_hostname($router->vars['hostname']);
	$account = $server->get_account_by_name($router->vars['account']);
} catch(ServerAccountNotFoundException $e) {
	require('views/error404.php');
	die;
} catch(ServerNotFoundException $e) {
	require('views/error404.php');
	die;
}
$page = new PageSection('serveraccount_sync_status_json');
$page->set('sync_status', $account->sync_status);
$page->set('pending', $account->sync_is_pending());
header('Content-type: application/json; charset=utf-8');
echo $page->generate();
