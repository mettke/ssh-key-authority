#!/usr/bin/env php
<?php
chdir(__DIR__);
require('../core.php');

$pubkeys = $pubkey_dir->list_public_keys();
foreach($pubkeys as $pubkey) {
	try {
		$pubkey->import($pubkey->export(), null, true);
		$pubkey->update();
	} catch(InvalidArgumentException $e) {
		echo "Invalid public key {$pubkey->id}\n";
	}
}
