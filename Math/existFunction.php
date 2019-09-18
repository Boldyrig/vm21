<?php

function existFunction($f, $a, $b){
    for ($i = $a; $i <= $b; $i++){ 
        return  is_nan ( $f($i) );
    }
}

function pointExistFunction($f, $a, $b){
    $existPoint = $a;
    while (is_nan ( $f($existPoint)) && $existPoint < $b ) {
        $existPoint++;
    }
    return $existPoint;
}