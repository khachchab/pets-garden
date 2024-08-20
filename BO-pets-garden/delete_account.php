<?php
include_once 'db.php';

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");

$database = new Database();
$db = $database->getConnection();

$data = json_decode(file_get_contents("php://input"));

if (!isset($data->id)) {
    echo json_encode(array("message" => "L'identifiant du compte est requis."));
    exit();
}

$query = "DELETE FROM accounts WHERE id = :id";
$stmt = $db->prepare($query);
$stmt->bindParam(':id', $data->id);

if ($stmt->execute()) {
    echo json_encode(array("message" => "Compte supprimé avec succès."));
} else {
    echo json_encode(array("message" => "Impossible de supprimer le compte."));
}
?>
