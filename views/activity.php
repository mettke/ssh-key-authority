<?php
if(!$active_user->admin && count($active_user->list_admined_servers()) == 0 && count($active_user->list_admined_groups()) == 0) {
	require('views/error403.php');
	die;
}

$content = new PageSection('activity');
if($active_user->admin) {
	$content->set('events', $event_dir->list_events());
} else {
	$content->set('events', $active_user->list_events());
}

$page = new PageSection('base');
$page->set('title', 'Activity');
$page->set('content', $content);
$page->set('alerts', $active_user->pop_alerts());
echo $page->generate();
