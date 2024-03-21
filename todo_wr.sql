-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3307
-- Generation Time: Feb 20, 2023 at 06:09 PM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `todo_wr`
--

CREATE DATABASE IF NOT EXISTS `todo_wr` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `todo_wr`;

DELIMITER $$
--
-- Procedures
--

DROP PROCEDURE IF EXISTS `Add_List_Items`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Add_List_Items` (IN `add_to_list` VARCHAR(256), IN `to_list` INT(16))   BEGIN

INSERT INTO `List Item` (`text`, `list_idx`, `created`)
VALUES (add_to_list, to_list, CURRENT_DATE()); 

END$$

DROP PROCEDURE IF EXISTS `Check_Items`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Check_Items` (IN `item_in` VARCHAR(256))   BEGIN

UPDATE `List Item`
SET `text` = item_in, `checked` = 1
WHERE `text` = `item_in`;

END$$

DROP PROCEDURE IF EXISTS `Uncheck_Items`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Uncheck_Items` (IN `item_in` VARCHAR(256))   BEGIN

UPDATE `List Item`
SET `text` = item_in, `checked` = 0
WHERE `text` = `item_in`;

END$$

DROP PROCEDURE IF EXISTS `Create_List`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Create_List` (IN `new_list` VARCHAR(32))   BEGIN

INSERT INTO `list` (`name`, `created`)
VALUES (new_list,  CURRENT_DATE());

END$$

DROP PROCEDURE IF EXISTS `Delete_List`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Delete_List` (IN `list_in` VARCHAR(32))   BEGIN

DELETE FROM `List` 
WHERE name = list_in;

END$$

DROP PROCEDURE IF EXISTS `Remove_List_Items`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Remove_List_Items` (IN `description` VARCHAR(256))   BEGIN

DELETE FROM `List Item` WHERE text = description;

END$$

DROP PROCEDURE IF EXISTS `Rename_List`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Rename_List` (IN `list_in` VARCHAR(32), IN `new_name` VARCHAR(32))   BEGIN

UPDATE `List`
SET `name` = new_name
WHERE `name` = list_in;

END$$

DROP PROCEDURE IF EXISTS `View_List`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `View_List` (IN `in_list` VARCHAR(256))   BEGIN

SELECT * FROM `List Item` WHERE list_idx = in_list;

END$$

DROP PROCEDURE IF EXISTS `View_summaries_of_all_Lists`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `View_summaries_of_all_Lists` ()   BEGIN

SELECT name FROM `List`;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `list`
--

DROP TABLE IF EXISTS `list`;
CREATE TABLE `list` (
  `idx` int(16) NOT NULL,
  `name` varchar(32) NOT NULL,
  `created` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `list`
--

INSERT INTO `list` (`idx`, `name`, `created`) VALUES
(1, 'final project', '2024-04-18');

-- --------------------------------------------------------

--
-- Table structure for table `list item`
--

DROP TABLE IF EXISTS `list item`;
CREATE TABLE `list item` (
  `idx` int(16) NOT NULL,
  `text` varchar(256) NOT NULL,
  `checked` tinyint(1) NOT NULL,
  `list_idx` int(16) NOT NULL,
  `created` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `list item`
--

INSERT INTO `list item` (`idx`, `text`, `checked`, `list_idx`, `created`) VALUES
(1, 'View summaries of all lists', 0, 1, '2024-02-28'),
(10, 'View a List', 1, 1, '2024-02-28'),
(11, 'Create a List', 1, 1, '2024-02-28'),
(12, 'Add/Remove List Items', 1, 1, '2024-02-28'),
(13, 'Check/Uncheck List Items', 1, 1, '2024-02-28'),
(14, 'Rename a List', 1, 1, '2024-02-28'),
(31, 'Delete a List', 1, 1, '2024-02-28'),
(32, 'Sort List Summaries', 0, 1, '2024-02-28');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `list`
--
ALTER TABLE `list`
  ADD PRIMARY KEY (`idx`);

--
-- Indexes for table `list item`
--
ALTER TABLE `list item`
  ADD PRIMARY KEY (`idx`),
  ADD KEY `fk_list_idx` (`list_idx`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `list`
--
ALTER TABLE `list`
  MODIFY `idx` int(16) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `list item`
--
ALTER TABLE `list item`
  MODIFY `idx` int(16) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- Constraints for table `list item`
--
ALTER TABLE `list item`
  ADD CONSTRAINT `fk_list_idx` FOREIGN KEY (`list_idx`) REFERENCES `list` (`idx`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
