<?php
require("helpers/handler.php");

$handler = new Handler();

$handler->process();
function GET(Handler $handler)
{
    $id = $handler->request->get["id"];
    $pdo = $handler->db->PDO();
    $query = 'CALL View_List(?)';
    $statement = $pdo->prepare($query);
    $statement->execute([$id]);
    $results = $statement->fetchAll();
    $handler->response->json($results);
}


function POST(Handler $handler)
{
    $list = $handler->request->get["id"];
    $item = $handler->request->input;
    $pdo = $handler->db->PDO();
    $query = 'CALL Add_List_Items(?, ?)';
    $statement = $pdo->prepare($query);
    $statement->execute([$item, $list]);
    $results = $statement->fetchAll();
    $handler->response->json($results);
}

function PUT(Handler $handler)
{
    $item = $handler->request->get["id"];
    $value = $handler->request->input;
    $pdo = $handler->db->PDO();
    if ($value == 1) { $query = 'CALL Check_Items(?)'; }
    if ($value == 0) { $query = 'CALL Uncheck_Items(?)'; }
    $statement = $pdo->prepare($query);
    $statement->execute([$item]);
    $results = $statement->fetchAll();
    $handler->response->json($results);
}

function DELETE(Handler $handler)
{
    $id = $handler->request->get["id"];
    $pdo = $handler->db->PDO();
    $query = 'CALL Remove_List_Items(?)';
    $statement = $pdo->prepare($query);
    $statement->execute([$id]);
    $results = $statement->fetchAll();
    $handler->response->json($results);
}
