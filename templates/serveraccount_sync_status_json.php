<?php
$sync_status = $this->get('sync_status');
$pending = $this->get('pending');
$json = new StdClass;
$json->sync_status = $sync_status;
$json->pending = $pending;
out(json_encode($json), ESC_NONE);
