<?php
require_once('Tank.php');
require_once('Tile.php');

class Logic {
    function __construct() {
        $this->tanks = array(new Tank(1, 1), new Tank(1, 0));
        $this->field = array(array(new Tile(1), new Tile(1), new Tile(1)),
                            array(new Tile(1), new Tile(1), new Tile(1)),
                            array(new Tile(1), new Tile(1), new Tile(1)));
    }

    public function getTanks(){
        return $this->tanks;
    }

    public function getField(){
        return $this->field;
    }

    private function findTank($x, $y, $direction){
        $x = ($direction == 'left') ? --$x : ($direction == 'right') ? ++$x : $x;
        $y = ($direction == 'down') ? --$y : ($direction == 'up') ? ++$y : $y;
        for($i = 0; $i < count($this->tanks); $i++){
            if($this->tanks[$i]->x == $x && $this->tanks[$i]->y == $y){
                return $this->tanks[$i];
            }
        }
        return null;
    }

    private function findTile($x, $y, $direction){
        $x = ($direction == 'left') ? --$x : ($direction == 'right') ? ++$x : $x;
        $y = ($direction == 'down') ? --$y : ($direction == 'up') ? ++$y : $y;
        if(isset($this->field[$x][$y])) {
            return $this->field[$x][$y];
        }
        return null;
    }

    public function move($num, $direction) {
        $tank = $this->tanks[$num];
        $x = $tank->x;
        $y = $tank->y;
        $newTank = $this->findTank($x, $y, $direction);
        $newTile = $this->findTile($x, $y, $direction);
        if(!isset($newTank) && isset($newTile) && $newTile->passability == 1){
            switch($direction){
                case 'up':
                    $y++;
                    break;
                case 'down':
                    $y--;
                    break;
                case 'left':
                    $x--;
                    break;
                case 'right':
                    $x++;
                    break;
                default:
                    break;
            }
        }
        $tank->x = $x;
        $tank->y = $y;
    }
}
