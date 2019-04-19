<?php
$json = new StdClass;
$json->users = array();
$json->server_accounts = array();
foreach($this->get('group_members') as $member) {
	$group_member = new StdClass;
	if(get_class($member) == 'User') {
		$group_member->uid = $member->uid;
		$group_member->email = $member->email;
		$json->users[] = $group_member;
	} elseif(get_class($member) == 'ServerAccount') {
		$group_member->name = $member->name;
		$group_member->hostname = $member->server->hostname;
		$json->server_accounts[] = $group_member;
	}
}
out(json_encode($json), ESC_NONE);
