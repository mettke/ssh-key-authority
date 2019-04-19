<h1>Bulk mail <?php out(str_replace('_', ' ', $this->get('recipients')))?></h1>
<div class="alert alert-warning">This form will send a mail to <strong>all</strong> <?php out($this->get('rcpt_desc'))?> the SSH Key Authority system!</div>
<form method="post" action="<?php outurl($this->data->relative_request_url)?>">
	<?php out($this->get('active_user')->get_csrf_field(), ESC_NONE) ?>
	<div class="form-group">
		<label for="subject">Subject</label>
		<input type="text" class="form-control" id="subject" name="subject" required value="">
	</div>
	<div class="form-group">
		<label for="body">Body</label>
		<textarea class="form-control monospace" rows="20" id="body" name="body" required>You are being sent this mail as a <?php out($this->get('rcpt_role'))?> the SSH Key Authority system.

</textarea>
	</div>
	<div class="form-group"><button type="submit" data-confirm="Send mail? Are you sure?" class="btn btn-primary btn-lg btn-block">Send bulk mail to <?php out(str_replace('_', ' ', $this->get('recipients')))?></button></div>
</form>
