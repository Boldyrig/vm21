<?php
function calcCube($a, $b, $c, $d) { 
    if ( $a == 0 )   return print_r('Error'); 
    if ($d == 0 && $a != 0) {        //Решение кубических уравнений с рациональными корнями
        $D = pow($b, 2) -4*$a*$c; 
            if ( $D > 0) { 
                $x1 = 0;
                $x2 = (-$b + sqrt($D))/(2*$a);
                $x3 = (-$b - sqrt($D))/(2*$a);
            return array(
                'x1' => $x1,
                'x2' => $x2,
                'x3' => $x3 );
            }
            if ( $D == 0) { 
                $x2 = -$b/(2 * $a); 
                return array( 
                'x1' => $x1,
                'x2' => $x2, 
                'x3' => $x2 );
            }  
        } 
    $p = (3*$a*$c-$b*$b)/(3*$a*$a);
    $q = (2*$b*$b*$b-9*$a*$b*$c+27*$a*$a*$d)/(27*$a*$a*$a);
    $S = (4*(3*$a*$c-$b*$b)*(3*$a*$c-$b*$b)*(3*$a*$c-$b*$b)
       +(2*$b*$b*$b-9*$a*$b*$c+27*$a*$a*$d)*(2*$b*$b*$b-9*$a*$b*$c+27*$a*$a*$g))
       /(2916*$a*$a*$a*$a*$a*$a);
    $y1 = 0;   $y2 = 0;    $t = 0;
    if ( $S < 0 ) {
        if ($q<0) { $t = atan(-2*sqrt(-$S)/$q); }
        if ($q>0) { $t = atan(-2*sqrt(-$S)/$q)+pi(); }
        if ($q=0) { $t = pi()/2; }
        $x1 = 2*sqrt(-$p/3)*cos($t/3)-$b/(3*$a); 
        $x2 = 2*sqrt(-$p/3)*cos(($t+2*pi())/3)-$b/(3*$a);
        $x3 = 2*sqrt(-$p/3)*cos(($t+4*pi())/3)-$b/(3*$a);
        if ($q==0) { $x3 = -$b/(3*$a); }
        return array(
            'x1' => $x1,
            'x2' => $x2,
            'x3' => $x3
        );
    } 
    if ($S > 0) {
        if ((-$q/2+sqrt($S)) >  0) { $y1 = exp(log(abs(-$q/2+sqrt($S)))/3); }
        if ((-$q/2+sqrt($S)) <  0) { $y1 = -exp(log(abs(-$q/2+sqrt($S)))/3); }
        if ((-$q/2+sqrt($S)) == 0) { $y1 = 0; }
        if ((-$q/2-sqrt($S)) >  0) { $y2 = exp(log(abs(-$q/2-sqrt($S)))/3); }
        if ((-$q/2-sqrt($S)) <  0) { $y2 = -exp(log(abs(-$q/2-sqrt($S)))/3); }
        if ((-$q/2-sqrt($S)) == 0) { $y2 = 0; }
        $x1 = $y1+$y2-$b/$a/3;
        $Re1 = -($y1+$y2)/2-$b/$a/3;
        $Im1 = ($y1-$y2)*sqrt(3)/2;
        return array(
            'x1' => $x1,
            'Re1' => $Re1,
            'Im1' => $Im1
        );
    }  
    if ($S==0) {
        if ($q < 0) { $y1 = exp(log(abs(-$q/2))/3); }
        if ($q > 0) { $y1 = -exp(log(abs(-$q/2))/3); }
        if ($q = 0) { $y1 = 0; }
        $x1 = 2*$y1-$b/$a/3;
        $x2 = -$y1-$b/$a/3;
        $x3 = -$y1-$b/$a/3;
        return array(
            'x1' => $x1,
            'x2' => $x2,
            'x3' => $x3,
        );
        } 
     return null;
    }

    //print_r(calcCube(1, 155, 7939, 134505 ));



