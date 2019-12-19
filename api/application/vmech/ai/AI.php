<?php

class AI {

    function __construct($battle, $field, $tanks) {
        $this->battle = $battle;
        $this->field = $field;
        $this->tanks = $tanks;
    }

    private function findShootableTank($tank) {
        foreach ($this->tanks as $t) {
            if ($t->team != $tank->team) {
                $result = null;
                if ($tank->x === $t->x && $tank->y >= $t->y) {
                    $result = 'up';
                }
                if ($tank->x === $t->x && $tank->y <= $t->y) {
                    $result = 'down';
                }
                if ($tank->y === $t->y && $tank->x >= $t->x) {
                    $result = 'left';
                }
                if ($tank->y === $t->y && $tank->x <= $t->x) {
                    $result = 'right';
                }

                // проверить, что на пути нету блоков

                return $result;
            }
        }
        return null;
    }

    public function updateTank($tank) {
        // если можно выстрелить по танку противника - выстрелить
        $shootDirection = $this->findShootableTank($tank);
        if ($shootDirection) {
            return array(
                'command' => 'shoot',
                'direction' => $shootDirection
            );
        }
        // найти ближайший танк противника
        // совершить шаг к ближайшему танку противника
        return null;

        /*return array(
            'command' => 'move',
            'direction' => 'left'
        );*/
    }
}