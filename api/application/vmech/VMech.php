<?php
//require_once('types/Tank.php');
//require_once('types/Bullet.php');
//require_once('types/Building.php');
//require_once('types/Objects.php');

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
				return $building;
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
		$bullets = $this->db->getBullets();
		$tanks = $this->db->getTanks(); 
		$buildings = $this->db->getBuildings();
		$battle = $this->db->getBattle();
		$blocks = $this->db->getField();
		$field = $this->getField(
			$battle->fieldX, 
			$battle->fieldY, 
			$blocks
		);
		// идем по массиву пуль
		for ($i = 0; $i < count($bullets); $i++) {
			$bullet = $bullets[$i];
			if ($bullet->rangeBullet > 0) {
				// уменьшить rangeBullet
				$bullet->rangeBullet--;
				// если rangeBullet < 0, то удалить пулю
				if ($bullet->rangeBullet <= 0) {
					$this->db->deleteBulletById($bullet->id);
					continue;
				}
				// подвинуть пулю
				$x = $bullet->x;
				$y = $bullet->y;
				switch ($bullet->direction) {
					case 'left' : $x --; break;
					case 'right': $x ++; break;
					case 'up'   : $y --; break; 
					case 'down' : $y ++; break;
				}
				// если пуля улетела за край карты - удалить пулю
				if ($y < 0 || $x < 0 || $y >= $battle->fieldY || $x >= $battle->fieldX) {
					$this->db->deleteBulletById($bullet->id);
					continue;
				}
				// если пуля воткнулась в стену - удалить пулю и нанести дамаг
				if($field[$y][$x] > 0){
					$gun = $this->db->getGun($bullet->type);
					$damage = $gun->damage;
					for ($j = 0; $j < count($blocks); $j++) {
						if($blocks[$j]->x == $x && $blocks[$j]->y == $y) {
							$this->db->deleteBulletById($bullet->id);
							$field[$y][$x] -= $damage;
							$blocks[$j]->hp -= $damage;
							if($blocks[$j]->hp <= 0) {
								$this->db->deleteBlockById($blocks[$j]->id);
							} else {
								$this->db->updateBlockById($blocks[$j]->id, $blocks[$j]->hp);
							}
							break;
						}
					}
					$this->db->addBoom($x, $y);
					continue;
				}
				// если пуля воткнулась в танк - удалить пулю и нанести дамаг и удалить танк (если надо)
				if($tank = $this->getTankByXY(intval($x), intval($y), $tanks)){
					$gun = $this->db->getGun($bullet->type);
					$damage = $gun->damage;
					$tank->hp -= $damage;
					if($tank->hp <= 0){
						$this->db->deleteTankById($tank->id);
					} else {
						$this->db->updateTankById($tank->id, $tank->hp);
					}
					$this->db->deleteBulletById($bullet->id);
					$this->db->addBoom($x, $y);
					continue;
				}
				// если пуля воткнулась в строение - удалить пулю и нанести дамаг и удалить строение (если надо)
				if($building = $this->isInnerBuilding(intval($x), intval($y), $buildings)){
					$gun = $this->db->getGun($bullet->type);
					$damage = $gun->damage;
					$building->hp -= $damage;
					$this->db->deleteBulletById($bullet->id);
					if($building->hp <= 0){
						$this->db->deleteBuildingById($building->id);
					} else {
						$this->db->updateBuildingById($building->id, $building->hp);
					}
					$this->db->addBoom($x, $y);
					continue;
				}
				// проапдейтить пулю
				$this->db->updateBulletById($bullet->id, $x, $y, $bullet->rangeBullet);
			}
		}
	}

	private function updateBooms(){
		$booms = $this->db->getBooms();
		for($i = 0; $i < count($booms); $i ++){
			$booms[$i]->timeLife--;
			if($booms[$i]->timeLife <= 0){
				$this->db->deleteBoomById($booms[$i]->id);
			} else {
				$this->db->updateBoomById($booms[$i]->id, $booms[$i]->timeLife);
			}
		}
	}

	private function getScene($battle){
		$scene = new stdClass();
		$scene->field = $this->getField(
								$battle->fieldX, 
								$battle->fieldY, 
								$this->db->getField()
							);
		$scene->tanks = $this->db->getTanks();
		$scene->buildings = $this->db->getBuildings();
		$scene->bullets = $this->db->getBullets();
		$scene->spriteMap = $this->db->getSpriteMap();
		$scene->booms = $this->db->getBooms();
		return $scene;
	}

	// переместить танк
    public function move($userId, $direction) {
		$tanks = $this->db->getTanks(); 
		$buildings = $this->db->getBuildings();
		$tank = $this->getTankById($userId, $tanks);
		if ($tank) {
			$speed = $this->db->getSpeed($tank->shassisType)->speed;
			$timeStamp = round(microtime(true) * 1000);
			$moveTimeStamp = $tank->moveTimeStamp;
			if($tank->direction != $direction) {
				if ($timeStamp - $moveTimeStamp >= $speed){
					return $this->db->updateTankXY($tank->id, $tank->x, $tank->y, $direction, $timeStamp);
				}	
			}
			if ($timeStamp - $moveTimeStamp >= $speed){
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

				return $this->db->updateTankXY($tank->id, $x, $y, $direction, $timeStamp);
			}
			// если на пути объект
			//..
		}
		return false;
	}
	
	//проверка конца игры
	public function checkEndGame() {
		return ($this->db->getBaseCount() === 2);
	}

	// выстрел (добавление пули в массив пулей)
	public function shoot($userId) {
		$tank = $this->db->getTankByUserId($userId); // взять танк по user_id
		if ($tank) {
			$gun = $this->db->getGun($tank->gunType); // взять его орудие		
			// проверить прошло ли время перезарядки
			$currentTime = round(microtime(true) * 1000); // текущее время
			if ($currentTime - $tank->reloadTimeStamp >= $gun->reloadTime) {
				$y = $tank->y;
				$x = $tank->x;
				$this->db->updateReloadTimeStamp($tank->id, $currentTime); // изменить время перезарядки у танка
				return $this->db->addBullet($x, $y, $tank->direction, $gun->id, $gun->rangeFire); // добавить новую пулю в массив пуль
			}
		}
		return false;
	}

	private function createScene($battle) {
		// все удалить
		$this->db->deleteAllTank();	// удалить все танки
		$this->db->deleteAllBlock(); // удалить все блоки
		$this->db->deleteAllObject(); // удалить все объекты
		$this->db->deleteAllBuilding();	// удалить все строения
		$this->db->deleteAllBoom();	// удалить все booms
		$this->db->deleteAllBullet(); // удалить все bullets
		// все заново создать
		// нарандомить блоки 
		$this->randomBlock($battle);
		// нарандомить базы
		$this->randomBase();
	}
	
	private function randomBlock($battle) {
		for($i = 0; $i < $battle->fieldX; $i++) {
			for($j = 0; $j < $battle->fieldY; $j++) {
				$random = rand(0, 100);
				if($random < 5) {
					$this->db->addBlock($i, $j, 100);
				}
			}
		}
	}

	private function randomBase(){
        $mapSize = $this->db->getBattle();
        $fieldX = $mapSize->fieldX-2;
        $fieldY = $mapSize->fieldY-2;

        $x1 = rand(0,$fieldX);

        if (($x1 <= ceil($fieldX * 0.1)) || ($x1 >= floor($fieldX * 0.9))){
            $y1 = rand(0,$fieldY);
        } else {
            $rndFront = random_int(0, 1);
            if ($rndFront == 0){
                $y1 = ceil(rand(0, $fieldY * 0.1));
            } else {
                $y1 = floor(rand($fieldY * 0.9, $fieldY));
            }
        }

        $x2 = $fieldX - $x1;
        $y2 = $fieldY - $y1;

        $this->db->addBuilding(1, $x1, $y1, 100, 2, 2, "base");
        $this->db->addBuilding(2, $x2, $y2, 100, 2, 2, "base");
    }

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

	private function isBlock($x, $y, $blocks){
		for($i = 0; $i < count($blocks); $i ++){
			if($x == $blocks[$i]->x && $y == $blocks[$i]->y){
				return $blocks[$i];
			}
		}
		return null;
	}

	private function randomPointAroudBase($base, $radius){
		$buildings = $this->db->getBuildings();
		$blocks = $this->db->getField();
		$battle = $this->db->getBattle();
		$points = array();//массив точек вокруг базы
		if($radius > 0){
			for($i = $base->x - $radius; $i < $base->x + $base->width + $radius; $i ++){
				for($j = $base->y - $radius; $j < $base->y + $base->height + $radius; $j ++){
					if( $i >= 0 && $i < $battle->fieldX &&
						$j >= 0 && $j < $battle->fieldY && 
						!$this->isInnerBuilding($i, $j, $buildings) && 
						!$this->isBlock($i, $j, $blocks)
						){//точка не может быть вне карты, на камне, в здании
						$point = new stdClass();
						$point->x = $i;
						$point->y = $j;
						$points[] = $point;
					}
				}
			}
		}
		$rnd = random_int(0, count($points));//рандомим номер точки
		return $points[$rnd];
	}

	// обновить и вернуть сцену
	public function updateScene($userId) {
		if ($this->db->isTankExists($userId)) {
			$battle = $this->db->getBattle(); // взять битву из БД
			if ($this->checkEndGame()) {
				$timeStamp = $battle->timeStamp; // текущее время в битве
				$updateTime = $battle->updateTime; // время ДО обновления
				$currentTime = round(microtime(true) * 1000); // текущее время
				if ($currentTime - $timeStamp >= $updateTime) { // прошло достаточно времени
					// обновить сцену и вернуть её на клиент
					$this->db->updateBattleTimeStamp($battle->id, $currentTime);
					$this->updateBooms();
					$this->updateBullets();// сдвигаем пули
					return $this->getScene($battle);
				}
				return false;
			}
			$this->createScene($battle);
			return array('gameover' => true);
		}
		return array('die' => true);
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
			$base = $this->db->getBaseByTeamId($team->id);
			// переписали этот говна кусок
			// if ($base->team == 1) {
			// 	$x = intval($base->x) - rand(1,intval($base->width));
			// 	$y = intval($base->y) + rand(-1, intval($base->height)-1);
			// }
			// if ($base->team == 2) {
			// 	$x = intval($base->x) + intval($base->width) + rand(0,1);
			// 	$y = intval($base->y) + rand(0, intval($base->height)-1);
			// }
			//рандомим точку вокруг базы в радиусе 2
			$randomPoint = $this->randomPointAroudBase($base, 2);
			$x = $randomPoint->x;
			$y = $randomPoint->y;
			//проверить, что хватает баблишка
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