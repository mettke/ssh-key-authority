<?php
/**
* Class that represents a destination restriction rule on a public key (based on account name and
* server hostname). Wildcards (*) are possible for use in either or both fields.
* Public keys with one or more PublicKeyDestRule objects associated with them will only be synced
* to a destination if it matches at least one of those rules.
*/
class PublicKeyDestRule extends Record {
	/**
	* Defines the database table that this object is stored in
	*/
	protected $table = 'public_key_dest_rule';
}
