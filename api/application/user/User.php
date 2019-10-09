<?php

class User {




    
    public function login($login, $hash, $rnd) {
        $loginPass = '4a2d247d0c05a4f798b0b03839d94cf0';
        if ($loginPass) {
            $hashS = md5($loginPass . $rnd);
            if (strval($hash) === strval($hashS)) {
                return array('token' => md5($hash . strval(rand())));
            }
        }
        return false;
    }
}