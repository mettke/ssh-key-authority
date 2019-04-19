<?php
if(!$active_user->admin) {
	require('views/error403.php');
	die;
}

$content = new PageSection('tools');

$page = new PageSection('base');
$page->set('title', 'Tools');
$page->set('content', $content);
$page->set('alerts', $active_user->pop_alerts());
echo $page->generate();
