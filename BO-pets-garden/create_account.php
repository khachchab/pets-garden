<?php
include_once 'db.php';

$database = new Database();
$db = $database->getConnection();

$data = json_decode(file_get_contents("php://input"));

$query = "INSERT INTO accounts SET email=:email, password=:password, is_active=:is_active";
$stmt = $db->prepare($query);

$stmt->bindParam(':email', $data->email);
$stmt->bindParam(':password', $data->password); // Assurez-vous de hacher le mot de passe
$stmt->bindParam(':is_active', $data->is_active);

if ($stmt->execute()) {
    $account_id = $db->lastInsertId();

    $profileQuery = "INSERT INTO profiles SET account_id=:account_id, name=:name, profile_photo=:profile_photo, user_type=:user_type";
    $profileStmt = $db->prepare($profileQuery);

    $profileStmt->bindParam(':account_id', $account_id);
    $profileStmt->bindParam(':name', $data->name);
    $profileStmt->bindParam(':profile_photo', $data->profile_photo);
    $profileStmt->bindParam(':user_type', $data->user_type);

    if ($profileStmt->execute()) {
        echo json_encode(array("message" => "Compte et profil créés avec succès."));
    } else {
        echo json_encode(array("message" => "Compte créé, mais impossible de créer le profil."));
    }
} else {
    echo json_encode(array("message" => "Impossible de créer le compte."));
}
?>
