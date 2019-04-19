<?php
$defaults = array();
$defaults['fingerprint'] = '';
$defaults['type'] = '';
$defaults['keysize-min'] = '';
$defaults['keysize-max'] = '';
$filter = simplify_search($defaults, $_GET);
$pubkeys = $pubkey_dir->list_public_keys(array(), $filter);

if(isset($router->vars['format']) && $router->vars['format'] == 'json') {
	$page = new PageSection('pubkeys_json');
	$page->set('pubkeys', $pubkeys);
	header('Content-type: text/plain; charset=utf-8');
	echo $page->generate();
} else {
	$content = new PageSection('pubkeys');
	$content->set('filter', $filter);
	$content->set('pubkeys', $pubkeys);
	$content->set('admin', $active_user->admin);

	$page = new PageSection('base');
	$page->set('title', 'Public keys');
	$page->set('content', $content);
	$page->set('alerts', $active_user->pop_alerts());
	echo $page->generate();
}
