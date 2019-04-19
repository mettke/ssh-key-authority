<?php
$content = new PageSection('error404');
$content->set('address', $relative_request_url);
$content->set('fulladdress', $absolute_request_url);
$content->set('referrer', isset($_SERVER['HTTP_REFERER']) ? $_SERVER['HTTP_REFERER'] : '');

$page = new PageSection('base');
$page->set('title', 'Page not found');
$page->set('content', $content);
$page->set('alerts', array());
header('HTTP/1.1 404 Not Found');
echo $page->generate();
