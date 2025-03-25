<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);
require($_SERVER['DOCUMENT_ROOT'] . '/config/db.php');
$db = new DatabaseController();

$spName = $_POST['spName'];

$params = isset($_POST['params']) && !empty($_POST['params']) ? $_POST['params'] : [];

$response = $db->executeStoredProcedure($spName, $params);
echo json_encode($response);
?>