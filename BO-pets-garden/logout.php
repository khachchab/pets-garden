<?php
    header("Access-Control-Allow-Origin: *");
    header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
    header("Access-Control-Allow-Headers: Content-Type, Authorization");
    
    session_start();
    session_unset(); // Supprimer toutes les variables de session
    session_destroy(); // Détruire la session

    // Rediriger vers la page de connexion après la déconnexion
    header("Location: login.php");
    exit;
?>
