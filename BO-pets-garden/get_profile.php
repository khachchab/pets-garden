<?php
include_once 'db.php';

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");

$database = new Database();
$db = $database->getConnection();

$data = json_decode(file_get_contents("php://input"));

if (!isset($data->account_id)) {
    echo json_encode(array("message" => "L'identifiant du compte est requis."));
    exit();
}

$query = "SELECT 
            a.email,
            p.name,
            p.profile_photo,
            p.user_type,
            p.telephone,
            p.description
          FROM profiles p 
          JOIN accounts a ON p.account_id = a.id
          WHERE p.account_id = :account_id";

$stmt = $db->prepare($query);
$stmt->bindParam(':account_id', $data->account_id, PDO::PARAM_INT);

if($stmt->execute()) {
    $profile = $stmt->fetch(PDO::FETCH_ASSOC);

    if ($profile) {
        echo json_encode($profile);
    } else {
        echo json_encode(array("message" => "Profil non trouvé."));
    }
} else {
    echo json_encode(array("message" => "Erreur lors de la récupération du profil."));
}
?>
