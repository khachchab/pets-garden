-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : dim. 08 sep. 2024 à 16:18
-- Version du serveur : 10.4.22-MariaDB
-- Version de PHP : 7.4.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `pets_garden`
--

-- --------------------------------------------------------

--
-- Structure de la table `accounts`
--

CREATE TABLE `accounts` (
  `id` int(11) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `is_active` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `accounts`
--

INSERT INTO `accounts` (`id`, `email`, `password`, `is_active`, `created_at`) VALUES
(1, 'user1@example.com', '$2y$10$JzYN8a5./Jwr6UzoPpCMXOS.NYUNW3OU1fH0LzHr.BG7ayZRxwbZi\n', 1, '2024-08-14 14:23:22'),
(2, 'user2@example.com', 'password_hash_2', 1, '2024-08-14 14:23:22'),
(3, 'user3@example.com', 'password_hash_3', 0, '2024-08-14 14:23:22'),
(4, 'admin@admin.com', '$2y$10$uGg8PZg3STJ0AfJQrPvjK.hOLPvj5PeXa8y9O9UhyRH4Jq/Z1hOhe', 1, '2024-08-21 12:09:14'),
(5, 'amine@gmail.com', '$2y$10$6geDvqO1AUfYnk90hKBz5O/GkWXtxBfhdwjPADv9g6ULiDwE/YgWC', 1, '2024-08-21 19:27:01'),
(6, 'simo@gmail.com', '$2y$10$If4GXW98knGGyXtKw.K8CeW6deA6cJzL0RVdYdrwOGTDFa7bwhgAu', 1, '2024-08-22 13:39:03');

-- --------------------------------------------------------

--
-- Structure de la table `ads`
--

CREATE TABLE `ads` (
  `id` int(11) NOT NULL,
  `profile_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `animal_type` enum('Cat','dog') NOT NULL,
  `breed` varchar(100) NOT NULL,
  `sex` varchar(10) NOT NULL,
  `age` varchar(10) NOT NULL,
  `origin` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `animal_photo` varchar(255) DEFAULT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `city` varchar(100) NOT NULL,
  `comments` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `ads`
--

INSERT INTO `ads` (`id`, `profile_id`, `name`, `animal_type`, `breed`, `sex`, `age`, `origin`, `description`, `animal_photo`, `start_date`, `end_date`, `city`, `comments`, `created_at`) VALUES
(1, 1, 'Mono LaMi', 'Cat', 'British Shorthair cats', 'Female', '1', 'US', 'Pets bring joy, companionship, and love into our lives. Whether furry, feathered, or scaled, they offer comfort and loyalty. From playful antics to gentle purrs, they teach us patience and responsibility.', 'cat3.png', '2024-08-01', '2024-08-15', 'New York', NULL, '2024-08-14 14:23:22'),
(2, 2, 'Amila Marko', 'Cat', 'LaPerm cats', 'Female', '2', 'US', 'Pets bring joy, companionship, and love into our lives. Whether furry, feathered, or scaled, they offer comfort and loyalty. From playful antics to gentle purrs, they teach us patience and responsibility.', 'cat2.png', '2024-08-01', '2024-08-15', 'Los Angeles', NULL, '2024-08-14 14:23:22'),
(3, 3, 'Yon lee', 'Cat', 'Persian cat', 'Female', '3', 'Iran', 'Pets bring joy, companionship, and love into our lives. Whether furry, feathered, or scaled, they offer comfort and loyalty. From playful antics to gentle purrs, they teach us patience and responsibility.', 'cat1.png', '2024-08-01', '2024-08-15', 'San Francisco', NULL, '2024-08-14 14:23:22'),
(4, 1, 'Max', 'dog', 'Labrador Retriever', 'Male', '1', 'UK', 'Pets bring joy, companionship, and love into our lives. Whether furry, feathered, or scaled, they offer comfort and loyalty. From playful antics to gentle purrs, they teach us patience and responsibility.', 'dog1.png', '2024-08-01', '2024-08-15', 'London', NULL, '2024-08-14 14:23:22'),
(5, 2, 'Bella', 'dog', 'Golden Retriever', 'Male', '2', 'Italy', 'Pets bring joy, companionship, and love into our lives. Whether furry, feathered, or scaled, they offer comfort and loyalty. From playful antics to gentle purrs, they teach us patience and responsibility.', 'dog2.png', '2024-08-01', '2024-08-15', 'Rome', NULL, '2024-08-14 14:23:22'),
(6, 3, 'Charlie', 'dog', 'German Shepherd', 'Male', '2.5', 'India', 'Pets bring joy, companionship, and love into our lives. Whether furry, feathered, or scaled, they offer comfort and loyalty. From playful antics to gentle purrs, they teach us patience and responsibility.', 'dog3.png', '2024-08-01', '2024-08-15', 'Delhi', NULL, '2024-08-14 14:23:22'),
(7, 1, 'Daisy', 'dog', 'Beagle', 'Male', '2.5', 'India', 'Pets bring joy, companionship, and love into our lives. Whether furry, feathered, or scaled, they offer comfort and loyalty. From playful antics to gentle purrs, they teach us patience and responsibility.', 'dog4.png', '2024-08-01', '2024-08-15', 'Mumbai', NULL, '2024-08-14 14:23:22'),
(8, 2, 'Luna', 'dog', 'Siberian Husky', 'Male', '2.5', 'India', 'Pets bring joy, companionship, and love into our lives. Whether furry, feathered, or scaled, they offer comfort and loyalty. From playful antics to gentle purrs, they teach us patience and responsibility.', 'dog5.png', '2024-08-01', '2024-08-15', 'Bangalore', NULL, '2024-08-14 14:23:22');

-- --------------------------------------------------------

--
-- Structure de la table `messages`
--

CREATE TABLE `messages` (
  `id` int(11) NOT NULL,
  `ad_id` int(11) NOT NULL,
  `sender_id` int(11) NOT NULL,
  `receiver_id` int(11) NOT NULL,
  `content` text NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `messages`
--

INSERT INTO `messages` (`id`, `ad_id`, `sender_id`, `receiver_id`, `content`, `timestamp`) VALUES
(1, 1, 1, 2, 'Is this pet still available?', '2024-08-14 14:23:22'),
(2, 2, 2, 1, 'Yes, it is. Do you want to arrange a meeting?', '2024-08-14 14:23:22'),
(3, 1, 1, 3, 'I am interested in adopting this pet. Could you tell me more?', '2024-08-14 14:23:22');

-- --------------------------------------------------------

--
-- Structure de la table `profiles`
--

CREATE TABLE `profiles` (
  `id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `profile_photo` varchar(255) DEFAULT NULL,
  `user_type` enum('A','B') NOT NULL,
  `telephone` varchar(15) DEFAULT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `profiles`
--

INSERT INTO `profiles` (`id`, `account_id`, `name`, `profile_photo`, `user_type`, `telephone`, `description`) VALUES
(1, 1, 'John Doe', 'images/profile1.png', 'A', NULL, NULL),
(2, 2, 'Jane Smith', 'images/profile2.png', 'B', NULL, NULL),
(3, 3, 'Alice Johnson', 'images/profile3.png', 'A', NULL, NULL),
(4, 5, 'amine', 'images/amine.jpg', 'B', NULL, NULL),
(5, 6, 'simo', '', 'B', NULL, NULL);

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Index pour la table `ads`
--
ALTER TABLE `ads`
  ADD PRIMARY KEY (`id`),
  ADD KEY `profile_id` (`profile_id`);

--
-- Index pour la table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ad_id` (`ad_id`),
  ADD KEY `sender_id` (`sender_id`),
  ADD KEY `receiver_id` (`receiver_id`);

--
-- Index pour la table `profiles`
--
ALTER TABLE `profiles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `account_id` (`account_id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `accounts`
--
ALTER TABLE `accounts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `ads`
--
ALTER TABLE `ads`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT pour la table `messages`
--
ALTER TABLE `messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `profiles`
--
ALTER TABLE `profiles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `ads`
--
ALTER TABLE `ads`
  ADD CONSTRAINT `ads_ibfk_1` FOREIGN KEY (`profile_id`) REFERENCES `profiles` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `messages`
--
ALTER TABLE `messages`
  ADD CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`ad_id`) REFERENCES `ads` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `messages_ibfk_2` FOREIGN KEY (`sender_id`) REFERENCES `profiles` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `messages_ibfk_3` FOREIGN KEY (`receiver_id`) REFERENCES `profiles` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `profiles`
--
ALTER TABLE `profiles`
  ADD CONSTRAINT `profiles_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
