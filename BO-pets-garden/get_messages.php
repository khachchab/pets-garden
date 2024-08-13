<?php
include_once 'db.php';

$database = new Database();
$db = $database->getConnection();

$data = json_decode(file_get_contents("php://input"));

if (!isset($data->ad_id)) {
    echo json_encode(array("message" => "L'identifiant de l'annonce est requis."));
    exit();
}

$query = "SELECT * FROM messages WHERE ad_id = :ad_id ORDER BY timestamp ASC";
$stmt = $db->prepare($query);
$stmt->bindParam(':ad_id', $data->ad_id);
$stmt->execute();

$messages = $stmt->fetchAll(PDO::FETCH_ASSOC);

if ($messages) {
    echo json_encode($messages);
} else {
    echo json_encode(array("message" => "Aucun message trouvé pour cette annonce."));
}
?>
