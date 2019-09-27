<?php

require_once('Math/check.php');
require_once('math/existFunction.php');

//Нули уравнения
/*
function findZero($F, $a, $b, $eps = 0.001) {
    if (!checkFunction($F))     return null;
    if (abs($F($a)) < 0 + $eps) return $a;
    if (abs($F($b)) < $eps)     return $b;
    $c = ($a + $b)/2;
    if (abs($F($c)) < $eps)     return $c;
    if ($F($a) * $F($c) < 0)    return findZero($F, $a, $c); 
    if ($F($c) * $F($b) < 0)    return findZero($F, $c, $b);
    return null;
}*/


function findZero($f, $a, $b, $eps = 0.001){
    if (existFunction($f, $a, $b)) {
       echo ('Функция не существует на промежутке ['. $a ." ; " . pointExistFunction($f, $a, $b). "].<br/>");
    }
    if (!checkFunction($f)) { 
        echo "Неверное значение функции";
        return null;
    }
    if (abs($f($a)) < $eps){
        return $a;
    }
    if (abs($f($b)) < $eps){
        return $b;
    }
    $c = ($a + $b)/2;
    if (abs($f($c)) < $eps){
        return $c;
    }
    if ($f($a) * $f($c) < 0){
        return findZero($f, $a, $c);
    }
    if ($f($b) * $f($c) < 0){
        return findZero($f, $c, $b);
    }
    echo "у функции нет нулей.";
    return null;
}

//echo "Функция достигает нуля в точке".