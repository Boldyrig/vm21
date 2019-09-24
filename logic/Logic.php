<?php
require_once('types/Tank.php');
require_once('types/Bullet.php');

class Logic {
    function __construct() {
        // add tanks
        $data = new stdClass();
        $data->id = 123;
        $data->x = 1;
        $data->y = 1;
        $this->tanks = array();
        $this->tanks[] = new Tank($data);
        $data = new stdClass();
        $data->id = 321;
        $data->x = 2;
        $data->y = 2;
        $this->tanks[] = new Tank($data);
        // add field
        $this->field = array(array(0, 0, 0),
                             array(0, 0, 0),
                             array(0, 0, 0)
                            );

		// add bullet
		$data = new stdClass();
		$data->id = 111;
		$data->x = 0;
		$data->y = 0;
		$this->bullets = array();
		$this->bullets[] = new Bullet($data);
	}

    private function findTank($x, $y) {
        for ($i = 0; $i < count($this->tanks); $i++) {
            if ($this->tanks[$i]->x == $x && $this->tanks[$i]->y == $y) {
                return $this->tanks[$i];
            }
        }
        return null;
    }

	private function killTank($tank) {
		for ($i = 0; $i < count($this->tanks); $i++) {
			if ($tank == $this->tanks[$i]) {
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

    public function move($id, $direction) {
		if (isset($id)) {
			
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
			if ($this->findTank($x, $y) || $this->field[$y][$x] > 0) {
				return false;
			}
			for ($i = 0; $i < count($this->bullets); $i++){
				if ($x == $this->bullets[$i]->x  && $y == $this->bullets[$i]->y) {
					$this->killTank($tank);
					return false;
				}
			}

			$tank->x = $x;
			$tank->y = $y;
			return true;
		}
		return false;
	}
}