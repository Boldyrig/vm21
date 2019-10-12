<?php
error_reporting(1);

header("Access-Control-Allow-Origin: *");

require_once('application/Application.php');

function router($params) {
    $method = $params['method'];
    if ($method) {
        $app = new Application();
        switch ($method) {
            case 'test': return $app->test();
            // about user
            case 'login': return $app->login($params);
            case 'logout': return $app->logout($params);
            case 'registration': return $app->registration($params);
            // about game
            case 'move': return $app->move($params);
            case 'shoot': return $app->shoot($params);
            case 'update': return $app->updateScene($params);
            case 'checkEndGame': return $app->checkEndGame();
            default: return false;
        }
    }
    return false;
}

function answer($data) {
    if ($data) {
        return array(
            'result' => 'ok',
            'data' => $data
        );
    }
    return array(
        'result' => 'error',
        'error' => array(
            'code' => 9000,
            'text' => 'unknown error'
        )
    );
}

echo json_encode(answer(router($_GET)));