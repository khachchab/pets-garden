<?php

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Credentials: true");
header("Content-type: application/json;charset=utf-8");
header("Access-Control-Allow-Methods: GET");

include_once 'db.php';

try {
    // Connexion à la base de données
    $database = new Database();
    $db = $database->getConnection();
    $db->exec("SET NAMES 'utf8'");

    // Préparation de la requête SQL
    $query = "SELECT 
                profiles.id, 
                profiles.name, 
                profiles.profile_photo, 
                profiles.user_type, 
                profiles.telephone, 
                profiles.description, 
                accounts.email AS account_email
              FROM profiles 
              JOIN accounts ON profiles.account_id = accounts.id";
              
    $stmt = $db->prepare($query);

    // Exécution de la requête
    if ($stmt->execute()) {
        // Récupération des résultats
        $profiles = $stmt->fetchAll(PDO::FETCH_ASSOC);

        // Vérification si des données ont été récupérées
        if (!empty($profiles)) {
            // Tentative d'encodage en JSON avec formatage
            $json = json_encode($profiles, JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
            
            // Vérification d'erreurs d'encodage JSON
            if (json_last_error() === JSON_ERROR_NONE) {
                echo $json;
            } else {
                echo json_encode([
                    "error" => "JSON encoding error",
                    "message" => json_last_error_msg()
                ]);
            }
        } else {
            // Aucun profil trouvé
            echo json_encode(["error" => "No profiles found"], JSON_PRETTY_PRINT);
        }
    } else {
        // Erreur lors de l'exécution de la requête
        echo json_encode(["error" => "Database query failed"], JSON_PRETTY_PRINT);
    }
} catch (Exception $e) {
    // Gestion des exceptions
    echo json_encode(["error" => "An error occurred: " . $e->getMessage()], JSON_PRETTY_PRINT);
}

?>
