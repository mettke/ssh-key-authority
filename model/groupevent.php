<?php
/**
* Class that represents a log event that was recorded in relation to a group
*/
class GroupEvent extends EntityEvent {
	/**
	* Magic getter method - if group field requested, return Group object of the affected group.
	* @param string $field to retrieve
	* @return mixed data stored in field
	*/
	public function &__get($field) {
		switch($field) {
		case 'group':
			$group = new Group($this->data['entity_id']);
			return $group;
		default:
			return parent::__get($field);
		}
	}
}
