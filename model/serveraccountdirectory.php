<?php
/**
* Class for reading/writing to the list of ServerAccount objects in the database.
* This class has no add or list methods as these will always be invoked from the parent object (Server).
*/
class ServerAccountDirectory extends DBDirectory {
	/**
	* Get a server account from the database by its entity ID.
	* @param int $entity_id of server account
	* @return ServerAccount with specified entity ID
	* @throws ServerAccountNotFoundException if no server account with that entity ID exists
	*/
	public function get_server_account_by_id($entity_id) {
		$stmt = $this->database->prepare("SELECT * FROM server_account WHERE entity_id = ?");
		$stmt->bind_param('d', $entity_id);
		$stmt->execute();
		$result = $stmt->get_result();
		if($row = $result->fetch_assoc()) {
			$account = new ServerAccount($row['entity_id'], $row);
		} else {
			throw new ServerAccountNotFoundException('Server account does not exist.');
		}
		$stmt->close();
		return $account;
	}
}

class ServerAccountNotFoundException extends Exception {}
class ServerAccountNotDeletableException extends Exception {}
