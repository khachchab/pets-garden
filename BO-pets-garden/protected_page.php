<?php
session_start(); // Démarrer la session

// Vérifier si l'utilisateur est connecté
if (!isset($_SESSION['loggedin']) || $_SESSION['loggedin'] !== true) {
    // Rediriger vers la page de connexion
    header("Location: login.php");
    exit;
}

// Ici, vous pouvez afficher le contenu de la page protégée
echo "Bienvenue, " . $_SESSION['email'];
?>
