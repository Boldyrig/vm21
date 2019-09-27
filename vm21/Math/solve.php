<?php
function solve($a, $b, $c){
    $d = $b*$b - 4 * $a * $c;
    if ($d >= 0){
        $x1 = (-$b + sqrt($d))/(2 * $a);
        $x2 = (-$b - sqrt($d))/(2 * $a);
        return array(
            'x1' => $x1,
            'x2' => $x2
        );
    }
    return null;
}
