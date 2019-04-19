<?php
class ServerAccountEvent extends EntityEvent {
	/**
	* Magic getter method - if account field requested, return ServerAccount object of the affected account.
	* @param string $field to retrieve
	* @return mixed data stored in field
	*/
	public function &__get($field) {
		switch($field) {
		case 'account':
			$group = new ServerAccount($this->data['entity_id']);
			return $group;
		default:
			return parent::__get($field);
		}
	}
}
