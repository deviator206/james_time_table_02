/*
SQLyog Community v12.09 (64 bit)
MySQL - 5.6.21-log : Database - dev_teacher
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`dev_teacher` /*!40100 DEFAULT CHARACTER SET utf8 */;

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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

/*Data for the table `map_teach_sub` */

insert  into `map_teach_sub`(`mapid`,`classid`,`subjectid`,`teacherid`,`isactive`) values (4,1,11,16,0),(5,1,12,16,0);

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
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=utf8;

/*Data for the table `subject` */

insert  into `subject`(`subjectid`,`name`,`isactive`,`classid`,`count`,`successive`) values (11,'Maths',1,1,10,0),(12,'Games',1,1,1,0),(13,'Craft',1,1,2,0),(14,'PE',1,1,2,0),(15,'Marathi',1,1,6,0),(16,'English',1,1,10,0),(17,'GK',1,1,1,0),(18,'Art',1,1,2,0),(19,'CAP',1,1,1,0),(20,'MD',1,1,2,0),(21,'Computer',1,1,2,1),(22,'Marathi',1,2,8,0),(23,'Hindi',1,2,5,0),(24,'English',1,2,8,0),(25,'Mathis',1,2,8,0),(26,'Computer',1,2,2,0),(27,'Art',1,2,2,0),(28,'Craft',1,2,2,0),(29,'PE',1,2,2,0),(30,'V.ed',1,2,1,0),(31,'GK',1,2,1,0),(32,'CAP',1,2,1,0),(33,'MD',1,2,2,0),(34,'Marathi',1,3,5,0),(35,'Hindi',1,3,6,0),(36,'English',1,3,7,0),(37,'Science',1,3,5,0),(38,'Maths',1,3,8,0),(39,'Arts',1,3,2,0),(40,'S.S',1,3,6,0),(41,'Craft',1,3,2,0),(42,'P.E&M.D',1,3,4,0),(43,'Computer',1,3,2,0),(44,'V.ED',1,3,1,0),(45,'CAP & MD',1,3,1,0),(46,'English',1,4,7,0),(47,'Marathi',1,4,5,0),(48,'Hindi',1,4,5,0),(49,'Maths',1,4,8,0),(50,'SC',1,4,5,0),(51,'SS',1,4,6,0),(52,'Art',1,4,2,0),(53,'Craft',1,4,2,0),(54,'Computer',1,4,2,0),(55,'Library',1,4,1,0),(56,'V.ED',1,4,1,0),(57,'GK',1,4,1,0),(58,'P.E',1,4,2,0),(59,'C.A.P',1,4,1,0),(60,'MD',1,4,2,0),(61,'English',1,5,7,0),(62,'Marathi',1,5,5,0),(63,'Hindi',1,5,5,0),(64,'Maths',1,5,8,0),(65,'S.C',1,5,5,0),(66,'S.S',1,5,6,0),(67,'Arts',1,5,3,0),(68,'W.E',1,5,2,0),(69,'P.E',1,5,2,0),(70,'Comp',1,5,2,0),(71,'V.ED',1,5,1,0),(72,'GK',1,5,1,0),(73,'C.A.P',1,5,1,0),(74,'MD',1,5,3,0);

/*Table structure for table `teacher` */

DROP TABLE IF EXISTS `teacher`;

CREATE TABLE `teacher` (
  `teacherid` int(11) NOT NULL AUTO_INCREMENT,
  `firstname` varchar(100) DEFAULT NULL,
  `lastname` varchar(100) DEFAULT NULL,
  `isactive` int(11) DEFAULT '1',
  PRIMARY KEY (`teacherid`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

/*Data for the table `teacher` */

insert  into `teacher`(`teacherid`,`firstname`,`lastname`,`isactive`) values (16,'Sonia','Mehra',1);

/*Table structure for table `time_slot` */

DROP TABLE IF EXISTS `time_slot`;

CREATE TABLE `time_slot` (
  `slotid` int(11) NOT NULL AUTO_INCREMENT,
  `label` varchar(50) NOT NULL,
  `active` int(11) NOT NULL,
  PRIMARY KEY (`slotid`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

/*Data for the table `time_slot` */

insert  into `time_slot`(`slotid`,`label`,`active`) values (1,'07.40 – 8-10',1),(2,'08.10 – 8-40',1),(3,'08.40 – 9-10',1),(4,'09.10 – 9-40',1),(5,'09.40 - 10-10',1),(6,'10.10 – 10-30',1),(7,'10.30 – 11-00',1),(8,'11.00 – 11-30',1),(9,'11.30 – 12-00',1),(10,'12.00 – 12-30',1),(11,'12.30 –0 1-00',1);

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `time_table` */

/* Procedure structure for procedure `addNewSubject` */

/*!50003 DROP PROCEDURE IF EXISTS  `addNewSubject` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `addNewSubject`(IN subName varchar(40),IN ac int,classId int, OUT nSubjectId INT)
BEGIN
	Set nSubjectId = 0;
	insert into subject (name,isactive,classid) values (subName,ac,classId);
	SET nSubjectId =  LAST_INSERT_ID();
	SELECT nSubjectId;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `addNewTeacher` */

/*!50003 DROP PROCEDURE IF EXISTS  `addNewTeacher` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `addNewTeacher`( IN fname varchar(100),IN lname VARCHAR(100), IN ac int, OUT latestId int  )
BEGIN
	INSERT INTO teacher (firstname,lastname,isactive) VALUES (fname,lname,ac);
	set latestId =  last_insert_id();
	select latestId;
	
    END */$$
DELIMITER ;

/* Procedure structure for procedure `test04` */

/*!50003 DROP PROCEDURE IF EXISTS  `test04` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `test04`(IN id INT)
BEGIN
	 SELECT * FROM SUBJECT WHERE classid = id;
    END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
