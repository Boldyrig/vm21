<?php
// Калькулятор линейного уравнения  
function calcLin ($a, $b) { 
    if ($a == $b && $b == 0)   return null; 
    if ($a == 0 && $b !== 0)   return 0;
    if ($a != 0 ) {
         $x = -$b/$a; 
         return $x;    
    } 
}
//print_r(calcLin(4,-10));
