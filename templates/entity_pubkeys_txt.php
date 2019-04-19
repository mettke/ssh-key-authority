<?php
foreach($this->get('pubkeys') as $pubkey) {
	out($pubkey->export()."\n", ESC_NONE);
}
