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

    public function getAllUsers() { return $this->getAllData('users'); }

	public function addUsers($login, $hash , $token){
		$query = 'INSERT INTO users (login, password , token) VALUES ("'.$login . '" , "' . $hash . '" , "' . $token .'")';
		$this->conn->query($query);
        return true;
    }

    public function updateToken($id, $token) {
        $query = 'UPDATE users SET token="' . $token . '" WHERE id=' . $id;
        $this->conn->query($query);
        return true;
    }
    
    public function updateUserMoney($id, $money) {
        $query = 'UPDATE users SET money = money + '.$money.' WHERE id=' . $id;
        $this->conn->query($query);
        return true;
    }

    public function getHulls() { return $this->getAllData('hull'); }
    public function getGuns() { return $this->getAllData('gun'); }
    public function getShassis() { return $this->getAllData('shassis'); }
    public function getTeams() { return $this->getAllData('team'); }

    public function getHull($id) { return $this->getDataById('hull', $id); }
    public function getGun($id) { return $this->getDataById('gun', $id); }
    public function getShassi($id) { return $this->getDataById('shassis', $id); }
    public function getTeam($id) { return $this->getDataById('team', $id); }

    public function getBattle() {
        $query = 'SELECT * FROM battle';
        $result = $this->conn->query($query);
        return $this->oneRecord($result);
    }

    public function getField(){ return $this->getAllData('field'); }
	public function getTanks(){ return $this->getAllData('tanks'); }
	public function getBuildings(){ return $this->getAllData('building'); }
    public function getBullets(){ return $this->getAllData('bullets'); }
    public function getBooms(){ return $this->getAllData('booms'); }
    
    public function getSpriteMap(){ return $this->getAllData('sprite_map'); }

    public function getSpeed($shassisType){ return $this->getDataById('shassis', $shassisType); }
	public function getTankByUserId($userId){return $this->getDataByUserId('tanks', $userId); }
	public function getBaseById($id){ return $this->getDataById('building', id); }

    public function addTank($userId, $teamId, $hp, $cargo, $hullId, $gunId, $shassiId, $x, $y) {
        $query = 'DELETE FROM tanks WHERE user_id=' . $userId;
        $this->conn->query($query);
        $query = 'INSERT INTO tanks 
                (user_id, team, x, y, hp, cargo, hullType, gunType, shassisType ) 
                VALUES 
                ('.$userId.', 
                 '.$teamId.',
				 '.$x.',
				 '.$y.',
                 '.$hp.', 
                 '.$cargo.', '.$hullId.', '.$gunId.', '.$shassiId.')';
        $this->conn->query($query);
        return true;
    }

	public function addBullet($x, $y, $direction, $type, $rangeBullet, $user_id){
		$query = 'INSERT INTO bullets 
                (x, y, direction, type, rangeBullet, user_id)
				VALUES 
                ('.$x.', 
                 '.$y.',
				 "'.$direction.'",
				 '.$type.',
                 '.$rangeBullet.',
                 '.$user_id.')';
		$this->conn->query($query);
        return true;
    }

    public function addBuilding($team, $x, $y, $hp, $width, $height, $type) {
        $query = 'INSERT INTO building 
                (team, x, y, hp, width, height, type )
                VALUES 
                ('.$team.', 
                 '.$x.',
                 '.$y.',
                 '.$hp.',
                 '.$width.',
                 '.$height.',
                 "'.$type.'")';
        $this->conn->query($query);
        return true;
    }
    
    public function addBoom($x, $y){
		$query = 'INSERT INTO booms (x, y) VALUES ('.$x.', '.$y.')';
		$this->conn->query($query);
        return true;
    }

    public function addBlock($x, $y, $hp) {
        $query = 'INSERT INTO field (x, y, hp) VALUES ('.$x.', '.$y.', '.$hp.')';
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

    public function updateBulletById($bulletId, $x, $y, $rangeBullet) {
        $query = 'UPDATE bullets SET x='.$x.', y= '.$y.', rangeBullet = '.$rangeBullet.' WHERE id='.$bulletId;
        $this->conn->query($query);
        return true;
    }

    public function updateReloadTimeStamp($id, $timeStamp) {
        $query = 'UPDATE tanks SET reloadTimeStamp='.$timeStamp.' WHERE id='.$id;
        $this->conn->query($query);
        return true;
    }

    public function UpdateHpById($tableName, $hp, $id) {
        $query = 'UPDATE '.$tableName.' SET hp='.$hp.' WHERE id='.$id;
        $this->conn->query($query);
        return true;
    }

    public function updateBoomById($boomId, $timeLife){
        $query = 'UPDATE booms SET timeLife='.$timeLife.' WHERE id='.$boomId;
        $this->conn->query($query);
        return true;
    }

    public function updateBlockById($blockId, $hp) {return $this->UpdateHpById('field', $hp, $blockId); }
    public function updateBuildingById($buildingId, $hp) {return $this->UpdateHpById('building', $hp, $buildingId); }
    public function updateTankById($tankId, $hp) {return $this->UpdateHpById('tanks', $hp, $tankId); }

    public function DeleteById($tableName, $id) {
        $query = 'DELETE FROM '.$tableName.' WHERE id=' . $id;
        $this->conn->query($query);
		return true;
    }
    

	public function deleteBulletById($bulletId){return $this->DeleteById('bullets', $bulletId); }
    public function deleteBlockById($blockId){return $this->DeleteById('field', $blockId); }
    public function deleteBuildingById($buildingId){return $this->DeleteById('building', $buildingId); }
    public function deleteTankById($tankId){return $this->DeleteById('tanks', $tankId); }
    public function deleteBoomById($boomId){return $this->DeleteById('booms', $boomId); }
    
    public function deleteAllData($tableName){
        $query = 'DELETE FROM '.$tableName;
        $this->conn->query($query);
		return true;
    }

    public function deleteAllTank(){return $this->deleteAllData('tanks'); }
    public function deleteAllBuilding(){return $this->deleteAllData('building'); }
    public function deleteAllObject(){return $this->deleteAllData('objects'); }
    public function deleteAllBlock(){return $this->deleteAllData('field'); }
    public function deleteAllBullet(){return $this->deleteAllData('bullets'); }
    public function deleteAllBoom(){return $this->deleteAllData('booms'); }

    public function isTankExists($userId) {
        return $this->getDataByUserId('tanks', $userId);
    }

    public function getBaseCount(){
        $query = 'SELECT COUNT(type) AS count FROM building WHERE type="base"';
        $result = $this->conn->query($query);
        return intval($this->oneRecord($result)->count);
    }

	public function getBaseByTeamId($teamId) {
        $query = 'SELECT * FROM building WHERE team=' . $teamId;
        $result = $this->conn->query($query);
        return $this->oneRecord($result);
    }
}