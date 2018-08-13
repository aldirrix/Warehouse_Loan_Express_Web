-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         5.6.34-log - MySQL Community Server (GPL)
-- SO del servidor:              Win32
-- HeidiSQL Versión:             9.5.0.5282
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Volcando estructura de base de datos para warehouse
DROP DATABASE IF EXISTS `warehouse`;
CREATE DATABASE IF NOT EXISTS `warehouse` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_bin */;
USE `warehouse`;

-- Volcando estructura para tabla warehouse.carreer
DROP TABLE IF EXISTS `carreer`;
CREATE TABLE IF NOT EXISTS `carreer` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(200) COLLATE utf8mb4_bin NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Volcando datos para la tabla warehouse.carreer: ~9 rows (aproximadamente)
/*!40000 ALTER TABLE `carreer` DISABLE KEYS */;
INSERT INTO `carreer` (`id`, `name`) VALUES
	(1, 'Mecatrónica'),
	(2, 'Mecánica Eléctrica'),
	(3, 'Arquitectura'),
	(4, 'Sistemas Automotrices'),
	(6, 'Diseño Industrial'),
	(7, 'Civil'),
	(8, 'Diseño de interiores y paisajismo'),
	(9, 'Electrónica Biomédica'),
	(10, 'Diseño Gráfico');
/*!40000 ALTER TABLE `carreer` ENABLE KEYS */;

-- Volcando estructura para tabla warehouse.category
DROP TABLE IF EXISTS `category`;
CREATE TABLE IF NOT EXISTS `category` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(200) COLLATE utf8mb4_bin NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Volcando datos para la tabla warehouse.category: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
/*!40000 ALTER TABLE `category` ENABLE KEYS */;

-- Volcando estructura para tabla warehouse.department
DROP TABLE IF EXISTS `department`;
CREATE TABLE IF NOT EXISTS `department` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(200) COLLATE utf8mb4_bin NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Volcando datos para la tabla warehouse.department: ~4 rows (aproximadamente)
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
INSERT INTO `department` (`id`, `name`) VALUES
	(1, 'Carpintería'),
	(2, 'Soldadura'),
	(3, 'Máquinas'),
	(4, 'Herramientas Manuales');
/*!40000 ALTER TABLE `department` ENABLE KEYS */;

-- Volcando estructura para tabla warehouse.item
DROP TABLE IF EXISTS `item`;
CREATE TABLE IF NOT EXISTS `item` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(200) COLLATE utf8mb4_bin NOT NULL,
  `quantity` int(11) unsigned NOT NULL,
  `inventoryID` varchar(200) COLLATE utf8mb4_bin DEFAULT NULL,
  `departmentID` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `departmentIDFK` (`departmentID`),
  CONSTRAINT `departmentIDFK` FOREIGN KEY (`departmentID`) REFERENCES `department` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=215 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Volcando datos para la tabla warehouse.item: ~214 rows (aproximadamente)
