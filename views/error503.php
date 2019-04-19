<?php
$content = new PageSection('error503');

$page = new PageSection('base');
$page->set('title', 'Down for maintenance');
$page->set('content', $content);
$page->set('alerts', array());
header('HTTP/1.1 503 Service Unavailable');
echo $page->generate();
