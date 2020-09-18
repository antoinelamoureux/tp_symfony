-- phpMyAdmin SQL Dump
-- version 4.9.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:8889
-- Generation Time: Sep 18, 2020 at 10:41 AM
-- Server version: 5.7.26
-- PHP Version: 7.4.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Database: `tp_symfony`
--

-- --------------------------------------------------------

--
-- Table structure for table `comment`
--

CREATE TABLE `comment` (
  `id` int(11) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `user_id_id` int(11) DEFAULT NULL,
  `comment_text` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `comment`
--

INSERT INTO `comment` (`id`, `product_id`, `user_id_id`, `comment_text`, `created_at`) VALUES
(1, 2, 1, 'Super produit!', NULL),
(2, 2, 1, 'tgtgtgtgtg', NULL),
(3, 2, 1, 'Livraison rapide et fiable', NULL),
(4, 3, 1, 'Trop cher!', NULL),
(5, 7, 1, 'Buy an Audi instead!', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `id` int(11) NOT NULL,
  `name` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `category` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`id`, `name`, `category`, `description`, `image`, `price`, `user_id`, `updated_at`) VALUES
(2, 'Playstation', 'Games', 'Playstation 4 (mint condition)', 'ps4-overview-screen-03-eu-06sep16.jpeg', 300, NULL, '2020-09-17 22:14:01'),
(3, 'Iphone', 'Phone', 'Iphone 11 Pro Max (Good condition)', 'c062f2a9-apple-iphone-11-pro-max-un-minimum-d-effort-pour-rester-au-top__w1280.jpeg', 1599, NULL, '2020-09-18 09:45:21'),
(4, 'ASUS Chromebook C423', 'Computers', 'Great computer', 'téléchargement.jpeg', 599, NULL, '2020-09-18 09:50:05'),
(5, 'Nintendo Switch', 'Games', 'New gaming console from Nintendo', 'shopping.png', 299, NULL, '2020-09-18 10:08:00'),
(6, 'Imac', 'Computers', 'Processeur Intel Core i5 hexacœur de 10ᵉ génération à 3,1 GHz', 'imac.png', 1999, NULL, '2020-09-18 10:23:20'),
(7, 'Mercedes Class C', 'Cars', '4 cylindres en ligne de 1,5 L, diesel 4 cylindres en ligne de 2,0 L.', 'mercedes1.jpeg', 54150, NULL, '2020-09-18 10:26:09'),
(8, 'Apple Watch Serie 5', 'Watches', '38 mm - Aluminium Gris sidéral - Bracelet Sport Noir.', 'applewatch5.png', 299, NULL, '2020-09-18 10:39:16'),
(9, 'Rolex Daytona', 'Watches', 'La Rolex Daytona, nommé d’après le circuit de course en Floride qui héberge la course de vingt-quatre heures de Rolex, incarne la finale montre du pilote.', 'rolex1.jpeg', 25480, NULL, '2020-09-18 10:40:49');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `email` varchar(180) COLLATE utf8mb4_unicode_ci NOT NULL,
  `roles` json NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `first_name` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `email`, `roles`, `password`, `name`, `first_name`) VALUES
(1, 'toto@toto.fr', '[]', '$2y$13$RvIhaxz8LSa8Y2e5erKRkOdLBUL5MgzHOkJJjisb6tn.5ySdohjv2', 'tata', 'toto');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `comment`
--
ALTER TABLE `comment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_9474526C9D86650F` (`user_id_id`),
  ADD KEY `IDX_9474526C4584665A` (`product_id`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_D34A04ADA76ED395` (`user_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_8D93D649E7927C74` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `comment`
--
ALTER TABLE `comment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `comment`
--
ALTER TABLE `comment`
  ADD CONSTRAINT `FK_9474526C4584665A` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  ADD CONSTRAINT `FK_9474526C9D86650F` FOREIGN KEY (`user_id_id`) REFERENCES `user` (`id`);

--
-- Constraints for table `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `FK_D34A04ADA76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);
