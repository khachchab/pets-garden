<?php
session_start();

include_once 'db.php';

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(204);
    exit;
}

$database = new Database();
$db = $database->getConnection();

$data = json_decode(file_get_contents("php://input"), true);

if (!$data || !isset($data['email']) || !isset($data['password'])) {
    echo json_encode(array(
        "status" => "error",
        "message" => "Invalid input."
    ));
    exit;
}

$email = filter_var($data['email'], FILTER_SANITIZE_EMAIL);
$password = trim($data['password']);

$query = "SELECT * FROM accounts WHERE email = :email";
$stmt = $db->prepare($query);
$stmt->bindParam(':email', $email);

if ($stmt->execute()) {
    $account = $stmt->fetch(PDO::FETCH_ASSOC);

    if ($account && password_verify($password, $account['password'])) {
        if ($account['is_active']) {
            // Stocker les informations de l'utilisateur dans la session
            $_SESSION['loggedin'] = true;
            $_SESSION['account_id'] = $account['id'];
            $_SESSION['email'] = $account['email'];

            echo json_encode(array(
                "status" => "success",
                "message" => "Connexion réussie.",
                "account_id" => $account['id']
            ));
        } else {
            echo json_encode(array(
                "status" => "error",
                "message" => "Compte désactivé."
            ));
        }
    } else {
        echo json_encode(array(
            "status" => "error",
            "message" => "Email or password is incorrect."
        ));
    }
} else {
    echo json_encode(array(
        "status" => "error",
        "message" => "Database error."
    ));
}
