CREATE DATABASE /*!32312 IF NOT EXISTS*/`dev_teacher` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `dev_teacher`;

/*Table structure for table `class` */

SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS `class`;

CREATE TABLE `class` (
  `classid` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(40) DEFAULT NULL,
  `isactive` INT(11) NOT NULL,
  PRIMARY KEY (`classid`)
) ENGINE=INNODB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

/*Data for the table `class` */

INSERT  INTO `class`(`classid`,`name`,`isactive`) VALUES (1,'I',1),(2,'II',1),(3,'III',1),(4,'IV',1),(5,'V',1),(6,'VI',1),(7,'VII',1),(8,'VIII',1),(9,'IX',1),(10,'X',1);

/*Table structure for table `days` */

DROP TABLE IF EXISTS `days`;

CREATE TABLE `days` (
  `dayid` INT(11) NOT NULL AUTO_INCREMENT,
  `daylabel` VARCHAR(100) NOT NULL,
  `isactive` INT(11) NOT NULL,
  PRIMARY KEY (`dayid`)
) ENGINE=INNODB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

/*Data for the table `days` */

INSERT  INTO `days`(`dayid`,`daylabel`,`isactive`) VALUES (1,'MONDAY',1),(2,'TUESDAY',1),(3,'WEDNESDAY',1),(4,'THURSDAY',1),(5,'FRIDAY',1);

/*Table structure for table `map_teach_sub` */

DROP TABLE IF EXISTS `map_teach_sub`;

CREATE TABLE `map_teach_sub` (
  `mapid` INT(11) NOT NULL AUTO_INCREMENT,
  `classid` INT(11) DEFAULT NULL,
  `subjectid` INT(11) DEFAULT NULL,
  `teacherid` INT(11) DEFAULT NULL,
  `isactive` INT(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`mapid`),
  KEY `classid` (`classid`),
  KEY `teacherid` (`teacherid`),
  KEY `subjectid` (`subjectid`),
  CONSTRAINT `map_teach_sub_ibfk_1` FOREIGN KEY (`classid`) REFERENCES `class` (`classid`),
  CONSTRAINT `map_teach_sub_ibfk_2` FOREIGN KEY (`teacherid`) REFERENCES `teacher` (`teacherid`),
  CONSTRAINT `map_teach_sub_ibfk_3` FOREIGN KEY (`subjectid`) REFERENCES `subject` (`subjectid`)
) ENGINE=INNODB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

/*Data for the table `map_teach_sub` */

INSERT  INTO `map_teach_sub`(`mapid`,`classid`,`subjectid`,`teacherid`,`isactive`) VALUES (8,1,11,30,0),(9,1,12,30,0),(10,1,13,31,0),(11,1,14,31,0),(12,1,15,31,0),(13,1,16,32,0),(14,1,17,33,0),(15,1,18,31,0),(16,1,19,30,0),(17,1,20,31,0),(18,1,21,33,0),(19,2,22,31,0),(20,2,23,31,0),(21,2,24,33,0),(22,2,25,30,0),(23,2,26,33,0),(24,2,27,31,0),(25,2,28,30,0),(26,2,29,31,0),(27,2,30,33,0),(28,2,31,30,0),(29,2,32,31,0),(30,2,33,31,0);

/*Table structure for table `subject` */

DROP TABLE IF EXISTS `subject`;

CREATE TABLE `subject` (
  `subjectid` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(40) DEFAULT NULL,
  `isactive` INT(11) NOT NULL DEFAULT '1',
  `classid` INT(11) DEFAULT NULL,
  `count` INT(11) DEFAULT NULL,
  `successive` INT(11) DEFAULT '0',
  PRIMARY KEY (`subjectid`),
  KEY `classid` (`classid`),
  CONSTRAINT `subject_ibfk_1` FOREIGN KEY (`classid`) REFERENCES `class` (`classid`)
) ENGINE=INNODB AUTO_INCREMENT=75 DEFAULT CHARSET=utf8;

/*Data for the table `subject` */

