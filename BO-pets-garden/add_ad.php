<?php

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");

// Connexion à la base de données
$database = new Database();
$db = $database->getConnection();

// Récupérer les données envoyées en JSON
$data = json_decode(file_get_contents("php://input"));

// Vérifier que toutes les données nécessaires sont présentes
if(
    isset($data->profile_id) && 
    isset($data->animal_type) && 
    isset($data->breed) && 
    isset($data->sex) && 
    isset($data->age) && 
    isset($data->origin) && 
    isset($data->start_date) && 
    isset($data->end_date) && 
    isset($data->city) && 
    isset($data->comments)
) {
    // Préparer la requête d'insertion
    $query = "INSERT INTO ads 
                SET profile_id=:profile_id, 
                    animal_type=:animal_type, 
                    breed=:breed, 
                    sex=:sex, 
                    age=:age, 
                    origin=:origin, 
                    description=:description, 
                    start_date=:start_date, 
                    end_date=:end_date, 
                    city=:city, 
                    comments=:comments, 
                    animal_photo=:animal_photo";
                    
    $stmt = $db->prepare($query);

    // Liaison des paramètres
    $stmt->bindParam(":profile_id", $data->profile_id);
    $stmt->bindParam(":animal_type", $data->animal_type);
    $stmt->bindParam(":breed", $data->breed);
    $stmt->bindParam(":sex", $data->sex);
    $stmt->bindParam(":age", $data->age);
    $stmt->bindParam(":origin", $data->origin);
    $stmt->bindParam(":description", $data->description);
    $stmt->bindParam(":start_date", $data->start_date);
    $stmt->bindParam(":end_date", $data->end_date);
    $stmt->bindParam(":city", $data->city);
    $stmt->bindParam(":comments", $data->comments);

    // Gestion de l'image (si fournie)
    $animal_photo = null;
    if(isset($data->animal_photo) && !empty($data->animal_photo)) {
        $imageName = uniqid() . '.png'; // Nom unique pour l'image
        $imagePath = "uploads/" . $imageName;

        // Créer le dossier "uploads" s'il n'existe pas
        if (!file_exists('uploads')) {
            mkdir('uploads', 0777, true);
        }

        // Sauvegarder l'image
        if (file_put_contents($imagePath, base64_decode($data->animal_photo))) {
            $animal_photo = $imagePath;
        } else {
            echo json_encode(array("message" => "Erreur lors de l'upload de l'image."));
            exit();
        }
    }

    $stmt->bindParam(":animal_photo", $animal_photo);

    // Exécuter la requête
    if ($stmt->execute()) {
        echo json_encode(array("message" => "Annonce ajoutée avec succès."));
    } else {
        echo json_encode(array("message" => "Impossible d'ajouter l'annonce."));
    }

} else {
    echo json_encode(array("message" => "Données incomplètes."));
}
?>
