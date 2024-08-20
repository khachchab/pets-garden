<?php
include_once 'db.php';

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");

$database = new Database();
$db = $database->getConnection();

$data = json_decode(file_get_contents("php://input"));

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
$stmt->bindParam(":animal_photo", $data->animal_photo);

if ($stmt->execute()) {
    echo json_encode(array("message" => "Annonce ajoutée avec succès."));
} else {
    echo json_encode(array("message" => "Impossible d'ajouter l'annonce."));
}
?>
