<?php
/**
* Class that represents a request for key syncing
*/
class SyncRequest extends Record {
	/**
	* Defines the database table that this object is stored in
	*/
	protected $table = 'sync_request';

	/**
	* Mark this request as in progress
	*/
	public function set_in_progress() {
		$this->processing = true;
		$this->update();
	}
}
