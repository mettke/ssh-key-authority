<?php
$json = new StdClass;
$json->public_keys = array();
foreach($this->get('pubkeys') as $pubkey) {
	$json->public_keys[] = pubkey_json($pubkey, false, true);
}
out(json_encode($json), ESC_NONE);
