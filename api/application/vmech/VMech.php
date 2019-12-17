<?php
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
			'HULL_TYPE' => $this->db->getHulls(),
			'NUKE' => $this->db->getNukes()
		);
		$array['DEFAULT_MONEY'] = $this->db->getBattle()->defaultMoney;
		return $array;
	}

	public function getRating()	{
		$kills = $this->db->getKills();
		$deaths = $this->db->getDeaths();
		$friendFires = $this->db->getFriendFire();
		$users = $this->db->getUsers();
		$rating = [];
		for($i = 0; $i < count($users); $i ++) {
			$elem = new stdClass();
			$elem->id = $users[$i]->id;
			$elem->login = $users[$i]->login;
			$rating[] = $elem;
		}
		for($i = 0; $i < count($rating); $i ++) {
			for($j = 0; $j < count($kills); $j ++) {
				if($kills[$j]->id == $rating[$i]->id) $rating[$i]->kills = $kills[$j]->kills;
			}
			for($j = 0; $j < count($deaths); $j ++) {
				if($deaths[$j]->id == $rating[$i]->id) $rating[$i]->deaths = $deaths[$j]->deaths;
			}
			for($j = 0; $j < count($friendFires); $j ++) {
				if($friendFires[$j]->id == $rating[$i]->id) $rating[$i]->friendFires = $friendFires[$j]->friendFires;
			}
		}
		return $rating;
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
	private function getBulletByXY($x, $y, $bullet) {
		for ($i = 0; $i < count($bullet); $i++) {
			if ($bullet[$i]->x && $y == $bullet[$i]->y) {
				return $bullet[$i];
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

	// подобрать объект в танк
	private function raiseObject($tank, $x, $y) {
		// узнать, на какой объект наступил танк
		$objects = $this->db->getObjectsByXY($x, $y);
		// изменить cargo танка,объекта и если нужно удалить 
		for($i = 0; $i < count($objects); $i++){
			if ($tank->cargo - $objects[$i]->count >= 0){
				$this->db->updateTankCargo($tank->id, $tank->cargo - $objects[$i]->count);
				$this->db->deleteObject($objects[$i]->id);
				
			}else {
				$this->db->updateTankCargo($tank->id, 0);
				$this->db->updateObjectCount($objects[$i]->id,$objects[$i]->count - $tank->cargo);
			}
		}
	}

	//перемещение пуль
	private function updateBullets($userId) {
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
					$this->db->addBoom($x, $y, 4, 'bullet');
					continue;
				}
				// если пуля воткнулась в танк - удалить пулю и нанести дамаг и удалить танк (если надо)
				if($tank = $this->getTankByXY(intval($x), intval($y), $tanks)){
					if($tank->user_id == $userId) continue;//если попал в себя
					$gun = $this->db->getGun($bullet->type);
					$damage = $gun->damage;
					$tank->hp -= $damage;
					if($tank->hp <= 0){
						$killerTank = $this->db->getTankByUserId($userId);
						$this->db->addResult($tank, $bullet->user_id);
						$this->db->deleteTankById($tank->id);
						if ($tank->team == $killerTank->team) {
							$this->db->updateUserMoneyById($userId, -intval($battle->moneyTank));
						} else {
							$this->db->updateUserMoneyById($userId, intval($battle->moneyTank));
						}
						$count = rand(0,20);
						if ($count > 0){
						 $this->db->addObject($tank->x,$tank->y,$count,1);
						} 
					} else {
						$this->db->updateTankById($tank->id, $tank->hp);
					}
					$this->db->deleteBulletById($bullet->id);
					$this->db->addBoom($x, $y, 4, 'bullet');
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
						$killerTank = $this->db->getTankByUserId($userId);
						if ($building->team == $killerTank->team) {
							$this->db->updateUserMoneyById($userId, -intval($battle->moneyBase));
						}else {
							$this->db->updateUserMoneyById($userId, intval($battle->moneyBase));
						}
					} else {
						$this->db->updateBuildingById($building->id, $building->hp);
					}
					$this->db->addBoom($x, $y, 4, 'bullet');
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

	private function getScene($battle, $userId){
		$scene = new stdClass();
		$scene->field = $this->getField(
								$battle->fieldX, 
								$battle->fieldY, 
								$this->db->getField()
							);
		$scene->users = $this->db->getUsers();
		$scene->tanks = $this->db->getTanks();
		$scene->buildings = $this->db->getBuildings();
		$scene->bullets = $this->db->getBullets();
		$scene->spriteMap = $this->db->getSpriteMap();
		$scene->booms = $this->db->getBooms();
		$scene->userMoney = $this->db->getUserById($userId)->money;
		$scene->objects = $this->db->getObjects();
		$scene->battle = $this->db->getBattle();
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
				if(intval($this->db->getHull($tank->hullType)->cargo) - intval($tank->cargo) > 0){
					$building = $this->db->getBuilding($tank->team);
					$buildingX = $this->db->getBuilding($tank->team)->x;
					$buildingY = $this->db->getBuilding($tank->team)->y;
					if((($x == ($buildingX+2)) && ($y == ($buildingY     || ($buildingY+1)))) ||
					   (($x == ($buildingX+1)) && ($y == (($buildingY+2) || ($buildingY-1)))) ||
					   (($x ==  $buildingX)    && ($y == (($buildingY+2) || ($buildingY-1)))) ||
					   (($x == ($buildingX-1)) && ($y == (($buildingY+1) || $buildingY)))
					){
						
						$hp = intval($this->db->getHull($tank->hullType)->cargo) - intval($tank->cargo);
						$this->db->updateUserMoneyById($userId, $hp*2);
						$this->db->updateHpBase($hp,$tank->team);
						$this->db->updateTankCargo($tank->id,intval($this->db->getHull($tank->hullType)->cargo));

					}
				}
				// если на пути объект
				$this->raiseObject($tank,$x,$y);
				return $this->db->updateTankXY($tank->id, $x, $y, $direction, $timeStamp);

			}
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
				return $this->db->addBullet($userId, $x, $y, $tank->direction, $gun->id, $gun->rangeFire); // добавить новую пулю в массив пуль
			}
		}
		return false;
	}

	public function boom($userId){
		$tank = $this->db->getTankByUserId($userId);
		if ($tank){
			if (intval($tank->nuke) > 0){
				$nukeDamage = intval($this->db->getNuke()->damage);
				$field = $this->db->getField();
				$tanks = $this->db->getTanks();
				$buildings = $this->db->getBuildings();
				$objects = $this->db->getObjects();
				foreach ($field as $wall){
					$distance = $this->calcDistance($wall->x, $wall->y,
													$tank->x, $tank->y);
					$damage = ($distance === 0) ? $nukeDamage : $nukeDamage / pow($distance, 2);
					if ($damage > $nukeDamage / 10){
						$hp = $wall->hp - $damage;
						if ($hp > 0) {
							$this->db->updateBlockById($wall->id, $hp);
						} else {
							$this->db->deleteBlockById($wall->id);
						}
					}
				}
				foreach ($buildings as $b){
					$distance = $this->calcDistance($b->x, $b->y,
													$tank->x, $tank->y);
					$damage = ($distance === 0) ? $nukeDamage : $nukeDamage / pow($distance, 2);
					if ($damage > $nukeDamage / 10){
						$hp = $b->hp - $damage;
						if ($hp > 0) {
							$this->db->updateBuildingById($b->id, $hp);
						} else {
							$this->db->deleteBuildingById($b->id);
						}
					}
				}
				foreach ($tanks as $t){
					$distance = $this->calcDistance($t->x, $t->y,
													$tank->x, $tank->y);
					$damage = (intval($distance) !== 0) ? ($nukeDamage / pow($distance, 2)): $nukeDamage;
					if ($damage > $nukeDamage / 10){
						$hp = $t->hp - $damage;
						if ($hp > 0) {
							$this->db->updateTankById($t->id, $hp);
						} else {
							$this->db->addResult($t, $tank->user_id);
							$this->db->deleteTankById($t->id);
						}
					}
				}
				foreach ($objects as $o) {
					$distance = $this->calcDistance($o->x, $o->y,
													$tank->x, $tank->y);
					$damage = ($distance === 0) ? $nukeDamage : $nukeDamage / pow($distance, 2);
					if ($damage > $nukeDamage / 10){
						$this->db->deleteObject($o->id);
					}
				}
				$this->db->addBoom($tank->x, $tank->y, 10, 'nuke');
				return true;
			}
		}
		return false;
	}

	private function calcDistance($x1, $y1, $x2, $y2){
		return sqrt(pow($x1-$x2, 2) + pow($y1-$y2, 2));
	}

	private function createScene() {
		$battle = $this->db->getBattle();
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
		$this->randomBase($battle);
	}
	
	private function randomBlock($battle) {
		for($i = 0; $i < $battle->fieldX; $i++) {
			for($j = 0; $j < $battle->fieldY; $j++) {
				$random = rand(0, 100);
				if($random < 40) {
					$this->db->addBlock($i, $j, 100);
				}
			}
		}
	}

	private function randomBase($battle){
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

        $this->db->addBuilding(1, $x1, $y1, $battle->healthBase, 2, 2, "base");
        $this->db->addBuilding(2, $x2, $y2, $battle->healthBase, 2, 2, "base");
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
			for($i = $base->x - $radius; $i < ($base->x + $base->width + $radius); $i ++){
				for($j = $base->y - $radius; $j < ($base->y + $base->height + $radius); $j ++){
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
		$rnd = rand(0, count($points) - 1);//рандомим номер точки
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
					$this->updateBullets($userId);// сдвигаем пули
					return $this->getScene($battle, $userId);
				}
				return false;
			}
			$this->createScene();
			return array('gameover' => true);
		}
		return array('die' => true);
	}

	// добавить танк (вычесть баблишко у пользователя)
	public function addTank(
		$userId, 
		$teamId, 
		$hullId, 
		$gunId, 
		$shassisId, 
		$nuke, 
		$money
	) {
		if(!$this->checkEndGame()) $this->createScene();
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
					$y,
					$nuke
				);
			}
		}
		return false;
	}
}