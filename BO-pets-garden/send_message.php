<?php
include_once 'db.php';

$database = new Database();
$db = $database->getConnection();

$data = json_decode(file_get_contents("php://input"));

$query = "INSERT INTO messages SET ad_id=:ad_id, sender_id=:sender_id, receiver_id=:receiver_id, content=:content, timestamp=:timestamp";
$stmt = $db->prepare($query);

$stmt->bindParam(':ad_id', $data->ad_id);
$stmt->bindParam(':sender_id', $data->sender_id);
$stmt->bindParam(':receiver_id', $data->receiver_id);
$stmt->bindParam(':content', $data->content);
$stmt->bindParam(':timestamp', $data->timestamp);

if ($stmt->execute()) {
    echo json_encode(array("message" => "Message envoyé avec succès."));
} else {
    echo json_encode(array("message" => "Impossible d'envoyer le message."));
}
?>
