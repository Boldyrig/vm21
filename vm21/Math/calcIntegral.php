<?php
// посчитать определенный интегралл на отрезке трапециями 
function calcIntegral($F, $a, $b, $N) {
    $h = ($b-$a) /$N;
    $x = $a;
    $S = 0;
    while ($x+$h < $b) {
        $S1 = (($F($x) + $F($x + $h))) * $h /2;
        $S += abs($S1);
        $x += $h;
    }
    return $S;
}

//echo(calcIntegral(F,0,2,20));