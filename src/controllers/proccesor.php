<?php
require($_SERVER['DOCUMENT_ROOT'] . '/config/db.php');
$db = new DatabaseController();

$spName = $_POST['spName'];

$params = isset($_POST['params']) && !empty($_POST['params']) ? $_POST['params'] : [];

$response = $db->executeStoredProcedure($spName, $params);
echo json_encode($response);
?>