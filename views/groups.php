<?php
if(isset($_POST['add_group']) && ($active_user->admin)) {
	$name = trim($_POST['name']);
	if(preg_match('|/|', $name)) {
		$content = new PageSection('invalid_group_name');
		$content->set('group_name', $name);
	} else {
		try {
			$new_admin = $user_dir->get_user_by_uid(trim($_POST['admin_uid']));
		} catch(UserNotFoundException $e) {
			$content = new PageSection('user_not_found');
		}
		if(isset($new_admin)) {
			$group = new Group;
			$group->name = $name;
			try {
				$group_dir->add_group($group);
				$group->add_admin($new_admin);
				$alert = new UserAlert;
				$alert->content = 'Group \'<a href="'.rrurl('/groups/'.urlencode($name)).'" class="alert-link">'.hesc($name).'</a>\' successfully created.';
				$alert->escaping = ESC_NONE;
				$active_user->add_alert($alert);
			} catch(GroupAlreadyExistsException $e) {
				$alert = new UserAlert;
				$alert->content = 'Group \'<a href="'.rrurl('/groups/'.urlencode($name)).'" class="alert-link">'.hesc($name).'</a>\' already exists.';
				$alert->escaping = ESC_NONE;
				$alert->class = 'danger';
				$active_user->add_alert($alert);
			}
			redirect('#add');
		}
	}
} else {
	$defaults = array();
	$defaults['active'] = array('1');
	$defaults['name'] = '';
	$filter = simplify_search($defaults, $_GET);
	try {
		$groups = $group_dir->list_groups(array('admins', 'members'), $filter);
	} catch(GroupSearchInvalidRegexpException $e) {
		$groups = array();
		$alert = new UserAlert;
		$alert->content = "The group name search pattern '".$filter['hostname']."' is invalid.";
		$alert->class = 'danger';
		$active_user->add_alert($alert);
	}
	$content = new PageSection('groups');
	$content->set('filter', $filter);
	$content->set('admin', $active_user->admin);
	$content->set('groups', $groups);
	$content->set('all_users', $user_dir->list_users());
}

$page = new PageSection('base');
$page->set('title', 'Groups');
$page->set('content', $content);
$page->set('alerts', $active_user->pop_alerts());
echo $page->generate();
