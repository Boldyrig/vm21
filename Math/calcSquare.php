<?php
function calcSquare ($a, $b, $c) {
    $D= pow($b, 2) -4*$a*$c; 
    if ( $D > 0) {
        $x1 = (-$b + sqrt($D))/(2*$a);
        $x2 = (-$b - sqrt($D))/(2*$a);
       return array(
           'x1' => $x1,
           'x2' => $x2
       );
    } else if ( $D == 0) { 
        $x = -$b/(2 * $a); 
        return array(
            'x1' => $x,
            'x2' => $x
        );
    }  
        return null;

}

//$answer = calcSquare(1,6,8);
//print_r($answer);
