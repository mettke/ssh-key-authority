<?php
$json = array();
foreach($this->get('pubkeys') as $pubkey) {
	$json[] = pubkey_json($pubkey, true, false);
}
out(json_encode($json), ESC_NONE);
