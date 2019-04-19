<?php
$pubkey = $this->get('pubkey');
out($pubkey->export()."\n", ESC_NONE);
