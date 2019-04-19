<?php
/**
* Abstract class that represents a log event that was recorded in relation to an entity
*/
abstract class EntityEvent extends Record {
	/**
	* Defines the database table that this object is stored in
	*/
	protected $table = 'entity_event';

	/**
	* Magic getter method - if actor field requested, return User object of the person who triggered
	* the logged event.
	* @param string $field to retrieve
	* @return mixed data stored in field
	*/
	public function &__get($field) {
		global $user_dir;
		switch($field) {
		case 'actor':
			$actor = new User($this->data['actor_id']);
			return $actor;
		default:
			return parent::__get($field);
		}
	}
}