INSERT  INTO `subject`(`subjectid`,`name`,`isactive`,`classid`,`count`,`successive`) VALUES (11,'Maths',1,1,10,0),(12,'Games',1,1,1,0),(13,'Craft',1,1,2,0),(14,'PE',1,1,2,0),(15,'Marathi',1,1,6,0),(16,'English',1,1,10,0),(17,'GK',1,1,1,0),(18,'Art',1,1,2,0),(19,'CAP',1,1,1,0),(20,'MD',1,1,2,0),(21,'Computer',1,1,2,1),(22,'Marathi',1,2,8,0),(23,'Hindi',1,2,5,0),(24,'English',1,2,8,0),(25,'Mathis',1,2,8,0),(26,'Computer',1,2,2,0),(27,'Art',1,2,2,0),(28,'Craft',1,2,2,0),(29,'PE',1,2,2,0),(30,'V.ed',1,2,1,0),(31,'GK',1,2,1,0),(32,'CAP',1,2,1,0),(33,'MD',1,2,2,0),(34,'Marathi',1,3,5,0),(35,'Hindi',1,3,6,0),(36,'English',1,3,7,0),(37,'Science',1,3,5,0),(38,'Maths',1,3,8,0),(39,'Arts',1,3,2,0),(40,'S.S',1,3,6,0),(41,'Craft',1,3,2,0),(42,'P.E&M.D',1,3,4,0),(43,'Computer',1,3,2,0),(44,'V.ED',1,3,1,0),(45,'CAP & MD',1,3,1,0),(46,'English',1,4,7,0),(47,'Marathi',1,4,5,0),(48,'Hindi',1,4,5,0),(49,'Maths',1,4,8,0),(50,'SC',1,4,5,0),(51,'SS',1,4,6,0),(52,'Art',1,4,2,0),(53,'Craft',1,4,2,0),(54,'Computer',1,4,2,0),(55,'Library',1,4,1,0),(56,'V.ED',1,4,1,0),(57,'GK',1,4,1,0),(58,'P.E',1,4,2,0),(59,'C.A.P',1,4,1,0),(60,'MD',1,4,2,0),(61,'English',1,5,7,0),(62,'Marathi',1,5,5,0),(63,'Hindi',1,5,5,0),(64,'Maths',1,5,8,0),(65,'S.C',1,5,5,0),(66,'S.S',1,5,6,0),(67,'Arts',1,5,3,0),(68,'W.E',1,5,2,0),(69,'P.E',1,5,2,0),(70,'Comp',1,5,2,0),(71,'V.ED',1,5,1,0),(72,'GK',1,5,1,0),(73,'C.A.P',1,5,1,0),(74,'MD',1,5,3,0);

/*Table structure for table `teacher` */

DROP TABLE IF EXISTS `teacher`;

CREATE TABLE `teacher` (
  `teacherid` INT(11) NOT NULL AUTO_INCREMENT,
  `firstname` VARCHAR(100) DEFAULT NULL,
  `lastname` VARCHAR(100) DEFAULT NULL,
  `isactive` INT(11) DEFAULT '1',
  PRIMARY KEY (`teacherid`)
) ENGINE=INNODB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;

/*Data for the table `teacher` */

INSERT  INTO `teacher`(`teacherid`,`firstname`,`lastname`,`isactive`) VALUES (21,'Hema','Patil',1),(30,'Gloria','Surname',1),(31,'Nilima','K',1),(32,'Grace','C',1),(33,'Sr.Thomasy','D',1);

/*Table structure for table `time_slot` */

DROP TABLE IF EXISTS `time_slot`;

CREATE TABLE `time_slot` (
  `slotid` INT(11) NOT NULL AUTO_INCREMENT,
  `label` VARCHAR(50) NOT NULL,
  `active` INT(11) NOT NULL,
  PRIMARY KEY (`slotid`)
) ENGINE=INNODB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

/*Data for the table `time_slot` */

INSERT  INTO `time_slot`(`slotid`,`label`,`active`) VALUES (12,'01:00 - 01:45',1),(13,'01:45 - 02:30',1),(14,'02:30 - 03:05',1),(15,'03:05 - 03:40',1),(16,'04:00 - 04:30',1),(17,'04:30 - 05:00',1),(18,'05:00 - 05:30',1),(19,'05:30 - 06:00',1),(20,'03:40 - 04:00',1);

/*Table structure for table `time_table` */

DROP TABLE IF EXISTS `time_table`;

CREATE TABLE `time_table` (
  `ttid` INT(11) NOT NULL AUTO_INCREMENT,
  `slotid` INT(11) NOT NULL,
  `classid` INT(11) NOT NULL,
  `teacherid` INT(11) NOT NULL,
  `teachername` VARCHAR(100) DEFAULT NULL,
  `subjectid` INT(11) NOT NULL,
  `subjectname` VARCHAR(100) DEFAULT NULL,
  `dayid` INT(11) NOT NULL,
  `daylabel` VARCHAR(100) DEFAULT NULL,
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
) ENGINE=INNODB DEFAULT CHARSET=utf8;


