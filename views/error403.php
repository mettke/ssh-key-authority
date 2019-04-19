<?php
$content = new PageSection('error403');
$content->set('address', $relative_request_url);
$content->set('fulladdress', $absolute_request_url);

$page = new PageSection('base');
$page->set('title', 'Access denied');
$page->set('content', $content);
$page->set('alerts', array());
header('HTTP/1.1 403 Forbidden');
echo $page->generate();
