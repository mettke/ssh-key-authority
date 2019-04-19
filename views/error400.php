<?php
$content = new PageSection('error400');
$content->set('referrer', isset($_SERVER['HTTP_REFERER']) ? $_SERVER['HTTP_REFERER'] : '');
$content->set('host', isset($_SERVER['HTTP_HOST']) ? $_SERVER['HTTP_HOST'] : '');

$page = new PageSection('base');
$page->set('title', 'Bad Request');
$page->set('content', $content);
$page->set('alerts', array());
header('HTTP/1.1 400 Bad Request');
echo $page->generate();
