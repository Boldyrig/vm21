<?php
require_once('types/Tank.php');
require_once('types/Bullet.php');
require_once('types/Building.php');
require_once('types/Objects.php');

class VMech {
    function __construct($db) {
		$this->db = $db;
	}

	public function getConstructor() {
		$array = array();
		$array['CONSTRUCTOR'] = array(
			'TEAM' => $this->db->getTeams(),
			'GUN_TYPE' => $this->db->getGuns(),
			'SHASSIS_TYPE' => $this->db->getShassis(),
			'HULL_TYPE' => $this->db->getHulls()
		);
		$array['DEFAULT_MONEY'] = $this->db->getBattle()->defaultMoney;
		return $array;
	}

	// взять танк по id
	private function getTankById($id, $tanks) {
		for ($i = 0; $i < count($tanks); $i++) {
			if ($tanks[$i]->user_id === $id) {
				return $tanks[$i];
			}
		}
		return null;
	}

	// взять танк по (х, у)
    private function getTankByXY($x, $y, $tanks) {
        for ($i = 0; $i < count($tanks); $i++) {
            if (intval($tanks[$i]->x) === $x && intval($tanks[$i]->y) === $y) {
                return $tanks[$i];
            }
        }
        return null;
	}

	// взять пулю по (х, у)
	private function getBulletByXY($x, $y) {
		for ($i = 0; $i < count($this->bullets); $i++) {
			if ($x == $this->bullets[$i]->x && $y == $this->bullets[$i]->y) {
				return $this->bullets[$i];
			}
		}
		return null;
	}

	// взять объект по (х, у)	
	private function getObjectByXY($x, $y){
        for ($i = 0; $i < count($this->objects); $i++) {
            if ($x === $this->objects[$i]->x && $y === $this->objects[$i]->y) {
                return $this->objects[$i];
            }
        }
	}
	
	// проверка, находятся ли (x, y) в здании
	private function isInnerBuilding($x, $y, $buildings) {
		for ($i = 0; $i < count($buildings); $i++) {
			$building = $buildings[$i];
			if ($x >= $building->x && 
				$x <= $building->x + $building->width - 1 &&
				$y >= $building->y &&
				$y <= $building->y + $building->height - 1
			) {
				return true;
			}
		}
		return false;
	}

	// нанести урон object 
	private function damage($object, $bullet){
		$damage = $bullet->damage;
		if($object->hp > $damage) {
			 $object->hp -= $damage;
		} else {
			if(get_class($object) ===  Tank){
				$this->killTank($object->id);
			}
			if(get_class($object) === Building){
				$this->killBuilding($object->id);
			}
			if(get_class($object) === Objects){
				$this->killObject($object->id);
			}
		}
	}

	//вырезать танк из массива по id
	private function killTank($id) {
		for ($i = 0; $i < count($this->tanks); $i++) {
			if ($id == $this->tanks[$i]->id) {
				array_splice($this->tanks, $i, 1);
				return;
			}
		}
	}

	//вырезать объект из массива по id
	private function killObject($id){
		for ($i = 0; $i < count($this->objects); $i++) {
			if ($this->objects[$i]->id == $id) {
				array_splice($this->objects, $i, 1);
				return;
			}
		}
	}

	private function killBuilding($id){
		for ($i = 0; $i < count($this->buildings); $i++) {
			if ($this->buildings[$i]->id == $id) {
				array_splice($this->buildings, $i, 1);
				return;
			}
		}

	}
	// подобрать объект в танк
	private function raiseObject($object, $tank) {
		if ($tank->cargoType == $object->type || !$tank->cargoType){ 
			$tank->cargoType = $object->type;
			$cargoLeft = $this->db->getHull($tank->hullType)->cargo - $tank->cargo;
			if ($cargoLeft >= $object->count){
				$tank->cargo += $object->count;
				$this->killObject($object->id);
			} else {
				$tank->cargo += $cargoLeft;
				$object->count -= $cargoLeft;
			}
		}
	}

