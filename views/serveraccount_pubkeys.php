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
$pubkeys = $account->list_public_keys();
if(isset($router->vars['format']) && $router->vars['format'] == 'txt') {
	$page = new PageSection('entity_pubkeys_txt');
	$page->set('pubkeys', $pubkeys);
	header('Content-type: text/plain; charset=utf-8');
	echo $page->generate();
} elseif(isset($router->vars['format']) && $router->vars['format'] == 'json') {
	$page = new PageSection('entity_pubkeys_json');
	$page->set('pubkeys', $pubkeys);
	header('Content-type: application/json; charset=utf-8');
	echo $page->generate();
}
