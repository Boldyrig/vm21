<?php
require_once('types/Tank.php');
require_once('types/Bullet.php');
require_once('types/Building.php');
require_once('types/Object.php');

class Logic {
    function __construct() {      
        // add field
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
		// add hull types
		$this->HULL_LIGHT = new stdClass();
		$this->HULL_LIGHT->cargo = 10;
		$this->HULL_LIGHT->weight = 10;
		$this->HULL_LIGHT->hp = 20;
		$this->HULL_TYPES = array($this->HULL_LIGHT);
		// add tanks
        $this->tanks = array();
		$this->addTank(111, 5, 2);
		$this->addTank(222, 6, 3);
		// add bullet
		$this->bullets = array();
		$this->addBullet(11, 3, 5);
		// add building
		$this->buildings = array();
		//$this->addBuilding(1, 4, 4);
		// add object
		$this->objects = array();
		$this->addObject('000', 4, 4);
	}

	private function addBuilding($id, $x, $y, $width = 2, $height = 2){
		$data = new stdClass();
		$data->id = $id;
		$data->x = $x;
		$data->y = $y;
		$data->width = $width;
		$data->height = $height;
		$this->array = array();
		$this->buildings[] = new Building($data);
	}

	private function addObject($id, $x, $y, $type = 1, $count = 1){
		$data = new stdClass();
		$data->id = $id;
		$data->x = $x;
		$data->y = $y;
		$data->type = $type;
		$data->count = $count;
		$this->objects[] = new Object($data);
	}

	private function addBullet($id, $x, $y, $direction = 1, $speed = 1, $type = 1, $range=10){
		$data = new stdClass();
		$data->id = $id;
		$data->x = $x;
		$data->y = $y;
		$data->direction = $direction;
		$data->speed = $speed;
		$data->type = $type;
		$data->range = $range;
		$this->bullets[] = new Bullet($data);
	}

	private function addTank($id, $x, $y, $team = 1, $hullType = 1, $gunType = 1, $shasshisType = 1, $direction = 'up', $reloadTime = 10, $hp = 100, $cargo = 100, $cargoType = 1) {
		$data = new stdClass();
		$data->id = $id;
        $data->x = $x;
        $data->y = $y;
		$data->team = $team;
		$data->hullType = $hullType;
		$data->gunType = $gunType;
		$data->shassisType = $shasshisType;
		$data->direction = $direction;
		$data->reloadTime = $reloadTime;
		$data->hp = $hp;
		$data->cargo = $cargo;
		$data->cargoType = $cargoType;
		$this->tanks[] = new Tank($data);
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
	// взять пули по (х, у)
	private function getBulletByXY($x, $y) {
		for ($i = 0; $i < count($this->bullets); $i++) {
			if ($x == $this->bullets[$i]->x && $y == $this->bullets[$i]->y) {
				return $this->bullets[$i];
			}
		}
		return null;
	}
	// взять объекты по (х, у)
	private function getObjectByXY($x, $y){
        for ($i = 0; $i < count($this->objects); $i++) {
            if ($x === $this->objects[$i]->x && $y === $this->objects[$i]->y) {
                return $this->objects[$i];
            }
        }
	}
	
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

	private function killTank($id) {
		for ($i = 0; $i < count($this->tanks); $i++) {
			if ($id == $this->tanks[$i]->id) {
				array_splice($this->tanks, $i, 1);
				return;
			}
		}
	}
	private function killObject($id){
		for ($i = 0; $i < count($this->objects); $i++) {
			if ($this->objects[$i]->id == $id) {
				array_splice($this->objects, $i, 1);
			}
		}
	}

	// подобрать объект
	private function raiseObject($object, $tank) {
		// если у танка и у объекта одинаковые типы грузов, или у танка вообще нет груза, 
		// то подбирать груз
		// подобрать груза на объем оставшегося места в танке
		// уменьшить количество груза в объекте
		// если у объекта закончился груз - удалить его
		if ($tank->cargoType == $object->type || !$tank->cargoType){
			$tank->cargoType = $object->type;
			$cargoLeft = $this->HULL_TYPES[$tank->hullType]->cargo - $tank->cargo; //сколько осталось вместить через его вместимость минус сколько уже есть
			if ($cargoLeft >= $object->count){  // если у объекта закончился груз - удаляем объект
				$tank->cargo += $object->count;
				$this->killObject($object->id);
			} else {    //иначе уменьшаем количество груза в объекте 
				$tank->cargo += $cargoLeft;
				$object->count -= $cargoLeft;
			}
			
		}
		/*$tank->loot[] = $object;
		for ($i = 0; $i < count($this->objects); $i++) {
			if ($this->objects[$i]->id == $object->id) {
				array_splice($this->objects, $i, 1);
			}
		}*/
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
				// check bullet
				if ($this->getBulletByXY($x, $y)) {
					// заруинить здоровье и убить при случае
					//...
					$this->killTank($id);
					return false;
				}
				//check object
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
}