	//перемещение пуль
	private function updateBullets() {
		// идем по массиву пуль
		for ($i = 0; $i < count($this->bullets); $i++) {
			$bullet = $this->bullets[$i];
			$x = $bullet->x;
			$y = $bullet->y;
			// по направлению пули меняем координаты на speed
			switch ($bullet->direction) {
				case 'left': $x -= $bullet->speed; break;
				case 'right': $x += $bullet->speed; break;
				case 'up': $y -= $bullet->speed; break; 
				case 'down': $y += $bullet->speed; break;
			}
			//проверка на range
			if ($bullet->distance > $bullet->range) {
				array_splice($this->bullets, $i, 1);
				return false;
			}
			$bullet->distance += $bullet->speed;
			// идем по клеткам, которые пролетела пуля
			for ($j = 0; $j < $bullet->speed; $j++) {
				$xs = $x - $bullet->x > 0 ? $j : $x - $bullet->x < 0 ? -$j : 0; // смещение по x
				$ys = $y - $bullet->y > 0 ? -$j : $y - $bullet->y < 0 ? $j : 0; // смещение по y
				// если на одной из клеток стояло здание
				$building = $this->isInnerBuilding($bullet->x + $xs, $bullet->y + $ys);
				if ($building) {
					$this->damage($building, $bullet);
					array_splice($this->bullets, $i, 1);
					return;
				}
				// если на одной из клеток стоял танк
				$tank = $this->getTankByXY($bullet->x + $xs, $bullet->y + $ys);
				if ($tank) {
					$this->damage($tank, $bullet);
					array_splice($this->bullets, $i, 1);
					return;
				}	
			} 
			$bullet->x = $x;
			$bullet->y = $y;
		}
	}

    /*public function getTanks() { return $this->tanks; }
	public function getBullets() { return $this->bullets; }
	public function getBuildings() { return $this->buildings; }
	public function getObjects() { return $this->objects; } */

	// переместить танк
    public function move($userId, $direction) {
		$tanks = $this->db->getTanks();
		$buildings = $this->db->getBuildings();
		$tank = $this->getTankById($userId, $tanks);
		if ($tank) {
			$battle = $this->db->getBattle();
			$field = $this->getField(
				$battle->fieldX, 
				$battle->fieldY, 
				$this->db->getField()
			);
			$x = $tank->x;
			$y = $tank->y;
			switch ($direction) {
				case 'left': $x--; break;
				case 'right': $x++; break;
				case 'up': $y--; break;
				case 'down': $y++; break;
			}
			//print_r($this->isInnerBuilding($x, $y, $buildings));
			// проверить наличие препятствий движению
			if ($y < 0 || $x < 0 || // если пытается уехать совсем влево или вверх
				$y >= count($field) || // если пытается уехать вниз
				$x >= count($field[$y]) || // если пытается уехать вправо
				$field[$y][$x] > 0 || // если на пути стена
				$this->getTankByXY(intval($x), intval($y), $tanks) || // если на пути танк
				$this->isInnerBuilding(intval($x), intval($y), $buildings) // если на пути строение
			) {
				return false;
			}
			// если на пути объект
			/*$object = $this->getObjectByXY($x, $y);
			if ($object) {
				$this->raiseObject($object, $tank);
			}*/
			//return $this->getTankByXY(5, 2, $tanks);
			return $this->db->updateTankXY($tank->id, $x, $y, $direction);
		}
		return false;
	}
	
	//проверка конца игры
	public function checkEndGame() {
		return true;
		/*for ($i = 0; $i < count($this->buildings); $i++){
			if ($this->buildings[$i]->type == 1 && $this->buildings[$i]->type == 2)	{
				return true;
			}
			return false;
		}*/
	}



	// выстрел (добавление пули в массив пулей)
	public function shoot($tankId) {		
		$tank = $this->getTankById($tankId); // взять танк по id
		if ($tank) {
			$gun = $this->db->getGun($tank->gunType); // взять его орудие		
			// проверить прошло ли время перезарядки
			$currentTime = round(microtime(true) * 1000); // текущее время
			if ($currentTime - $tank->reloadTimestamp >= $gun->reloadTime) {
				$tank->reloadTimestamp = $currentTime; // изменить время перезарядки у танка
				$y = $tank->y;
				$x = $tank->x;
				// пуля создается в след ячейке от танка
				switch ($tank->direction) {
					case 'left': $x--;  break;
					case 'right': $x++; break;
					case 'up': $y--;   break; 
					case 'down': $y++; break; 
				}  
				$this->bullets[] = $this->createBullet($x, $y, $tank, $gun); // добавить новую пулю в массив пуль
				return true;
			}
		}
		return false;
	}

