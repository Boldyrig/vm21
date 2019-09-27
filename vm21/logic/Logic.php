<?php
require_once('types/Tank.php');
require_once('types/Bullet.php');
require_once('types/Building.php');
require_once('types/Object.php');

class Logic {
    function __construct() {      
        // add field
        $this->field = array(array(0, 0, 0, 0, 0, 1, 0, 0, 0, 0),
							 array(0, 0, 0, 0, 0, 0, 0, 1, 0, 0),
							 array(0, 0, 0, 1, 0, 0, 0, 0, 0, 0),
							 array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
							 array(0, 0, 0, 0, 0, 1, 0, 0, 0, 0),
							 array(0, 0, 1, 0, 0, 0, 0, 0, 0, 0),
							 array(0, 0, 0, 0, 0, 0, 1, 0, 0, 0),
							 array(1, 0, 0, 0, 0, 0, 0, 0, 0, 0),
							 array(0, 0, 0, 1, 0, 0, 0, 1, 0, 0),
							 array(0, 0, 0, 0, 1, 0, 0, 0, 0, 0)
                            );
		// add tanks
        $this->tanks = array();
		$this->addTank(111, 5, 2);
		$this->addTank(222, 7, 3);
		// add bullet
		$this->bullets = array();
		$this->addBullet(11, 3, 5);
		// add building
		$this->buildings = array();
		$this->addBuilding(1, 4, 4);
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

	private function addTank($id, $x, $y, $team = 1, $hullType = 1, $gunType = 1, $shasshisType = 1, $direction = 'up', $reloadTime = 10, $hp = 100, $cargo = 100){
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
		$this->tanks[] = new Tank($data);
	}

	private function checkBuilding($x, $y){
		for ($i = 0; $i < count($this->buildings); $i++){
			for ($j = 0; $j < $this->buildings[$i]->height; $j++){
				for ($k = 0; $k < $this->buildings[$i]->width; $k++){
					if ($x == $this->buildings[$i]->x + $k && $y == $this->buildings[$i]->y + $j){
						return $this->buildings;
					}
				}
			}
		}
		return null;
	}	

	private function checkBullet($x, $y){
		for ($i = 0; $i < count($this->bullets); $i++){
			if ($x == $this->bullets[$i]->x  && $y == $this->bullets[$i]->y) {
				return $this->bullets[$i];
			}
		}
		return null;
	}

    private function checkTank($x, $y) {
        for ($i = 0; $i < count($this->tanks); $i++) {
            if ($this->tanks[$i]->x == $x && $this->tanks[$i]->y == $y) {
                return $this->tanks[$i];
            }
        }
        return null;
    }

	private function killTank($tank) {
		for ($i = 0; $i < count($this->tanks); $i++) {
			if ($tank->id == $this->tanks[$i]->id) {
				array_splice($this->tanks, $i, 1);	
			}
		}
	}

    public function getTanks(){
        return $this->tanks;
    }

    public function getField(){
        return $this->field;
    }

	public function getBullets() {
		return $this->bullets;
	}

	public function getBuildings() {
		return $this->buildings;
	}
	public function getObjects() {
		return $this->objects;
	}


    public function move($id, $direction) {
		if (isset($id)) {
			// getTank by id
			for ($i = 0; $i < count($this->tanks); $i++) {
				if ($this->tanks[$i]->id == $id) {
					$tank = $this->tanks[$i];
				}
			}
			$x = $tank->x;
			$y = $tank->y;
			switch ($direction) {
				case 'left': $x--; break;
				case 'right': $x++; break;
				case 'up': $y--; break;
				case 'down': $y++; break;
			}

			// check tank
			//print_r($this->checkBuilding($x, $y));
			if ($this->field[$y][$x] > 0 || $this->checkTank($x, $y) || $this->checkBuilding($x, $y)) {
				return false;
			}

			// check bullet
			if ($this->checkBullet($x, $y)){
				$this->killTank($tank);
				return false;
			}

			$tank->x = $x;
			$tank->y = $y;
			return true;
		}
		return false;
	}
}