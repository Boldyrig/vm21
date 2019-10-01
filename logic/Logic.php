<?php
require_once('types/Tank.php');
require_once('types/Bullet.php');
require_once('types/Building.php');
require_once('types/Object.php');

class Logic {
    function __construct() {      
        // создать поле
        $this->field = array(array(0, 0, 0, 0, 0, 1, 0, 0, 0, 0),
							 array(0, 0, 0, 0, 0, 1, 1, 1, 0, 0),
							 array(0, 0, 0, 1, 1, 0, 0, 1, 0, 0),
							 array(0, 0, 1, 0, 0, 1, 0, 0, 0, 0),
							 array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
							 array(0, 0, 1, 0, 0, 0, 0, 0, 0, 0),
							 array(0, 0, 0, 0, 0, 0, 1, 0, 0, 0),
							 array(1, 0, 0, 0, 0, 0, 0, 0, 0, 0),
							 array(0, 0, 0, 1, 0, 0, 0, 1, 0, 0),
							 array(0, 0, 0, 0, 1, 0, 0, 0, 0, 0)
							);
		// создать массив с типами брони
		$this->HULL_LIGHT = new stdClass();
		$this->HULL_LIGHT->cargo = 10;
		$this->HULL_LIGHT->weight = 10;
		$this->HULL_LIGHT->hp = 20;
		$this->HULL_TYPES = array($this->HULL_LIGHT);
		// создать массив с типами орудий
		$this->GUN_LIGHT = new stdClass();
		$this->GUN_LIGHT->reloadTime = 125; // ms
		$this->GUN_LIGHT->damage = 5;
		$this->GUN_LIGHT->range = 10;
		$this->GUN_TYPES = array($this->GUN_LIGHT);
		// создать массив с танками
        $this->tanks = array();
		$this->tanks[] = $this->createTank(111, 5, 7);
		$this->tanks[] = $this->createTank(222, 7, 3);
		// создать массив с пулями
		$this->bullets = array();
		// создать массив с зданиями
		$this->buildings = array();
		// создать массив с объектами
		$this->objects = array();
		$this->objects[] = $this->createObject(4, 6, 6);
	}

	private function createBuilding($id, $x, $y, $width = 2, $height = 2){
		$data = new stdClass();
		$data->id = $id;
		$data->x = $x;
		$data->y = $y;
		$data->width = $width;
		$data->height = $height;
		$this->array = array();
		return new Building($data);
	}

	private function createObject($id, $x, $y, $type = 1, $count = 1){
		$data = new stdClass();
		$data->id = $id;
		$data->x = $x;
		$data->y = $y;
		$data->type = $type;
		$data->count = $count;
		return new Object($data);
	}

	private function createBullet($id, $x, $y, $direction = 'up', $speed = 1, $type = 1, $distance = 1){
		$data = new stdClass();
		$data->id = $id;
		$data->x = $x;
		$data->y = $y;
		$data->direction = $direction;
		$data->speed = $speed;
		$data->type = $type;
		$data->distance = $distance; // сколько пуля пролетела
		return new Bullet($data);
	}

	private function createTank($id, $x, $y, 
								$team = 1, $hullType = 0, $gunType = 0, 
								$shasshisType = 1, $direction = 'up', 
								$reloadTimestamp = 0, 
								$hp = 100, $cargo = 100, $cargoType = 1) {
		$data = new stdClass();
		$data->id = $id;
        $data->x = $x;
        $data->y = $y;
		$data->team = $team;
		$data->hullType = $hullType;
		$data->gunType = $gunType;
		$data->shassisType = $shasshisType;
		$data->direction = $direction;
		$data->reloadTimestamp = $reloadTimestamp;
		$data->hp = $hp;
		$data->cargo = $cargo;
		$data->cargoType = $cargoType;
		return new Tank($data);
	}

	// взять танк по id
	private function getTankById($id) {
		for ($i = 0; $i < count($this->tanks); $i++) {
			if ($this->tanks[$i]->id === $id) {
				return $this->tanks[$i];
			}
		}
		return null;
	}

