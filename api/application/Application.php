<?php
require_once('user/User.php');
require_once('vmech/VMech.php');

class Application {

    function __construct() {
        $this->user = new User();
        $this->vMech = new VMech();
    }

    /********************/
    /* Про пользователя */
    /********************/
    public function login($params) {
        if ($params['login'] && $params['hash'] && intval($params['rnd'])) {
            return $this->user->login($params['login'], $params['hash'], intval($params['rnd']));
        }
        return false;
    }

    public function logout($params) {

    }

    public function registration($params) {

    }

    /************/
    /* Про игру */
    /************/
    public function move($params) {
        if ($params['id'] && $params['direction']) {
            return $this->vMech->move(intval($params['id']), $params['direction']);
        }
        return false;
    }

    public function shoot($params) {
        if ($params['id']) {
            return $this->vMech->shoot(intval($params['id']));
        }
        return false;
    }

    public function updateScene($params) {
        return $this->vMech->updateScene();
    }

    public function test() {
        return true;
    }
}