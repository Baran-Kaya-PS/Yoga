-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : ven. 10 mars 2023 à 21:52
-- Version du serveur : 10.4.27-MariaDB
-- Version de PHP : 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `yoga`
--

-- --------------------------------------------------------

--
-- Structure de la table `cours`
--

CREATE TABLE `cours` (
  `id` int(11) NOT NULL,
  `nom_cours` varchar(100) NOT NULL,
  `instructeur` varchar(100) NOT NULL,
  `date_cours` date NOT NULL,
  `heure_cours` time NOT NULL,
  `duree_cours` int(11) NOT NULL CHECK (`duree_cours` > 0 and `duree_cours` <= 240)
) ;

--
-- Déchargement des données de la table `cours`
--

INSERT INTO `cours` (`id`, `nom_cours`, `instructeur`, `date_cours`, `heure_cours`, `duree_cours`) VALUES
(1, 'Yoga doux', 'Instructeur 5', '2022-01-09', '13:00:00', 103),
(2, 'Jivamukti yoga', 'Instructeur 2', '2022-03-21', '19:00:00', 106),
(3, 'Yin yoga', 'Instructeur 4', '2022-11-15', '11:00:00', 64),
(4, 'Hatha yoga', 'Instructeur 5', '2022-08-19', '09:00:00', 77),
(5, 'Yin yoga', 'Instructeur 3', '2022-09-11', '18:00:00', 108),
(6, 'Anusara yoga', 'Instructeur 1', '2022-03-03', '10:00:00', 60),
(7, 'Hatha yoga', 'Instructeur 3', '2022-04-09', '16:00:00', 77),
(8, 'Ashtanga yoga', 'Instructeur 1', '2022-11-11', '19:00:00', 115),
(9, 'Yoga doux', 'Instructeur 3', '2022-10-03', '10:00:00', 83),
(10, 'Yin yoga', 'Instructeur 4', '2022-11-11', '11:00:00', 92),
(11, 'Anusara yoga', 'Instructeur 2', '2022-05-24', '08:00:00', 95),
(12, 'Yoga doux', 'Instructeur 1', '2022-08-01', '18:00:00', 71),
(13, 'Ashtanga yoga', 'Instructeur 1', '2022-09-23', '15:00:00', 87),
(14, 'Yin yoga', 'Instructeur 3', '2022-03-12', '20:00:00', 116),
(15, 'Vinyasa yoga', 'Instructeur 1', '2022-10-05', '18:00:00', 64),
(16, 'Anusara yoga', 'Instructeur 3', '2022-11-23', '12:00:00', 111),
(17, 'Jivamukti yoga', 'Instructeur 1', '2022-11-18', '14:00:00', 87),
(18, 'Yoga nidra', 'Instructeur 1', '2022-12-11', '12:00:00', 97),
(19, 'Yin yoga', 'Instructeur 5', '2022-03-17', '20:00:00', 116),
(20, 'Jivamukti yoga', 'Instructeur 4', '2022-11-14', '18:00:00', 92);

-- --------------------------------------------------------

--
-- Structure de la table `notifications`
--

CREATE TABLE `notifications` (
  `id` int(11) NOT NULL,
  `destinataire` varchar(100) NOT NULL,
  `contenu` text NOT NULL,
  `date_envoi` datetime NOT NULL
) ;

-- --------------------------------------------------------

--
-- Structure de la table `paiements`
--