/*!40000 ALTER TABLE `item` DISABLE KEYS */;
INSERT INTO `item` (`id`, `name`, `quantity`, `inventoryID`, `departmentID`) VALUES
	(1, 'GARLOPAS', 3, NULL, 1),
	(2, 'CEPILLO NUMERO 5', 1, NULL, 1),
	(3, 'CEPILLO NUMERO 4', 1, NULL, 1),
	(4, 'SERRUCHOS DE COSTILLA LARGA', 3, NULL, 1),
	(5, 'SERRUCHOS DE COSTILLA', 3, NULL, 1),
	(6, 'SERROTES', 2, NULL, 1),
	(7, 'ESCUADRA CON TOPE DE 10"', 1, NULL, 1),
	(8, 'ESCUADRA CON TOPE DE 6"', 1, NULL, 1),
	(9, 'ESCOFINAS', 8, NULL, 1),
	(10, 'LIJADORA DE MEDIO PLIEGO 4X9" BLACK DECKER', 1, NULL, 1),
	(11, 'ROUTER SKILL', 2, NULL, 1),
	(12, 'ROUTER 5/8 BLACK DECKER', 1, NULL, 1),
	(13, 'BIRBIQUIN', 4, NULL, 1),
	(14, 'FORMONES', 11, NULL, 1),
	(15, 'JUEGOS DE GURBIAS DE 5 PIEZAS C/1', 2, NULL, 1),
	(16, 'MARTILLOS DE CARPINTERIA', 2, NULL, 1),
	(17, 'FLEXOMETROS', 4, NULL, 1),
	(18, 'ROUTER DEWALT', 1, NULL, 1),
	(19, 'PLANTILLA PARA MONTAJE COLA DE MILANO DE 1/4 Y !/2" DE 5/8', 1, NULL, 1),
	(20, 'SIERRA CINTA C/MOTOR 3/4 HP 110 VOLTS', 1, '31121', 1),
	(21, 'SIERRA CINTA C/MOTOR 1.5 HP 220 VOLTS', 1, '31185', 1),
	(22, 'SIERRA CINTA C/MOTOR 1 HP 110 VOLTS', 1, '87065', 1),
	(23, 'SIERRRA DE BANCO DE DISCO10" 120 VOLTS DELTA', 1, '65200', 1),
	(24, 'SIERRA DE GRUA DISCO 16", 5 HP 220 VOLTS DEWALT', 1, '85252', 1),
	(25, 'SIERRA DE GRUA DISCO 10" CRAFTMAN', 1, '5097', 1),
	(26, 'TORNO PARA MADERA C/MOTOR 1 HP', 1, '111127', 1),
	(27, 'TORNO PARA MADERA MOTOR 1/2 HO 110 VOLTS', 1, '23130', 1),
	(28, 'LIJADIRA DE DISCO CORREA DE 6" Y DISCO DE 9"', 1, '65201', 1),
	(29, 'TROMPO DE BANCO MOTOR 3 HP 220 VOLTS', 1, '88414', 1),
	(30, 'TALADRO DE BANCO MOTOR 1/2" HP 110 VOLTS', 1, '31148', 1),
	(31, 'BANCO P/ROUTER C/ROUTER 3 HP BLACK DECKER', 1, '44001', 1),
	(32, 'LIJADORA DE DISCO C/MOTOR 1/4 HP 110 VOLTS', 1, '30311', 1),
	(33, 'PINTARRON', 1, '87416', 1),
	(34, 'MAQUINA ELECTRODO REVESTIDO ECONOTIG', 1, NULL, 2),
	(35, 'CILINDRO ARGON 1.5M3', 1, '2776', 2),
	(36, 'CILINDRO ARGON 9 M3', 1, NULL, 2),
	(37, 'RECTIFICADOR MILLER', 1, '31338', 2),
	(38, 'GENERADOR LINCON', 1, '5040-A', 2),
	(39, 'GENERADOR LINCON', 1, '5039-A', 2),
	(40, 'TRANSFORMADOR LINCON', 1, '5055-A', 2),
	(41, 'TRANSFORMADOR INFRA', 1, '42396', 2),
	(42, 'ESMERIL DE BANCO', 1, '85208', 2),
	(43, 'TALADRO DE BANCO DE 5/8"', 1, '31335', 2),
	(44, 'GUILLOTINA MANUAL CHICA', 1, '85221', 2),
	(45, 'PUNTEADORA', 1, '85209', 2),
	(46, 'EQUIPO DE OXIACETILENO', 2, NULL, 2),
	(47, 'GUILLOTINA GRANDE', 1, '85202', 2),
	(48, 'DOBLADORA GRANDE', 1, '85201', 2),
	(49, 'EQUIPOS DE PROTECCION PERSONAL ', 10, NULL, 2),
	(50, 'SOPLETES DE CORTE SMITHS', 2, NULL, 2),
	(51, 'BOQUILLAS 209 SMITHS', 2, NULL, 2),
	(52, 'BOQUILLAS 207 SMITHS', 2, NULL, 2),
	(53, 'BOQUILLAS 205 SMITHS', 2, NULL, 2),
	(54, 'BOQUILLAS 203 SMITHS', 2, NULL, 2),
	(55, 'ANTORCHA', 1, NULL, 2),
	(56, 'MANERALES MEZCLADORES', 2, NULL, 2),
	(57, 'ENCENDEDORES DE CAZUELA', 10, NULL, 2),
	(58, 'CEPILLOS DE ALAMBRE', 5, NULL, 2),
	(59, 'MARTILLOS ESCOREADORES', 2, NULL, 2),
	(60, 'PINZAS DE PRESION', 5, NULL, 2),
	(61, 'ARCOS DE SEGUETA', 2, NULL, 2),
	(62, 'CARETAS', 2, NULL, 2),
	(63, 'PARES DE MANGAS', 2, NULL, 2),
	(64, 'PINZAS MECANICAS', 2, NULL, 2),
	(65, 'GAFAS', 6, NULL, 2),
	(66, 'ESCUADRA UNIVERSAL', 1, NULL, 2),
	(67, 'ESCUADRA 12" CON TOPE', 1, NULL, 2),
	(68, 'TORNO SOUTH BEND', 1, '85137', 3),
	(69, 'TORNO SOUTH BEND', 1, '85138', 3),
	(70, 'TORNO SOUTH BEND', 1, '85139', 3),
	(71, 'TORNO SOUTH BEND', 1, '85140', 3),
	(72, 'TORNO SOUTH BEND', 1, '85141', 3),
	(73, 'TORNO JOIN VILLE', 1, '85167', 3),
	(74, 'TORNO CHIN HUNG', 1, '85145', 3),
	(75, 'TORNO BMT 13400', 1, '85144', 3),
	(76, 'TORNO NARDINI 350', 1, NULL, 3),
	(77, 'TORNO YUE-JIM', 1, '85142', 3),
	(78, 'CEPILLO ROCCO 450', 1, '85171', 3),
	(79, 'CEPILLO SANCHES BLANES', 1, '85172', 3),
	(80, 'FRESADFORA MYGY', 1, '85170', 3),
	(81, 'FRESADORA CEA M-66', 1, '85173', 3),
	(82, 'FRESADORA PAO FONG', 1, 'PA31074000006', 3),
	(83, 'RECTIFICADORA CHEVALIER END-MILL', 1, '3136', 3),
	(84, 'TROQUELADORA', 1, '85166', 3),
	(85, 'TALADRO YADOYA', 1, '85165', 3),
	(86, 'TALADRO VIMALERT', 1, NULL, 3),
	(87, 'TALADRO GACELA', 1, '5412-A', 3),
	(88, 'TALADRO NEWTON', 1, '6633-B', 3),
	(89, 'TALADRO EMERSON DRILL PRESS', 1, '110779', 3),
	(90, 'ESMERIL HECORT', 1, NULL, 3),
	(91, 'ESMERIL BLACK DECKER', 1, '85242', 3),
	(92, '2/2	ESMERIL HECORT', 1, '6032-A', 3),
	(93, 'SEGUETA MECANICA', 1, NULL, 3),
	(94, 'SEGUETA CIRCULAR', 1, '3102', 3),
	(95, 'INYECTORA MANUAL', 1, NULL, 3),
	(96, 'MARTILLOS DE GOMA', 2, NULL, 4),
	(97, 'PINZAS ELECTRICISTA', 2, NULL, 4),
	(98, 'PINZAS DE PRESION EN "C"', 6, NULL, 4),
	(99, 'PINZAS DE PRESION ', 4, NULL, 4),
	(100, 'PINZAS DE CORTE', 8, NULL, 4),
	(101, 'PERICAS 8"', 3, NULL, 4),
	(102, 'PERICAS 10"', 3, NULL, 4),
	(103, 'PERICAS 12"', 5, NULL, 4),
	(104, 'PINZAS MECANICAS', 6, NULL, 4),
	(105, 'PINZAS DE PUNTA', 5, NULL, 4),
	(106, 'TIJERAS PARA LAMINA', 4, NULL, 4),
	(107, 'ESCUADRAS 24"', 3, NULL, 4),
	(108, 'JUEGOS LLVES ALLEN STD', 10, NULL, 4),
	(109, 'JUEGOS LLAVES ALLEN MM', 2, NULL, 4),
	(110, 'ESCUADRAS UNIVERSALES', 3, NULL, 4),
	(111, 'JUEGOS DESARMADORES PUNTA DADO ', 2, NULL, 4),
	(112, 'BLOCK EN V', 1, NULL, 4),
	(113, 'TRANSPORTADOR UNIVERSAL', 1, NULL, 4),
	(114, 'TRANSPORTADORES DE LAMINA', 2, NULL, 4),
	(115, 'NIVEL ', 1, NULL, 4),
	(116, 'PORTAMACHUELOS EN T', 2, NULL, 4),
	(117, 'FLEXOMETROS', 5, NULL, 4),
	(118, 'COMPAS DE EXTERIORES', 2, NULL, 4),
	(119, 'COMPAS DE INTERIORES', 1, NULL, 4),
	(120, 'COMPAS DE PUNTA', 2, NULL, 4),
	(121, 'PORTA TARRAJAS', 4, NULL, 4),
	(122, 'PORTAMACHUELOS LINEAL', 3, NULL, 4),
	(123, 'PISTOLA DE AIRE', 1, NULL, 4),
	(124, 'ESCUADRAS 9" CON TOPE', 3, NULL, 4),
	(125, 'ESCUADRAS 10" CON TOPE', 4, NULL, 4),
	(126, 'ESCUADRAS 10"', 3, NULL, 4),
	(127, 'VERNIERS', 17, NULL, 4),
	(128, 'JUEGO DESARMADORES PLANOS (5 PIEZAS)', 1, NULL, 4),
	(129, 'JUEGO DESARMADORES DE CRUZ (5 PIEZAS)', 2, NULL, 4),
	(130, 'PRENSAS "C" 4"', 2, NULL, 4),
	(131, 'PRENSAS "C" 6"', 4, NULL, 4),
	(132, 'PRENSAS "C" 8"', 4, NULL, 4),
	(133, 'REMACHADORAS', 3, NULL, 4),
	(134, 'CALEFATEADORAS', 2, NULL, 4),
	(135, 'ESPATULAS', 2, NULL, 4),
	(136, 'PUNZONES', 7, NULL, 4),
	(137, 'CINCELES', 3, NULL, 4),
	(138, 'JUEGO DE DESARMADORES ( 17 PIEZAS)', 1, NULL, 4),
	(139, 'DESARMADORES PLANOS', 12, NULL, 4),
	(140, 'LLAVES STILSON', 4, NULL, 4),
	(141, 'LENTES DE SEGURIDAD', 12, NULL, 4),
	(142, 'SERRUCHOS DE HOJA', 2, NULL, 4),
	(143, 'SERRUCHOS DE COSTILLA', 2, NULL, 4),
	(144, 'ARCOS DE SEGUETA', 7, NULL, 4),
	(145, 'PRENSAS AJUSTABLES', 3, NULL, 4),
	(146, 'MARTILLOS DE BOLA (MECANICOS)', 5, NULL, 4),
	(147, 'MARILLOS DE CARPINTERO (CHIVA)', 4, NULL, 4),
	(148, 'MARTILLOS DE GOMA', 2, NULL, 4),
	(149, 'CEPILLOS ALAMBRE', 2, NULL, 4),
	(150, 'LLAVE MM 7 MIXTAS', 1, NULL, 4),
	(151, 'LLAVE MM 8 MIXTAS', 1, NULL, 4),
	(152, 'LLAVE MM 9 MIXTAS', 1, NULL, 4),
	(153, 'LLAVE MM 10 MIXTAS', 1, NULL, 4),
	(154, 'LLAVE MM 11 MIXTAS', 1, NULL, 4),
	(155, 'LLAVE MM 12 MIXTAS', 1, NULL, 4),
	(156, 'LLAVE MM 14 MIXTAS', 1, NULL, 4),
	(157, 'LLAVE MM 15 MIXTAS', 1, NULL, 4),
	(158, 'LLAVE MM 16 MIXTAS', 1, NULL, 4),
	(159, 'LLAVE MM 17 MIXTAS', 1, NULL, 4),
	(160, 'LLAVE MM 18 MIXTAS', 1, NULL, 4),
	(161, 'LLAVE MM 19 MIXTAS', 1, NULL, 4),
	(162, 'LLAVE MM 20 MIXTAS', 1, NULL, 4),
	(163, 'LLAVE MM 21 MIXTAS', 1, NULL, 4),
	(164, 'LLAVE ESPAÑOLA 15/16', 1, NULL, 4),
	(165, 'LLAVE ESPAÑOLA 5/8-11/16', 1, NULL, 4),
	(166, 'LLAVE ESPAÑOLA 7/16-1/2', 1, NULL, 4),
	(167, 'LLAVE ESPAÑOLA 3/8-7/16', 1, NULL, 4),
	(168, 'LLAVE ESPAÑOLA 5/16-3/8', 1, NULL, 4),
	(169, 'LLAVE ESPAÑOLA 1/4-5/16', 1, NULL, 4),
	(170, 'LLAVE ESPAÑOLA 3/16-1/4', 1, NULL, 4),
	(171, 'LLAVE ESPAÑOLA 9/16-5/8', 1, NULL, 4),
	(172, 'LLAVE ESPAÑOLA 5/8-3/4', 1, NULL, 4),
	(173, 'LLAVE ESPAÑOLA 11/16- 3/4', 1, NULL, 4),
	(174, 'LLAVE ESPAÑOLA 3/4-13/16', 1, NULL, 4),
	(175, 'LLAVE ESPAÑOLA 3/4-7/8', 1, NULL, 4),
	(176, 'LLAVE ESPAÑOLA 13/16-7/8', 1, NULL, 4),
	(177, 'LLAVE ESPAÑOLA 16/16-1"', 1, NULL, 4),
	(178, 'DADO 11MM URREA', 1, NULL, 4),
	(179, 'DADO 12 MM URREA', 1, NULL, 4),
	(180, 'DADO 13 MM URREA', 1, NULL, 4),
	(181, 'DADO 14 MM URREA', 1, NULL, 4),
	(182, 'DADO 15 MM URREA', 1, NULL, 4),
	(183, 'DADO 16 MM URREA', 1, NULL, 4),
	(184, 'DADO 17 MM URREA', 1, NULL, 4),
	(185, 'DADO 18 MM URREA', 1, NULL, 4),
	(186, 'DADO 19 MM URREA', 1, NULL, 4),
	(187, 'DADO 20 MM URREA', 1, NULL, 4),
	(188, 'DADO 21 MM URREA', 1, NULL, 4),
	(189, 'DADO 22 MM URREA', 1, NULL, 4),
	(190, 'DADO 23 MM URREA', 1, NULL, 4),
	(191, 'DADO 24 MM URREA', 1, NULL, 4),
	(192, 'DADO 25 MM URREA', 1, NULL, 4),
	(193, 'DADO 26 MM URREA', 1, NULL, 4),
	(194, 'DADO 27 MM URREA', 1, NULL, 4),
	(195, 'DADO 28 MM URREA', 1, NULL, 4),
	(196, 'DADO 29 MM URREA', 1, NULL, 4),
	(197, 'DADO 30 MM URREA', 1, NULL, 4),
	(198, 'DADO 31 MM URREA', 1, NULL, 4),
	(199, 'DADO 32 MM URREA', 1, NULL, 4),
	(200, 'EXTENSION 1/2 URREA', 1, NULL, 4),
	(201, 'MATRACA 1/2 URREA', 1, NULL, 4),
	(202, 'MANERAL 1/2" URREA', 1, NULL, 4),
	(203, 'NUDO 1/2" URREA', 1, NULL, 4),
	(204, 'DADO 7/16 URREA', 1, NULL, 4),
	(205, 'DADO 1/2 URREA', 1, NULL, 4),
	(206, 'DADO 9/16 URREA', 1, NULL, 4),
	(207, 'DADO 5/8 URREA', 1, NULL, 4),
	(208, 'DADO 11/16 URREA', 1, NULL, 4),
	(209, 'DADO 3/4 URREA', 1, NULL, 4),
	(210, 'DADO 13/16 URREA', 1, NULL, 4),
	(211, 'DADO 7/8 URREA', 1, NULL, 4),
	(212, 'DADO 15/16 URREA', 1, NULL, 4),
	(213, 'DADO 1" URREA', 1, NULL, 4),
	(214, 'DADO 19/32" URREA', 1, NULL, 4);
