<?php

class User {

    function __construct($db) {
        $this->db = $db;
    }

    public function login($login, $hash, $rnd) {
        $user = $this->db->getUserByLogin($login);
        if ($user) {
            $hashS = md5($user->password . $rnd);
            if (strval($hash) === strval($hashS)) {
                $token = md5($hash . strval(rand()));
                $this->db->updateToken($user->id, $token);
                return array(
                    'token' => $token,
                    'login' => $user->login,
                    'money' => $user->money
                );
            }
        }
        return false;
    }
    
    public function logout($token) {
        $user = $this->db->getUserByToken($token);
        if ($user) {
            return $this->db->updateToken($user->id, null);
        }
        return false;
    }

    public function getUserByToken($token) {
        return $this->db->getUserByToken($token);
    }
}