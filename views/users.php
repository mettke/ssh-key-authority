<?php
if(isset($_POST['add_user']) && $active_user->admin) {
    $uid = trim($_POST['uid']);
    $name = trim($_POST['name']);
    $email = trim($_POST['email']);
    
    $user = new User;
    $user->uid = $uid;
    $user->name = $name;
    $user->email = $email;
    
    $user->active = 1;
    if (isset($_POST['admin']) && $_POST['admin'] === 'admin') {
        $user->admin = 1;
    } else {
        $user->admin = 0;
    }
    $user->auth_realm = 'local';

    try {
        $user_dir->add_user($user);
        $alert = new UserAlert;
        $alert->content = 'User \'<a href="'.rrurl('/users/'.urlencode($user->uid)).'" class="alert-link">'.hesc($user->uid).'</a>\' successfully created.';
        $alert->escaping = ESC_NONE;
        $active_user->add_alert($alert);
    } catch(UserAlreadyExistsException $e) {
        $alert = new UserAlert;
        $alert->content = 'User \'<a href="'.rrurl('/users/'.urlencode($user->uid)).'" class="alert-link">'.hesc($user->uid).'</a>\' is already known by SSH Key Authority.';
        $alert->escaping = ESC_NONE;
        $alert->class = 'danger';
        $active_user->add_alert($alert);
    }
    redirect('#add');
} else {
    $content = new PageSection('users');
    $content->set('users', $user_dir->list_users());
    $content->set('admin', $active_user->admin);
}
    
$page = new PageSection('base');
$page->set('title', 'Users');
$page->set('content', $content);
$page->set('alerts', $active_user->pop_alerts());
echo $page->generate();
