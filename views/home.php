<?php
global $config;
$public_keys = $active_user->list_public_keys();
$admined_servers = $active_user->list_admined_servers(array('pending_requests', 'admins'));

if(isset($_POST['add_public_key'])) {
	try {
		$public_key = new PublicKey;
		$public_key->import($_POST['add_public_key'], $active_user->uid);
		$active_user->add_public_key($public_key);
		redirect();
	} catch(InvalidArgumentException $e) {
		$content = new PageSection('key_upload_fail');
		switch($e->getMessage()) {
		case 'Insufficient bits in public key':
			$minbits = $config['general']['minimum_rsa_key_size'];
			$content->set('message', "The public key you submitted is of insufficient strength; it must be at least " . $minbits . " bits.");
			break;
		default:
			$content->set('message', "The public key you submitted doesn't look valid.");
		}
	} catch(PublicKeyAlreadyKnownException $e) {
		$content = new PageSection('key_upload_fail');
		$content->set('message', "The public key you submitted is already in use. Please create a new one.");
	}
} elseif(isset($_POST['delete_public_key'])) {
	foreach($public_keys as $public_key) {
		if($public_key->id == $_POST['delete_public_key']) {
			$key_to_delete = $public_key;
		}
	}
	if(isset($key_to_delete)) {
		$active_user->delete_public_key($key_to_delete);
	}
	redirect();
} else {
	$content = new PageSection('home');
	$content->set('user_keys', $public_keys);
	$content->set('admined_servers', $admined_servers);
	$content->set('uid', $active_user->uid);
}

$page = new PageSection('base');
$page->set('title', 'Keys management');
$page->set('content', $content);
$page->set('alerts', $active_user->pop_alerts());
echo $page->generate();
