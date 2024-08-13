<?php
include_once 'db.php';

$database = new Database();
$db = $database->getConnection();

$data = json_decode(file_get_contents("php://input"));

if (!isset($data->account_id)) {
    echo json_encode(array("message" => "L'identifiant du compte est requis."));
    exit();
}

$query = "SELECT * FROM profiles WHERE account_id = :account_id";
$stmt = $db->prepare($query);
$stmt->bindParam(':account_id', $data->account_id);
$stmt->execute();

$profile = $stmt->fetch(PDO::FETCH_ASSOC);

if ($profile) {
    echo json_encode($profile);
} else {
    echo json_encode(array("message" => "Profil non trouvé."));
}
?>