CREATE TABLE `paiements` (
  `id` int(11) NOT NULL,
  `id_utilisateur` int(11) NOT NULL,
  `montant` decimal(10,2) NOT NULL CHECK (`montant` >= 0),
  `date_paiement` date NOT NULL,
  `mode_paiement` varchar(50) NOT NULL CHECK (`mode_paiement` in ('Carte de crédit','PayPal','Virement bancaire')),
  `etat_paiement` varchar(50) NOT NULL CHECK (`etat_paiement` in ('Accepté','Refusé','En attente'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `réservations`
--

CREATE TABLE `réservations` (
  `id` int(11) NOT NULL,
  `id_utilisateur` int(11) NOT NULL,
  `id_cours` int(11) NOT NULL,
  `etat_reservation` varchar(50) NOT NULL CHECK (`etat_reservation` in ('Confirmé','Annulé','En attente'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `utilisateurs`
--

CREATE TABLE `utilisateurs` (
  `id` int(11) NOT NULL,
  `firstname` varchar(50) NOT NULL,
  `lastname` varchar(50) NOT NULL,
  `pseudo` varchar(20) NOT NULL,
  `mail` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL
) ;

--
-- Déchargement des données de la table `utilisateurs`
--

INSERT INTO `utilisateurs` (`id`, `firstname`, `lastname`, `pseudo`, `mail`, `password`) VALUES
(1, 'Pierre', 'Blanc', 'user1', 'pierreblanc@example.com', 'd2db083779b967ee366fc993926d7aee'),
(2, 'Julien', 'Dubois', 'user2', 'juliendubois@example.com', '4306b884c15c1a32b8b8244287d3942b'),
(3, 'Lucie', 'Girard', 'user3', 'luciegirard@example.com', '1e859fb8d063265975ab136fbf50dfa2'),
(4, 'Claire', 'Lefèvre', 'user4', 'clairelefèvre@example.com', '265b2dbea40cfd8ddb23855ad7ee874e'),
(5, 'Pierre', 'Rousseau', 'user5', 'pierrerousseau@example.com', '2333c07316d60d326ab4855b733f72a5'),
(6, 'Anne', 'Dupont', 'user6', 'annedupont@example.com', '14ccbcd1ef5f1d015fab329da33d5849'),
(7, 'Julien', 'Martin', 'user7', 'julienmartin@example.com', '603acf81c980431eb6cf3605e989f4e5'),
(8, 'Sophie', 'Dupont', 'user8', 'sophiedupont@example.com', 'e3984558f7fc33030c1ed3a54c0ed8b2'),
(9, 'Sophie', 'Lefèvre', 'user9', 'sophielefèvre@example.com', '452bd4d817c23c8ab923a5e22ee635e2'),
(10, 'Marie', 'Leclerc', 'user10', 'marieleclerc@example.com', '43491dc127d54918f3705cc4224ad5ca');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `cours`
--
ALTER TABLE `cours`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `paiements`
--
ALTER TABLE `paiements`
  ADD PRIMARY KEY (`id`),
  ADD KEY `paiements_fk_utilisateur` (`id_utilisateur`);

--
-- Index pour la table `réservations`
--
ALTER TABLE `réservations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `réservations_fk_utilisateur` (`id_utilisateur`),
  ADD KEY `réservations_fk_cours` (`id_cours`);

--
-- Index pour la table `utilisateurs`
--
ALTER TABLE `utilisateurs`
  ADD PRIMARY KEY (`id`,`pseudo`),
  ADD UNIQUE KEY `mail` (`mail`),
  ADD UNIQUE KEY `utilisateurs_pseudo_unique` (`pseudo`),
  ADD UNIQUE KEY `utilisateurs_mail_unique` (`mail`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `cours`
--
ALTER TABLE `cours`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `paiements`
--
ALTER TABLE `paiements`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `réservations`
--
ALTER TABLE `réservations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `utilisateurs`
--
ALTER TABLE `utilisateurs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `paiements`
--
ALTER TABLE `paiements`
  ADD CONSTRAINT `paiements_fk_utilisateur` FOREIGN KEY (`id_utilisateur`) REFERENCES `utilisateurs` (`id`);

--
-- Contraintes pour la table `réservations`
--
ALTER TABLE `réservations`
  ADD CONSTRAINT `réservations_fk_cours` FOREIGN KEY (`id_cours`) REFERENCES `cours` (`id`),
  ADD CONSTRAINT `réservations_fk_utilisateur` FOREIGN KEY (`id_utilisateur`) REFERENCES `utilisateurs` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
