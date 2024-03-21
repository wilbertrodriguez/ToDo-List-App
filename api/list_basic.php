<?php
require("helpers/handler.php");
$handler = new Handler();

$handler->process();

function GET(Handler $handler)
{
    $pdo = $handler->db->PDO();
    $query = 'CALL View_summaries_of_all_lists()';
    $statement = $pdo->prepare($query);
    $statement->execute();
    $results = $statement->fetchAll();
    $handler->response->json($results);
}





function POST(Handler $handler)
{
    $data = $handler->request->input;
    $pdo = $handler->db->PDO();
    $query = 'CALL Create_List(?)';
    $statement = $pdo->prepare($query);
    $statement->execute([$data]);
    $results = $statement->fetchAll();
    $handler->response->json($results);
}

function PUT(Handler $handler)
{
    $old_name = $handler->request->get["id"];
    $new_name = $handler->request->input;
    $pdo = $handler->db->PDO();
    $query = 'CALL Rename_List(?, ?)';
    $statement = $pdo->prepare($query);
    $statement->execute([$old_name, $new_name]);
    $results = $statement->fetchAll();
    $handler->response->json($results);
}

function DELETE(Handler $handler)
{
    $id = $handler->request->get["id"];
    $pdo = $handler->db->PDO();
    $query = 'CALL Delete_List(?)';
    $statement = $pdo->prepare($query);
    $statement->execute([$id]);
    $results = $statement->fetchAll();
    $handler->response->json($results);
}