	// взять танк по (х, у)
    private function getTankByXY($x, $y) {
        for ($i = 0; $i < count($this->tanks); $i++) {
            if ($this->tanks[$i]->x === $x && $this->tanks[$i]->y === $y) {
                return $this->tanks[$i];
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
	private function isInnerBuilding($x, $y){
		for ($i = 0; $i < count($this->buildings); $i++) {
			$building = $this->buildings[$i];
			if ($x >= $building->x && 
				$x <= $building->x + $building->width &&
				$y >= $building->y &&
				$y >= $building->y + $building->height
			) {
				return true;
			}
		}
		return false;
	}

	// нанести урон object в зависимости от type
	private function damage($object, $bullet){
		//switch ($type) {
			//... 
			// $object->hp -= ...
		//}
	}

	//вырезать танк из массипа по id
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
			}
		}
	}

	// подобрать объект в танк
	private function raiseObject($object, $tank) {
		if ($tank->cargoType == $object->type || !$tank->cargoType){ 
			$tank->cargoType = $object->type;
			$cargoLeft = $this->HULL_TYPES[$tank->hullType]->cargo - $tank->cargo;
			if ($cargoLeft >= $object->count){
				$tank->cargo += $object->count;
				$this->killObject($object->id);
			} else {
				$tank->cargo += $cargoLeft;
				$object->count -= $cargoLeft;
			}
		}
	}

    public function getTanks() { return $this->tanks; }
    public function getField() { return $this->field; }
	public function getBullets() { return $this->bullets; }
	public function getBuildings() { return $this->buildings; }
	public function getObjects() { return $this->objects; }

	// переместить танк
    public function move($id, $direction) {
		if (isset($id) && $direction) {
			$tank = $this->getTankById($id);
			if ($tank) {
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
					$y >= count($this->field) || // если пытается уехать вниз
					$x >= count($this->field[$y]) || // если пытается уехать вправо
					$this->field[$y][$x] > 0 || // если на пути стена
					$this->getTankByXY($x, $y) || // если на пути танк
					$this->isInnerBuilding($x, $y) // если на пути строение
				) {
					return false;
				}
				// если на пути пуля
				/*if ($this->getBulletByXY($x, $y)) {
					// заруинить здоровье и убить при случае
					//...
					$this->killTank($id);
					return false;
				}*/
				// если на пути объект
				$object = $this->getObjectByXY($x, $y);
				if ($object) {
					$this->raiseObject($object, $tank);
				}
				$tank->x = $x;
				$tank->y = $y;
				return true;
			}
		}
		return false;
	}

	// выстрел (добавление пули в массив пулей)
	public function shoot($tankId) {
		$tank = $this->getTankById($tankId); // взять танк по id
		if ($tank) {
			$gun = $this->GUN_TYPES[$tank->gunType]; // взять его орудие
			// проверить прошло ли время перезарядки
			$currentTime = round(microtime(true) * 1000); // текущее время
			if ($currentTime - $tank->reloadTimestamp >= $gun->reloadTime) {
				// добавить новую пулю в массив пуль
				//$this->bullets[] = $this->createBullet($id, $x, $y, $direction, $speed);
				$tank->reloadTimestamp = $currentTime; // изменить время перезарядки у танка
			}
			return true;
		}
		return false;
	}

	//перемещение пуль
	public function updateBullets(){
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
			/*
			...
			проверка на range
			...
			*/
			// идем по клеткам, которые пролетела пуля
			for ($j = 0; $j < $bullet->speed; $j++) {
				$xs = $x - $bullet->x > 0 ? $j : $x - $bullet->x < 0 ? -$j : 0;// смещение по x
				$ys = $y - $bullet->y > 0 ? -$j : $y - $bullet->y < 0 ? $j : 0;// смещение по y
				// если на одной из клеток стояло здание
				if ($this->isInnerBuilding($bullet->x + $xs, $bullet->y + $ys)) {
					//$this->damage();
					array_splice($this->bullets, $i, 1);
					return;
				}
				// если на одной из клеток стоял танк
				$tank = $this->getTankByXY($bullet->x + $xs, $bullet->y + $ys);
				if ($tank) {
					$this->damage($tank, $bullet->type);
					array_splice($this->bullets, $i, 1);
					return;
				}	
			} 
			$bullet->x = $x;
			$bullet->y = $y;
		}
	}
}