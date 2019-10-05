<?php

require_once('vmech/VMech.php');

class Application {

    function __construct() {
        $this->vMech = new VMech();
    }

    public function move($params) {
        if ($params['id'] && $params['direction']) {
            return $this->vMech->move(intval($params['id']), $params['direction']);
        }
        return false;
    }

    public function test() {
        return true;
    }
}