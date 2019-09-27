<?php
require_once('logic/Logic.php');

$logic = new Logic();
$logic->move(111, 'down');
$logic->move(222, 'left');

print_r($logic->getTanks());
print_r($logic->getBuildings());


/* 1) игровое поле (поверхности и преграды, разрушаемость)
   2) объекты(башни-базы заводы ящики с ресурсами)
   3) Юниты характеристики составные части
   4) Вход,регистрация,старт/конец(победа стороны)
   5) модель перемещения повреждения выстрела
   6) Макеты страниц и переходы между ними*/