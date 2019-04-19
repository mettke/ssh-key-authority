<?php
$content = new PageSection('csrf');
$content->set('address', $relative_request_url);
$content->set('fulladdress', $absolute_request_url);

$page = new PageSection('base');
$page->set('title', 'Form submission failed');
$page->set('content', $content);
$page->set('alerts', array());
echo $page->generate();