	/*private function createScene($tanks, $buildings, $bullets, $objects, $field) {
		$scene = new stdClass();
		$scene->tanks = $tanks;
		$scene->buildings = $buildings;
		$scene->bullets = $bullets;
		$scene->objects = $objects;
		+ $scene->field = $field;
		return $scene;
	}*/




	private function getField($fieldX, $fieldY, $field) {
		$grassField = array();
		for ($i = 0; $i < $fieldY; $i++) {
			$array = array();
			for ($j = 0; $j < $fieldX; $j++) {
				$array[] = 0;
			}
			$grassField[] = $array; 
		}
		for($i=0; $i<count($field); $i++) {
			$grassField[$field[$i]->y][$field[$i]->x] = intval($field[$i]->hp);
		}
		return $grassField;
	}

	// обновить и вернуть сцену
	public function updateScene() {
		if ($this->checkEndGame()) {
			$battle = $this->db->getBattle(); // взять битву из БД
			$users = $this->db->getUsers();
			$tanks = $this->db->getTanks();
			$buildings = $this->db->getBuildings();
			$timeStamp = $battle->timeStamp; // текущее время в битве
			$updateTime = $battle->updateTime; // время ДО обновления
			$currentTime = round(microtime(true) * 1000); // текущее время
			if ($currentTime - $timeStamp >= $updateTime) { // прошло достаточно времени
				// обновить сцену и вернуть её на клиент
				$this->db->updateBattleTimeStamp($battle->id, $currentTime);
				//$this->updateBullets();// сдвигаем пули
				$scene = new stdClass();
				$scene->field = $this->getField(
										$battle->fieldX, 
										$battle->fieldY, 
										$this->db->getField()
									);
				$scene->tanks = $tanks;
				$scene->buildings = $buildings;
				return $scene;
			}
			return false;
		} 
		return false;
	}

	// добавить танк (вычесть баблишко у пользователя)
	public function addTank($userId, $teamId, $hullId, $gunId, $shassisId, $money) {
		$team = null;
		$gun = null;
		$hull = null;
		$shassi = null;
		// взять команды
		$teams = $this->db->getTeams();
		for ($i = 0; $i < count($teams); $i++){
			if ($teams[$i]->id == $teamId) {
				$team = $teams[$i];
				break;
			}
		}
		// взять типы корпусов
		$hulls = $this->db->getHulls();
		for ($i = 0; $i < count($hulls); $i++){
			if ($hulls[$i]->id == $hullId) {
				$hull = $hulls[$i];
				break;
			}
		}
		// взять типы пушек
		$guns = $this->db->getGuns();
		for ($i = 0; $i < count($guns); $i++){
			if ($guns[$i]->id == $gunId) {
				$gun = $guns[$i];
				break;
			}
		}
		// взять типы шасси
		$shassis = $this->db->getShassis();
		for ($i = 0; $i < count($shassis); $i++){
			if ($shassis[$i]->id == $shassisId) {
				$shassi = $shassis[$i];
				break;
			}
		}
		if ($team && $hull && $gun && $shassi && $money) {
			if ($team->id === '1') {
				$x = rand(7,9);
				$y = 7;
			} else {
				$x = rand(0,2);
				$y = 2;
			}
			//print_r($team->id);
			// проверить, что хватает баблишка
			$battle = $this->db->getBattle(); 
			$defaultMoney = $battle->defaultMoney;
			$price = $hull->price + $gun->price + $shassi->price;
			$userMoney = $money >= $defaultMoney; // флажок, что бабки пользовательские
			$money = ($userMoney) ? $money : $defaultMoney;
			if ($money >= $price) {
				if ($userMoney) {
					$money -= $price;
					$this->db->updateUserMoney($userId, $money);
				}
				// добавить танк
				return $this->db->addTank(
					$userId, 
					$team->id, 
					$gun->reloadTime, 
					$hull->hp,
					$hull->cargo,
					$hull->id,
					$gun->id,
					$shassi->id,
					$x,
					$y
				);
			}
		}
		return false;
	}
}