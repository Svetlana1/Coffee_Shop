-- --------------------------------------------------------
-- Сервер:                       127.0.0.1
-- Версія сервера:               5.5.41-MariaDB - mariadb.org binary distribution
-- ОС сервера:                   Win64
-- HeidiSQL Версія:              8.3.0.4694
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Dumping database structure for coffee
CREATE DATABASE IF NOT EXISTS `coffee` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `coffee`;


-- Dumping structure for таблиця coffee.cash
CREATE TABLE IF NOT EXISTS `cash` (
  `id` int(11) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `id_seller` int(11) NOT NULL,
  `id_transaction` int(11) NOT NULL,
  `comment` varchar(1000) NOT NULL,
  `date` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_cash_transaction` (`id_transaction`),
  KEY `FK_cash_seller` (`id_seller`),
  CONSTRAINT `FK_cash_seller` FOREIGN KEY (`id_seller`) REFERENCES `seller` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_cash_transaction` FOREIGN KEY (`id_transaction`) REFERENCES `transaction` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Dumping data for table coffee.cash: ~2 rows (приблизно)
/*!40000 ALTER TABLE `cash` DISABLE KEYS */;
INSERT INTO `cash` (`id`, `id_seller`, `id_transaction`, `comment`, `date`) VALUES
	(00000000001, 2, 1, 'benefit', '2015-01-24'),
	(00000000002, 1, 2, 'for Tom', '2013-01-24');
/*!40000 ALTER TABLE `cash` ENABLE KEYS */;


-- Dumping structure for таблиця coffee.category
CREATE TABLE IF NOT EXISTS `category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `photo` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Dumping data for table coffee.category: ~2 rows (приблизно)
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` (`id`, `name`, `photo`) VALUES
	(1, 'Chine coffee', NULL),
	(2, 'England coffee', NULL);
/*!40000 ALTER TABLE `category` ENABLE KEYS */;


-- Dumping structure for таблиця coffee.client
CREATE TABLE IF NOT EXISTS `client` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(100) CHARACTER SET latin1 NOT NULL,
  `password` varchar(100) CHARACTER SET latin1 NOT NULL,
  `name` varchar(100) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf16;

-- Dumping data for table coffee.client: ~2 rows (приблизно)
/*!40000 ALTER TABLE `client` DISABLE KEYS */;
INSERT INTO `client` (`id`, `email`, `password`, `name`) VALUES
	(1, 'sveta@gmail.com', '123', 'Sveta'),
	(2, 'kate@mail.ru', '345', 'Kate');
/*!40000 ALTER TABLE `client` ENABLE KEYS */;


-- Dumping structure for таблиця coffee.comment
CREATE TABLE IF NOT EXISTS `comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_client` int(11) NOT NULL,
  `id_product` int(11) NOT NULL,
  `date` date NOT NULL,
  `text` varchar(1000) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_comment_client` (`id_client`),
  KEY `FK_comment_product` (`id_product`),
  CONSTRAINT `FK_comment_client` FOREIGN KEY (`id_client`) REFERENCES `client` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_comment_product` FOREIGN KEY (`id_product`) REFERENCES `product` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Dumping data for table coffee.comment: ~2 rows (приблизно)
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` (`id`, `id_client`, `id_product`, `date`, `text`) VALUES
	(1, 2, 1, '2015-01-24', 'today'),
	(2, 1, 2, '2015-01-24', 'yes');
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;


-- Dumping structure for таблиця coffee.order
CREATE TABLE IF NOT EXISTS `order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_client` int(11) NOT NULL,
  `id_product` int(11) NOT NULL,
  `id_seller` int(11) NOT NULL,
  `date` date NOT NULL,
  `discount` int(11) NOT NULL,
  `type_delivery` varchar(100) NOT NULL,
  `isPayed` bit(1) NOT NULL,
  `isDeliveried` bit(1) NOT NULL,
  `address` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_order_client` (`id_client`),
  KEY `FK_order_product` (`id_product`),
  KEY `FK_order_seller` (`id_seller`),
  CONSTRAINT `FK_order_client` FOREIGN KEY (`id_client`) REFERENCES `client` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_order_product` FOREIGN KEY (`id_product`) REFERENCES `product` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_order_seller` FOREIGN KEY (`id_seller`) REFERENCES `seller` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Dumping data for table coffee.order: ~2 rows (приблизно)
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
INSERT INTO `order` (`id`, `id_client`, `id_product`, `id_seller`, `date`, `discount`, `type_delivery`, `isPayed`, `isDeliveried`, `address`) VALUES
	(1, 1, 2, 1, '2015-01-24', 10, 'spreed', b'1', b'0', 'Tomova 6'),
	(2, 1, 1, 1, '2013-01-24', 5, 'low', b'0', b'1', 'Drozdova 8');
/*!40000 ALTER TABLE `order` ENABLE KEYS */;


-- Dumping structure for таблиця coffee.product
CREATE TABLE IF NOT EXISTS `product` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(100) DEFAULT NULL,
  `photo` varchar(100) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `category_id` int(11) NOT NULL,
  `price_purchase` float(100,2) NOT NULL,
  `price_sale` float(100,2) NOT NULL,
  `count` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_product_category` (`category_id`),
  CONSTRAINT `FK_product_category` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Dumping data for table coffee.product: ~2 rows (приблизно)
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` (`id`, `description`, `photo`, `name`, `category_id`, `price_purchase`, `price_sale`, `count`) VALUES
	(1, 'good', NULL, '"Black jack"', 1, 10.20, 12.80, 10),
	(2, 'nice', NULL, 'Nescafe', 2, 8.90, 10.40, 2);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;


-- Dumping structure for таблиця coffee.productlist
CREATE TABLE IF NOT EXISTS `productlist` (
  `id_order` int(11) NOT NULL AUTO_INCREMENT,
  `id_product` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  KEY `FK_productList_product` (`id_product`),
  KEY `FK_productlist_order` (`id_order`),
  CONSTRAINT `FK_productlist_order` FOREIGN KEY (`id_order`) REFERENCES `order` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_productList_product` FOREIGN KEY (`id_product`) REFERENCES `product` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Dumping data for table coffee.productlist: ~2 rows (приблизно)
/*!40000 ALTER TABLE `productlist` DISABLE KEYS */;
INSERT INTO `productlist` (`id_order`, `id_product`, `quantity`) VALUES
	(2, 2, 12),
	(1, 1, 4);
/*!40000 ALTER TABLE `productlist` ENABLE KEYS */;


-- Dumping structure for таблиця coffee.role
CREATE TABLE IF NOT EXISTS `role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- Dumping data for table coffee.role: ~3 rows (приблизно)
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` (`id`, `name`) VALUES
	(1, 'ADMIN'),
	(2, 'CLIENT'),
	(3, 'SELLER');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;


-- Dumping structure for таблиця coffee.seller
CREATE TABLE IF NOT EXISTS `seller` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_role` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `address` varchar(100) NOT NULL,
  `salary` float(100,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_seller_role` (`id_role`),
  CONSTRAINT `FK_seller_role` FOREIGN KEY (`id_role`) REFERENCES `role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Dumping data for table coffee.seller: ~2 rows (приблизно)
/*!40000 ALTER TABLE `seller` DISABLE KEYS */;
INSERT INTO `seller` (`id`, `id_role`, `name`, `email`, `password`, `address`, `salary`) VALUES
	(1, 1, 'Tom', 'fan@gmail.com', '2345', 'Klova 2', 1000.50),
	(2, 3, 'Jack', 'jack@mail.ru', 'd324', 'Movzaleaya 6', 5000.00);
/*!40000 ALTER TABLE `seller` ENABLE KEYS */;


-- Dumping structure for таблиця coffee.transaction
CREATE TABLE IF NOT EXISTS `transaction` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(100) NOT NULL,
  `amount` float(100,2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Dumping data for table coffee.transaction: ~2 rows (приблизно)
/*!40000 ALTER TABLE `transaction` DISABLE KEYS */;
INSERT INTO `transaction` (`id`, `type`, `amount`) VALUES
	(1, 'add_seller', 100.40),
	(2, 'delete_admin', 40.50);
/*!40000 ALTER TABLE `transaction` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
