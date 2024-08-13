<?php
include_once 'db.php';

$database = new Database();
$db = $database->getConnection();

$data = json_decode(file_get_contents("php://input"));

if (!isset($data->id)) {
    echo json_encode(array("message" => "L'identifiant de l'annonce est requis."));
    exit();
}

$query = "DELETE FROM ads WHERE id = :id";
$stmt = $db->prepare($query);

$stmt->bindParam(':id', $data->id);

if ($stmt->execute()) {
    echo json_encode(array("message" => "Annonce supprimée avec succès."));
} else {
    echo json_encode(array("message" => "Impossible de supprimer l'annonce."));
}
?>
