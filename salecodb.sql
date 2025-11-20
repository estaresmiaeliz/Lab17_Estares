/*
SQLyog Ultimate v10.42 
MySQL - 5.5.5-10.1.28-MariaDB : Database - salecodb
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`salecodb` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `salecodb`;

/*Table structure for table `customer` */

DROP TABLE IF EXISTS `customer`;

CREATE TABLE `customer` (
  `cus_code` int(11) NOT NULL DEFAULT '0',
  `cus_lname` varchar(15) DEFAULT NULL,
  `cus_fname` varchar(15) DEFAULT NULL,
  `cus_initial` varchar(1) DEFAULT NULL,
  `cus_areacode` varchar(3) DEFAULT NULL,
  `cus_phone` varchar(8) DEFAULT NULL,
  `cus_balance` double DEFAULT '0',
  PRIMARY KEY (`cus_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `customer` */

insert  into `customer`(`cus_code`,`cus_lname`,`cus_fname`,`cus_initial`,`cus_areacode`,`cus_phone`,`cus_balance`) values (10010,'Ramas','Alfred','A','615','844-2573',0),(10011,'Dunne','Leona','K','713','894-1238',0),(10012,'Smith','Kathy','W','615','894-2285',345.86),(10013,'Olowski','Paul','F','615','894-2180',536.75),(10014,'Orlando','Myron',NULL,'615','222-1672',0),(10015,'O\'Brian','Amy','B','713','442-3381',0),(10016,'Brown','James','G','615','297-1228',221.19),(10017,'Williams','George',NULL,'615','290-2556',768.93),(10018,'Farriss','Anne','G','713','382-7185',216.55),(10019,'Smith','Olette','K','615','297-3809',0);

/*Table structure for table `invoice` */

DROP TABLE IF EXISTS `invoice`;

CREATE TABLE `invoice` (
  `inv_number` int(11) NOT NULL DEFAULT '0',
  `cus_code` int(11) DEFAULT '0',
  `inv_date` datetime DEFAULT NULL,
  `inv_subtotal` double DEFAULT '0',
  `inv_tax` double DEFAULT '0',
  `inv_total` double DEFAULT '0',
  PRIMARY KEY (`inv_number`),
  KEY `reference3` (`cus_code`),
  CONSTRAINT `reference3_cus_code_customer_cus_code` FOREIGN KEY (`cus_code`) REFERENCES `customer` (`cus_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `invoice` */

insert  into `invoice`(`inv_number`,`cus_code`,`inv_date`,`inv_subtotal`,`inv_tax`,`inv_total`) values (1001,10014,'2008-01-16 00:00:00',24.9,1.99,26.89),(1002,10011,'2008-01-16 00:00:00',9.98,0.8,10.78),(1003,10012,'2008-01-16 00:00:00',153.85,12.31,166.16),(1004,10011,'2008-01-17 00:00:00',34.97,2.8,37.77),(1005,10018,'2008-01-17 00:00:00',70.44,5.64,76.08),(1006,10014,'2008-01-17 00:00:00',397.83,31.83,429.66),(1007,10015,'2008-01-17 00:00:00',34.97,2.8,37.77),(1008,10011,'2008-01-17 00:00:00',399.15,31.93,431.08);

/*Table structure for table `line` */

DROP TABLE IF EXISTS `line`;

CREATE TABLE `line` (
  `inv_number` int(11) NOT NULL DEFAULT '0',
  `line_number` smallint(6) NOT NULL DEFAULT '0',
  `p_code` varchar(10) DEFAULT NULL,
  `line_units` double DEFAULT '0',
  `line_price` double DEFAULT '0',
  `line_total` double DEFAULT '0',
  PRIMARY KEY (`inv_number`,`line_number`),
  KEY `reference1` (`p_code`),
  KEY `reference2` (`inv_number`),
  CONSTRAINT `reference1_p_code_product_p_code` FOREIGN KEY (`p_code`) REFERENCES `product` (`p_code`),
  CONSTRAINT `reference2_inv_number_invoice_inv_number` FOREIGN KEY (`inv_number`) REFERENCES `invoice` (`inv_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `line` */

insert  into `line`(`inv_number`,`line_number`,`p_code`,`line_units`,`line_price`,`line_total`) values (1001,1,'13-Q2/P2',1,14.99,14.99),(1001,2,'23109-HB',1,9.95,9.95),(1002,1,'54778-2T',2,4.99,9.98),(1003,1,'2238/QPD',1,38.95,38.95),(1003,2,'1546-QQ2',1,39.95,39.95),(1003,3,'13-Q2/P2',5,14.99,74.95),(1004,1,'54778-2T',3,4.99,14.97),(1004,2,'23109-HB',2,9.95,19.9),(1005,1,'PVC23DRT',12,5.87,70.44),(1006,1,'SM-18277',3,6.99,20.97),(1006,2,'2232/QTY',1,109.92,109.92),(1006,3,'23109-HB',1,9.95,9.95),(1006,4,'89-WRE-Q',1,256.99,256.99),(1007,1,'13-Q2/P2',2,14.99,29.98),(1007,2,'54778-2T',1,4.99,4.99),(1008,1,'PVC23DRT',5,5.87,29.35),(1008,2,'WR3/TT3',3,119.95,359.85),(1008,3,'23109-HB',1,9.95,9.95);

/*Table structure for table `product` */

DROP TABLE IF EXISTS `product`;

CREATE TABLE `product` (
  `p_code` varchar(10) NOT NULL COMMENT 'Product code: Primary key',
  `p_descript` varchar(35) DEFAULT NULL COMMENT 'Product description',
  `p_indate` datetime DEFAULT NULL COMMENT 'Product stock date',
  `p_qoh` smallint(6) DEFAULT '0' COMMENT 'Number of units on hand (i.e., available for sale.)',
  `p_min` smallint(6) DEFAULT '0' COMMENT 'Minimum number of units on hand',
  `p_price` double DEFAULT '0' COMMENT 'Product sales price',
  `p_discount` double DEFAULT '0' COMMENT 'product discount pct.',
  `v_code` int(11) DEFAULT '0' COMMENT 'Vendor code: Foreign key to VENDOR',
  PRIMARY KEY (`p_code`),
  KEY `reference` (`v_code`),
  CONSTRAINT `reference_v_code_vendor_v_code` FOREIGN KEY (`v_code`) REFERENCES `vendor` (`v_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `product` */

insert  into `product`(`p_code`,`p_descript`,`p_indate`,`p_qoh`,`p_min`,`p_price`,`p_discount`,`v_code`) values ('11QER/31','Power painter, 15 psi., 3-nozzle','2007-11-03 00:00:00',8,5,109.99,0,25595),('13-Q2/P2','7.25-in. pwr. saw blade','2007-12-13 00:00:00',32,15,14.99,0.05,21344),('14-Q1/L3','9.00-in. pwr. saw blade','2007-11-13 00:00:00',18,12,17.49,0,21344),('1546-QQ2','Hrd. cloth, 1/4-in., 2x50','2008-01-15 00:00:00',15,8,39.95,0,23119),('1558-QW1','Hrd. cloth, 1/2-in., 3x50','2008-01-15 00:00:00',23,5,43.99,0,23119),('2232/QTY','B&D jigsaw, 12-in. blade','2007-12-30 00:00:00',8,5,109.92,0.05,24288),('2232/QWE','B&D jigsaw, 8-in. blade','2007-12-24 00:00:00',6,5,99.87,0.05,24288),('2238/QPD','B&D cordless drill, 1/2-in.','2008-01-20 00:00:00',12,5,38.95,0.05,25595),('23109-HB','Claw hammer','2008-01-20 00:00:00',23,10,9.95,0.1,21225),('23114-AA','Sledge hammer, 12 lb.','2008-01-02 00:00:00',8,5,14.4,0.05,NULL),('54778-2T','Rat-tail file, 1/8-in. fine','2007-12-15 00:00:00',43,20,4.99,0,21344),('89-WRE-Q','Hicut chain saw, 16 in.','2008-02-07 00:00:00',11,5,256.99,0.05,24288),('PVC23DRT','PVC pipe, 3.5-in., 8-ft','2008-02-20 00:00:00',188,75,5.87,0,NULL),('SM-18277','1.25-in. metal screw, 25','2008-03-01 00:00:00',172,75,6.99,0,21225),('SW-23116','2.5-in. wd. screw, 50','2008-02-24 00:00:00',237,100,8.45,0,21231),('WR3/TT3','Steel matting, 4\'x8\'x1/6\", .5\" mesh','2008-01-17 00:00:00',18,5,119.95,0.1,25595);

/*Table structure for table `vendor` */

DROP TABLE IF EXISTS `vendor`;

CREATE TABLE `vendor` (
  `v_code` int(11) NOT NULL DEFAULT '0' COMMENT 'Vendor code (primary key.)',
  `v_name` varchar(15) DEFAULT NULL,
  `v_contact` varchar(50) DEFAULT NULL,
  `v_areacode` varchar(3) DEFAULT NULL,
  `v_phone` varchar(8) DEFAULT NULL,
  `v_state` varchar(2) DEFAULT NULL,
  `v_order` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`v_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `vendor` */

insert  into `vendor`(`v_code`,`v_name`,`v_contact`,`v_areacode`,`v_phone`,`v_state`,`v_order`) values (21225,'Bryson, Inc.','Smithson','615','223-3234','TN','Y'),(21226,'SuperLoo, Inc.','Flushing','904','215-8995','FL','N'),(21231,'D&E Supply','Singh','615','228-3245','TN','Y'),(21344,'Gomez Bros.','Ortega','615','889-2546','KY','N'),(22567,'Dome Supply','Smith','901','678-1419','GA','N'),(23119,'Randsets Ltd.','Anderson','901','678-3998','GA','Y'),(24004,'Brackman Bros.','Browning','615','228-1410','TN','N'),(24288,'ORDVA, Inc.','Hakford','615','898-1234','TN','Y'),(25443,'B&K, Inc.','Smith','904','227-0093','FL','N'),(25501,'Damal Supplies','Smythe','615','890-3529','TN','N'),(25595,'Rubicon Systems','Orton','904','456-0092','FL','Y');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
