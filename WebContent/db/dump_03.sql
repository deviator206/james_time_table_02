/*
SQLyog Community v12.09 (64 bit)
MySQL - 5.7.5-m15 : Database - dev_teacher
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`dev_teacher` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `dev_teacher`;

/*Table structure for table `class` */

DROP TABLE IF EXISTS `class`;

CREATE TABLE `class` (
  `classid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(40) DEFAULT NULL,
  `isactive` int(11) NOT NULL,
  PRIMARY KEY (`classid`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

/*Data for the table `class` */

insert  into `class`(`classid`,`name`,`isactive`) values (1,'I',1),(2,'II',1),(3,'III',1),(4,'IV',1),(5,'V',1),(6,'VI',1),(7,'VII',1),(8,'VIII',1),(9,'IX',1),(10,'X',1);

/*Table structure for table `days` */

DROP TABLE IF EXISTS `days`;

CREATE TABLE `days` (
  `dayid` int(11) NOT NULL AUTO_INCREMENT,
  `daylabel` varchar(100) NOT NULL,
  `isactive` int(11) NOT NULL,
  PRIMARY KEY (`dayid`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

/*Data for the table `days` */

insert  into `days`(`dayid`,`daylabel`,`isactive`) values (1,'MONDAY',1),(2,'TUESDAY',1),(3,'WEDNESDAY',1),(4,'THURSDAY',1),(5,'FRIDAY',1);

/*Table structure for table `map_teach_sub` */

DROP TABLE IF EXISTS `map_teach_sub`;

CREATE TABLE `map_teach_sub` (
  `mapid` int(11) NOT NULL AUTO_INCREMENT,
  `classid` int(11) DEFAULT NULL,
  `subjectid` int(11) DEFAULT NULL,
  `teacherid` int(11) DEFAULT NULL,
  `isactive` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`mapid`),
  KEY `classid` (`classid`),
  KEY `teacherid` (`teacherid`),
  KEY `subjectid` (`subjectid`),
  CONSTRAINT `map_teach_sub_ibfk_1` FOREIGN KEY (`classid`) REFERENCES `class` (`classid`),
  CONSTRAINT `map_teach_sub_ibfk_2` FOREIGN KEY (`teacherid`) REFERENCES `teacher` (`teacherid`),
  CONSTRAINT `map_teach_sub_ibfk_3` FOREIGN KEY (`subjectid`) REFERENCES `subject` (`subjectid`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

/*Data for the table `map_teach_sub` */

insert  into `map_teach_sub`(`mapid`,`classid`,`subjectid`,`teacherid`,`isactive`) values (8,1,11,30,0),(9,1,12,30,0),(10,1,13,31,0),(11,1,14,31,0),(12,1,15,31,0),(13,1,16,32,0),(14,1,17,33,0),(15,1,18,31,0),(16,1,19,30,0),(17,1,20,31,0),(18,1,21,33,0),(19,2,22,31,0),(20,2,23,31,0),(21,2,24,33,0),(22,2,25,30,0),(23,2,26,33,0),(24,2,27,31,0),(25,2,28,30,0),(26,2,29,31,0),(27,2,30,33,0),(28,2,31,30,0),(29,2,32,31,0),(30,2,33,31,0);

/*Table structure for table `subject` */

DROP TABLE IF EXISTS `subject`;

CREATE TABLE `subject` (
  `subjectid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(40) DEFAULT NULL,
  `isactive` int(11) NOT NULL DEFAULT '1',
  `classid` int(11) DEFAULT NULL,
  `count` int(11) DEFAULT NULL,
  `successive` int(11) DEFAULT '0',
  PRIMARY KEY (`subjectid`),
  KEY `classid` (`classid`),
  CONSTRAINT `subject_ibfk_1` FOREIGN KEY (`classid`) REFERENCES `class` (`classid`)
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8;

/*Data for the table `subject` */

insert  into `subject`(`subjectid`,`name`,`isactive`,`classid`,`count`,`successive`) values (11,'Maths',1,1,10,0),(12,'Games',1,1,1,0),(13,'Craft',1,1,2,0),(14,'PE',1,1,2,0),(15,'Marathi',1,1,6,0),(16,'English',1,1,10,0),(17,'GK',1,1,1,0),(18,'Art',1,1,2,0),(19,'CAP',1,1,1,0),(20,'MD',1,1,2,0),(21,'Computer',1,1,2,1),(22,'Marathi',1,2,8,0),(23,'Hindi',1,2,5,0),(24,'English',1,2,8,0),(25,'Mathis',1,2,8,0),(26,'Computer',1,2,2,0),(27,'Art',1,2,2,0),(28,'Craft',1,2,2,0),(29,'PE',1,2,2,0),(30,'V.ed',1,2,1,0),(31,'GK',1,2,1,0),(32,'CAP',1,2,1,0),(33,'MD',1,2,2,0),(34,'Marathi',1,3,5,0),(35,'Hindi',1,3,6,0),(36,'English',1,3,7,0),(37,'Science',1,3,5,0),(38,'Maths',1,3,8,0),(39,'Arts',1,3,2,0),(40,'S.S',1,3,6,0),(41,'Craft',1,3,2,0),(42,'P.E&M.D',1,3,4,0),(43,'Computer',1,3,2,0),(44,'V.ED',1,3,1,0),(45,'CAP & MD',1,3,1,0),(46,'English',1,4,7,0),(47,'Marathi',1,4,5,0),(48,'Hindi',1,4,5,0),(49,'Maths',1,4,8,0),(50,'SC',1,4,5,0),(51,'SS',1,4,6,0),(52,'Art',1,4,2,0),(53,'Craft',1,4,2,0),(54,'Computer',1,4,2,0),(55,'Library',1,4,1,0),(56,'V.ED',1,4,1,0),(57,'GK',1,4,1,0),(58,'P.E',1,4,2,0),(59,'C.A.P',1,4,1,0),(60,'MD',1,4,2,0),(61,'English',1,5,7,0),(62,'Marathi',1,5,5,0),(63,'Hindi',1,5,5,0),(64,'Maths',1,5,8,0),(65,'S.C',1,5,5,0),(66,'S.S',1,5,6,0),(67,'Arts',1,5,3,0),(68,'W.E',1,5,2,0),(69,'P.E',1,5,2,0),(70,'Comp',1,5,2,0),(71,'V.ED',1,5,1,0),(72,'GK',1,5,1,0),(73,'C.A.P',1,5,1,0),(74,'MD',1,5,3,0),(75,'',0,1,NULL,0),(76,'',0,2,NULL,0),(77,'',0,3,NULL,0),(78,'',0,4,NULL,0),(79,'',0,5,NULL,0),(80,'',0,6,NULL,0),(81,'',0,7,NULL,0),(82,'',0,8,NULL,0),(83,'',0,9,NULL,0),(84,'',0,10,NULL,0);

/*Table structure for table `teacher` */

DROP TABLE IF EXISTS `teacher`;

CREATE TABLE `teacher` (
  `teacherid` int(11) NOT NULL AUTO_INCREMENT,
  `firstname` varchar(100) DEFAULT NULL,
  `lastname` varchar(100) DEFAULT NULL,
  `isactive` int(11) DEFAULT '1',
  PRIMARY KEY (`teacherid`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;

/*Data for the table `teacher` */

insert  into `teacher`(`teacherid`,`firstname`,`lastname`,`isactive`) values (21,'Hema','Patil',1),(30,'Gloria','Surname',1),(31,'Nilima','K',1),(32,'Grace','C',1),(33,'Sr.Thomasy','D',1),(34,'Break','',1);

/*Table structure for table `time_slot` */

DROP TABLE IF EXISTS `time_slot`;

CREATE TABLE `time_slot` (
  `slotid` int(11) NOT NULL AUTO_INCREMENT,
  `label` varchar(50) NOT NULL,
  `active` int(11) NOT NULL,
  `break` int(11) DEFAULT NULL,
  PRIMARY KEY (`slotid`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

/*Data for the table `time_slot` */

insert  into `time_slot`(`slotid`,`label`,`active`,`break`) values (12,'01:00 - 01:45',1,0),(13,'01:45 - 02:30',1,0),(14,'02:30 - 03:05',1,0),(15,'03:05 - 03:40',1,0),(16,'04:00 - 04:30',1,1),(17,'04:30 - 05:00',1,0),(18,'05:00 - 05:30',1,0),(19,'05:30 - 06:00',1,0),(20,'03:40 - 04:00',1,0);

/*Table structure for table `time_table` */

DROP TABLE IF EXISTS `time_table`;

CREATE TABLE `time_table` (
  `ttid` int(11) NOT NULL AUTO_INCREMENT,
  `slotid` int(11) NOT NULL,
  `classid` int(11) NOT NULL,
  `teacherid` int(11) NOT NULL,
  `teachername` varchar(100) DEFAULT NULL,
  `subjectid` int(11) NOT NULL,
  `subjectname` varchar(100) DEFAULT NULL,
  `dayid` int(11) NOT NULL,
  `daylabel` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ttid`),
  KEY `slotid` (`slotid`),
  KEY `classid` (`classid`),
  KEY `teacherid` (`teacherid`),
  KEY `subjectid` (`subjectid`),
  KEY `dayid` (`dayid`),
  CONSTRAINT `time_table_ibfk_1` FOREIGN KEY (`slotid`) REFERENCES `time_slot` (`slotid`),
  CONSTRAINT `time_table_ibfk_2` FOREIGN KEY (`classid`) REFERENCES `class` (`classid`),
  CONSTRAINT `time_table_ibfk_3` FOREIGN KEY (`teacherid`) REFERENCES `teacher` (`teacherid`),
  CONSTRAINT `time_table_ibfk_4` FOREIGN KEY (`subjectid`) REFERENCES `subject` (`subjectid`),
  CONSTRAINT `time_table_ibfk_5` FOREIGN KEY (`dayid`) REFERENCES `days` (`dayid`)
) ENGINE=InnoDB AUTO_INCREMENT=131 DEFAULT CHARSET=utf8;

/*Data for the table `time_table` */

insert  into `time_table`(`ttid`,`slotid`,`classid`,`teacherid`,`teachername`,`subjectid`,`subjectname`,`dayid`,`daylabel`) values (1,12,1,30,'Gloria',11,'Maths',1,'MONDAY'),(2,13,1,30,'Gloria',11,'Maths',1,'MONDAY'),(3,12,1,30,'Gloria',11,'Maths',2,'TUESDAY'),(4,13,1,30,'Gloria',11,'Maths',2,'TUESDAY'),(5,12,1,30,'Gloria',11,'Maths',3,'WEDNESDAY'),(6,13,1,30,'Gloria',11,'Maths',3,'WEDNESDAY'),(7,12,1,30,'Gloria',11,'Maths',4,'THURSDAY'),(8,13,1,30,'Gloria',11,'Maths',4,'THURSDAY'),(9,12,1,30,'Gloria',11,'Maths',5,'FRIDAY'),(10,13,1,30,'Gloria',11,'Maths',5,'FRIDAY'),(11,14,1,30,'Gloria',12,'Games',1,'MONDAY'),(12,15,1,31,'Nilima',13,'Craft',1,'MONDAY'),(13,14,1,31,'Nilima',13,'Craft',2,'TUESDAY'),(14,16,1,31,'Nilima',14,'PE',1,'MONDAY'),(15,15,1,31,'Nilima',14,'PE',2,'TUESDAY'),(16,17,1,31,'Nilima',15,'Marathi',1,'MONDAY'),(17,18,1,31,'Nilima',15,'Marathi',1,'MONDAY'),(18,16,1,31,'Nilima',15,'Marathi',2,'TUESDAY'),(19,17,1,31,'Nilima',15,'Marathi',2,'TUESDAY'),(20,14,1,31,'Nilima',15,'Marathi',3,'WEDNESDAY'),(21,15,1,31,'Nilima',15,'Marathi',3,'WEDNESDAY'),(22,14,1,31,'Nilima',15,'Marathi',4,'THURSDAY'),(23,15,1,31,'Nilima',15,'Marathi',4,'THURSDAY'),(24,14,1,31,'Nilima',15,'Marathi',5,'FRIDAY'),(25,15,1,31,'Nilima',15,'Marathi',5,'FRIDAY'),(26,19,1,32,'Grace',16,'English',1,'MONDAY'),(27,18,1,32,'Grace',16,'English',2,'TUESDAY'),(28,19,1,32,'Grace',16,'English',2,'TUESDAY'),(29,16,1,32,'Grace',16,'English',3,'WEDNESDAY'),(30,17,1,32,'Grace',16,'English',3,'WEDNESDAY'),(31,16,1,32,'Grace',16,'English',4,'THURSDAY'),(32,17,1,32,'Grace',16,'English',4,'THURSDAY'),(33,16,1,32,'Grace',16,'English',5,'FRIDAY'),(34,17,1,32,'Grace',16,'English',5,'FRIDAY'),(35,18,1,33,'Sr.Thomasy',17,'GK',3,'WEDNESDAY'),(36,19,1,31,'Nilima',18,'Art',3,'WEDNESDAY'),(37,18,1,31,'Nilima',18,'Art',4,'THURSDAY'),(38,19,1,30,'Gloria',19,'CAP',4,'THURSDAY'),(39,18,1,31,'Nilima',20,'MD',5,'FRIDAY'),(40,19,1,33,'Sr.Thomasy',21,'Computer',5,'FRIDAY'),(41,12,2,31,'Nilima',22,'Marathi',1,'MONDAY'),(42,13,2,31,'Nilima',22,'Marathi',1,'MONDAY'),(43,12,2,31,'Nilima',22,'Marathi',2,'TUESDAY'),(44,13,2,31,'Nilima',22,'Marathi',2,'TUESDAY'),(45,12,2,31,'Nilima',22,'Marathi',3,'WEDNESDAY'),(46,13,2,31,'Nilima',22,'Marathi',3,'WEDNESDAY'),(47,12,2,31,'Nilima',22,'Marathi',4,'THURSDAY'),(48,13,2,31,'Nilima',22,'Marathi',4,'THURSDAY'),(49,12,2,31,'Nilima',22,'Marathi',5,'FRIDAY'),(50,13,2,31,'Nilima',22,'Marathi',5,'FRIDAY'),(51,14,2,31,'Nilima',23,'Hindi',1,'MONDAY'),(52,14,2,31,'Nilima',23,'Hindi',2,'TUESDAY'),(53,14,2,31,'Nilima',23,'Hindi',3,'WEDNESDAY'),(54,14,2,31,'Nilima',23,'Hindi',4,'THURSDAY'),(55,14,2,31,'Nilima',23,'Hindi',5,'FRIDAY'),(56,15,2,33,'Sr.Thomasy',24,'English',1,'MONDAY'),(57,16,2,33,'Sr.Thomasy',24,'English',1,'MONDAY'),(58,15,2,33,'Sr.Thomasy',24,'English',2,'TUESDAY'),(59,16,2,33,'Sr.Thomasy',24,'English',2,'TUESDAY'),(60,15,2,33,'Sr.Thomasy',24,'English',3,'WEDNESDAY'),(61,16,2,33,'Sr.Thomasy',24,'English',3,'WEDNESDAY'),(62,15,2,33,'Sr.Thomasy',24,'English',4,'THURSDAY'),(63,16,2,33,'Sr.Thomasy',24,'English',4,'THURSDAY'),(64,15,2,33,'Sr.Thomasy',24,'English',5,'FRIDAY'),(65,16,2,33,'Sr.Thomasy',24,'English',5,'FRIDAY'),(66,17,2,30,'Gloria',25,'Mathis',1,'MONDAY'),(67,18,2,30,'Gloria',25,'Mathis',1,'MONDAY'),(68,17,2,30,'Gloria',25,'Mathis',2,'TUESDAY'),(69,18,2,30,'Gloria',25,'Mathis',2,'TUESDAY'),(70,17,2,30,'Gloria',25,'Mathis',3,'WEDNESDAY'),(71,18,2,30,'Gloria',25,'Mathis',3,'WEDNESDAY'),(72,17,2,30,'Gloria',25,'Mathis',4,'THURSDAY'),(73,18,2,30,'Gloria',25,'Mathis',4,'THURSDAY'),(74,17,2,30,'Gloria',25,'Mathis',5,'FRIDAY'),(75,18,2,30,'Gloria',25,'Mathis',5,'FRIDAY'),(76,19,2,33,'Sr.Thomasy',26,'Computer',1,'MONDAY'),(77,19,2,33,'Sr.Thomasy',26,'Computer',2,'TUESDAY'),(78,19,2,31,'Nilima',27,'Art',3,'WEDNESDAY'),(79,19,2,31,'Nilima',27,'Art',4,'THURSDAY'),(80,19,2,30,'Gloria',28,'Craft',5,'FRIDAY'),(81,20,1,34,'BREAK',75,'BREAK',1,'MONDAY'),(82,20,1,34,'BREAK',75,'BREAK',2,'TUESDAY'),(83,20,1,34,'BREAK',75,'BREAK',3,'WEDNESDAY'),(84,20,1,34,'BREAK',75,'BREAK',4,'THURSDAY'),(85,20,1,34,'BREAK',75,'BREAK',5,'FRIDAY'),(86,20,2,34,'BREAK',75,'BREAK',1,'MONDAY'),(87,20,2,34,'BREAK',75,'BREAK',2,'TUESDAY'),(88,20,2,34,'BREAK',75,'BREAK',3,'WEDNESDAY'),(89,20,2,34,'BREAK',75,'BREAK',4,'THURSDAY'),(90,20,2,34,'BREAK',75,'BREAK',5,'FRIDAY'),(91,20,3,34,'BREAK',75,'BREAK',1,'MONDAY'),(92,20,3,34,'BREAK',75,'BREAK',2,'TUESDAY'),(93,20,3,34,'BREAK',75,'BREAK',3,'WEDNESDAY'),(94,20,3,34,'BREAK',75,'BREAK',4,'THURSDAY'),(95,20,3,34,'BREAK',75,'BREAK',5,'FRIDAY'),(96,20,4,34,'BREAK',75,'BREAK',1,'MONDAY'),(97,20,4,34,'BREAK',75,'BREAK',2,'TUESDAY'),(98,20,4,34,'BREAK',75,'BREAK',3,'WEDNESDAY'),(99,20,4,34,'BREAK',75,'BREAK',4,'THURSDAY'),(100,20,4,34,'BREAK',75,'BREAK',5,'FRIDAY'),(101,20,5,34,'BREAK',75,'BREAK',1,'MONDAY'),(102,20,5,34,'BREAK',75,'BREAK',2,'TUESDAY'),(103,20,5,34,'BREAK',75,'BREAK',3,'WEDNESDAY'),(104,20,5,34,'BREAK',75,'BREAK',4,'THURSDAY'),(105,20,5,34,'BREAK',75,'BREAK',5,'FRIDAY'),(106,20,6,34,'BREAK',75,'BREAK',1,'MONDAY'),(107,20,6,34,'BREAK',75,'BREAK',2,'TUESDAY'),(108,20,6,34,'BREAK',75,'BREAK',3,'WEDNESDAY'),(109,20,6,34,'BREAK',75,'BREAK',4,'THURSDAY'),(110,20,6,34,'BREAK',75,'BREAK',5,'FRIDAY'),(111,20,7,34,'BREAK',75,'BREAK',1,'MONDAY'),(112,20,7,34,'BREAK',75,'BREAK',2,'TUESDAY'),(113,20,7,34,'BREAK',75,'BREAK',3,'WEDNESDAY'),(114,20,7,34,'BREAK',75,'BREAK',4,'THURSDAY'),(115,20,7,34,'BREAK',75,'BREAK',5,'FRIDAY'),(116,20,8,34,'BREAK',75,'BREAK',1,'MONDAY'),(117,20,8,34,'BREAK',75,'BREAK',2,'TUESDAY'),(118,20,8,34,'BREAK',75,'BREAK',3,'WEDNESDAY'),(119,20,8,34,'BREAK',75,'BREAK',4,'THURSDAY'),(120,20,8,34,'BREAK',75,'BREAK',5,'FRIDAY'),(121,20,9,34,'BREAK',75,'BREAK',1,'MONDAY'),(122,20,9,34,'BREAK',75,'BREAK',2,'TUESDAY'),(123,20,9,34,'BREAK',75,'BREAK',3,'WEDNESDAY'),(124,20,9,34,'BREAK',75,'BREAK',4,'THURSDAY'),(125,20,9,34,'BREAK',75,'BREAK',5,'FRIDAY'),(126,20,10,34,'BREAK',75,'BREAK',1,'MONDAY'),(127,20,10,34,'BREAK',75,'BREAK',2,'TUESDAY'),(128,20,10,34,'BREAK',75,'BREAK',3,'WEDNESDAY'),(129,20,10,34,'BREAK',75,'BREAK',4,'THURSDAY'),(130,20,10,34,'BREAK',75,'BREAK',5,'FRIDAY');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
