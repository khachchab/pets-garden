<?php
include_once 'db.php';

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");

$database = new Database();
$db = $database->getConnection();

$data = json_decode(file_get_contents("php://input"));

// Vérifie si l'identifiant de l'annonce est fourni
if (!isset($data->id)) {
    echo json_encode(array("message" => "L'identifiant de l'annonce est requis."));
    exit();
}

// Vérifie si l'annonce existe
$checkQuery = "SELECT id FROM ads WHERE id = :id";
$checkStmt = $db->prepare($checkQuery);
$checkStmt->bindParam(':id', $data->id);
$checkStmt->execute();

if ($checkStmt->rowCount() == 0) {
    echo json_encode(array("message" => "Annonce non trouvée."));
    exit();
}

// Supprime l'annonce
$query = "DELETE FROM ads WHERE id = :id";
$stmt = $db->prepare($query);
$stmt->bindParam(':id', $data->id);

if ($stmt->execute()) {
    echo json_encode(array("message" => "Annonce supprimée avec succès."));
} else {
    echo json_encode(array("message" => "Impossible de supprimer l'annonce."));
}
?>
