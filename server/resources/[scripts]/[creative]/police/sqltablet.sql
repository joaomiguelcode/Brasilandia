-- --------------------------------------------------------
-- Servidor:                     127.0.0.1
-- Versão do servidor:           10.4.28-MariaDB - mariadb.org binary distribution
-- OS do Servidor:               Win64
-- HeidiSQL Versão:              12.5.0.6677
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Copiando estrutura do banco de dados para invokerework
CREATE DATABASE IF NOT EXISTS `invokev8` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `invokev8`;

-- Copiando estrutura para tabela invokerework.port
CREATE TABLE IF NOT EXISTS `port` (
  `portId` int(11) NOT NULL AUTO_INCREMENT,
  `identity` longtext DEFAULT NULL,
  `user_id` text DEFAULT NULL,
  `portType` longtext DEFAULT NULL,
  `serial` longtext DEFAULT NULL,
  `nidentity` longtext DEFAULT NULL,
  `exam` longtext DEFAULT NULL,
  `date` text DEFAULT NULL,
  PRIMARY KEY (`portId`),
  KEY `portId` (`portId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Copiando dados para a tabela invokerework.port: ~0 rows (aproximadamente)
INSERT INTO `port` (`portId`, `identity`, `user_id`, `portType`, `serial`, `nidentity`, `exam`, `date`) VALUES
	(3, 'Invoke Solution', '1', 'Pistol', 'XXX-XX1', 'Invoke Solution', 'sdfgsdfghhjfghjghj', '19/09/2023 ás 20:12');

-- Copiando estrutura para tabela invokerework.prison
CREATE TABLE IF NOT EXISTS `prison` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `police` varchar(255) DEFAULT '0',
  `nuser_id` int(11) NOT NULL DEFAULT 0,
  `services` int(11) NOT NULL DEFAULT 0,
  `fines` int(20) NOT NULL DEFAULT 0,
  `text` longtext DEFAULT NULL,
  `date` text DEFAULT NULL,
  `cops` varchar(50) DEFAULT NULL,
  `association` varchar(50) DEFAULT NULL,
  `residual` varchar(50) DEFAULT NULL,
  `url` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Copiando dados para a tabela invokerework.prison: ~2 rows (aproximadamente)
INSERT INTO `prison` (`id`, `police`, `nuser_id`, `services`, `fines`, `text`, `date`, `cops`, `association`, `residual`, `url`) VALUES
	(7, 'Invoke Solution', 1, 95, 16000, '<p>EASDASDASDASD</p><p data-criminal="true">USO INDEVIDO DA FARDA POLICIAL, ABANDONO DE VEÍCULO, DANO AO PATRIMÔNIO, DIREÇÃO COM VEÍCULO DANIFICADO,</p>', '15/08/2023 ás 14:30', NULL, NULL, NULL, NULL),
	(8, 'Invoke Solution', 1, 2, 22, '<p>SDASDASDASD</p>', '15/08/2023 ás 14:32', NULL, NULL, NULL, NULL),
	(9, 'Invoke Solution', 1, 1, 0, '<p>sdfgsdfgsdfgsdfgsdfg</p>', '25/08/2023 ás 00:08', NULL, NULL, NULL, NULL),
	(10, 'Invoke Solution', 1, 1, 0, '<p>SDFASDFASDF</p>', '28/08/2023 ás 14:26', NULL, NULL, NULL, NULL);

-- Copiando estrutura para tabela invokerework.reports
CREATE TABLE IF NOT EXISTS `reports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `victim_id` text DEFAULT NULL,
  `police_name` text DEFAULT NULL,
  `solved` text DEFAULT NULL,
  `victim_name` text DEFAULT NULL,
  `created_at` text DEFAULT NULL,
  `victim_report` text DEFAULT NULL,
  `updated_at` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `portId` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Copiando dados para a tabela invokerework.reports: ~1 rows (aproximadamente)
INSERT INTO `reports` (`id`, `victim_id`, `police_name`, `solved`, `victim_name`, `created_at`, `victim_report`, `updated_at`) VALUES
	(5, '1', 'Invoke Solution', '0', 'asdfsadf', '19/09/2023 ás 20:11', '<p>asdfgfghfghfgh</p>', '19/09/2023 ás 20:11'),
	(6, '22', 'Invoke Solution', '0', '1', '21/10/2023 ás 22:17', '<p>asdasda</p>', '21/10/2023 ás 22:18');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
