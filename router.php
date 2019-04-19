<?php
class Router {
	private $routes = array();
	private $route_vars;
	public $view = null;
	public $public = null;
	public $vars = array();

	public function add_route($path, $view, $public) {
		$this->route_vars = array();
		$path = preg_replace_callback('|\\\{([a-z]+)\\\}|', array($this, 'parse_route_variable'), preg_quote($path, '|'));
		$route = new StdClass;
		$route->view = $view;
		$route->vars = $this->route_vars;
		$route->public = $public;
		$this->routes[$path] = $route;
	}

	private function parse_route_variable($matches) {
		$this->route_vars[] = $matches[1];
		return '([^/]*)';
	}

	public function handle_request($request_path) {
		$request_path = preg_replace('|\?.*$|', '', $request_path);
		foreach($this->routes as $path => $route) {
			if(preg_match('|^'.$path.'$|', $request_path, $matches)) {
				$this->view = $route->view;
				$this->public = $route->public;
				$i = 0;
				foreach($route->vars as $var) {
					$i++;
					if(isset($matches[$i])) {
						$this->vars[$var] = urldecode($matches[$i]);
					}
				}
			}
		}
		if(is_null($this->view)) {
			$this->view = 'error404';
		}
	}
}
