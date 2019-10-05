<?php
error_reporting(1);

require_once('application/Application.php');

function router($params) {
    $method = $params['method'];
    if ($method) {
        $app = new Application();
        switch ($method) {
            case 'test': return $app->test();
            case 'move': return $app->move($params);
            case 'shoot': return $app->shoot($params);
            case 'update': return $app->update($params);
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