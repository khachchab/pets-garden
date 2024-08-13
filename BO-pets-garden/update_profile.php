<?php
include_once 'db.php';

$database = new Database();
$db = $database->getConnection();

$data = json_decode(file_get_contents("php://input"));

if (!isset($data->account_id)) {
    echo json_encode(array("message" => "L'identifiant du compte est requis."));
    exit();
}

$query = "UPDATE profiles SET 
    name = :name,
    profile_photo = :profile_photo,
    user_type = :user_type
    WHERE account_id = :account_id";

$stmt = $db->prepare($query);

$stmt->bindParam(':name', $data->name);
$stmt->bindParam(':profile_photo', $data->profile_photo);
$stmt->bindParam(':user_type', $data->user_type);
$stmt->bindParam(':account_id', $data->account_id);

if ($stmt->execute()) {
    echo json_encode(array("message" => "Profil mis à jour avec succès."));
} else {
    echo json_encode(array("message" => "Impossible de mettre à jour le profil."));
}
?>
