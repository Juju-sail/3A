-- phpMyAdmin SQL Dump
-- version 4.2.7.1
-- http://www.phpmyadmin.net
--
-- Client :  localhost
-- Généré le :  Mer 06 Janvier 2021 à 21:51
-- Version du serveur :  5.6.20-log
-- Version de PHP :  5.4.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de données :  `projet_mbd`
--

-- --------------------------------------------------------

--
-- Structure de la table `acteurs`
--

CREATE TABLE IF NOT EXISTS `acteurs` (
`id_acteur` int(11) NOT NULL,
  `nom` varchar(20) COLLATE utf8_bin NOT NULL,
  `prenom` varchar(20) COLLATE utf8_bin NOT NULL,
  `date_birth` varchar(10) COLLATE utf8_bin DEFAULT NULL
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=30 ;

--
-- Contenu de la table `acteurs`
--

INSERT INTO `acteurs` (`id_acteur`, `nom`, `prenom`, `date_birth`) VALUES
(3, 'Paltrow', 'Gwyneth', '1972-09-27'),
(1, 'Downey', 'Robert', '1965-04-04'),
(4, 'Howard', 'Terrence', '1969-03-11'),
(5, 'Bridges', 'Jeff', '1949-12-04'),
(6, 'Gregg', 'Clark', '1962-04-02'),
(7, 'Jackson', 'Samuel', '1948-12-21'),
(8, 'Hanks', 'Tom', '1956-07-09'),
(9, 'Wright', 'Robin', '1966-04-08'),
(10, 'Sinise', 'Gary', '1955-03-17'),
(11, 'Williamson', 'Mykelti', '1957-03-04'),
(12, 'Field', 'Sally', '1946-11-06'),
(13, 'Humphreys', 'Michael', '1985-03-01'),
(14, 'Aniston', 'Jennifer', '1969-02-11'),
(15, 'Cox', 'Courteney', '1964-06-15'),
(16, 'LeBlanc', 'Matt', '1967-07-25'),
(17, 'Kudrow', 'Lisa', '1963-07-30'),
(18, 'Perry', 'Matthew', '1969-08-19'),
(19, 'Schwimmer', 'David', '1966-11-02'),
(20, 'Schilling', 'Taylor', '1984-07-27'),
(21, 'Mulgrew', 'Kate', '1955-04-29'),
(22, 'Prepon', 'Laura', '1980-03-07'),
(23, 'Lyonne', 'Natasha', '1979-04-04'),
(24, 'Aduba', 'Uzo', '1981-02-10'),
(25, 'Brooks', 'Danielle', '1989-09-17'),
(26, 'Manning', 'Taryn', '1978-11-06'),
(27, 'Leyva', 'Selenis', '1972-05-26'),
(28, 'Moore', 'Adrienne', '1980-08-14'),
(29, 'Polanco', 'Dascha', '1982-12-03');

-- --------------------------------------------------------

--
-- Structure de la table `films`
--

CREATE TABLE IF NOT EXISTS `films` (
`id_film` int(11) NOT NULL,
  `titre` varchar(40) COLLATE utf8_bin NOT NULL,
  `date_sortie` int(11) NOT NULL,
  `resume` text COLLATE utf8_bin NOT NULL
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=19 ;

--
-- Contenu de la table `films`
--

INSERT INTO `films` (`id_film`, `titre`, `date_sortie`, `resume`) VALUES
(1, 'Iron Man', 2008, 'Film racontant les origines et debut du personnage d''Iron Man. Le film est issu du comics publié par Marvel.'),
(2, 'Forest Gump', 1994, 'Quelques décennies d''histoire américaine, des années 1940 à la fin du XXème siècle, à travers le regard et l''étrange odyssée d''un homme simple et pur, Forrest Gump.'),
(18, 'Titanic', 1997, 'Elle raconte l''histoire de deux jeunes passagers du paquebot Titanic en avril 1912. L''un, Rose, est une passagère de première classe qui tente de se suicider pour se libérer des contraintes imposées par son entourage, et le second, Jack, est un vagabond embarqué à la dernière minute en troisième classe pour retourner aux États-Unis. Ils se rencontrent par hasard lors de la tentative de suicide de Rose et vivent une histoire d''amour vite troublée par le naufrage du navire. '),
(11, 'La belle et la bete', 2017, 'À la fin du XVIIIe siècle, dans un château proche d''un petit village français, vivait un jeune prince capricieux, égoïste et insensible. Pour avoir refusé d''abriter une fée déguisée en vieille mendiante, il est condamné à vivre sous l''apparence d''une bête monstrueuse jusqu''à ce qu''il puisse aimer une femme et s''en faire aimer en retour, ce qui le délivrerait du sortilège qui a frappé son château et ses habitants. Mais les années passent et la Bête perd peu à peu tout espoir de rompre un jour la malédiction.  Au village vit une jeune fille, rêveuse et romantique, nommée Belle. Courtisée par Gaston, un arrogant chasseur, qu''elle considère comme grossier et vaniteux, elle aide son père, Maurice, un inventeur fantasque qui se perd dans la forêt et se réfugie dans le château de la Bête. Belle part à sa recherche et conclut un pacte avec la Bête, la vie de son père contre la sienne. Prisonnière à son tour, elle découvre un monde magique et découvre peu à peu la Bête sous un autre jour.');

-- --------------------------------------------------------

--
-- Structure de la table `role`
--

CREATE TABLE IF NOT EXISTS `role` (
`id_role` int(11) NOT NULL,
  `id_acteur` int(11) NOT NULL,
  `role` varchar(20) COLLATE utf8_bin NOT NULL
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=29 ;

--
-- Contenu de la table `role`
--

INSERT INTO `role` (`id_role`, `id_acteur`, `role`) VALUES
(1, 1, 'Tony Stark'),
(2, 15, 'Monica Geller'),
(3, 3, 'Pepper Potts'),
(4, 4, 'War Machine'),
(5, 5, 'Obadiah Stane'),
(6, 6, 'Phil Coulson'),
(7, 7, 'Nick Fury'),
(8, 8, 'Forrest Gump'),
(9, 9, 'Jennifer Curran'),
(10, 10, 'lt Dan Taylor'),
(11, 11, 'Bubba'),
(12, 12, 'Mme Gump'),
(13, 13, 'Forrest Gump enfant'),
(14, 14, 'Rachel Green'),
(15, 16, 'Joey Tribbiani'),
(16, 17, 'Phoebe Buffay'),
(17, 18, 'Chandler Bing'),
(18, 19, 'Ross Geller'),
(19, 20, 'Piper Chapman'),
(20, 21, 'Red'),
(21, 22, 'Alex Vause'),
(22, 23, 'Gloria Mendoza'),
(23, 24, 'Suzanne'),
(24, 25, 'Taystee'),
(25, 26, 'Pennsatucky'),
(26, 27, 'Nicky Nichols '),
(27, 28, 'Black Cindy'),
(28, 29, 'Daya');

-- --------------------------------------------------------

--
-- Structure de la table `role_film`
--

CREATE TABLE IF NOT EXISTS `role_film` (
  `id_role` int(11) NOT NULL,
  `id_film` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Contenu de la table `role_film`
--

INSERT INTO `role_film` (`id_role`, `id_film`) VALUES
(1, 1),
(3, 1),
(4, 1),
(5, 1),
(6, 1),
(7, 1),
(8, 2),
(9, 2),
(10, 2),
(11, 2),
(12, 2);

-- --------------------------------------------------------

--
-- Structure de la table `role_serie`
--

CREATE TABLE IF NOT EXISTS `role_serie` (
  `id_role` int(11) NOT NULL,
  `id_serie` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Contenu de la table `role_serie`
--

INSERT INTO `role_serie` (`id_role`, `id_serie`) VALUES
(2, 1),
(14, 1),
(15, 1),
(16, 1),
(17, 1),
(18, 1),
(19, 2),
(20, 2),
(21, 2),
(22, 2),
(23, 2),
(24, 2),
(25, 2),
(26, 2),
(27, 2),
(28, 2);

-- --------------------------------------------------------

--
-- Structure de la table `series`
--

CREATE TABLE IF NOT EXISTS `series` (
`id_serie` int(11) NOT NULL,
  `titre` varchar(40) COLLATE utf8_bin NOT NULL,
  `nb_saisons` int(11) NOT NULL,
  `nb_episodes` int(11) NOT NULL,
  `resume` text COLLATE utf8_bin NOT NULL
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=5 ;

--
-- Contenu de la table `series`
--

INSERT INTO `series` (`id_serie`, `titre`, `nb_saisons`, `nb_episodes`, `resume`) VALUES
(1, 'Friends', 10, 236, 'Monica Geller, une jeune cuisinière d''environ 25 ans, vit dans un appartement situé à Manhattan, dans Greenwich Village. Un jour, son amie d''enfance, Rachel Green, qu''elle n''avait plus vue depuis des années, lui rend visite après avoir quitté son fiancé à l''autel le jour de leur mariage. Rachel devient alors la nouvelle colocataire de Monica et s’intègre sans problème à son groupe d''amis, composé de Phoebe Buffay (l''ancienne colocataire de Monica), Ross Geller (le frère de Monica, qui est secrètement amoureux de Rachel depuis le lycée), Chandler Bing (qui est le meilleur ami de Ross depuis l''université) et Joey Tribbiani (le colocataire actuel de Chandler). Ces deux derniers vivent dans l''appartement juste en face de celui de Monica, sur le même palier.\r\n\r\nLa série raconte la vie quotidienne de ces six amis, ainsi que l''évolution de leur vie professionnelle et affective pendant dix ans. '),
(2, 'Orange is the new black', 7, 91, 'Piper Chapman est incarcérée à Litchfield, une prison de sécurité minimale pour quinze mois car elle a transporté une valise d''argent issue du trafic de drogue, dix ans plus tôt, pour son amante d''alors, Alex Vause. Elle tente de se faire à la vie en prison, entre le clanisme, les réseaux et les fortes personnalités des autres détenues.'),
(4, 'The queen gambit', 1, 7, 'Cette fiction suit Elisabeth Harmon, une prodige des échecs orpheline, de huit à vingt-deux ans, dans sa quête pour devenir la meilleure joueuse d''échecs du monde, tout en luttant contre des problèmes émotionnels et une dépendance aux drogues et à l''alcool. L''histoire commence au milieu des années 1950 et se poursuit dans les années 1960');

--
-- Index pour les tables exportées
--

--
-- Index pour la table `acteurs`
--
ALTER TABLE `acteurs`
 ADD PRIMARY KEY (`id_acteur`);

--
-- Index pour la table `films`
--
ALTER TABLE `films`
 ADD PRIMARY KEY (`id_film`);

--
-- Index pour la table `role`
--
ALTER TABLE `role`
 ADD PRIMARY KEY (`id_role`);

--
-- Index pour la table `role_film`
--
ALTER TABLE `role_film`
 ADD PRIMARY KEY (`id_role`);

--
-- Index pour la table `role_serie`
--
ALTER TABLE `role_serie`
 ADD PRIMARY KEY (`id_role`);

--
-- Index pour la table `series`
--
ALTER TABLE `series`
 ADD PRIMARY KEY (`id_serie`);

--
-- AUTO_INCREMENT pour les tables exportées
--

--
-- AUTO_INCREMENT pour la table `acteurs`
--
ALTER TABLE `acteurs`
MODIFY `id_acteur` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=30;
--
-- AUTO_INCREMENT pour la table `films`
--
ALTER TABLE `films`
MODIFY `id_film` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=19;
--
-- AUTO_INCREMENT pour la table `role`
--
ALTER TABLE `role`
MODIFY `id_role` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=29;
--
-- AUTO_INCREMENT pour la table `series`
--
ALTER TABLE `series`
MODIFY `id_serie` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
