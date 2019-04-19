<?php
$pubkey = $this->get('pubkey');
$json = pubkey_json($pubkey);
out(json_encode($json), ESC_NONE);
