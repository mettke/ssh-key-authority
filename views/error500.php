<?php
$content = new PageSection('error500');
$content->set('error_number', $error_number);
$content->set('admin_address', isset($config) ? $config['email']['admin_address'] : null);
if(isset($active_user) && is_object($active_user) && isset($e)) {
	if($active_user->developer) {
		$content->set('exception_class', get_class($e));
		$content->set('error_details', $e);
	}
}

$page = new PageSection('base');
$page->set('title', 'An error occurred');
$page->set('content', $content);
$page->set('alerts', array());
header('HTTP/1.1 500 Internal Server Error');
echo $page->generate();
