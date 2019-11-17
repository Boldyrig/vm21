<?php
require_once('db/DB.php');
require_once('user/User.php');
require_once('vmech/VMech.php');

class Application {

    function __construct() {
        $db = new DB();
        $this->user = new User($db);
        $this->vMech = new VMech($db);
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
        if ($params['token']) {
            return $this->user->logout($params['token']);
        }
        return false;
    }

    public function registration($params) {
		if ($params['login'] && $params['hash']) {
			return $this->user->registration($params['login'], $params['hash']);
		}
		return false;
    }

    /************/
    /* Про игру */
    /************/

    public function addTank($params) {
        if ($params['token'] && 
            $params['team'] && 
            $params['hull'] && 
            $params['gun'] && 
            $params['shassis'] &&
            $params['money']
        ) {
            $user = $this->user->getUserByToken($params['token']);
            if ($user) {
                return $this->vMech->addTank(
                    $user->id, 
                    $params['team'], 
                    $params['hull'],
                    $params['gun'],
                    $params['shassis'],
                    $user->money);
            }
        }
        return false;
    }

    public function move($params) {
        if ($params['token'] && $params['direction']) {
            $user = $this->user->getUserByToken($params['token']);
            if ($user) {
                return $this->vMech->move($user->id, $params['direction']);
            }
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

    public function joinGame($params) {
        if($params['id'] && $params['x'] && $params['y'] && $params['hull'] && $params['gun'] && $params['shasshi']){
            return $this->vMech->tanks[] = $this->vMech->createTank(intval($params['id']), intval($params['x']), intval($params['y']), $params['hull'], $params['gun'], $params['shasshi']);
        } return false;
    }

    public function getConstructor() {
        return $this->vMech->getConstructor();
    }
}