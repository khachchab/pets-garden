<?php
include_once 'db.php';

$database = new Database();
$db = $database->getConnection();

$data = json_decode(file_get_contents("php://input"));

$query = "SELECT * FROM accounts WHERE email = :email";
$stmt = $db->prepare($query);
$stmt->bindParam(':email', $data->email);
$stmt->execute();

$account = $stmt->fetch(PDO::FETCH_ASSOC);

if ($account) {
    if (password_verify($data->password, $account['password'])) { // Vérifiez que le mot de passe est correct
        if ($account['is_active']) {
            echo json_encode(array(
                "message" => "Connexion réussie.",
                "account_id" => $account['id']
            ));
        } else {
            echo json_encode(array("message" => "Compte désactivé."));
        }
    } else {
        echo json_encode(array("message" => "Mot de passe incorrect."));
    }
} else {
    echo json_encode(array("message" => "Email non trouvé."));
}
?>
