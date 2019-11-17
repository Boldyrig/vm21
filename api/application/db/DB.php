<?php

class DB {

    function __construct() {
        $host = 'localhost';
        $user = 'root';
        $password = '';
        $db = 'vmech';
        $this->conn = new mysqli($host, $user, $password, $db);
        if ($this->conn->connect_errno) {
            printf("Не удалось подключиться: %s\n", $this->conn->connect_error);
            exit();
        }
    }

    function __destruct() {
        $this->conn->close();
    }

    private function oneRecord($result) {
        while ($row = $result->fetch_object()) {
            return $row;
        }
        return null;
    }

    private function allRecords($result) {
        $res = array();
        while ($row = $result->fetch_object()) {
            $res[] = $row;
        }
        return $res;
    }

    private function getAllData($tableName) {
        $query = 'SELECT * FROM ' . $tableName;
        $result = $this->conn->query($query);
        return $this->allRecords($result);
    }

    private function getDataById($tableName, $id) {
        $query = 'SELECT * FROM ' . $tableName . ' WHERE id=' . $id;
        $result = $this->conn->query($query);
        return $this->oneRecord($result);
    }

	private function getDataByUserId($tableName, $userId) {
        $query = 'SELECT * FROM ' . $tableName . ' WHERE user_id=' . $userId;
        $result = $this->conn->query($query);
        return $this->oneRecord($result);
    }

    public function getUserByLogin($login) {
        $query = 'SELECT * FROM users WHERE login="' . $login . '"';
        $result = $this->conn->query($query);
        return $this->oneRecord($result);
    }

	public function getUsers(){
		$query = 'SELECT * FROM users';
        $result = $this->conn->query($query);
        return $this->oneRecord($result);
	}

    public function getUserByToken($token) {
        $query = 'SELECT * FROM users WHERE token="' . $token . '"';
        $result = $this->conn->query($query);
        return $this->oneRecord($result);
    }

    public function updateToken($id, $token) {
        $query = 'UPDATE users SET token="' . $token . '" WHERE id=' . $id;
        $this->conn->query($query);
        return true;
    }

    public function getAllUsers() { return $this->getAllData('users'); }
    public function getHulls() { return $this->getAllData('hull'); }
    public function getGuns() { return $this->getAllData('gun'); }
    public function getShassis() { return $this->getAllData('shassis'); }
    public function getTeams() { return $this->getAllData('team'); }

    public function getHull($id) { return $this->getDataById('hull', $id); }
    public function getGun($id) { return $this->getDataById('gun', $id); }
    public function getShassi($id) { return $this->getDataById('shassis', $id); }
    public function getTeam($id) { return $this->getDataById('team', $id); }

    public function addTank($userId, $teamId, $reloadTime, $hp, $cargo, $hullId, $gunId, $shassiId, $x, $y) {
        // удалить все танки игрока
        $query = 'DELETE FROM tanks WHERE user_id=' . $userId;
        $this->conn->query($query);
        // добавить танк игрока
        $query = 'INSERT INTO tanks 
                (user_id, team, x, y, reloadTime, hp, cargo, hullType, gunType, shassisType ) 
                VALUES 
                ('.$userId.', 
                 '.$teamId.',
				 '.$x.',
				 '.$y.',
                 '.$reloadTime.', 
                 '.$hp.', 
                 '.$cargo.', '.$hullId.', '.$gunId.', '.$shassiId.')';
        $this->conn->query($query);
        return true;
    }

    public function getBattle() {
        $query = 'SELECT * FROM battle';
        $result = $this->conn->query($query);
        return $this->oneRecord($result);
    }

	public function addUsers($login, $hash , $token){
		$query = 'INSERT INTO users (login, password , token) VALUES ("'.$login . '" , "' . $hash . '" , "' . $token .'")';
		$this->conn->query($query);
        return true;
    }
    
    public function updateUserMoney($id, $money) {
        $query = 'UPDATE users SET money='.$money.' WHERE id=' . $id;
        $this->conn->query($query);
        return true;
    }

    public function updateBattleTimeStamp($id, $timeStamp) {
        $query = 'UPDATE battle SET timeStamp='.$timeStamp.' WHERE id='.$id;
        $this->conn->query($query);
        return true;
    }

    public function updateTankXY($id, $x, $y, $direction, $timeStamp) {
        $query = 'UPDATE  tanks SET  x='.$x.', y= '.$y.', direction = "'.$direction.'", moveTimeStamp = '.$timeStamp.' WHERE id='.$id;
        $this->conn->query($query);
        return true;
    }

    public function getField(){
        return $this->getAllData('field');
    }

	public function getTanks(){
        return $this->getAllData('tanks');
    }

	public function getBuildings(){
		return $this->getAllData('building');
    }
    
    public function getSpeed($shassisType){
        return $this->getDataById('shassis', $shassisType);
    }

}