<?php
/**
* Basic database directory abstract class. Inherited by most classes that manipulate lists of objects in the database.
*/
abstract class DBDirectory {
	protected $database;

	/**
	* Sets up the local $database object for use by the inheriting classes.
	*/
	public function __construct() {
		global $database;
		$this->database = $database;
	}

}
