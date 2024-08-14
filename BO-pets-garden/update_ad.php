<?php
include_once 'db.php';

$database = new Database();
$db = $database->getConnection();

$data = json_decode(file_get_contents("php://input"));

// Vérifie si l'identifiant de l'annonce est fourni
if (!isset($data->id)) {
    echo json_encode(array("message" => "L'identifiant de l'annonce est requis."));
    exit();
}

// Vérifie si l'annonce existe
$checkQuery = "SELECT id FROM ads WHERE id = :id";
$checkStmt = $db->prepare($checkQuery);
$checkStmt->bindParam(':id', $data->id);
$checkStmt->execute();

if ($checkStmt->rowCount() == 0) {
    echo json_encode(array("message" => "Annonce non trouvée."));
    exit();
}

// Mise à jour de l'annonce
$query = "UPDATE ads SET 
    animal_type = :animal_type,
    breed = :breed,
    sex = :sex,
    age = :age,
    origin = :origin,
    description = :description,
    start_date = :start_date,
    end_date = :end_date,
    city = :city,
    comments = :comments,
    animal_photo = :animal_photo
    WHERE id = :id";

$stmt = $db->prepare($query);

$stmt->bindParam(':animal_type', $data->animal_type);
$stmt->bindParam(':breed', $data->breed);
$stmt->bindParam(':sex', $data->sex);
$stmt->bindParam(':age', $data->age);
$stmt->bindParam(':origin', $data->origin);
$stmt->bindParam(':description', $data->description);
$stmt->bindParam(':start_date', $data->start_date);
$stmt->bindParam(':end_date', $data->end_date);
$stmt->bindParam(':city', $data->city);
$stmt->bindParam(':comments', $data->comments);
$stmt->bindParam(':animal_photo', $data->animal_photo);
$stmt->bindParam(':id', $data->id);

if ($stmt->execute()) {
    echo json_encode(array("message" => "Annonce mise à jour avec succès."));
} else {
    echo json_encode(array("message" => "Impossible de mettre à jour l'annonce."));
}
?>