/*!40000 ALTER TABLE `item` ENABLE KEYS */;

-- Volcando estructura para tabla warehouse.order
DROP TABLE IF EXISTS `order`;
CREATE TABLE IF NOT EXISTS `order` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `owner` varchar(200) COLLATE utf8mb4_bin NOT NULL,
  `studentID` int(11) unsigned NOT NULL,
  `carreerID` int(11) unsigned NOT NULL,
  `confirmed` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `createdAt` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `deletedAt` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `carreerIDFK` (`carreerID`),
  CONSTRAINT `carreerIDFK` FOREIGN KEY (`carreerID`) REFERENCES `carreer` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Volcando datos para la tabla warehouse.order: ~1 rows (aproximadamente)
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
INSERT INTO `order` (`id`, `owner`, `studentID`, `carreerID`, `confirmed`, `createdAt`, `deletedAt`) VALUES
	(36, 'Aldo Preciado Cuevas', 2529503, 1, 1, '0000-00-00 00:00:00', '2018-08-09 15:33:32');
/*!40000 ALTER TABLE `order` ENABLE KEYS */;

-- Volcando estructura para tabla warehouse.orderitem
DROP TABLE IF EXISTS `orderitem`;
CREATE TABLE IF NOT EXISTS `orderitem` (
  `orderID` int(11) unsigned NOT NULL,
  `itemID` int(11) unsigned NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `deletedAt` timestamp NULL DEFAULT NULL,
  KEY `orderIDFK` (`orderID`),
  KEY `itemIDFK` (`itemID`),
  CONSTRAINT `itemIDFK` FOREIGN KEY (`itemID`) REFERENCES `item` (`id`),
  CONSTRAINT `orderIDFK` FOREIGN KEY (`orderID`) REFERENCES `order` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Volcando datos para la tabla warehouse.orderitem: ~4 rows (aproximadamente)
/*!40000 ALTER TABLE `orderitem` DISABLE KEYS */;
INSERT INTO `orderitem` (`orderID`, `itemID`, `createdAt`, `deletedAt`) VALUES
	(36, 96, '2018-08-09 15:25:27', NULL),
	(36, 97, '2018-08-09 15:25:27', NULL),
	(36, 98, '2018-08-09 15:25:27', NULL),
	(36, 98, '2018-08-09 15:25:27', NULL);
/*!40000 ALTER TABLE `orderitem` ENABLE KEYS */;

-- Volcando estructura para tabla warehouse.user
DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(200) COLLATE utf8mb4_bin NOT NULL DEFAULT '0',
  `password` varchar(200) COLLATE utf8mb4_bin NOT NULL DEFAULT '0',
  `name` varchar(200) COLLATE utf8mb4_bin NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Volcando datos para la tabla warehouse.user: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
/*!40000 ALTER TABLE `user` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
