<?php
/**
* Class that represents an alert associated with a user
*/
class UserAlert extends Record {
	/**
	* Defines the database table that this object is stored in
	*/
	protected $table = 'user_alert';

	/**
	* Set some default values for the alert, including escaping HTML by default.
	*/
	public function __construct($id = null, $preload_data = array()) {
		parent::__construct($id, $preload_data);
		if(!isset($this->data['class'])) $this->data['class'] = 'success';
		if(!isset($this->data['escaping'])) $this->data['escaping'] = ESC_HTML;
	}
}
