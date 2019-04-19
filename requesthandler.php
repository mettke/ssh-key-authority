<?php
chdir(dirname(__FILE__));
require('core.php');
ob_start();
set_exception_handler('exception_handler');

// Work out where we are on the server
$base_path = dirname(__FILE__);
$base_url = dirname($_SERVER['SCRIPT_NAME']);
$request_url = $_SERVER['REQUEST_URI'];
$isSecure = false;
if (isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] == 'on') {
    $isSecure = true;
} elseif (!empty($_SERVER['HTTP_X_FORWARDED_PROTO']) && $_SERVER['HTTP_X_FORWARDED_PROTO'] == 'https' || !empty($_SERVER['HTTP_X_FORWARDED_SSL']) && $_SERVER['HTTP_X_FORWARDED_SSL'] == 'on') {
    $isSecure = true;
}
if(!isset($_SERVER['HTTP_HOST'])) {
	require('views/error400.php');
	die;
}
$relative_request_url = preg_replace('/^'.preg_quote($base_url, '/').'/', '/', $request_url);
$absolute_request_url = 'http'.($isSecure ? 's' : '').'://'.$_SERVER['HTTP_HOST'].$request_url;

if(isset($_SERVER['PHP_AUTH_USER'])) {
	try {
		$active_user = $user_dir->get_user_by_uid($_SERVER['PHP_AUTH_USER']);
	} catch(UserNotFoundException $ex) {
		require('views/error403.php');
		die;
	}
} else {
	throw new Exception("Not logged in.");
}

if(empty($config['web']['enabled'])) {
	require('views/error503.php');
	die;
}

if(!$active_user->active) {
	require('views/error403.php');
	die;
}

if(!empty($_POST)) {
	// Check CSRF token
	if(isset($_SERVER['HTTP_X_BYPASS_CSRF_PROTECTION']) && $_SERVER['HTTP_X_BYPASS_CSRF_PROTECTION'] == 1) {
		// This is being called from script, not a web browser
	} elseif(!$active_user->check_csrf_token($_POST['csrf_token'])) {
		require('views/csrf.php');
		die;
	}
}

// Route request to the correct view
$router = new Router;
foreach($routes as $path => $service) {
	$public = array_key_exists($path, $public_routes);
	$router->add_route($path, $service, $public);
}
$router->handle_request($relative_request_url);
if(isset($router->view)) {
	$view = path_join($base_path, 'views', $router->view.'.php');
	if(file_exists($view)) {
		if($active_user->auth_realm == 'LDAP' || $active_user->auth_realm == 'local' || $router->public) {
			require($view);
		} else {
			require('views/error403.php');
			die;
		}
	} else {
		throw new Exception("View file $view missing.");
	}
}

// Handler for uncaught exceptions
function exception_handler($e) {
	global $active_user, $config;
	$error_number = time();
	error_log("$error_number: ".str_replace("\n", "\n$error_number: ", $e));
	while(ob_get_length()) {
		ob_end_clean();
	}
	require('views/error500.php');
	die;
}
