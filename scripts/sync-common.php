<?php
/**
* Synchronization child process object
*/
class SyncProcess {
	private $handle;
	private $pipes;
	private $output;
	private $errors;
	private $request;

	/**
	* Create a new sync process
	* @param string $command command to run
	* @param array $args arguments
	* @param Request $request object that triggered this sync
	*/
	public function __construct($command, $args, $request = null) {
		global $config;
		$timeout_util = $config['general']['timeout_util'];

		$this->request = $request;
		$this->output = '';
		$descriptorspec = array(
			0 => array("pipe", "r"),  // stdin
			1 => array("pipe", "w"),  // stdout
			2 => array("pipe", "w"),  // stderr
			3 => array("pipe", "w")   //
		);
		switch ($timeout_util) {
			case "BusyBox":
				$commandline = '/usr/bin/timeout -t 60 '.$command.' '.implode(' ', array_map('escapeshellarg', $args));
				break;
			default:
				$commandline = '/usr/bin/timeout 60s '.$command.' '.implode(' ', array_map('escapeshellarg', $args));
		}

		$this->handle = proc_open($commandline, $descriptorspec, $this->pipes);
		stream_set_blocking($this->pipes[1], 0);
		stream_set_blocking($this->pipes[2], 0);
	}

	/**
	* Get data from the child process
	* @return string output from the child process
	*/
	public function get_data() {
		if(isset($this->handle) && is_resource($this->handle)) {
			$out = fread($this->pipes[1], 4096);
			$this->output .= $out;
			$this->errors .= fread($this->pipes[2], 4096);
			if(feof($this->pipes[1]) && feof($this->pipes[2])) {
				foreach($this->pipes as $ref => $pipe) {
					fclose($this->pipes[$ref]);
				}
				unset($this->handle);
				if($this->errors) {
					echo $this->errors;
					$this->output = '';
				}
				return array('done' => true, 'output' => $this->output);
			}
		}
	}

	/**
	* Delete the request that triggered this sync
	*/
	public function __destruct() {
		global $sync_request_dir;
		if(!is_null($this->request)) {
			$sync_request_dir->delete_sync_request($this->request);
		}
	}
}
