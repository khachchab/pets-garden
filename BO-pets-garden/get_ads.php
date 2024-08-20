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
                ads.id, 
                profiles.name AS profile_name, 
                ads.name,
                ads.animal_type, 
                ads.breed, 
                ads.sex, 
                ads.age, 
                ads.origin, 
                ads.description, 
                ads.start_date, 
                ads.end_date, 
                ads.city, 
                ads.comments, 
                ads.animal_photo 
              FROM ads 
              JOIN profiles ON ads.profile_id = profiles.id";
              
    $stmt = $db->prepare($query);

    // Exécution de la requête
    if ($stmt->execute()) {
        // Récupération des résultats
        $ads = $stmt->fetchAll(PDO::FETCH_ASSOC);

        // Vérification si des données ont été récupérées
        if (!empty($ads)) {
            // Tentative d'encodage en JSON avec formatage
            $json = json_encode($ads, JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
            
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
            // Aucune annonce trouvée
            echo json_encode(["error" => "No ads found"], JSON_PRETTY_PRINT);
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
