<?php
require_once('types/Tank.php');

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
        $data->x = 1;
        $data->y = 0;
        $this->tanks[] = new Tank($data);
        // add field
        $this->field = array(array(0, 0, 0),
                             array(1, 0, 0),
                             array(0, 0, 0)
                            );
    }

    private function findTank($x, $y) {
        for ($i = 0; $i < count($this->tanks); $i++) {
            if ($this->tanks[$i]->x == $x && $this->tanks[$i]->y == $y) {
                return $this->tanks[$i];
            }
        }
        return null;
    }

    public function getTanks(){
        return $this->tanks;
    }

    public function getField(){
        return $this->field;
    }

    public function move($id, $direction) {
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
        $tank->x = $x;
        $tank->y = $y;
        return true;
    }
}