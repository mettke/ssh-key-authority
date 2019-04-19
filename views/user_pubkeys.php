<?php
try {
	$user = $user_dir->get_user_by_uid($router->vars['username']);
} catch(UserNotFoundException $e) {
	require('views/error404.php');
	die;
}
$pubkeys = $user->list_public_keys();
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
} else {
	$content = new PageSection('user_pubkeys');
	$content->set('user', $user);
	$content->set('pubkeys', $pubkeys);
	$content->set('admin', $active_user->admin);

	$head = '<link rel="alternate" type="application/json" href="pubkeys.json" title="JSON for this page">'."\n";
	$head .= '<link rel="alternate" type="text/plain" href="pubkeys.txt" title="TXT format for this page">'."\n";

	$page = new PageSection('base');
	$page->set('title', 'Public keys for '.$user->name);
	$page->set('head', $head);
	$page->set('content', $content);
	$page->set('alerts', $active_user->pop_alerts());
	echo $page->generate();
}
