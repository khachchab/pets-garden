<?php
include_once 'db.php';

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");

$database = new Database();
$db = $database->getConnection();

$data = json_decode(file_get_contents("php://input"));

// Hacher le mot de passe avant de l'insérer dans la base de données
$hashedPassword = password_hash($data->password, PASSWORD_BCRYPT);

$query = "INSERT INTO accounts SET email=:email, password=:password, is_active=:is_active";
$stmt = $db->prepare($query);

$stmt->bindParam(':email', $data->email);
$stmt->bindParam(':password', $hashedPassword);
$stmt->bindParam(':is_active', $data->is_active);

if ($stmt->execute()) {
    $account_id = $db->lastInsertId();

    // Définir les valeurs par défaut
    $name = $data->name;
    $profilePhoto = ""; // Laisser vide par défaut
    $userType = "B"; // Type d'utilisateur par défaut

    $profileQuery = "INSERT INTO profiles SET account_id=:account_id, name=:name, profile_photo=:profile_photo, user_type=:user_type";
    $profileStmt = $db->prepare($profileQuery);

    $profileStmt->bindParam(':account_id', $account_id);
    $profileStmt->bindParam(':name', $name);
    $profileStmt->bindParam(':profile_photo', $profilePhoto);
    $profileStmt->bindParam(':user_type', $userType);

    if ($profileStmt->execute()) {
        echo json_encode(array("message" => "Compte et profil créés avec succès."));
    } else {
        echo json_encode(array("message" => "Compte créé, mais impossible de créer le profil."));
    }
} else {
    echo json_encode(array("message" => "Impossible de créer le compte."));
}
?>
