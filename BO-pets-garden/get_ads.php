<?php
include_once 'db.php';

$database = new Database();
$db = $database->getConnection();

$query = "SELECT ads.id, profiles.name, ads.animal_type, ads.start_date, ads.end_date, ads.city, ads.comments, ads.animal_photo 
          FROM ads 
          JOIN profiles ON ads.profile_id = profiles.id";
$stmt = $db->prepare($query);
$stmt->execute();

$ads = $stmt->fetchAll(PDO::FETCH_ASSOC);
echo json_encode($ads);
?>
