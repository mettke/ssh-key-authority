<h1>Public keys for <a href="<?php outurl('/users/'.urlencode($this->get('user')->uid))?>"><?php out($this->get('user')->name)?></a></h1>
<?php foreach($this->get('pubkeys') as $pubkey) { ?>
<div class="panel panel-default">
	<dl class="panel-body">
		<dt>Key data</dt>
		<dd><pre><?php out($pubkey->export())?></pre></dd>
		<dt>Key size</dt>
		<dd><?php out($pubkey->keysize)?></dd>
		<dt>Fingerprint (MD5)</dt>
		<dd><?php out($pubkey->fingerprint_md5)?></dd>
		<dt>Fingerprint (SHA256)</dt>
		<dd><?php out($pubkey->fingerprint_sha256)?></dd>
		<dt>Upload Date</dt>
		<dd><?php out($pubkey->upload_date) ?></dd>
		<?php if($this->config()['general']['key_expiration_enabled'] == 1) { ?>
		<dt>Expiration Date</dt>
		<dd>
		<?php 
		$date = $pubkey->upload_date;
		$expiration_days = $this->config()['general']['key_expiration_days'];
		$expiration_date = strtotime($date . ' + ' . $expiration_days . ' days');
		$expiration_time_in_days = round(($expiration_date - time()) / (60 * 60 * 24));
		out(date('Y-m-d H:i:s', $expiration_date) . ' (' . $expiration_time_in_days . ' days left)');
		?>
		</dd>
		<?php } ?>
	</dl>
</div>
<?php } ?>
