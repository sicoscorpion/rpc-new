-- MySQL dump 10.13  Distrib 5.5.46, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: rpc_old
-- ------------------------------------------------------
-- Server version	5.5.46-0+deb7u1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Admins`
--

DROP TABLE IF EXISTS `Admins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Admins` (
  `user_id` int(10) NOT NULL,
  `shirt_size` varchar(255) NOT NULL,
  `consent` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `Admins_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `Users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Admins`
--

LOCK TABLES `Admins` WRITE;
/*!40000 ALTER TABLE `Admins` DISABLE KEYS */;
INSERT INTO `Admins` VALUES (100000,'Adult M',NULL),(100001,'Adult M',NULL);
/*!40000 ALTER TABLE `Admins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Coaches`
--

DROP TABLE IF EXISTS `Coaches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Coaches` (
  `user_id` int(10) NOT NULL,
  `shirt_size` varchar(255) NOT NULL,
  `consent` varchar(128) DEFAULT NULL,
  `position` enum('Main Coach','Assistant Coach') DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `Coaches_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `Users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Coaches`
--

LOCK TABLES `Coaches` WRITE;
/*!40000 ALTER TABLE `Coaches` DISABLE KEYS */;
INSERT INTO `Coaches` VALUES (100000,'Adult M',NULL,'Main Coach'),(100005,'Adult M',NULL,'Main Coach'),(100008,'Adult L',NULL,'Main Coach'),(100010,'Adult XXXL',NULL,'Main Coach'),(100011,'Adult M',NULL,'Main Coach'),(100012,'Adult M',NULL,'Main Coach'),(100013,'Adult XL',NULL,'Main Coach'),(100014,'Adult M',NULL,'Assistant Coach'),(100015,'Adult XXL',NULL,'Main Coach'),(100016,'Adult S',NULL,'Main Coach'),(100017,'Adult M',NULL,'Assistant Coach'),(100018,'Adult L',NULL,'Main Coach'),(100019,'Adult XL',NULL,'Assistant Coach'),(100020,'Adult L',NULL,'Assistant Coach'),(100021,'Adult S',NULL,'Main Coach'),(100022,'Adult XL',NULL,'Main Coach'),(100023,'Adult L',NULL,'Assistant Coach'),(100024,'Adult XL',NULL,'Assistant Coach'),(100025,'Adult L',NULL,'Main Coach'),(100026,'Adult S',NULL,'Main Coach'),(100027,'Adult XL',NULL,'Main Coach'),(100028,'Adult S',NULL,'Main Coach'),(100029,'Adult S',NULL,'Main Coach'),(100030,'Adult XL',NULL,'Assistant Coach'),(100031,'Adult M',NULL,'Main Coach'),(100032,'Adult M',NULL,'Assistant Coach'),(100033,'Adult M',NULL,'Assistant Coach'),(100034,'Adult XXL',NULL,'Main Coach'),(100035,'Adult M',NULL,'Main Coach'),(100036,'Adult M',NULL,'Main Coach'),(100037,'Adult XXL',NULL,'Assistant Coach'),(100038,'Adult M',NULL,'Main Coach'),(100039,'Adult S',NULL,'Main Coach'),(100040,'Adult M',NULL,'Main Coach'),(100041,'Adult L',NULL,'Main Coach'),(100042,'Adult XL',NULL,'Assistant Coach'),(100043,'Adult L',NULL,'Main Coach'),(100044,'Adult XL',NULL,'Main Coach'),(100045,'Adult XL',NULL,'Assistant Coach'),(100046,'Adult M',NULL,'Assistant Coach'),(100047,'Adult XXL',NULL,'Main Coach'),(100048,'Adult L',NULL,'Main Coach'),(100049,'Adult M',NULL,'Main Coach'),(100050,'Adult M',NULL,'Main Coach'),(100051,'Adult L',NULL,'Main Coach'),(100052,'Adult L',NULL,'Main Coach'),(100053,'Adult S',NULL,'Main Coach'),(100054,'Adult M',NULL,'Main Coach'),(100055,'Adult XL',NULL,'Assistant Coach'),(100056,'Adult L',NULL,'Assistant Coach'),(100057,'Adult M',NULL,'Main Coach'),(100058,'Adult M',NULL,'Assistant Coach'),(100059,'Adult L',NULL,'Assistant Coach'),(100060,'Adult XXL',NULL,'Main Coach'),(100061,'Adult XXL',NULL,'Assistant Coach'),(100062,'Adult M',NULL,'Main Coach'),(100064,'Adult M',NULL,'Assistant Coach'),(100066,'Adult L',NULL,'Main Coach'),(100067,'Adult XXL',NULL,'Main Coach'),(100068,'Adult L',NULL,'Main Coach'),(100069,'Adult L',NULL,'Main Coach'),(100070,'Adult M',NULL,'Main Coach'),(100071,'Adult M',NULL,'Assistant Coach'),(100072,'Adult XL',NULL,'Main Coach'),(100073,'Youth S',NULL,'Assistant Coach'),(100074,'Adult M',NULL,'Main Coach'),(100075,'Adult XXL',NULL,'Main Coach'),(100076,'Adult M',NULL,'Main Coach'),(100077,'Adult XXL',NULL,'Assistant Coach'),(100078,'Adult M',NULL,'Main Coach'),(100079,'Adult S',NULL,'Assistant Coach'),(100080,'Adult XL',NULL,'Main Coach');
/*!40000 ALTER TABLE `Coaches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Competitions`
--

DROP TABLE IF EXISTS `Competitions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Competitions` (
  `competition_id` int(10) NOT NULL AUTO_INCREMENT,
  `season_year` varchar(128) NOT NULL,
  `name` varchar(128) NOT NULL,
  `status` enum('open','closed','completed') DEFAULT 'closed',
  `time` varchar(128) DEFAULT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `civic_number` varchar(128) DEFAULT NULL,
  `street1` varchar(128) DEFAULT NULL,
  `street2` varchar(128) DEFAULT NULL,
  `city` varchar(128) DEFAULT NULL,
  `province` varchar(128) DEFAULT NULL,
  `postal_code` char(7) DEFAULT NULL,
  `capacity` int(3) NOT NULL,
  PRIMARY KEY (`competition_id`,`season_year`),
  KEY `season_year` (`season_year`),
  CONSTRAINT `Competitions_ibfk_1` FOREIGN KEY (`season_year`) REFERENCES `Seasons` (`year`)
) ENGINE=InnoDB AUTO_INCREMENT=100002 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Competitions`
--

LOCK TABLES `Competitions` WRITE;
/*!40000 ALTER TABLE `Competitions` DISABLE KEYS */;
INSERT INTO `Competitions` VALUES (100000,'2015-2016','FLL Trash Trek','open','February 13, 2016','902-585-1269','27 University Avenue','Carnegie Hall','Acadia Univeristy','Wolfville','NS','B4P 2R6',500),(100001,'2015-2016','Robofest','open','February 13, 2016','902-585-1269','27 University Avenue','Carnegie Hall','Acadia University','Wolfville','NS','B4P 2R6',150);
/*!40000 ALTER TABLE `Competitions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `HasPosition`
--

DROP TABLE IF EXISTS `HasPosition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `HasPosition` (
  `volunteer_id` int(10) NOT NULL,
  `position_id` int(10) NOT NULL,
  PRIMARY KEY (`volunteer_id`,`position_id`),
  KEY `position_id` (`position_id`),
  CONSTRAINT `HasPosition_ibfk_1` FOREIGN KEY (`volunteer_id`) REFERENCES `Volunteers` (`volunteer_id`),
  CONSTRAINT `HasPosition_ibfk_2` FOREIGN KEY (`position_id`) REFERENCES `VolunteerPositions` (`position_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `HasPosition`
--

LOCK TABLES `HasPosition` WRITE;
/*!40000 ALTER TABLE `HasPosition` DISABLE KEYS */;
/*!40000 ALTER TABLE `HasPosition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `HasRole`
--

DROP TABLE IF EXISTS `HasRole`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `HasRole` (
  `user_id` int(10) NOT NULL,
  `email` varchar(128) NOT NULL,
  `first_name` varchar(128) NOT NULL,
  `last_name` varchar(128) NOT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `civic_number` varchar(128) DEFAULT NULL,
  `street1` varchar(128) DEFAULT NULL,
  `street2` varchar(128) DEFAULT NULL,
  `city` varchar(128) DEFAULT NULL,
  `province` varchar(128) DEFAULT NULL,
  `postal_code` char(7) DEFAULT NULL,
  `dob` varchar(128) DEFAULT NULL,
  `gender` varchar(30) DEFAULT NULL,
  `medical_info` varchar(128) DEFAULT NULL,
  `shirt_size` varchar(128) DEFAULT NULL,
  `consent` varchar(128) DEFAULT NULL,
  `position` enum('Super Admin','Qualifier Admin','Main Coach','Assistant Coach') DEFAULT NULL,
  `admin` tinyint(1) NOT NULL DEFAULT '0',
  `qualifier_admin` tinyint(1) NOT NULL DEFAULT '0',
  `coach` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `HasRole`
--

LOCK TABLES `HasRole` WRITE;
/*!40000 ALTER TABLE `HasRole` DISABLE KEYS */;
INSERT INTO `HasRole` VALUES (100000,'rpc.assistant@acadiau.ca','Anne','Mercer-Hall','1234567890','1','1','1','1','AB','e3e3e3','November 1, 2015','Female','','Adult M',NULL,'Super Admin',1,0,0),(100001,'fady.abdelmohsen@gmail.com','Fady','Abdelmohsen','2894001819','1 beckwith street','asdasd','Wolfville','Wolfville','AB','B4P1R5','November 4, 2015','Male','','Adult M',NULL,'Super Admin',1,0,0),(100002,'mike.duggan@nscc.ca','Mike','Duggan','902-491-4967','5685','Leeds Street','','Halifax','NS','B3J3C4','November 3, 2015','Male','','Adult L',NULL,'Qualifier Admin',0,1,0),(100004,'blair.lipsett@nscc.ca','Blair','Lipsett','9025430685','75','High Street','','Bridgewater','NS','B4V1V8','November 3, 2015','Male','','Adult L',NULL,'Qualifier Admin',0,1,0),(100005,'jhafting@acadian.ca','Jeff','Hafting','902 402 3700','712','St. George Street','','Annapolis Royal','NS','B0S1A0','July 19, 1969','Male','','Adult M',NULL,'Main Coach',0,0,1),(100006,'sean.morrow@nscc.ca','Sean','Morrow','(902)893-7891','36','Arthur Street','','Truro','NS','B2N 1X5','November 3, 2015','Male','','Adult L',NULL,'Qualifier Admin',0,1,0),(100007,'darren.andrews@nscc.ca','Darren','Andrews','(902)563-2654','1240','Grand Lake Road','PO Box 1042','Sydney','NS','B1P 6J7','November 3, 2015','Male','','Adult XXL',NULL,'Qualifier Admin',0,1,0),(100008,'jenna.watson-findley@acadiau.ca','Jenna','Watson-Findley','(902)585-1269','27','University Ave','','Wolfville','NS','B4P 2R6','November 4, 2015','Female','Tester Team','Adult L',NULL,'Main Coach',0,0,1),(100010,'TBroderick@hrsb.ca','Tina','Broderick','902-240-3554','1601','Frankie Drive','','Beaver Bank','NS','B4E2M6','September 1, 1964','Female','','Adult XXXL',NULL,'Main Coach',0,0,1),(100011,'tamara.franz-odendaal@msvu.ca','Tamara','Franz-Odendaal','902-2407372','44 Clearview drive','44 Clearview drive','','Bedford','NS','B4A 3C8','September 21, 1972','Female','','Adult M',NULL,'Main Coach',0,0,1),(100012,'heather.sullivan@tcrsb.ca','Heather','Manzer','9022474597','56 Second Avenue','same','same','Digby','NS','B0V1A0','August 11, 1980','Female','','Adult M',NULL,'Main Coach',0,0,1),(100013,'arhinelander@armbrae.ns.ca','Alex','Rhinelander','9024565280','1400','Oxford St','','Halifax','NS','B3H 3Y8','December 28, 1962','Male','','Adult XL',NULL,'Main Coach',0,0,1),(100014,'deseric@scolaire.ednet.ns.ca','Éric','Desmarais','902-832-4302','500 Larry Uteck Blvd.','500 Larry Uteck Blvd.','','Halifax','NS','B3M 0E6','November 2, 1981','Male','','Adult M',NULL,'Assistant Coach',0,0,1),(100015,'kimd@pictoulandingschool.ca','Kim','Dorrington','9027559954','43 Maple Street','43 Maple Street','','Pictou Landing','NS','B0K1X0','October 21, 1970','Female','','Adult XXL',NULL,'Main Coach',0,0,1),(100016,'libbyosgood@gmail.com','Libby','Osgood','9023940479','111 Richmond St','Unit 301','','Charlottetown','PE','C1A1H7','March 19, 1983','Female','','Adult S',NULL,'Main Coach',0,0,1),(100017,'sara.chisholm@ca.michelin.com','Sara','Chisholm','902-825-1747','158 Gates Mountain Road','158 Gates Mountain Road','','Middleton','NS','B0S1P0','October 26, 1966','Female','Team 18806','Adult M',NULL,'Assistant Coach',0,0,1),(100018,'borenech@scolaire.ednet.ns.ca','Rene','Bouillon','902-832-4302','500 Larry Uteck Blvd.','500 Larry Uteck Blvd.','','Halifax','NS','B3M 0E6','May 3, 1974','Male','','Adult L',NULL,'Main Coach',0,0,1),(100019,'sarahouthitsmith@hotmail.com','Sarah','Outhit-Smith','(902)457-6140','44','Clearview drive','','Bedford','NS','B4A 3C8','November 5, 2015','Female','','Adult XL',NULL,'Assistant Coach',0,0,1),(100020,'rpc.assistant@gmail.com','Anne','Mercer-Hall','9025851585','10005','HWY 221 RR 2','Canning','Canning','NS','B0P1H0','August 26, 1965','Female','','Adult L',NULL,'Assistant Coach',0,0,1),(100021,'cathygordrobinson@outlook.com','Cathy','Robinson','902-897-2920','2531','Lilyvale Road','','Greenfield','NS','B6L 3V1','October 5, 1968','Female','','Adult S',NULL,'Main Coach',0,0,1),(100022,'kimdoconnor@gmail.com','Kim','O\'Connor','9026982705','18 Orchard Rd','18 Orchard Rd','Kentville','Kentville','NS','B4N1R9','October 19, 1975','Female','Men\'s size shirt XL; if the shirts are women\'s shirts please use XXL.','Adult XL',NULL,'Main Coach',0,0,1),(100023,'ian_colwell@hotmail.com','Ian','Colwell','5066090926','20 Spring Lane, apt. 8','20 Spring Lane, apt. 8','','Charlottetown','PE','C1A5Z9','September 21, 1991','Male','','Adult L',NULL,'Assistant Coach',0,0,1),(100024,'hancocksharpe@doctors.org.uk','Andy','Sharpe','9025321700','861 Hwy 201','R.R. #1','','Annapolis Royal','NS','B0S 1A0','October 4, 2015','Male','','Adult XL',NULL,'Assistant Coach',0,0,1),(100025,'MDoherty@hrsb.ca','Melissa','Doherty','902-412-5369','4','Chervin Court','','Windsor Junction','NS','B2T 1G7','August 26, 1975','Female','','Adult L',NULL,'Main Coach',0,0,1),(100026,'mouellette@hrsb.ca','Monique','Ouellette','9024315537','33 Purcells Cove Rd','33 Purcells Cove Rd','33 Purcells Cove Rd','Halifax','NS','B3N 1R3','September 22, 1983','Female','','Adult S',NULL,'Main Coach',0,0,1),(100027,'walkerjc@ccrsb.ca','Jeremy','Walker','9023311932','143 Mitchell Street','143','','New Glasgow','NS','B2H1H4','October 20, 1979','Male','','Adult XL',NULL,'Main Coach',0,0,1),(100028,'allisoncameron007@hotmail.com','Allison','Cameron','9022408634','38 South Point Rd.','38 South Point Rd.','Portuguese Cove','Portuguese Cove','NS','B3V 1K3','April 2, 1959','Female','Shambhala Shadowvolts #12664','Adult S',NULL,'Main Coach',0,0,1),(100029,'acameron@shambhalaschool.org','Allison','Cameron','9022408634','38 South Point Rd.','38 South Point Rd.','Portuguese Cove','Portuguese Cove','NS','B3V 1K3','April 2, 1959','Female','Shambhala Shadowvolts #12664','Adult S',NULL,'Main Coach',0,0,1),(100030,'synchronicitynow@gmail.com','David','Jellicoe','902 999-2619','6551','Almon','','Halifax','NS','B3L1V9','August 14, 1958','Male','','Adult XL',NULL,'Assistant Coach',0,0,1),(100031,'milomilo789@hotmail.com','Milo','Crowell','902-956-8271','114','Truro Road','','North River','NS','B6L6V8','May 18, 1967','Female','','Adult M',NULL,'Main Coach',0,0,1),(100032,'hennigar6@seasidehighspeed.com','sarah','hennigar','902-890-2458','1579 greenfield rd','1579 greenfield rd','','greenfield','NS','b6l 3m1','November 1, 2015','Female','','Adult M',NULL,'Assistant Coach',0,0,1),(100033,'fraserrobinson@outlook.com','Fraser','Robinson','(902) 897-2920','2531 Lilyvale Road','2531 Lilyvale Road','','Greenfield','NS','B6L 3V1','September 13, 1998','Male','','Adult M',NULL,'Assistant Coach',0,0,1),(100034,'tchampion@gnspes.ca','Ted','Champion','902 582 2040','1816 Bains Road','1816 Bains Road','Canning','Canning','NS','B0P1H0','June 23, 1963','Male','','Adult XXL',NULL,'Main Coach',0,0,1),(100035,'phimmelm@tcrsb.ca','Peter','Himmelman','902-875-4900','PO Box 914','67 Bulkley St','','Shelburne','NS','B0T 1W0','November 6, 1968','Male','','Adult M',NULL,'Main Coach',0,0,1),(100036,'jasaunders@nstu.ca','Josh','Saunders','9024419841','93 Samuel Danial Drive','93 Samuel Danial Drive','','Easter Passage','NS','B3G 1S8','January 7, 1976','Male','','Adult M',NULL,'Main Coach',0,0,1),(100037,'greg.fox@avrsb.ca','Greg','Fox','(902) 582-2040','1816 Bains Rd, Canning, NS B0P 1H0','Bains Rd','','Canning','NS','B0P 1H0','November 9, 2015','Male','','Adult XXL',NULL,'Assistant Coach',0,0,1),(100038,'djdecoste@kes.ns.ca','DJ','DeCoste','9024723704','33 King\'s-Edgehill Lane','33 King\'s-Edgehill Lane','Windsor','Windsor','NS','B0N 2T0','May 16, 1980','Male','','Adult M',NULL,'Main Coach',0,0,1),(100039,'sleadbetter@shsh.ca','Shoneth','Leadbetter','9022400805','5820 Spring Garden Road','5820 Spring Garden Road','','Halifax','NS','B3J 1E7','October 9, 1986','Female','','Adult S',NULL,'Main Coach',0,0,1),(100040,'evan@mysterycreative.ca','Evan','Warner','902-300-0766','86','Gaspereau Ave.','','Wolfville','NS','B4P2E1','April 11, 1986','Male','Team Robo Lobo Wired','Adult M',NULL,'Main Coach',0,0,1),(100041,'ekershaw@kes.ns.ca','Eric','Kershaw','902-697-2011','Wolfville','Kent Avenue','15','Wolfville','NS','B4P1v2','January 21, 1981','Male','','Adult L',NULL,'Main Coach',0,0,1),(100042,'jeanclaude.boudreau@hrsb.ca','Jean Claude','Boudreau','902-223-0153','40 Bedros Lane Unit 104','40 Bedros Lane Unit 104','','Halifax','NS','B3M 4X1','November 8, 2015','Male','','Adult XL',NULL,'Assistant Coach',0,0,1),(100043,'lorieann.mills@gmail.com','Lorie','Mills','9024146449','26 Hauling Road','26 Hauling Road','Hacketts Cove','Hacketts Cove','NS','B3Z 0M4','November 19, 1972','Female','','Adult L',NULL,'Main Coach',0,0,1),(100044,'daugherf@eastlink.ca','Robert','Daugherty','902 553 0127','34 Pentz Road','34 Pentz Road','','Pentz','NS','B0R 1G0','May 3, 1946','Male','','Adult XL',NULL,'Main Coach',0,0,1),(100045,'oconnor.brent@gmail.com','Brent','O\'Connnor','902-678-6794','18 Orchard Road','18 Orchard Road','','Kentville','NS','B4N 1R9','November 5, 1972','Male','','Adult XL',NULL,'Assistant Coach',0,0,1),(100046,'scasey@hrsb.ca','Susan','Casey','902-823-2463','8671 Peggy\'s Cove Road','8671 Peggy\'s Cove Road','','Indian Harbour','NS','B3Z 3P5','July 4, 1974','Female','','Adult M',NULL,'Assistant Coach',0,0,1),(100047,'dybereta@nstu.ca','Darlene','Bereta','9027366273','256 Park Road','256 Park Road','','Florence','NS','B1Y1N2','January 5, 1967','Female','','Adult XXL',NULL,'Main Coach',0,0,1),(100048,'easantekorankye@dal.ca','Ernest','Korankye','902 957 1374','20 B Park Street','20 B Park Street','','Truo','NS','B2N 3J2','January 12, 1985','Male','','Adult L',NULL,'Main Coach',0,0,1),(100049,'haley.mathews0998@gmail.com','Haley','Mathews','902 895 5304','129 Queen street','129 Queen street','','Truro','NS','B2N 2B4','September 2, 1998','Female','','Adult M',NULL,'Main Coach',0,0,1),(100050,'haley.matthews0998@gmail.com','Haley','Matthews','902 895 5304','129 Queen street','129 Queen street','','Truro','NS','B2N 2B4','September 2, 1998','Female','','Adult M',NULL,'Main Coach',0,0,1),(100051,'isaiahreade@gmail.com','Isaiah','Reade','902 410 1087','6225 University Avenue','6225 University Avenue','','Halifax','NS','B3H 4R2','September 4, 1998','Male','','Adult L',NULL,'Main Coach',0,0,1),(100052,'eatonav@ccrsb.ca','Tony','Eaton','9022972757','#8','224 East Victoria St','','Amherst','NS','B4H1Y9','July 22, 1969','Male','','Adult L',NULL,'Main Coach',0,0,1),(100053,'cisert@hrsb.ca','Crystal','Isert','(902) 864-6785','100 Metropolitan Ave','100 Metropolitan Ave','','Lower Sackville','NS','B4C 2Z8','August 10, 1977','Female','','Adult S',NULL,'Main Coach',0,0,1),(100054,'kkdbarkhouse@gmail.com','Kari','Barkhouse','9025272516','2562 Aberdeen Rd','252 Aberdeen Rd','','Bridgewater','NS','B4V 2T2','July 26, 2016','Female','','Adult M',NULL,'Main Coach',0,0,1),(100055,'dickinsond@ccrsb.ca','Denise','Dickinson','(902) 251-3205','2843','Barronsfield Rd.','','River Herbert','NS','B0L 1G0','January 1, 1974','Female','','Adult XL',NULL,'Assistant Coach',0,0,1),(100056,'andriel_p@yahoo.ca','Andriel','Pitter','902-542-1545','8 Fairfield St','8 Fairfield St','','Wolfville','NS','B4P 1L9','December 28, 1966','Female','','Adult L',NULL,'Assistant Coach',0,0,1),(100057,'hale.matthews0998@gmail.com','Haley','Matthews','(902) 802-9824','129','Queen St.','','Truro','NS','b2n2b4','September 2, 1998','Female','','Adult M',NULL,'Main Coach',0,0,1),(100058,'asp.imhotep@dal.ca','Ifunanya','Kammelu','(902) 494-4037','6225','University Ave.','','Halifax','NS','b3h4r2','October 20, 1993','Female','','Adult M',NULL,'Assistant Coach',0,0,1),(100059,'namarsh99@hotmail.com','Natalie','Marsh','902 736-6787','249  Point Aconi Road','249 Point Aconi Road','','MilleCreek','NS','B1Y 1W9','June 27, 1963','Female','','Adult L',NULL,'Assistant Coach',0,0,1),(100060,'jkdaborn@gnspes.ca','John','Daborn','902-670-9778','7375','Brooklyn St.','Kentville','Kentville','NS','B4N 3V7','November 7, 1987','Male','','Adult XXL',NULL,'Main Coach',0,0,1),(100061,'micahlink@gmail.com','micah','Linkletter','902-986-1598','9','Walnut Crt','','Truro','NS','B2N 5S6','October 9, 1978','Male','','Adult XXL',NULL,'Assistant Coach',0,0,1),(100062,'jlcole76@gmail.com','Jaime','Cole','(902)836-4283','434 MacIntyre Rd.','434 MacIntyre Road','','Kensington','PE','C0B 1M0','June 7, 1975','Female','','Adult M',NULL,'Main Coach',0,0,1),(100064,'imhotep@dal.ca','Sidney','Idemudia','9024947884','6225 UNIVERSITY AVE., ROOM G40M/N. P.O. Box 15000','6225 UNIVERSITY AVE., ROOM G40M/N. P.O. Box 15000','6225 UNIVERSITY AVE., ROOM G40M/N. P.O. Box 15000','Halifax','NS','B3H 4R2','April 25, 1990','Male','','Adult M',NULL,'Assistant Coach',0,0,1),(100065,'sharla.rolfe-hunter@nscc.ca','Sharla','Rolfe-Hunter','902-584-2056','50','Elliot Rd. RR1','','Lawerencetown','NS','b0s 1m0','December 1, 2000','Female','','Adult M',NULL,'Qualifier Admin',0,1,0),(100066,'lgdonovan@staff.ednet.ns.ca','Leo','Donovan','9022852158','27 Old School Lane','PO Box 142','Ingonish Beach','Ingonish Beach','NS','B0C 1L0','October 18, 1970','Male','','Adult L',NULL,'Main Coach',0,0,1),(100067,'lists@dixonfamily.ca','Jon','Dixon','9026817683','9453 Commercial St.','9453 Commercial St.','','New Minas','NS','B4N 3G3','July 10, 1977','Male','','Adult XXL',NULL,'Main Coach',0,0,1),(100068,'bwalker@eastlink.ca','Robert','Walker','902-404-6427','12','Edgewater Close','','Dartmouth','NS','B2W 6S3','September 13, 1961','Male','','Adult L',NULL,'Main Coach',0,0,1),(100069,'programmingpanthers@gmail.com','Jill','Fraser','(902)695-5287','297','North main Street','','Trenton','NS','B0K 1X0','March 16, 2015','Female','','Adult L',NULL,'Main Coach',0,0,1),(100070,'shelly.bembridge@gmail.com','Shelly','Bembridge','902-229-7377','17','Falcon Run','','Bedford','NS','B4A 2Y8','July 4, 1974','Female','','Adult M',NULL,'Main Coach',0,0,1),(100071,'mackieke@ccrsb.ca','Kathryn','Mackie','(902) 921-8613','52','Lovet Cres.','','New Glasgow','NS','B2H 0B2','December 12, 1985','Female','','Adult M',NULL,'Assistant Coach',0,0,1),(100072,'leblcody@scolaire.ednet.ns.ca','Cody','LeBlanc','(902)896-4500','50 Aberdeen St.','50 Aberdeen St','','Truro','NS','B2N 4V3','February 14, 1984','Male','','Adult XL',NULL,'Main Coach',0,0,1),(100073,'rwalker@hrsb.ca','Zeyas','1','(902) 457-8930','45','Plateau Cres','','Halifax','NS','B3M 2V7','April 12, 2003','Male','Mentor','Youth S',NULL,'Assistant Coach',0,0,1),(100074,'steele01@ns.sympatico.ca','J\'aime','Steele','9028600580','221 Philip Dr','221 Philip Dr','','Fall River','NS','B2T1H7','April 14, 1976','Female','','Adult M',NULL,'Main Coach',0,0,1),(100075,'kyleandcrista@bellalient.net','Crista','MacNeil','(902) 389-2519','PO Box 155','1507 Palmer Dr.','','Kingston','NS','B0P 1R0','August 15, 1975','Female','','Adult XXL',NULL,'Main Coach',0,0,1),(100076,'annelmartin@eastlink.ca','Anne','Martin','902-445-8125','63','Woodward Crescent','','Halifax','NS','B3M 1J6','November 21, 1967','Female','','Adult M',NULL,'Main Coach',0,0,1),(100077,'thesteelesare@gmail.com','Mark','Steele','(902) 860-0580','221','Philip Dr','','Fall River','NS','B2T 1H7','November 19, 2015','Male','','Adult XXL',NULL,'Assistant Coach',0,0,1),(100078,'coordinator@capcbco.ca','Rachael','MacKeigan','(902) 979-0036','8','Crystal Dr.','','Florence','NS','B1Y 1G6','March 5, 1984','Female','','Adult M',NULL,'Main Coach',0,0,1),(100079,'jobs@capcbco.ca','Chelsea','Butts','(902) 979-0036','8','Crystal Dr.','','Florence','NS','B1Y 1G6','October 8, 1991','Female','','Adult S',NULL,'Assistant Coach',0,0,1),(100080,'currie@gnspes.ca','Mark','Currie','902 521-2655','3504 Hwy 332','Box 2B-1','RR#1','Rose Bay','NS','B0J 1X0','July 4, 1969','Male','','Adult XL',NULL,'Main Coach',0,0,1);
/*!40000 ALTER TABLE `HasRole` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Helps`
--

DROP TABLE IF EXISTS `Helps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Helps` (
  `qual_id` int(10) NOT NULL,
  `competition_id` int(10) NOT NULL,
  `season_year` varchar(128) NOT NULL,
  `volunteer_id` int(10) NOT NULL,
  PRIMARY KEY (`qual_id`,`competition_id`,`season_year`,`volunteer_id`),
  KEY `competition_id` (`competition_id`),
  KEY `volunteer_id` (`volunteer_id`),
  KEY `season_year` (`season_year`),
  CONSTRAINT `Helps_ibfk_1` FOREIGN KEY (`qual_id`) REFERENCES `Qualifiers` (`qual_id`),
  CONSTRAINT `Helps_ibfk_2` FOREIGN KEY (`competition_id`) REFERENCES `Competitions` (`competition_id`),
  CONSTRAINT `Helps_ibfk_3` FOREIGN KEY (`volunteer_id`) REFERENCES `Volunteers` (`volunteer_id`),
  CONSTRAINT `Helps_ibfk_4` FOREIGN KEY (`season_year`) REFERENCES `Seasons` (`year`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Helps`
--

LOCK TABLES `Helps` WRITE;
/*!40000 ALTER TABLE `Helps` DISABLE KEYS */;
/*!40000 ALTER TABLE `Helps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `HostQualifiers`
--

DROP TABLE IF EXISTS `HostQualifiers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `HostQualifiers` (
  `user_id` int(10) NOT NULL,
  `qual_id` int(10) NOT NULL,
  `competition_id` int(10) NOT NULL,
  `season_year` varchar(128) NOT NULL,
  PRIMARY KEY (`user_id`,`qual_id`,`competition_id`,`season_year`),
  KEY `season_year` (`season_year`),
  KEY `competition_id` (`competition_id`),
  KEY `qual_id` (`qual_id`),
  CONSTRAINT `HostQualifiers_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `Users` (`user_id`),
  CONSTRAINT `HostQualifiers_ibfk_2` FOREIGN KEY (`season_year`) REFERENCES `Qualifiers` (`season_year`),
  CONSTRAINT `HostQualifiers_ibfk_3` FOREIGN KEY (`competition_id`) REFERENCES `Qualifiers` (`competition_id`),
  CONSTRAINT `HostQualifiers_ibfk_4` FOREIGN KEY (`qual_id`) REFERENCES `Qualifiers` (`qual_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `HostQualifiers`
--

LOCK TABLES `HostQualifiers` WRITE;
/*!40000 ALTER TABLE `HostQualifiers` DISABLE KEYS */;
INSERT INTO `HostQualifiers` VALUES (100002,100001,100000,'2015-2016'),(100004,100003,100000,'2015-2016'),(100006,100005,100000,'2015-2016'),(100007,100004,100000,'2015-2016'),(100065,100002,100000,'2015-2016');
/*!40000 ALTER TABLE `HostQualifiers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Hosts`
--

DROP TABLE IF EXISTS `Hosts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Hosts` (
  `user_id` int(10) NOT NULL,
  `season_year` varchar(128) NOT NULL,
  PRIMARY KEY (`user_id`,`season_year`),
  KEY `season_year` (`season_year`),
  CONSTRAINT `Hosts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `Users` (`user_id`),
  CONSTRAINT `Hosts_ibfk_2` FOREIGN KEY (`season_year`) REFERENCES `Seasons` (`year`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Hosts`
--

LOCK TABLES `Hosts` WRITE;
/*!40000 ALTER TABLE `Hosts` DISABLE KEYS */;
INSERT INTO `Hosts` VALUES (100000,'2015-2016');
/*!40000 ALTER TABLE `Hosts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Manages`
--

DROP TABLE IF EXISTS `Manages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Manages` (
  `team_id` varchar(128) NOT NULL,
  `user_id` int(10) NOT NULL,
  PRIMARY KEY (`team_id`,`user_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `Manages_ibfk_1` FOREIGN KEY (`team_id`) REFERENCES `Teams` (`team_id`),
  CONSTRAINT `Manages_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `Users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Manages`
--

LOCK TABLES `Manages` WRITE;
/*!40000 ALTER TABLE `Manages` DISABLE KEYS */;
INSERT INTO `Manages` VALUES ('20836',100005),('2096',100005),('0000',100008),('0001',100008),('123123',100008),('21018',100010),('3015',100011),('14628',100012),('14079',100013),('19583',100013),('11386',100014),('15092',100016),('5885',100016),('18806',100017),('11386',100018),('3015',100019),('123123',100020),('3067',100021),('16886',100022),('21741',100022),('15092',100023),('5885',100023),('20836',100024),('2096',100024),('20743',100025),('21803',100025),('2499',100026),('19863',100027),('12664',100029),('12664',100030),('3496',100031),('3067',100032),('3067',100033),('1979-1',100034),('21404',100034),('4381',100035),('14410',100036),('14412',100036),('21404',100037),('18317',100038),('2170-1',100038),('2170-2',100038),('2170-3',100038),('10716',100039),('2815',100040),('18317',100041),('2499',100042),('10177',100043),('2544',100044),('16886',100045),('10177',100046),('16393',100047),('8435',100047),('14200',100048),('14209',100048),('14209',100050),('14200',100051),('2533',100052),('2563',100053),('21530',100054),('2533',100055),('2815',100056),('14200',100058),('14209',100058),('16393',100059),('8435',100059),('3496',100061),('15092',100062),('14200',100064),('14209',100064),('21614',100066),('21741',100067),('14193',100068),('7085',100069),('11273',100070),('7085',100071),('4379',100072),('14193',100073),('21086',100074),('18806',100075),('2699',100076),('21086',100077),('14400',100078),('21736',100078),('14400',100079),('21736',100079),('2464',100080);
/*!40000 ALTER TABLE `Manages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Members`
--

DROP TABLE IF EXISTS `Members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Members` (
  `member_id` int(10) NOT NULL AUTO_INCREMENT,
  `team_id` varchar(128) NOT NULL,
  `email` varchar(128) NOT NULL,
  `first_name` varchar(128) DEFAULT NULL,
  `last_name` varchar(128) DEFAULT NULL,
  `civic_number` varchar(128) DEFAULT NULL,
  `street1` varchar(128) DEFAULT NULL,
  `street2` varchar(128) DEFAULT NULL,
  `city` varchar(128) DEFAULT NULL,
  `province` varchar(128) DEFAULT NULL,
  `postal_code` char(7) DEFAULT NULL,
  `dob` varchar(128) DEFAULT NULL,
  `gender` varchar(30) DEFAULT NULL,
  `shirt_size` varchar(30) DEFAULT NULL,
  `guardian_name` varchar(128) DEFAULT NULL,
  `guardian_email` varchar(128) DEFAULT NULL,
  `guardian_phone` varchar(30) DEFAULT NULL,
  `medical_info` varchar(255) DEFAULT NULL,
  `consent` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`member_id`,`team_id`),
  KEY `team_id` (`team_id`),
  CONSTRAINT `Members_ibfk_1` FOREIGN KEY (`team_id`) REFERENCES `Teams` (`team_id`)
) ENGINE=InnoDB AUTO_INCREMENT=100308 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Members`
--

LOCK TABLES `Members` WRITE;
/*!40000 ALTER TABLE `Members` DISABLE KEYS */;
INSERT INTO `Members` VALUES (100000,'2096','jhafting@acadian.ca','Finn','Hafting','712 St. George Street','712 St. George Street','','Annapolis Royal','NS','B0S1A0','October 9, 2000','Male','Adult M',NULL,NULL,'902 402 3700','',''),(100006,'123123','blah@gmail.com','Billy','Joe','','','','','','','November 4, 2015','Other','Adult XS',NULL,NULL,'','',''),(100007,'123123','blah@gmail.com','Bobby','Sue','','','','','','','November 10, 2015','Other','Adult S',NULL,NULL,'','',''),(100008,'123123','blah@gmail.c','Jack','Flash','','','','','','','November 3, 2015','Other','Youth M',NULL,NULL,'','',''),(100009,'123123','blah@gmail.com','Ruby','Tuesday','','','','','','','November 26, 2015','Other','Youth M',NULL,NULL,'','',''),(100011,'14628','heather.sullivan@tcrsb.ca','Cooper','Theriault','','','','','','','January 20, 2006','Male','Youth M',NULL,NULL,'','',''),(100012,'14628','heather.sullivan@tcrsb.ca','Jordan','Mullen-Deveau','','','','','','','March 13, 2002','Male','Youth L',NULL,NULL,'','',''),(100013,'14628','heather.sullivan@tcrsb.ca','Nick','Balser','','','','','','','June 18, 2003','Male','Youth L',NULL,NULL,'','',''),(100014,'14628','heather.sullivan@tcrsb.ca','Mitchell','Annand','','','','','','','March 2, 2005','Male','Youth M',NULL,NULL,'','',''),(100015,'14628','heather.sullivan@tcrsb.ca','Ethan','Ettinger','','','','','','','September 5, 2005','Male','Youth L',NULL,NULL,'','',''),(100016,'14628','heather.sullivan@tcrsb.ca','Ava','Mullen','','','','','','','February 19, 2005','Female','Youth M',NULL,NULL,'','',''),(100017,'11386','borenech@scolaire.ednet.ns.ca','Rene','Bouillon','500 Larry Uteck','500 Larry Uteck','','Halifax','NS','B3M0E6','May 3, 1974','Male','Adult L',NULL,NULL,'902-832-4302','',''),(100018,'3015','sarahouthitsmith@hotmail.com','Victoria','Smith','','','','','','','June 26, 2004','Female','Adult S',NULL,NULL,'','',''),(100019,'3015','Tamara.Franz-Odendaal@msvu.ca','Julia','Odendaal','','','','','','','July 13, 2004','Female','Adult S',NULL,NULL,'','',''),(100020,'15092','eosgood@upei.ca','Emily','Cousins','','','','','','','May 30, 2005','Female','Youth S',NULL,NULL,'','',''),(100021,'15092','eosgood@upei.ca','Mallory','Cole','','','','','','','April 18, 2006','Female','Youth S',NULL,NULL,'','',''),(100022,'15092','eosgood@upei.ca','Ethan','Cole','','','','','','','August 22, 2003','Male','Youth L',NULL,NULL,'','',''),(100023,'15092','eosgood@upei.ca','Dylan','Moase','','','','','','','September 23, 2002','Male','Youth XL',NULL,NULL,'','',''),(100024,'15092','eosgood@upei.ca','Matthew','MacNeill','','','','','','','November 24, 2003','Male','Youth L',NULL,NULL,'','',''),(100025,'15092','eosgood@upei.ca','Matthew','Sevigny','','','','','','','June 28, 2005','Male','Youth L',NULL,NULL,'','',''),(100026,'15092','eosgood@upei.ca','Salman','Muhammad','','','','','','','September 14, 2003','Male','Adult S',NULL,NULL,'','',''),(100027,'15092','eosgood@upei.ca','Samuel','Pendleton','','','','','','','July 15, 2006','Male','Youth M',NULL,NULL,'','',''),(100028,'15092','eosgood@upei.ca','Zackary','Pendleton','','','','','','','May 23, 2003','Male','Youth XL',NULL,NULL,'','',''),(100029,'15092','eosgood@upei.ca','Dawson','MacKeigan','','','','','','','January 14, 2003','Male','Youth L',NULL,NULL,'','',''),(100030,'5885','eosgood@upei.ca','Nathan','Liang','','','','','','','December 21, 2004','Male','Youth M',NULL,NULL,'','',''),(100031,'5885','eosgood@upei.ca','Liam','Kelly-Kardos','','','','','','','January 2, 2002','Male','Adult L',NULL,NULL,'','',''),(100032,'5885','eosgood@upei.ca','Benjamin','Davidson','','','','','','','January 9, 2001','Male','Adult L',NULL,NULL,'','',''),(100033,'5885','eosgood@upei.ca','Sammy','MacLean','','','','','','','July 20, 2001','Male','Adult M',NULL,NULL,'','',''),(100034,'5885','eosgood@upei.ca','Markus','Wiedemer','','','','','','','July 11, 2003','Male','Youth L',NULL,NULL,'','',''),(100035,'5885','eosgood@upei.ca','Noah','Mannholland','','','','','','','February 12, 2001','Male','Adult L',NULL,NULL,'','',''),(100036,'5885','eosgood@upei.ca','Michael','MacEwen','','','','','','','April 4, 2002','Male','Adult S',NULL,NULL,'','',''),(100037,'5885','eosgood@upei.ca','Ava','Kelly-Kardos','','','','','','','July 12, 2004','Female','Youth S',NULL,NULL,'','',''),(100038,'2096','jhafting@acadian.ca','Elsa','Hafting','','','','','','','January 4, 2003','Female','Adult S',NULL,NULL,'','',''),(100039,'2096','jhafting@acadian.ca','Aidan','McGowan','','','','','','','October 3, 2001','Male','Youth L',NULL,NULL,'','',''),(100040,'2096','jhafting@acadian.ca','Alexandra','Hancock','','','','','','','October 13, 2000','Female','Adult M',NULL,NULL,'','',''),(100041,'2096','jhafting@acadian.ca','Sara','Abel','','','','','','','March 14, 2001','Female','Adult S',NULL,NULL,'','',''),(100042,'2096','jhafting@acadian.ca','Griffin','Batt','','','','','','','March 8, 2001','Male','Adult L',NULL,NULL,'','',''),(100043,'2096','jhafting@acadian.ca','Abigail','Bonnington','','','','','','','May 19, 2000','Female','Adult M',NULL,NULL,'','',''),(100044,'20836','jhafting@acadian.ca','Saul','Hafting','','','','','','','February 28, 2005','Male','Youth M',NULL,NULL,'','',''),(100045,'20836','jhafting@acadian.ca','Julian','McCarty','','','','','','','November 16, 2004','Male','Youth L',NULL,NULL,'','',''),(100046,'3067','cathygordrobinson@outlook.com','David','Robinson','','','','','NS','','May 5, 2005','Male','Youth M',NULL,NULL,'','',''),(100047,'3067','svchildcare.sh@gmail.com','Evan','Hennigar','','','','','','','October 12, 2005','Male','Youth L',NULL,NULL,'','',''),(100048,'3067','tmaccabe@hotmail.com','Aaron','MacCabe','','','','','','','January 13, 2002','Male','Adult M',NULL,NULL,'','',''),(100049,'3067','sjpaterson@eastlink.ca','Stephen','Burnett','','','','','','','November 18, 2002','Male','Youth XL',NULL,NULL,'','',''),(100050,'3067','sherri@bashan.ca','Canaan','Hebb','','','','','','','December 7, 2002','Male','Adult M',NULL,NULL,'','',''),(100051,'3067','melcotterill@hotmail.com','Ian','Cotterill','','','','','','','October 7, 2005','Male','Youth M',NULL,NULL,'','',''),(100052,'3067','macritchies@eastlink.ca','Joshua','MacRitchie','','','','','','','September 3, 2004','Male','Youth L',NULL,NULL,'','',''),(100053,'21018','cathymurphy@eastlin.ca','Jack','Hirtle','','','','','','','September 22, 2002','Male','Adult L',NULL,NULL,'','',''),(100054,'21018','tayub@hotmail.com','Hassaan','Tariq','','','','','','','February 4, 2001','Male','Adult L',NULL,NULL,'','',''),(100055,'21018','nadine.king@ns.sympatico.ca','Benjamin','King','','','','','','','November 15, 2000','Male','Adult L',NULL,NULL,'','',''),(100056,'21018','chrissnodden@eastlink.ca','Shae','Snodden','','','','','','','April 19, 2002','Male','Adult L',NULL,NULL,'','',''),(100057,'21018','nicolesyms@gmail.com','Thomas','Syms','','','','','','','April 11, 2002','Male','Adult L',NULL,NULL,'','',''),(100058,'21018','jeannette.c.cjanssen@gmail.com','Rustam-Jan','Kalyani-Janssen','','','','','','','February 4, 2003','Male','Adult M',NULL,NULL,'','',''),(100059,'21018','michaelandvicky.craig@ns.sympatico.ca','Matthew','Craig','','','','','','','October 11, 2003','Male','Adult M',NULL,NULL,'','',''),(100060,'21803','erikafgrandy@hotmail.com','Erika','Grandy','','','','','','','March 12, 2001','Female','Adult L',NULL,NULL,'','',''),(100061,'21018','holly.campbell@hrsb.ca','Connor','Campbell','','','','','','','May 21, 2003','Male','Adult XXL',NULL,NULL,'','',''),(100062,'21803','zaccourrier@gmail.com','Zach','Courrier','','','','','','','June 26, 2001','Male','Adult S',NULL,NULL,'','',''),(100063,'21018','austinpaquin@hotmail.com','Austin','Paquin','','','','','','','November 10, 2000','Male','Adult M',NULL,NULL,'','',''),(100064,'21803','madi.juntermanns@gmail.com','Madison','Juntermanns','','','','','','','May 2, 2001','Female','Adult M',NULL,NULL,'','',''),(100065,'21018','tina_broderick@hotmail.com','Todd','Deagle','','','','','','','October 3, 2000','Male','Adult XL',NULL,NULL,'','',''),(100069,'20836','jhafting@acadian.ca','Dylan','Longmire','','','','','','','September 3, 2004','Male','Adult L',NULL,NULL,'','',''),(100070,'12664','acameron@shambhalaschool.org','Lily','Harris','','','','','','','September 29, 2004','Female','Youth M',NULL,NULL,'','',''),(100071,'12664','acameron@shambhalaschool.org','Lilian','Hougan-Veenema','','','','','','','April 3, 2004','Female','Youth L',NULL,NULL,'','',''),(100072,'12664','acameron@shambhalaschool.org','DD','Robertson Webb','','','','','','','January 25, 2003','Male','Adult M',NULL,NULL,'','',''),(100073,'12664','acameron@shambhalaschool.org','Rowan','West','','','','','','','June 12, 2003','Female','Youth L',NULL,NULL,'','',''),(100074,'12664','acameron@shambhalaschool.org','Finn','Murphy','','','','','','','June 4, 2002','Male','Adult M',NULL,NULL,'','',''),(100075,'16886','kbtoconnor@gmail.com','Timothy','O\'Connor','','','','','','','October 2, 2004','Male','Youth XL',NULL,NULL,'','',''),(100076,'16886','kristyl@nspes.ca','Ben','Welton','','','','','','','June 19, 2004','Male','Youth M',NULL,NULL,'','',''),(100077,'16886','steph.hayne1@gmail.com','Andrew','Shirritt','','','','','','','December 6, 2003','Male','Youth XL',NULL,NULL,'','',''),(100078,'16886','legomind10@gmail.com','Sam','Chute','','','','','','','April 4, 2001','Male','Adult M',NULL,NULL,'','',''),(100079,'3496','milomilo789@hotmail.com','Nicholas','Crowell','114','Truro Road','','North River','NS','B6L 6V8','April 29, 2002','Male','Adult M',NULL,NULL,'902-956-8271','',''),(100080,'3496','milomilo789@hotmail.com','Lindsay','Crowell','114','Truro Road','','North River','NS','B6L 6V8','February 17, 2006','Female','Adult S',NULL,NULL,'902 956 8271','',''),(100081,'3496','sandraplussix@gmail.com','Jack','Somers','326','King Street','','Truro','NS','B2N 3L6','November 17, 2001','Male','Adult M',NULL,NULL,'902-897-0870','',''),(100082,'3496','cathygordrobinson@outlook.com','James','Robinson','2531','Lilyvale Road','','Greenfield','NS','B6L 3V1','April 4, 2002','Male','Adult M',NULL,NULL,'902-897-2920','',''),(100083,'3496','markcormier@bellaliant.net','Matthew','Cormier','133','Saxby Lane','','Brookside','NS','B6L 2T4','December 12, 2005','Male','Adult S',NULL,NULL,'902 895 2202','',''),(100084,'3496','candjelgee@gmail.com','Sam','Elgee','2024','Prince Street','','Truro','NS','B2N 1K3','May 1, 2003','Male','Adult M',NULL,NULL,'902-843-5296','',''),(100085,'3496','ecooper1110@gmail.com','Zachary','Gray','65','Edgewood Drive','','Truro','NS','B2N 1P1','October 11, 2002','Male','Adult M',NULL,NULL,'902 893 7313','',''),(100086,'3496','tawnyastates@hotmail.com','Xavier','Barrington','120','Hillcrest Avenue','','Bible Hill','NS','B2N 4L3','February 25, 2002','Male','Adult XL',NULL,NULL,'902-843-5960','',''),(100090,'20836','jhafting@acadian.ca','Ethan','Archibald','','','','','','','January 24, 2004','Male','Youth M',NULL,NULL,'','',''),(100091,'20836','jhafting@acadian.ca','Dustin','Chute','','','','','','','March 15, 2004','Male','Adult S',NULL,NULL,'','',''),(100092,'20836','jhafting@acadian.ca','Dawson','Edwards','','','','','','','August 20, 2004','Male','Youth L',NULL,NULL,'','',''),(100093,'20836','jhafting@acadian.ca','Quinn','Emery','','','','','','','November 6, 2004','Male','Youth XL',NULL,NULL,'','',''),(100094,'20836','jhafting@acadian.ca','Dane','Robinson','','','','','','','April 6, 2004','Male','Youth M',NULL,NULL,'','',''),(100095,'21404','tchampion@gnspes.ca','Kris','Mackinnon','1816 Bains Road','','','Canning','NS','B0P1H0','November 12, 2003','Male','Adult XS',NULL,NULL,'','',''),(100096,'21404','tchampion@gnspes.ca','Zack','Raymond','1816 Bains Road','','','Canning','','B0P1h0','December 29, 2002','Male','Adult M',NULL,NULL,'','',''),(100097,'21404','tchampion@gnspes.ca','Lucas','Robicheau','1816 Bains Road','','','Canning','','B0P1h0','August 7, 2003','Male','Adult L',NULL,NULL,'','',''),(100098,'21404','tchampion@gnspes.ca','Jason','Dominey','1816 Bains Road','','','Canning','','B0P1h0','October 12, 2003','Male','Adult M',NULL,NULL,'','',''),(100099,'21404','tchampion@gnspes.ca','Antonio','Blair','1816 Bains Road','','','Canning','NS','B0P1h0','January 31, 2002','Male','Adult L',NULL,NULL,'','',''),(100100,'21404','tchampion@gnspes.ca','Noah','Hillier','1816 Bains Road','','','Canning','NS','B0P1h0','June 16, 2003','Male','Adult S',NULL,NULL,'','',''),(100101,'21404','tchampion@gnspes.ca','Seth','Spinney','1816 Bains Road','','','Canning','NS','B0P1h0','April 7, 2004','Male','Adult M',NULL,NULL,'','',''),(100102,'21404','tchampion@gnspes.ca','Samuel','McNally','1816 Bains Road','','','Canning','NS','B0P1H0','February 27, 2002','Male','Adult L',NULL,NULL,'','',''),(100103,'20836','jhafting@acadian.ca','Gabriel','Charlton','','','','','','','September 4, 2004','Male','Adult M',NULL,NULL,'','',''),(100104,'16886','rsacrey@wnns.ca','Jonah','Sacrey','','','','','','','January 17, 2002','Male','Youth XL',NULL,NULL,'','',''),(100105,'2499','xingliang2002@gmail.com','Xingliang','Li','','','','','NS','','July 19, 2002','Male','Adult L',NULL,NULL,'','',''),(100106,'2499','epicsami02@gmail.com','Sami','Saber','','','','Halifax','NS','','June 15, 2002','Male','Adult M',NULL,NULL,'9028090382','duck',''),(100107,'2499','MonkBoks@gmail.com','Cameron','Calder','','','','','','','May 15, 2002','Male','Youth M',NULL,NULL,'','',''),(100108,'10177','brodie.mills@gmail.com','Brodie','Mills','','','','','','','June 19, 2004','Male','Adult M',NULL,NULL,'','',''),(100109,'18806','sisoscience1@gmail.com','Kenzie','MacNeil','','','','','','','March 16, 2006','Female','Youth M',NULL,NULL,'','',''),(100110,'16393','flemmingangela@yahoo.ca','MacKenzie','Bachmann','','24 Milville Hwy','','Milville','NS','B1Y2C5','October 14, 2002','Female','Adult S',NULL,NULL,'','',''),(100111,'16393','shannonbarrie@hotmail.com','Barrie','Leah','','2523 long Island Road','','Long Island','NS','B1Y3M6','August 21, 2003','Female','Adult S',NULL,NULL,'','',''),(100112,'16393','temh.penney@gmail.com','Penny','Hannah','','2555 Long Island','','LongIsland','NS','B1Y 3M6','May 31, 2003','Female','Adult L',NULL,NULL,'','',''),(100113,'2499','mouellette@hrsb.ca','Ethan','Lafond','','','','','','','January 18, 2002','Male','Adult S',NULL,NULL,'','',''),(100114,'2499','mouellette@hrsb.ca','Harrison','Ingham','','','','','','','September 11, 2002','Male','Youth M',NULL,NULL,'','',''),(100115,'2499','mouellette@hrsb.ca','Jack','Kilfoil','','1540 Henry St','1540 Henry St','Halifax NS','Object','B3H 3J9','November 10, 2002','Male','Adult M',NULL,NULL,'902 422 1293','',''),(100117,'2533','juliasouth31@gmail.com','Julia','Griggs','RR#2','Southhampton','','','NS','','April 15, 2004','Female','Youth S',NULL,NULL,'','',''),(100120,'2533','hhoeg@hotmail.com','Alex','Hoeg','','','','','','','June 11, 2006','Male','Youth M',NULL,NULL,'','',''),(100121,'2533','eatonav@ccrsb.ca','Spencer','Ackroyd','','','','','','','October 20, 2004','Male','Youth L',NULL,NULL,'','',''),(100122,'2533','staceygilroy@hotmail.com','Cadence','Burbine','','','','','','','June 11, 2006','Female','Youth M',NULL,NULL,'','',''),(100123,'2533','cath2886@gmail.com','Alexis','Jeffers','','','','','','','October 22, 2006','Female','Youth M',NULL,NULL,'','',''),(100124,'2533','hollycormier14@gmail.com','Matthew','Ripley','','','','','','','October 11, 2003','Male','Youth XL',NULL,NULL,'','',''),(100129,'2533','fincksam@gmail.com','Curtis','Kemsley','','','','','','','September 11, 2006','Male','Youth XL',NULL,NULL,'','',''),(100130,'2533','april.allen@von.ca','Kaden','Allen','','','','','','','August 16, 2006','Male','Youth XL',NULL,NULL,'','',''),(100132,'2499','moulette@hrsb.ca','Zach','Glazebrook','','','','','','','February 20, 2002','Male','Youth XL',NULL,NULL,'','',''),(100133,'2499','jpchevalier02@gmail.com','Jay','Chevalier','','','','','','','June 27, 2003','Male','Adult M',NULL,NULL,'','',''),(100134,'21530','kkdbarkhouse@gmail.com','Jonas','Talbot','','','','','NS','','September 17, 2015','Male','Youth L',NULL,NULL,'','',''),(100135,'21530','kkdbarkhouse@gmail.com','Cyndeyr','Levandier','','','','','NS','','August 26, 2004','Male','Adult M',NULL,NULL,'','',''),(100136,'21530','kkdbarkhouse@gmail.com','Sam','Tanner','','','','','NS','','October 23, 2004','Male','Youth M',NULL,NULL,'','',''),(100137,'21530','kkdbarkhouse@gmail.com','Adam','Culbert','','','','','NS','','June 15, 2003','Male','Adult L',NULL,NULL,'','',''),(100138,'21530','kkdbarkhouse@gmail.com','Brandon','O\'Quinn','','','','','NS','','February 10, 2003','Male','Youth L',NULL,NULL,'','',''),(100139,'21530','kkdbarkhouse@gmail.com','Keegan','Hall','','','','','NS','','May 19, 2004','Male','Youth M',NULL,NULL,'','',''),(100140,'21530','kkdbarkhouse@gmail.com','Brett','Risser','','','','','NS','','December 19, 2004','Male','Youth M',NULL,NULL,'','',''),(100141,'21530','kkdbarkhouse@gmail.com','Gregory','Croft','','','','','NS','','March 3, 2003','Male','Adult L',NULL,NULL,'','',''),(100142,'8435','bcc37183@nspes.ca','Clay','Brace','','935 Old Route 5','','Big Bras d\'Or','NS','B1X1Y6','June 1, 2015','Male','Youth L',NULL,NULL,'','Birthday should read June 1, 2004 For some reason it will not let me change it.',''),(100143,'8435','kstairs8@hotmail.com','Daelen','Stairs','','52 Russell Drive','','Bras d\"or','NS','B1Y 2B8','May 27, 2015','Male','Youth L',NULL,NULL,'','Year for birth date should read 2004',''),(100144,'8435','mnw367609@nspes.ca','Noah','Marsh','','252 King Grove Road','','Millville','NS','B1Y 2E5','July 25, 2004','Male','Youth L',NULL,NULL,'','',''),(100145,'8435','kristamarsh79@yahoo.ca','Ryder','Marsh','','1066 Point Aconi Road','','Point Aconi','NS','B1Y 2A7','November 1, 2004','Male','Youth L',NULL,NULL,'','',''),(100146,'8435','dlmartin@eastlink.ca','Logan','Martin','','388 Johnson Road','','Georges River','NS','B1Y 3Y6','June 28, 2004','Male','Youth L',NULL,NULL,'','',''),(100147,'8435','kdshebib@hotmail.com','Kirk','Shebib','','760 Kings Grove Road','','Millville','NS','B1Y 2E9','February 8, 2004','Male','Youth L',NULL,NULL,'','',''),(100148,'19863','walkerjc@ccrsb.ca','Ethan','Macdonald','','','','','','','June 15, 2005','Male','Adult M',NULL,NULL,'','',''),(100149,'19863','walkerjc@ccrsb.ca','Jacob','MacGillvary','','','','','','','August 10, 2005','Male','Adult M',NULL,NULL,'','',''),(100150,'19863','walkerjc@ccrsb.ca','Hannah','Cameron','','','','','','','May 18, 2005','Female','Adult M',NULL,NULL,'','',''),(100151,'19863','walkerjc@ccrsb.ca','Kyle','Simms','','','','','','','February 19, 2004','Male','Adult L',NULL,NULL,'','Mentor',''),(100152,'19863','walkerjc@ccrsb.ca','Dean','Winters','','','','','','','August 19, 2005','Male','Adult M',NULL,NULL,'','Mentor',''),(100153,'19863','walkerjc@ccrsb.ca','Savannah','Murray','','','','','','','March 14, 2005','Female','Adult M',NULL,NULL,'','Mentor',''),(100154,'19863','walkerjc@ccrsb.ca','Logan','Clyburne-Lewis','','','','','','','December 7, 2005','Male','Adult M',NULL,NULL,'','',''),(100155,'19863','walkerjc@ccrsb.ca','Mady','Momberquette','','','','','','','October 3, 2005','Female','Adult M',NULL,NULL,'','Mentor',''),(100156,'19863','walkerjc@ccrsb.ca','Brooklyn','Hazel','','','','','','','August 11, 2005','Female','Adult M',NULL,NULL,'','',''),(100157,'19863','walkerjc@ccrsb.ca','Shalyn','Clyburne-Lewis','','','','','','','March 8, 2005','Female','Adult M',NULL,NULL,'','',''),(100158,'19863','walkerjc@ccrsb.ca','Bradley','Hale','','','','','','','December 5, 2005','Male','Adult M',NULL,NULL,'','',''),(100159,'19863','walkerjc@ccrsb.ca','MaKayla','McGee','','','','','','','May 17, 2005','Female','Adult M',NULL,NULL,'','',''),(100160,'19863','walkerjc@ccrsb.ca','Shelby','Noel','','','','','','','August 8, 2004','Female','Adult M',NULL,NULL,'','',''),(100161,'19863','walkerjc@ccrsb.ca','Jesse','Latter','','','','','','','September 2, 2005','Male','Adult M',NULL,NULL,'','Mentor',''),(100162,'19863','walkerjc@ccrsb.ca','Camdon','Lake-Morrrell','','','','','','','November 1, 2005','Male','Adult M',NULL,NULL,'','Mentor',''),(100163,'19863','walkerjc@ccrsb.ca','Zack','MacKean','','','','','','','November 5, 2005','Male','Adult M',NULL,NULL,'','',''),(100164,'19863','walkerjc@ccrsb.ca','Caleb','Fraser','','','','','','','November 15, 2005','Male','Adult M',NULL,NULL,'','Mentor',''),(100165,'19863','walkerjc@ccrsb.ca','Justin','Henderson','','','','','','','August 4, 2005','Male','Adult M',NULL,NULL,'','Mentor',''),(100167,'10177','frasermb.mm@gmail.com','Matthew','Fraser','','','','','','','January 18, 2004','Male','Adult M',NULL,NULL,'','',''),(100168,'10177','muddingstar@hotmail.com','Eddie','Bowes','','','','','','','June 15, 2004','Male','Adult M',NULL,NULL,'','',''),(100169,'10177','shanynlovessoccer@hotmail.com','Shanyn','Bleeker','','','','','','','October 16, 2004','Female','Youth XL',NULL,NULL,'','',''),(100170,'10177','lorieann.mills@gmail.com','jadyn','zinck','','','','','','','August 26, 2004','Female','Youth XL',NULL,NULL,'','',''),(100171,'10177','kellygeorge20@hotmail.com','jaydyn','osborne','','','','','','','June 21, 2004','Female','Adult L',NULL,NULL,'','',''),(100172,'10177','jessewillyhw1234@gmail.com','Jesse','Henderson-Wallace','','','','','','','November 10, 2004','Male','Adult M',NULL,NULL,'','',''),(100173,'21614','praanesh34@gmail.com','Sivakumar','Navaneethan','357 New Haven Rd','','','Neil\'s Harbour','NS','B0C 1P0','June 24, 2015','Male','Adult M',NULL,NULL,'9022172735','',''),(100174,'21614','emilyjanedoyle@yahoo.ca','Emily','Doyle','44 Ardan Road','','','Ingonish Beach','','B0C 1L0','February 22, 2001','Female','Youth L',NULL,NULL,'9022852277','',''),(100175,'10177','gev348922@nspes.ca','Eryn','Gordon','','','','','','','June 12, 2004','Female','Youth L',NULL,NULL,'','',''),(100176,'21614','leogdonovan@hotmail.com','Nick','Phee-Donovan','27 Old School Lane','','','Ingonish Beach','NS','B0C 1L0','December 15, 2000','Male','Adult L',NULL,NULL,'9022852158','',''),(100177,'21614','liamsinatra@gmail.com','Sky','Moses-Fitzgerald','299 Shore Road','','','Dingwall','NS','B0C1G0','January 23, 2003','Male','Youth L',NULL,NULL,'9023832552','',''),(100178,'21614','iad104788@gnspes.ca','Alex','Ingraham','81 New Haven Road','P.O.Box 111','','Neil\'s Harbour','NS','B0C 1N0','July 15, 2002','Male','Adult XL',NULL,NULL,'9023362232','',''),(100179,'21614','guaranteedwhales@gmail.com','Morgan','Penny','103 Mountain View Road','Box 285','','Dingwall','NS','B0C1G0','August 10, 2002','Male','Youth M',NULL,NULL,'9023832514','',''),(100180,'21614','aidandamancostelo@hotmail.com','Aidan','Costelo','181 Bay Street','','','Cape North','NS','B0C1G0','December 8, 2000','Male','Adult L',NULL,NULL,'9023832177','',''),(100182,'21741','caleb@dixonfamily.ca','Caleb','Dixon','','','','','','','December 3, 2001','Male','Adult M',NULL,NULL,'','',''),(100183,'21741','reuben@dixonfamily.ca','Reuben','Dixon','','','','','','','November 10, 2005','Male','Adult S',NULL,NULL,'','',''),(100184,'21741','lists@dixonfamily.ca','Alex','Myatt','','','','','','','February 2, 2005','Male','Adult M',NULL,NULL,'','',''),(100185,'21741','lists@dixonfamily.ca','Carson','Harrison','','','','','','','January 9, 2015','Male','Adult M',NULL,NULL,'','',''),(100186,'21741','lists@dixonfamily.ca','Breanna','Velasco','','','','','','','October 11, 2004','Female','Adult M',NULL,NULL,'','',''),(100187,'21741','lists@dixonfamily.ca','Josh','Myers','','','','','','','May 9, 2004','Male','Adult M',NULL,NULL,'','',''),(100188,'21741','lists@dixonfamily.ca','Ryan','Goodman','','','','','','','December 16, 2003','Male','Adult M',NULL,NULL,'','',''),(100189,'21741','lists@dixonfamily.ca','Tyler','Goodman','','','','','','','August 28, 2006','Male','Adult S',NULL,NULL,'','',''),(100190,'21741','lists@dixonfamily.ca','Liam','Jagger','','','','','','','December 26, 2015','Male','Adult S',NULL,NULL,'','',''),(100191,'21741','lists@dixonfamily.ca','Weston','Myatt','','','','','','','November 8, 1978','Male','Adult XL',NULL,NULL,'','',''),(100192,'14193','bwalker@eastlink.ca','Stephanie','McGill','','','','','','','July 25, 2000','Female','Adult S',NULL,NULL,'','',''),(100193,'14193','bwalker@eastlink.ca','Ethan','Adams','','','','','','','December 8, 2000','Male','Adult L',NULL,NULL,'','',''),(100194,'14193','bwalker@eastlink.ca','Hernanth','Sammatur','','','','','','','January 1, 2000','Male','Adult M',NULL,NULL,'','',''),(100195,'14193','bwalker@eastlink.ca','Isaiah','Gordon','','','','','','','December 28, 2000','Male','Adult L',NULL,NULL,'','',''),(100196,'14193','bwalker@eastlink.ca','Thomas','Bowes','','','','','','','December 31, 2003','Male','Youth L',NULL,NULL,'','',''),(100197,'14193','bwalker@eastlink.ca','Hannah','Birru','','','','','','','October 30, 2000','Female','Adult L',NULL,NULL,'','',''),(100198,'14193','bwalker@eastlink.ca','William','Ippolitagraham','','','','','','','December 8, 2000','Male','Adult M',NULL,NULL,'','',''),(100199,'14193','bwalker@eastlink.ca','Hazir','Cakaj','','','','','','','October 12, 2000','Male','Adult M',NULL,NULL,'','',''),(100201,'14193','bwalker@eastlink.ca','Alice','Song','','','','','','','April 30, 2001','Female','Adult M',NULL,NULL,'','',''),(100202,'14193','bwalker@eastlnk.ca','Jarrod','Conrad','','','','','','','January 19, 2001','Male','Youth M',NULL,NULL,'','',''),(100203,'2533','jamet157@gmail.com','Julie','Butt','','','','','','','September 7, 2005','Female','Youth M',NULL,NULL,'','',''),(100204,'11273','shelly.bembridge@gmail.com','Rowan','Tulloch','','','','','','','July 14, 2002','Male','Adult M',NULL,NULL,'','',''),(100205,'11273','shelly.bembridge@gmail.com','Rowan','Hazel','','','','','','','December 27, 2001','Male','Adult S',NULL,NULL,'','',''),(100206,'11273','shelly.bembridge@gmail.com','Keigan','Reynolds','','','','','','','May 6, 2002','Male','Adult S',NULL,NULL,'','',''),(100207,'11273','shelly.bembridge@gmail.com','Lucas','Waddell','','','','','','','September 7, 2001','Male','Adult M',NULL,NULL,'','',''),(100208,'11273','shelly.bemgridge@gmail.com','Graham','MacNeil','','','','','','','September 23, 2002','Male','Adult M',NULL,NULL,'','',''),(100209,'7085','programmingpanthers@gmail.com','Maddie','Cameron','','','','','','','May 15, 2003','Female','Adult S',NULL,NULL,'','',''),(100210,'7085','programmingpanthers@gmail.com','Adam','Fraser','','','','','','','June 12, 2003','Male','Adult S',NULL,NULL,'','',''),(100211,'7085','programmingpanthers@gmail.com','Sarah','Dedekhani','','','','','','','October 2, 2003','Female','Adult S',NULL,NULL,'','',''),(100212,'7085','programmingpanthers@gmail.com','Madison','Demont','','','','','','','May 10, 2003','Female','Adult S',NULL,NULL,'','',''),(100213,'7085','programmingpanthers@gmail.com','Thomas','Gariepy','','','','','','','January 19, 2004','Male','Adult S',NULL,NULL,'','',''),(100214,'7085','programmingpanthers@gmail.com','Breton','MacDonnell','','','','','','','October 18, 2003','Male','Adult S',NULL,NULL,'','',''),(100215,'7085','programmingpanthers@gmail.com','Dustin','Rchards','','','','','','','October 11, 2004','Male','Adult S',NULL,NULL,'','',''),(100216,'7085','programmingpanters@gmail.com','Joe','Hubley','','','','','','','June 4, 2003','Male','Adult S',NULL,NULL,'','',''),(100217,'4379','jah03799@scolaire.ednet.ns.ca','Joseph','Haché','','','','','','','June 20, 2006','Male','Adult S',NULL,NULL,'','',''),(100218,'4379','o@scolaire.ednet.ns.ca','Ethan','Aarts','','','','','','','April 23, 2006','Male','Adult S',NULL,NULL,'','',''),(100219,'4379','mke25206@scolaire.ednet.ns.ca','Mason','Eisner','','','','','','','May 3, 2006','Male','Adult S',NULL,NULL,'','',''),(100221,'4379','lmk70291@scolaire.ednet.ns.ca','Liam','Kean','','','','','','','November 16, 2006','Male','Adult S',NULL,NULL,'','',''),(100222,'4379','rah03849@scolaire.ednet.ns.ca','Ryan','Hippern','','','','','','','May 19, 2006','Male','Adult S',NULL,NULL,'','',''),(100223,'4379','mcc41709@sepne.ca','Mitchel','Cruickshank','','','','','','','October 24, 2001','Male','Adult L',NULL,NULL,'','',''),(100224,'4379','bhp24184@sepne.ca','Brett','Poutney','','','','','','','February 15, 2002','Male','Adult L',NULL,NULL,'','',''),(100225,'4379','erh24143@sepne.ca','Eric','Hippern','','','','','','','June 7, 2002','Male','Adult L',NULL,NULL,'','',''),(100226,'4379','0@sepne.ca','Gage','Cruickshank','','','','','','','November 7, 2001','Male','Adult L',NULL,NULL,'','',''),(100227,'4379','0@sepne.ca','Lee','Gilbert','','','','','','','November 12, 2003','Male','Adult L',NULL,NULL,'','',''),(100228,'2815','speigs99@gmail.com','Nathan','Biro','','','','','','','April 23, 2004','Male','Youth L',NULL,NULL,'','',''),(100229,'2815','peter_jolley@hotmail.com','Sidney','Jolly','','','','','','','July 15, 2003','Male','Adult L',NULL,NULL,'','',''),(100230,'2815','cindykdrew@gmail.com','David','Helyer','','','','','','','May 25, 2004','Male','Youth M',NULL,NULL,'','',''),(100231,'2815','danzac@gmail.com','Lexington','Zacharias','','','','','','','December 6, 2003','Male','Adult M',NULL,NULL,'','',''),(100232,'2815','accessyou2@hotmail.com','Ethan','Bullerwell','','','','','','','December 22, 2002','Male','Adult S',NULL,NULL,'','',''),(100233,'2815','kennedy_oickle@hotmail.com','Austin','Oickle','','','','','','','October 29, 2002','Male','Adult M',NULL,NULL,'','',''),(100234,'2815','rbq406431@gnspes.ca','Brynley','Rector','','','','','','','June 28, 2004','Male','Youth M',NULL,NULL,'','',''),(100235,'4381','emmaswansburg@hotmail.com','Emma','Swansburg','','','','Shelburne','NS','','June 24, 2003','Female','Adult S',NULL,NULL,'','',''),(100236,'4381','elsimate@yahoo.ca','Elsi','Himmelman','','','','Shelburne','NS','','May 18, 2002','Female','Adult L',NULL,NULL,'','',''),(100237,'4381','myamunroe@hotmail.ca','Mya','Munroe','','','','Shelburne','NS','','July 3, 2003','Female','Adult M',NULL,NULL,'','',''),(100238,'4381','t.huskilson@ns.sympatico.ca','Mia','Huskilson','','','','Shelburne','NS','','April 13, 2015','Female','Adult S',NULL,NULL,'','',''),(100239,'4381','rhondahopkins02@yahoo.ca','Parker','Hopkins','','','','Shelburne','NS','','March 23, 2003','Male','Adult M',NULL,NULL,'','',''),(100240,'4381','familyscott@hotmail.ca','Kadin','Scott','','','','Shelburne','NS','','June 2, 2002','Male','Adult L',NULL,NULL,'','',''),(100241,'4381','Helen.Potgieter@SANDLANEVACATIONS.COM','Sam','Foss','','','','Shelburne','NS','','August 1, 2002','Male','Adult M',NULL,NULL,'','',''),(100242,'11386','deseric@scolaire.ednet.ns.ca','Jeremie','Boudreau','','500 Larry Uteck Blvd.','','halifax','NS','b3m 0e6','November 9, 2002','Male','Adult S',NULL,NULL,'902-832-4302','',''),(100243,'11386','deseric@scolaire.ednet.ns.ca','Claire','Boudreau','','500 Larry Uteck Blvd.','','halifax','NS','b3m 0e6','November 9, 2002','Female','Youth M',NULL,NULL,'902-832-4302','',''),(100244,'11386','deseric@scolaire.ednet.ns.ca','Mitchell','Owens','','500 Larry Uteck Blvd.','','halifax','NS','b3m 0e6','October 16, 2003','Male','Youth M',NULL,NULL,'902-832-4302','',''),(100245,'11386','deseric@scolaire.ednet.ns.ca','Alexandre','Delli Colli','','500 Larry Uteck Blvd.','','halifax','NS','b3m 0e6','June 26, 2003','Male','Youth M',NULL,NULL,'902-832-4302','',''),(100246,'11386','deseric@scolaire.ednet.ns.ca','Charlotte','Samson','','500 Larry Uteck Blvd.','','halifax','NS','b3m 0e6','April 26, 2003','Female','Adult S',NULL,NULL,'902-832-4302','',''),(100247,'11386','deseric@scolaire.ednet.ns.ca','Ivan','Spearman','','500 Larry Uteck Blvd.','','halifax','NS','b3m 0e6','April 9, 2003','Male','Youth M',NULL,NULL,'902-832-4302','',''),(100248,'11386','deseric@scolaire.ednet.ns.ca','Michel','Ayoub','','500 Larry Uteck Blvd.','','halifax','NS','b3m 0e6','January 23, 2003','Male','Adult S',NULL,NULL,'902-832-4302','',''),(100249,'14209','sheick5@hotmail.com','Biola','Oshikoya','','','','','NS','','June 14, 2003','Male','Adult M',NULL,NULL,'','',''),(100250,'14209','baileymb@live.com','Tristan','Rollins','','','','','NS','','September 5, 2001','Male','Adult XL',NULL,NULL,'','',''),(100251,'14209','sheick5@hotmail.com','Eniola','Oshikoya','','','','','','','October 13, 2000','Female','Adult L',NULL,NULL,'','',''),(100252,'14209','sheick5@hotmail.com','Tobi','Oshikoya','','','','','','','November 28, 2001','Male','Adult M',NULL,NULL,'','',''),(100253,'14209','morristhebadass@gmail.com','Nathan','Morris','','','','','NS','','June 11, 2000','Male','Adult M',NULL,NULL,'','',''),(100254,'14209','haley.matthews0998@gmail.com','Tyree','Desmond','','','','','NS','','July 31, 2001','Male','Adult M',NULL,NULL,'','',''),(100255,'18806','sisoscience2@gmail.com','Kayley','Jefferson','','','','','','','May 1, 2006','Female','Adult S',NULL,NULL,'','',''),(100256,'18806','sisoscience3@gmail.com','Chloe','Peck','','','','','','','March 10, 2006','Female','Adult L',NULL,NULL,'','',''),(100257,'18806','sisoscience4@gmail.com','Hailey','Costain','','','','','','','July 2, 2004','Female','Adult L',NULL,NULL,'','',''),(100258,'18806','sisoscience5@gmail.com','Maya','Costain','','','','','','','January 8, 2006','Female','Adult M',NULL,NULL,'','',''),(100259,'18806','sisoscience6@gmail.com','Carmen','Glavine','','','','','','','March 5, 2006','Female','Adult M',NULL,NULL,'','',''),(100260,'18806','sisoscience7@gmail.com','Hallie','Blatch','','','','','','','January 20, 2006','Female','Adult L',NULL,NULL,'','',''),(100261,'18806','sisoscience8@gmail.com','Amelia','Blatch','','','','','','','January 20, 2006','Female','Adult L',NULL,NULL,'','',''),(100262,'18806','sisoscience9@gmail.com','Emma','MacNeil-Comeau','','','','','','','February 28, 2006','Female','Adult M',NULL,NULL,'','',''),(100263,'18806','sisoscience10@gmail.com','Jaymie','Trace','','','','','','','May 10, 2005','Female','Adult L',NULL,NULL,'','',''),(100264,'21086','steele01@ns.sympatico.ca','Mac','Steele','','','','','','','October 25, 2005','Male','Youth L',NULL,NULL,'','',''),(100265,'21086','steele01@ns.sympatico.ca','Matthew','Campbell','','','','','','','March 10, 2005','Male','Youth L',NULL,NULL,'','',''),(100266,'21086','steele01@ns.sympatico.ca','Dominic','Sorhaindo','','','','','','','August 20, 2005','Male','Youth L',NULL,NULL,'','',''),(100267,'21086','steele01@ns.sympatico.ca','Sam','MacLennan','','','','','','','May 28, 2004','Male','Youth L',NULL,NULL,'','',''),(100268,'21086','steele01@ns.sympatico.ca','Megan','MacLennan','','','','','','','September 18, 2006','Female','Youth M',NULL,NULL,'','',''),(100269,'2544','daugherf@eastlink.ca','April','Deveau','','','','','','','August 15, 2004','Female','Adult M',NULL,NULL,'','',''),(100270,'2544','daugherf@eastlink.ca','Marjanah','Kalau','','','','','','','January 14, 2004','Female','Adult S',NULL,NULL,'','',''),(100271,'2544','daugherf@eastlink.ca','Noah','Norman-Pearson','','','','','','','April 2, 2002','Male','Adult M',NULL,NULL,'','',''),(100272,'2544','daugherf@eastlink.ca','Kai','Tanaka','','','','','','','July 27, 2003','Male','Adult M',NULL,NULL,'','',''),(100273,'2544','daugherf@eastlink.ca','Stuart','Lindsay','','','','','','','June 4, 2003','Male','Adult M',NULL,NULL,'','',''),(100274,'14410','cba210510@gnspes.ca','Brady','Chipman','','','','','','','December 28, 2003','Male','Adult L',NULL,NULL,'','',''),(100275,'14410','srj202988@gnspes.ca','Ryan','Shaw','','','','','','','March 22, 2003','Male','Adult M',NULL,NULL,'','',''),(100276,'14410','lat034950@gnspes.ca','Alex','Lloyd','','','','','','','May 10, 2003','Male','Adult M',NULL,NULL,'','',''),(100277,'14410','lcd202699@gnspes.ca','Corey','LeBlanc','','','','','','','April 10, 2003','Male','Adult M',NULL,NULL,'','',''),(100278,'14410','cpl670622@gnspes.ca','Parker','Couture','','','','','','','April 26, 2003','Male','Adult L',NULL,NULL,'','',''),(100279,'14410','blk202350@gnspes.ca','Luke','Bartlet','','','','','','','July 2, 2003','Male','Adult M',NULL,NULL,'','',''),(100280,'14410','sdc180366@gnspes.ca','Drake','Somers','','','','','','','January 26, 2003','Male','Adult M',NULL,NULL,'','',''),(100281,'14410','zm397929@gnspes.ca','Mikhael','Zavala','','','','','','','October 10, 2002','Male','Adult M',NULL,NULL,'','',''),(100282,'14410','mbr208340@gnspes.ca','Boyd','Marchand','','','','','','','November 3, 2003','Male','Adult M',NULL,NULL,'','',''),(100283,'14400','coordinator@capcbco.ca','Simon','Kumar-Britton','','','','','','','November 17, 2005','Male','Adult M',NULL,NULL,'','',''),(100284,'14400','coordinator@capcbco.ca','Angus','Cambell','','','','','','','November 17, 2004','Male','Adult L',NULL,NULL,'','',''),(100285,'14400','coordinator@capcbco.ca','Luke','MacCrae','','','','','','','November 17, 2003','Male','Adult L',NULL,NULL,'','',''),(100286,'14400','coordinator@capcbco.ca','Jacod','Cote-MacNeil','','','','','','','November 17, 2001','Male','Adult XL',NULL,NULL,'','',''),(100287,'11386','deseric@scolaire.ednet.ns.ca','Melanie','Boudreau','','500 Larry Uteck Blvd.','','Halifax','NS','B3M 0E6','December 24, 2004','Female','Youth M',NULL,NULL,'902-832-4302','',''),(100288,'14400','coordinator@capcbco.ca','Declan','MacLeod','','','','','','','November 17, 2002','Male','Adult XL',NULL,NULL,'','',''),(100289,'14400','coordinator@capcbco.ca','Moazan','Shahid','','','','','','','November 17, 2006','Male','Adult S',NULL,NULL,'','',''),(100290,'14400','coordinator@capcbco.ca','Syed','Kamran Ali','','','','','','','November 17, 2006','Male','Adult S',NULL,NULL,'','',''),(100291,'14400','coordinator@capcbco.ca','Jake','Wambolt','','','','','','','November 17, 2006','Male','Adult S',NULL,NULL,'','',''),(100292,'14400','coordinator@capcbco.ca','Liam','Ley','','','','','','','November 17, 2004','Male','Adult M',NULL,NULL,'','',''),(100293,'14400','coordinator@capcbco.ca','Jessie','Youden','','','','','','','November 17, 2004','Male','Adult M',NULL,NULL,'','',''),(100294,'21736','coordinator@capcbco.ca','Rebecca','Hillier','','','','','','','November 17, 2004','Female','Adult M',NULL,NULL,'','',''),(100295,'21736','coordinator@capcbco.ca','Adlie','Leviten-Reid','','','','','','','November 17, 2004','Female','Adult M',NULL,NULL,'','',''),(100296,'21736','coordinator@capcbco.ca','Danea','Mitchell','','','','','','','November 17, 2003','Female','Adult L',NULL,NULL,'','',''),(100297,'14200','woodrossiter@eastlink.ca','Evan','Rossiter','','','','','','','June 3, 2002','Male','Adult M',NULL,NULL,'','',''),(100298,'14200','imhotep@dal.ca','Christopher','Bahedi','','','','','','','November 16, 2003','Male','Adult XXL',NULL,NULL,'','',''),(100299,'14200','cdskinner1@hotmail.com','Donovan','Skinner','','','','','','','June 6, 2001','Male','Youth L',NULL,NULL,'','',''),(100300,'14200','kmichelereade@hotmail.com','Kailun','Grant','','','','','','','October 7, 2000','Female','Adult M',NULL,NULL,'','',''),(100301,'14200','simoneeden@hotmail.com','Simone','Reade','','','','','','','August 28, 2001','Female','Adult M',NULL,NULL,'','',''),(100302,'2464','currie@gnspes.ca','Adam','Currie','','','','','','','November 8, 2001','Male','Adult S',NULL,NULL,'','',''),(100303,'2464','currie@gnspes.ca','Connor','Haines','','','','','','','February 19, 2002','Male','Adult M',NULL,NULL,'','',''),(100304,'2464','currie@gnspes.ca','Ciaran','O\'Brien','','','','','','','December 18, 2000','Male','Adult M',NULL,NULL,'','',''),(100305,'2464','currie@gnspes.ca','Ben','Ernst','','','','','','','September 6, 2001','Male','Adult L',NULL,NULL,'','',''),(100306,'2464','currie@gnspes.ca','Aaron','Brewer','','','','','','','September 17, 2002','Male','Adult L',NULL,NULL,'','',''),(100307,'2464','currie@gnspes.ca','Racesa','Pierce','','','','','','','October 2, 2003','Female','Adult S',NULL,NULL,'','','');
/*!40000 ALTER TABLE `Members` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Participates`
--

DROP TABLE IF EXISTS `Participates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Participates` (
  `qual_id` int(10) NOT NULL,
  `competition_id` int(10) NOT NULL,
  `team_id` varchar(128) NOT NULL,
  `season_year` varchar(128) NOT NULL,
  `local_id` int(10) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`qual_id`,`team_id`,`competition_id`,`season_year`),
  UNIQUE KEY `local_id` (`local_id`),
  KEY `competition_id` (`competition_id`),
  KEY `team_id` (`team_id`),
  KEY `season_year` (`season_year`),
  CONSTRAINT `Participates_ibfk_1` FOREIGN KEY (`qual_id`) REFERENCES `Qualifiers` (`qual_id`),
  CONSTRAINT `Participates_ibfk_2` FOREIGN KEY (`competition_id`) REFERENCES `Qualifiers` (`competition_id`),
  CONSTRAINT `Participates_ibfk_3` FOREIGN KEY (`team_id`) REFERENCES `Teams` (`team_id`),
  CONSTRAINT `Participates_ibfk_4` FOREIGN KEY (`season_year`) REFERENCES `Qualifiers` (`season_year`)
) ENGINE=InnoDB AUTO_INCREMENT=100077 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Participates`
--

LOCK TABLES `Participates` WRITE;
/*!40000 ALTER TABLE `Participates` DISABLE KEYS */;
INSERT INTO `Participates` VALUES (100002,100000,'20836','2015-2016',100000),(100002,100000,'2096','2015-2016',100001),(100002,100000,'18806','2015-2016',100010),(100001,100000,'3015','2015-2016',100017),(100001,100000,'21018','2015-2016',100018),(100002,100000,'14628','2015-2016',100019),(100001,100000,'14079','2015-2016',100020),(100001,100000,'19583','2015-2016',100021),(100001,100000,'11386','2015-2016',100022),(100005,100000,'5885','2015-2016',100023),(100005,100000,'15092','2015-2016',100024),(100002,100000,'16886','2015-2016',100026),(100005,100000,'3067','2015-2016',100027),(100001,100000,'21803','2015-2016',100029),(100001,100000,'20743','2015-2016',100030),(100005,100000,'19863','2015-2016',100031),(100003,100000,'12664','2015-2016',100032),(100001,100000,'2499','2015-2016',100033),(100005,100000,'3496','2015-2016',100034),(100001,100000,'14410','2015-2016',100035),(100003,100000,'4381','2015-2016',100037),(100002,100000,'21404','2015-2016',100038),(100000,100001,'1979-1','2015-2016',100039),(100000,100001,'2170-2','2015-2016',100040),(100000,100001,'2170-1','2015-2016',100041),(100000,100001,'2170-3','2015-2016',100042),(100001,100000,'10716','2015-2016',100043),(100002,100000,'2815','2015-2016',100044),(100003,100000,'18317','2015-2016',100045),(100005,100000,'10177','2015-2016',100046),(100004,100000,'16393','2015-2016',100048),(100004,100000,'8435','2015-2016',100049),(100003,100000,'2544','2015-2016',100051),(100005,100000,'2533','2015-2016',100052),(100003,100000,'21530','2015-2016',100053),(100001,100000,'14200','2015-2016',100055),(100005,100000,'14209','2015-2016',100056),(100004,100000,'21614','2015-2016',100058),(100002,100000,'21741','2015-2016',100059),(100001,100000,'14193','2015-2016',100060),(100001,100000,'11273','2015-2016',100061),(100005,100000,'7085','2015-2016',100062),(100005,100000,'4379','2015-2016',100063),(100001,100000,'21086','2015-2016',100064),(100001,100000,'2699','2015-2016',100065),(100004,100000,'14400','2015-2016',100068),(100004,100000,'21736','2015-2016',100069),(100001,100000,'2563','2015-2016',100070),(100003,100000,'2464','2015-2016',100076);
/*!40000 ALTER TABLE `Participates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `QualifierAdmins`
--

DROP TABLE IF EXISTS `QualifierAdmins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `QualifierAdmins` (
  `user_id` int(10) NOT NULL,
  `shirt_size` varchar(255) NOT NULL,
  `consent` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `QualifierAdmins_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `Users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `QualifierAdmins`
--

LOCK TABLES `QualifierAdmins` WRITE;
/*!40000 ALTER TABLE `QualifierAdmins` DISABLE KEYS */;
INSERT INTO `QualifierAdmins` VALUES (100002,'Adult L',NULL),(100004,'Adult L',NULL),(100006,'Adult L',NULL),(100007,'Adult XXL',NULL),(100063,'Adult S',NULL),(100065,'Adult M',NULL);
/*!40000 ALTER TABLE `QualifierAdmins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Qualifiers`
--

DROP TABLE IF EXISTS `Qualifiers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Qualifiers` (
  `qual_id` int(10) NOT NULL AUTO_INCREMENT,
  `competition_id` int(10) NOT NULL,
  `season_year` varchar(128) NOT NULL,
  `name` varchar(128) NOT NULL,
  `status` enum('open','closed','completed') DEFAULT 'closed',
  `time` varchar(128) DEFAULT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `civic_number` varchar(128) DEFAULT NULL,
  `street1` varchar(128) DEFAULT NULL,
  `street2` varchar(128) DEFAULT NULL,
  `city` varchar(128) DEFAULT NULL,
  `province` varchar(128) DEFAULT NULL,
  `postal_code` char(7) DEFAULT NULL,
  `capacity` int(3) DEFAULT NULL,
  PRIMARY KEY (`qual_id`,`competition_id`,`season_year`),
  KEY `season_year` (`season_year`),
  KEY `competition_id` (`competition_id`),
  CONSTRAINT `Qualifiers_ibfk_1` FOREIGN KEY (`season_year`) REFERENCES `Competitions` (`season_year`),
  CONSTRAINT `Qualifiers_ibfk_2` FOREIGN KEY (`competition_id`) REFERENCES `Competitions` (`competition_id`)
) ENGINE=InnoDB AUTO_INCREMENT=100007 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Qualifiers`
--

LOCK TABLES `Qualifiers` WRITE;
/*!40000 ALTER TABLE `Qualifiers` DISABLE KEYS */;
INSERT INTO `Qualifiers` VALUES (100000,100001,'2015-2016','RoboGolf','open','February 13, 2016 830am','9025851269','27 University Avenue','Carnegie Hall','','Wolfville','NS','B4P2R6',20),(100001,100000,'2015-2016','NSCC IT Campus','open','November 28, 2015 8:30am','9024914967','5685','Leeds Street','','Halifax','NS','b3j3c4',20),(100002,100000,'2015-2016','NSCC COGS','open','November 28, 2015','9025842056','50','Elliot Rd.','RR 1','Lawrenencetown','NS','B0S1M0',17),(100003,100000,'2015-2016','NSCC Lunenburg','closed','November 27, 2015 830 am','9025430685','75','High Street','','Bridgewater','NS','B4V1V8',6),(100004,100000,'2015-2016','NSCC Marconi','open','November 21, 2015','9025632654','1240','Grand Lake Road','PO Box 1042','Sidney','NS','B1P6J7',8),(100005,100000,'2015-2016','NSCC Truro','open','November 21, 2015 830am','9028937891','36','Author Street','','Truro','NS','B2N1X5',12),(100006,100000,'2015-2016','FLL Acadia Championship','closed','February 13, 2016 830 am','9025851269','27','University Ave','Acadia University','Wolfville','NS','B4P2R5',30);
/*!40000 ALTER TABLE `Qualifiers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Seasons`
--

DROP TABLE IF EXISTS `Seasons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Seasons` (
  `year` varchar(128) NOT NULL,
  `info` varchar(255) DEFAULT NULL,
  `status` enum('open','closed','completed') DEFAULT 'closed',
  PRIMARY KEY (`year`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Seasons`
--

LOCK TABLES `Seasons` WRITE;
/*!40000 ALTER TABLE `Seasons` DISABLE KEYS */;
INSERT INTO `Seasons` VALUES ('2015-2016','','open');
/*!40000 ALTER TABLE `Seasons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ShirtSizes`
--

DROP TABLE IF EXISTS `ShirtSizes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ShirtSizes` (
  `shirt_size` varchar(128) NOT NULL,
  `season_year` varchar(128) NOT NULL,
  PRIMARY KEY (`shirt_size`),
  KEY `season_year` (`season_year`),
  CONSTRAINT `ShirtSizes_ibfk_1` FOREIGN KEY (`season_year`) REFERENCES `Seasons` (`year`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ShirtSizes`
--

LOCK TABLES `ShirtSizes` WRITE;
/*!40000 ALTER TABLE `ShirtSizes` DISABLE KEYS */;
/*!40000 ALTER TABLE `ShirtSizes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Teams`
--

DROP TABLE IF EXISTS `Teams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Teams` (
  `team_id` varchar(128) NOT NULL,
  `name` varchar(255) NOT NULL,
  `organization` varchar(255) NOT NULL,
  `approved` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`team_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Teams`
--

LOCK TABLES `Teams` WRITE;
/*!40000 ALTER TABLE `Teams` DISABLE KEYS */;
INSERT INTO `Teams` VALUES ('0000','Robotics Test','Acadia',0),('0001','Robotics Test 2','Acad',0),('10177','Techsperts','East St. Margaret\'s Elementary Team',0),('10716','Sacred Sharks','Fountain Academy of the Sacred Heart',0),('11273','ROBOmasters','Community Group',0),('11386','Les Cougars','École secondaire du Sommet',0),('123123','Jenna\'s test team','acadia',0),('12664','Shambhala Shadowvolts','Shambhala School',0),('14079','Armbrae Dragonites','ARMBRAE ACADEMY',0),('14193','Clayton Park #1','Clayton Park Jr. High',0),('14200','Volcanic Knights','Imhotep Legacy Academy',0),('14209','Imhotep Top Robots','Imhotep Legacy Academy',0),('14400','Robo Robotics','Community Group',0),('14410','EPEC1','Eastern Passage Education Centre',0),('14412','','',0),('14628','Electric Eels','Digby Regional High School',0),('15092','Island Robo-Recyclers','Engineers PEI',0),('16393','R2-TL','CBVRSB',0),('16886','21st Century Space Guys','Neighbourhood',0),('18317','KES','Kings Edgehill School',0),('18806','Sisters of Science (SOS) FLL','Community Group',0),('19583','Armbrae Anonymous','ARMBRAE ACADEMY',0),('1979-1','NKEC Titans','NKEC',0),('19863','ThorBots','Thorburn Consolidated School',0),('20743','KILR Robotics','Sackville High School',0),('20836','BroBots','Annapolis West Education Centre',0),('2096','Royal Robots','Annapolis West Education Centre',0),('21018','Oxford Knights','Oxford School',0),('21086','hippie lEgo loV3rs','neighborhood',0),('21404','Robot Rockers','Northeast Kings Education Centre',0),('21530','Bridgewater Robotics','BES/BJHS',0),('21614','Cabot Robotics','Cabot Education Center',0),('2170-1','The Marlies','King\'s-Edgehill School',0),('2170-2','Weapons of Grass Destruction','King\'s-Edgehill School',0),('2170-3','Bryck','King\'s-Edgehill School',0),('21736','Lego Ladies','Community Group',0),('21741','Missing Pieces','New Minas Rec',0),('21803','DMC HEROZ','Sackville High School',0),('2464','The Seahawks','Bluenose Academy',0),('2499','Gorsebrook Bears','Gorsebrook School',0),('2533','River Raiders','RIver Hebert District School',0),('2544','Vipères','Centre scolaire de la Rive-Sud',0),('2563','LT Lions','Leslie Thomas Jr High',0),('2699','MintCookie Robotics','home/community',0),('2815','Robo Lobo Wired','Wolfville School',0),('3015','BOTbesties','WISEatlantic/MSVU',0),('3067','Lego Intelligence','Community',0),('3496','Trurobotics','Community',0),('4379','Tornado Squad','École Acadienne de Truro',0),('4381','Shelburne Rebels','Shelburne Regional High School',0),('5885','Spud Bots','Engineers PEI',0),('7085','Programmin Panthers','New Glasgow Academy',0),('8435','TL Spartrons','cbvrsb',0);
/*!40000 ALTER TABLE `Teams` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Users`
--

DROP TABLE IF EXISTS `Users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Users` (
  `user_id` int(10) NOT NULL AUTO_INCREMENT,
  `email` varchar(128) NOT NULL,
  `password` varchar(128) DEFAULT NULL,
  `api_token` varchar(128) NOT NULL,
  `first_name` varchar(128) NOT NULL,
  `last_name` varchar(128) NOT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `civic_number` varchar(128) DEFAULT NULL,
  `street1` varchar(128) DEFAULT NULL,
  `street2` varchar(128) DEFAULT NULL,
  `city` varchar(128) DEFAULT NULL,
  `province` varchar(128) DEFAULT NULL,
  `postal_code` char(7) DEFAULT NULL,
  `dob` varchar(128) DEFAULT NULL,
  `gender` varchar(30) DEFAULT NULL,
  `medical_info` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `api_token` (`api_token`)
) ENGINE=InnoDB AUTO_INCREMENT=100081 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Users`
--

LOCK TABLES `Users` WRITE;
/*!40000 ALTER TABLE `Users` DISABLE KEYS */;
INSERT INTO `Users` VALUES (100000,'rpc.assistant@acadiau.ca','$2y$10$Z0pPfr1yNgJsKo9DOWSRmuY4129nxU0tx8ttKCEDQTN/9GoDhrzOu','4e32f120adc6ae47e16c6dec5debecaa','Anne','Mercer-Hall','1234567890','1','1','1','1','AB','e3e3e3','November 1, 2015','Female',''),(100001,'fady.abdelmohsen@gmail.com','$2y$10$YONYfCSuaUN0sl9qnqzfK.vx5PkUTue4BU2cgrABMQrOfUSFUfFiy','d3083f3648e2a714061a0b2552866872','Fady','Abdelmohsen','2894001819','1 beckwith street','asdasd','Wolfville','Wolfville','AB','B4P1R5','November 4, 2015','Male',''),(100002,'mike.duggan@nscc.ca','$2y$10$x3XXHpmHjMTXeQ0pFfi/XuRsZT/XV6KSUF7mfUyovFy8hReor3jla','d354b31e3736b6e74ddbc43ceae052fa','Mike','Duggan','902-491-4967','5685','Leeds Street','','Halifax','NS','B3J3C4','November 3, 2015','Male',''),(100004,'blair.lipsett@nscc.ca','$2y$10$9l8ZZGiXOjgLeQly3x9BNO89UeBuU4VoPSFXdzfSxd9u3XoyV1BdC','c0e7b0b27fc6880cdade8150e304ca04','Blair','Lipsett','9025430685','75','High Street','','Bridgewater','NS','B4V1V8','November 3, 2015','Male',''),(100005,'jhafting@acadian.ca','$2y$10$zme.aUVHgDQ2v7qh0htH8OfnMuKTVEi7DSLw19kYcjYQ.sTfh5hwC','9931bb88cf0b25b9ed29b86c692a6f17','Jeff','Hafting','902 402 3700','712','St. George Street','','Annapolis Royal','NS','B0S1A0','July 19, 1969','Male',''),(100006,'sean.morrow@nscc.ca','$2y$10$GBmqAhvUldT.Qzke8PNOH.ImWs.M8gJTRAvFedT7X3FSUsjyXYQKa','f9a41f0bd886306f7197a3c9f71f761d','Sean','Morrow','(902)893-7891','36','Arthur Street','','Truro','NS','B2N 1X5','November 3, 2015','Male',''),(100007,'darren.andrews@nscc.ca','$2y$10$DhFokpjH4Bc9vfPkcHbz8Oiy5vfEqB4UPpTqykoiEDQrfWOcOpt6O','43df603671827b67e8832797a8cf4371','Darren','Andrews','(902)563-2654','1240','Grand Lake Road','PO Box 1042','Sydney','NS','B1P 6J7','November 3, 2015','Male',''),(100008,'jenna.watson-findley@acadiau.ca','$2y$10$bdluKv6DK3qX7kcO6WPzQeuIMMMJC48ADVZzBy2w29O/RFbn8s8wW','6baff089209cde0e65a03ba733295748','Jenna','Watson-Findley','(902)585-1269','27','University Ave','','Wolfville','NS','B4P 2R6','November 4, 2015','Female','Tester Team'),(100010,'TBroderick@hrsb.ca','$2y$10$Ijue8lt8xC.d6e4StAyNA.mb/72oB8.QKCGraWP2iJ2P.gdCFu052','a2a230c194013afe23613512895a23fe','Tina','Broderick','902-240-3554','1601','Frankie Drive','','Beaver Bank','NS','B4E2M6','September 1, 1964','Female',''),(100011,'tamara.franz-odendaal@msvu.ca','$2y$10$Y7MgU2Yjq/xsVT6urzsV1.I4cPVxdLyJyj5IkzOfGwk06ts1hbO6a','74f9aae407228bc470a793c91a9f9dd9','Tamara','Franz-Odendaal','902-2407372','44 Clearview drive','44 Clearview drive','','Bedford','NS','B4A 3C8','September 21, 1972','Female',''),(100012,'heather.sullivan@tcrsb.ca','$2y$10$UymHTG7dcb9teWrEtyZL0OtA9nhChoeVsSPh1BYTVJt9gY2tDzQN.','226480638e1046a833f3e65ef8d328f8','Heather','Manzer','9022474597','56 Second Avenue','same','same','Digby','NS','B0V1A0','August 11, 1980','Female',''),(100013,'arhinelander@armbrae.ns.ca','$2y$10$kWuhceuYJ7uqeLyNktvH/.ZeKCPAXcPISioHE5VQAK4elGtQzKIm.','816ecb032d4a621f0ff0160cd5bb105e','Alex','Rhinelander','9024565280','1400','Oxford St','','Halifax','NS','B3H 3Y8','December 28, 1962','Male',''),(100014,'deseric@scolaire.ednet.ns.ca','$2y$10$hqE3/ESHCfnYNdA3R5fVk.a9oIGAegLQkNWwGxkjMb41v0T1fPY1C','61e103a8018073451cb9c0ad28691aba','Éric','Desmarais','902-832-4302','500 Larry Uteck Blvd.','500 Larry Uteck Blvd.','','Halifax','NS','B3M 0E6','November 2, 1981','Male',''),(100015,'kimd@pictoulandingschool.ca','$2y$10$qD.M0tOmAT6URJAlYKMj3e70MtuERVkqpBouaqCY5WG3U1RbpfgMi','de84c4639b6d15986b65586fa9219ec6','Kim','Dorrington','9027559954','43 Maple Street','43 Maple Street','','Pictou Landing','NS','B0K1X0','October 21, 1970','Female',''),(100016,'libbyosgood@gmail.com','$2y$10$KooFYOrlknfkFZFI0w0cOOk9bfNZ18PwRxCua7cjU15IzYsNf85Va','73734b3ddfeaebb2d93112d537206baf','Libby','Osgood','9023940479','111 Richmond St','Unit 301','','Charlottetown','PE','C1A1H7','March 19, 1983','Female',''),(100017,'sara.chisholm@ca.michelin.com','$2y$10$Jz5mkUeK3RucmSDV9ip0MOC/iuVC9YsMCwtoSVAcay6aGqmGkEdFa','1ff98c6f8a61fbc8aa7f9657b5d197f3','Sara','Chisholm','902-825-1747','158 Gates Mountain Road','158 Gates Mountain Road','','Middleton','NS','B0S1P0','October 26, 1966','Female','Team 18806'),(100018,'borenech@scolaire.ednet.ns.ca','$2y$10$ZGb/58tOC488zeXxDzz/OOprd70AJ46gYdqHSrqak7HvKtTdT3zkO','4e93478a5354c07bac11435bfbc6137f','Rene','Bouillon','902-832-4302','500 Larry Uteck Blvd.','500 Larry Uteck Blvd.','','Halifax','NS','B3M 0E6','May 3, 1974','Male',''),(100019,'sarahouthitsmith@hotmail.com','$2y$10$XMKsPxeSfZ3n.vlbBZ.oeuRpBc0g9ehanW10/gIMbpT8Cdu8skkQ.','145bd0f9a9f9c0dce312220bcb37d22f','Sarah','Outhit-Smith','(902)457-6140','44','Clearview drive','','Bedford','NS','B4A 3C8','November 5, 2015','Female',''),(100020,'rpc.assistant@gmail.com','$2y$10$x11X1zamqFlkuelsZmj/HeexhP4pPCIPduGjPDnwhNW5XhR5eBLz6','d7222eb6a7ef36b9997dace5a3a5dd49','Anne','Mercer-Hall','9025851585','10005','HWY 221 RR 2','Canning','Canning','NS','B0P1H0','August 26, 1965','Female',''),(100021,'cathygordrobinson@outlook.com','$2y$10$vvlHsJazbAC6SlPeS.H91O3la8cqwzzlHfL2jJFkBj7Nbpxa.SuEa','00fed75d818acbea041034c7d9ecd91d','Cathy','Robinson','902-897-2920','2531','Lilyvale Road','','Greenfield','NS','B6L 3V1','October 5, 1968','Female',''),(100022,'kimdoconnor@gmail.com','$2y$10$5bNlP3Z2Ay4/j5d54ePONO/7i1Bjw9saqZXGF.72RQiwM6bnAplA.','352af2896d118ab5651349bfe151c22d','Kim','O\'Connor','9026982705','18 Orchard Rd','18 Orchard Rd','Kentville','Kentville','NS','B4N1R9','October 19, 1975','Female','Men\'s size shirt XL; if the shirts are women\'s shirts please use XXL.'),(100023,'ian_colwell@hotmail.com','$2y$10$LbBtv.ERBJBYEqzdQ.o3O.UCJXWhDdCmV4eAdiNOE5XqSYiKCXlGC','6ae4016cc80dc3f9b6da22c50dbc7729','Ian','Colwell','5066090926','20 Spring Lane, apt. 8','20 Spring Lane, apt. 8','','Charlottetown','PE','C1A5Z9','September 21, 1991','Male',''),(100024,'hancocksharpe@doctors.org.uk','$2y$10$OxlDjbT0321iT3GELjdP9uPTPD1XBhSaoyBj6gN7W2agSHTl0USBK','9b04b00e5adaae44b146338ef832acac','Andy','Sharpe','9025321700','861 Hwy 201','R.R. #1','','Annapolis Royal','NS','B0S 1A0','October 4, 2015','Male',''),(100025,'MDoherty@hrsb.ca','$2y$10$/6oOqr5MtJ1NVlUKRU/VDO.ssawNd.XwSTrqJaYODou1bR8STLTgi','1ed3a9669f8aacf00ed6eb56ebced8d9','Melissa','Doherty','902-412-5369','4','Chervin Court','','Windsor Junction','NS','B2T 1G7','August 26, 1975','Female',''),(100026,'mouellette@hrsb.ca','$2y$10$/JEE9vKGaEjNDRso7jRxMepRGnMrYnwQ1olPMRvB8pDWyyOlIrgS2','1ed13a1ad817ea023d9fd2fd25a52d00','Monique','Ouellette','9024315537','33 Purcells Cove Rd','33 Purcells Cove Rd','33 Purcells Cove Rd','Halifax','NS','B3N 1R3','September 22, 1983','Female',''),(100027,'walkerjc@ccrsb.ca','$2y$10$vv7b48gBY/x2lSRjet2pROwIXsWJ6BpVHsChm1cS1V1nQZnNOWYSq','d5bae1ebcc7ffe67cb5628e62a7cae4f','Jeremy','Walker','9023311932','143 Mitchell Street','143','','New Glasgow','NS','B2H1H4','October 20, 1979','Male',''),(100028,'allisoncameron007@hotmail.com','$2y$10$DiX2PNlgt1kRr5K1UPdZ.e3yWJzfVpbL7sufFjS0oh8XUANZV3u9e','2fc74822607789e9956df8cb6dcf3095','Allison','Cameron','9022408634','38 South Point Rd.','38 South Point Rd.','Portuguese Cove','Portuguese Cove','NS','B3V 1K3','April 2, 1959','Female','Shambhala Shadowvolts #12664'),(100029,'acameron@shambhalaschool.org','$2y$10$PAABF26j8f2JUR8KJiAOAOb.qB/Ds1I.f3nVIODOBV.1ik.xbNAP6','409f7b7b0e2673462caafc63d57b79f1','Allison','Cameron','9022408634','38 South Point Rd.','38 South Point Rd.','Portuguese Cove','Portuguese Cove','NS','B3V 1K3','April 2, 1959','Female','Shambhala Shadowvolts #12664'),(100030,'synchronicitynow@gmail.com','$2y$10$VZz.Lr5H./PSy7FpoHRlx.nIMkAb8GhZTsEeJHPMLwis0jh1ZeeXe','059025d14fc571c55eea0978b03537c5','David','Jellicoe','902 999-2619','6551','Almon','','Halifax','NS','B3L1V9','August 14, 1958','Male',''),(100031,'milomilo789@hotmail.com','$2y$10$xYmmmeJBFInuQ.RLTslqiOcWmCeTXuK2nEJbVtSe2iOKOjCn5ptuG','f411ceeb9e183f37dd16593cc957b842','Milo','Crowell','902-956-8271','114','Truro Road','','North River','NS','B6L6V8','May 18, 1967','Female',''),(100032,'hennigar6@seasidehighspeed.com','$2y$10$VgTEox/a2S42cAXK2aUaS.41eL.DJ8P0PVy5UXHSZZI1EVj0ATiTe','74507c942da4a7d029d82767b3f47554','sarah','hennigar','902-890-2458','1579 greenfield rd','1579 greenfield rd','','greenfield','NS','b6l 3m1','November 1, 2015','Female',''),(100033,'fraserrobinson@outlook.com','$2y$10$EZGuDWlSCIrjcdSqsbhbbua1iQltNipCdDYFU72V/Ii1ggckIjugG','28de90ae1f6a048f65793d84ce8b067e','Fraser','Robinson','(902) 897-2920','2531 Lilyvale Road','2531 Lilyvale Road','','Greenfield','NS','B6L 3V1','September 13, 1998','Male',''),(100034,'tchampion@gnspes.ca','$2y$10$tmsLzZKc5G3WWUrjZn2q..jCNvbtV2VKF7Dnu9L7708XcV0gj9xd.','a495da42d64a0d1f36ef8ba2daaf0a03','Ted','Champion','902 582 2040','1816 Bains Road','1816 Bains Road','Canning','Canning','NS','B0P1H0','June 23, 1963','Male',''),(100035,'phimmelm@tcrsb.ca','$2y$10$fCRBMLL63PAiPYoitqpMGO5ptPYIjIGG9OXshJskmqRwDg.zMdl0y','35a3aa6cd81148b282f090d72b61b3f9','Peter','Himmelman','902-875-4900','PO Box 914','67 Bulkley St','','Shelburne','NS','B0T 1W0','November 6, 1968','Male',''),(100036,'jasaunders@nstu.ca','$2y$10$pZn/0Ylv140/4ZtHiQ.7iOtWczTYW6/4YL1or/k2plWIsMz6ag2bS','9a358098bfa5b45d34e3812b4c46f3e3','Josh','Saunders','9024419841','93 Samuel Danial Drive','93 Samuel Danial Drive','','Easter Passage','NS','B3G 1S8','January 7, 1976','Male',''),(100037,'greg.fox@avrsb.ca','$2y$10$0aZSW7tLPDQ7yd62yGiTeOaFTeb4BKleCAwM9VxYQqWqZGAK./.0u','584af77560fc8ddc9f7c12408d379da1','Greg','Fox','(902) 582-2040','1816 Bains Rd, Canning, NS B0P 1H0','Bains Rd','','Canning','NS','B0P 1H0','November 9, 2015','Male',''),(100038,'djdecoste@kes.ns.ca','$2y$10$TmwEQlSp76owsRGD/BMr9uGw3cbva.C2cTaWTFWRZODYj2Tv74tia','d3e6cc0b541960d35ae4b820a256e6d8','DJ','DeCoste','9024723704','33 King\'s-Edgehill Lane','33 King\'s-Edgehill Lane','Windsor','Windsor','NS','B0N 2T0','May 16, 1980','Male',''),(100039,'sleadbetter@shsh.ca','$2y$10$NF/5JqXT0oT8uCNN0zpele0DOkiQn68NEGGM7AJvuTJ1YKrOmlcr6','2504acb132023ddccc41fbf5edfa6934','Shoneth','Leadbetter','9022400805','5820 Spring Garden Road','5820 Spring Garden Road','','Halifax','NS','B3J 1E7','October 9, 1986','Female',''),(100040,'evan@mysterycreative.ca','$2y$10$bMGEsPNhLzapMFKItzLNHOWL495Gf.pdIQLplDTqz.i3t31didxuK','e94b3b9ce9cb2a79dadf53190ce4ce1a','Evan','Warner','902-300-0766','86','Gaspereau Ave.','','Wolfville','NS','B4P2E1','April 11, 1986','Male','Team Robo Lobo Wired'),(100041,'ekershaw@kes.ns.ca','$2y$10$69YGUvu2d6y0gyaXAPhW2.crNTKhCisH6GLZb4AXirIT7ELRpDIky','76f9336db9729d0ced29dd22fc2fbf4c','Eric','Kershaw','902-697-2011','Wolfville','Kent Avenue','15','Wolfville','NS','B4P1v2','January 21, 1981','Male',''),(100042,'jeanclaude.boudreau@hrsb.ca','$2y$10$hEoBKGdXsx1pb10cBRA1B.jJylCPjOwEOHTG/Du8zwgFVz2MPy4fG','58d56af5835ba3d45cdccae61de7d25a','Jean Claude','Boudreau','902-223-0153','40 Bedros Lane Unit 104','40 Bedros Lane Unit 104','','Halifax','NS','B3M 4X1','November 8, 2015','Male',''),(100043,'lorieann.mills@gmail.com','$2y$10$BkGqVUvhIYaBv4NEPvMTA.YGulGlz5DPe9QTBGRO7fWbT96MsIOI.','ce23290ec9f903ee7ab00dcb50d9ebcc','Lorie','Mills','9024146449','26 Hauling Road','26 Hauling Road','Hacketts Cove','Hacketts Cove','NS','B3Z 0M4','November 19, 1972','Female',''),(100044,'daugherf@eastlink.ca','$2y$10$EyHC9EpKkNZHOBLx2mAuG.09.I6T.kCtcXNCQbu1Uj.LL73LQZ./i','e8676375e4460cb552403aa07318fcfa','Robert','Daugherty','902 553 0127','34 Pentz Road','34 Pentz Road','','Pentz','NS','B0R 1G0','May 3, 1946','Male',''),(100045,'oconnor.brent@gmail.com','$2y$10$upRNFDUedmc9lWI.SsAzL.j8Oi..6X1ueyuWbGVJ8w1GssX8poNbG','bb4e0f4eaeae83e2c48f39e080c8e09c','Brent','O\'Connnor','902-678-6794','18 Orchard Road','18 Orchard Road','','Kentville','NS','B4N 1R9','November 5, 1972','Male',''),(100046,'scasey@hrsb.ca','$2y$10$tAeQSmgLXteokOtjEC6iMeBbcTw0wctjdfDPox8uou.BX0NntxncK','72da37941f2651ecf697fe32a972085a','Susan','Casey','902-823-2463','8671 Peggy\'s Cove Road','8671 Peggy\'s Cove Road','','Indian Harbour','NS','B3Z 3P5','July 4, 1974','Female',''),(100047,'dybereta@nstu.ca','$2y$10$KOhrAtZ92Xc26rEbxDi92eZpY49qwVwlesSqVRZyj4RylBiod.yWe','315ef4f514b75e5000ab9659a7f94539','Darlene','Bereta','9027366273','256 Park Road','256 Park Road','','Florence','NS','B1Y1N2','January 5, 1967','Female',''),(100048,'easantekorankye@dal.ca','$2y$10$s5GLFI8YZVU2P3TNwJs6j.FxB1HzdyFDVSl4dQoOrx.UNJTlTOyQe','368aedfb61a37e6e3920b10273e3956e','Ernest','Korankye','902 957 1374','20 B Park Street','20 B Park Street','','Truo','NS','B2N 3J2','January 12, 1985','Male',''),(100049,'haley.mathews0998@gmail.com','$2y$10$92b79g9ueTNvNBqijLcwEOR7t3jWc8JPeY9kwoO52HKVkQ3ktHTCi','586303da98bef9b815c5b3ef99298644','Haley','Mathews','902 895 5304','129 Queen street','129 Queen street','','Truro','NS','B2N 2B4','September 2, 1998','Female',''),(100050,'haley.matthews0998@gmail.com','$2y$10$KH7vN3vg7xoQahOaAixO/eXus31SL3/VVVGSa0lm3NpY.OkfD2QKu','71e2d48b7f5bff94502e40de1c4744f1','Haley','Matthews','902 895 5304','129 Queen street','129 Queen street','','Truro','NS','B2N 2B4','September 2, 1998','Female',''),(100051,'isaiahreade@gmail.com','$2y$10$79dwcmZkwyX5iCxWOIZfJ.9fzPpKKuyohS3rpZ5dr4rqwfHfEcYvm','3172c060177e0c401fc3858ca4fd2c96','Isaiah','Reade','902 410 1087','6225 University Avenue','6225 University Avenue','','Halifax','NS','B3H 4R2','September 4, 1998','Male',''),(100052,'eatonav@ccrsb.ca','$2y$10$1t6poCKwWbC/Bg.2eF.IpeD9HTyBdhl/Y4yCaGCBNyUbgI34bnFk6','0a7e0fedf49a9220086297c8c3e35f60','Tony','Eaton','9022972757','#8','224 East Victoria St','','Amherst','NS','B4H1Y9','July 22, 1969','Male',''),(100053,'cisert@hrsb.ca','$2y$10$vJ.bcP9OZ2dw4rFh5fvXw.pGkYZ30MzUbSiA4AUSibtuexjFqROnW','368518295041a1a27b5e6dd7300a4084','Crystal','Isert','(902) 864-6785','100 Metropolitan Ave','100 Metropolitan Ave','','Lower Sackville','NS','B4C 2Z8','August 10, 1977','Female',''),(100054,'kkdbarkhouse@gmail.com','$2y$10$VbUX0d23V/kMxRqc/VH.E.BOCC642cyF1C7rac2XalcNY68Xh8Ney','1d581a5f0627edda9e9045c6e6de0aac','Kari','Barkhouse','9025272516','2562 Aberdeen Rd','252 Aberdeen Rd','','Bridgewater','NS','B4V 2T2','July 26, 2016','Female',''),(100055,'dickinsond@ccrsb.ca','$2y$10$54cVP5p2WwSjXw8wOFSPdeYwlTn6w9VPcSVjKQNrkJpkSm9rPnMb6','c881f20359b440cfbf8cb1cc8eb3c888','Denise','Dickinson','(902) 251-3205','2843','Barronsfield Rd.','','River Herbert','NS','B0L 1G0','January 1, 1974','Female',''),(100056,'andriel_p@yahoo.ca','$2y$10$uamCDMBgDK4i5n0jVUtDqOds5CoCtIp/et/iE1wm8ZrdUe16vdCVW','6d8170018e4dceb39216f3753f1fab5b','Andriel','Pitter','902-542-1545','8 Fairfield St','8 Fairfield St','','Wolfville','NS','B4P 1L9','December 28, 1966','Female',''),(100057,'hale.matthews0998@gmail.com','$2y$10$0/s20MkW1SmO68RmOo8LCuDVDeo8qm0VA1tWJKSu7ZW.Bu8vori2K','e9dcb71f8be012e4afa42f8f75ff6293','Haley','Matthews','(902) 802-9824','129','Queen St.','','Truro','NS','b2n2b4','September 2, 1998','Female',''),(100058,'asp.imhotep@dal.ca','$2y$10$hDKNluA5QQw8WDno27oYVuNnI5UJCAMihwJ.1CuXZDiNdReICrp82','d5804be2a9345a850ced3d4a7edfa9f6','Ifunanya','Kammelu','(902) 494-4037','6225','University Ave.','','Halifax','NS','b3h4r2','October 20, 1993','Female',''),(100059,'namarsh99@hotmail.com','$2y$10$eyKqvctk8IOsSUUrxPhqWOaIoe86vkQvzRmB.4aokJ.5eRMR0qPNa','22ace6bd78eb90a7c55606d27b2804b1','Natalie','Marsh','902 736-6787','249  Point Aconi Road','249 Point Aconi Road','','MilleCreek','NS','B1Y 1W9','June 27, 1963','Female',''),(100060,'jkdaborn@gnspes.ca','$2y$10$0mEBtOnkGNqR.9SXpgw/quxHXbyZgWLP.lqDUjIY5Th1ZxWTXWB3.','f65762e8cc3cbdc0aa963c3ec4f9f8e4','John','Daborn','902-670-9778','7375','Brooklyn St.','Kentville','Kentville','NS','B4N 3V7','November 7, 1987','Male',''),(100061,'micahlink@gmail.com','$2y$10$y/RF16Nl4l44PxP9HAWvyutHr.4nyZNprwutds0xxarQ.PNuXXik2','f04fb933bd5def8e498c6e5c2f244b30','micah','Linkletter','902-986-1598','9','Walnut Crt','','Truro','NS','B2N 5S6','October 9, 1978','Male',''),(100062,'jlcole76@gmail.com','$2y$10$Sxm7bCqkgfNUshipvLSr3.Gi2qJ9NxwfQOAM3WOJaRuD6nOOJQIES','30f6ee9d4494f5afa6c112ed59bd27c2','Jaime','Cole','(902)836-4283','434 MacIntyre Rd.','434 MacIntyre Road','','Kensington','PE','C0B 1M0','June 7, 1975','Female',''),(100063,'sico.scorpion@gmail.com','$2y$10$l1l3Id9kSx1Ir9bm67H1Ne2QT1LvXD1WhdpqQIn2wr82AOJno28dy','f74611b2b465cd08b084488b56851c23','sico','scorpion','9025853822','2152','Roy Jodrey Hall, 39 University Avenue, Acadia University','','Wolfville','NS','B4P2S6','November 3, 2015','Male',''),(100064,'imhotep@dal.ca','$2y$10$ofXG4F2yoFW/2TXQrosiCeXMByQIyMILFVzwPNjCxKIA9I2Q4n2VS','40e8ed3829e633a6d97ebbbe2bb15384','Sidney','Idemudia','9024947884','6225 UNIVERSITY AVE., ROOM G40M/N. P.O. Box 15000','6225 UNIVERSITY AVE., ROOM G40M/N. P.O. Box 15000','6225 UNIVERSITY AVE., ROOM G40M/N. P.O. Box 15000','Halifax','NS','B3H 4R2','April 25, 1990','Male',''),(100065,'sharla.rolfe-hunter@nscc.ca','$2y$10$ezrJBvLKHJJhtBNsFHJfKebSbExQDbxITjg/I7KWYLf2wPXFE1NFe','7f5d627df5b24be4305229a051a5e489','Sharla','Rolfe-Hunter','902-584-2056','50','Elliot Rd. RR1','','Lawerencetown','NS','b0s 1m0','December 1, 2000','Female',''),(100066,'lgdonovan@staff.ednet.ns.ca','$2y$10$OnR6J70j10mmYAw9HulHGOoM46Bc3gp98VLYRmZQv2k5VJ.TgI96O','1b1aace9a2e66a91dd5220c3a7c8ee7a','Leo','Donovan','9022852158','27 Old School Lane','PO Box 142','Ingonish Beach','Ingonish Beach','NS','B0C 1L0','October 18, 1970','Male',''),(100067,'lists@dixonfamily.ca','$2y$10$LyfTxQCEv19CdOxzfckwi.d4nCR6qxJ0QROj034ZxnRIxrWDrliA.','47789f5e5b13f33de6eac1f24685e72e','Jon','Dixon','9026817683','9453 Commercial St.','9453 Commercial St.','','New Minas','NS','B4N 3G3','July 10, 1977','Male',''),(100068,'bwalker@eastlink.ca','$2y$10$Y3p6lOm.iWIZE4wZA7VcUeTm911iMuHrqbs4hc4jeoG6Ukqu4faKu','d506d636557584c4b61c240432879d55','Robert','Walker','902-404-6427','12','Edgewater Close','','Dartmouth','NS','B2W 6S3','September 13, 1961','Male',''),(100069,'programmingpanthers@gmail.com','$2y$10$A.qEy.MH1VJsgRzcedLWoe6ume5qnhkPj5cLzykIxl5szQjtBZGa2','07f074cf786ae9f05b42a064d360c62b','Jill','Fraser','(902)695-5287','297','North main Street','','Trenton','NS','B0K 1X0','March 16, 2015','Female',''),(100070,'shelly.bembridge@gmail.com','$2y$10$PjjHXx8FujTjJ7Jv1jjfTua7uvAuPcQCmXkEq7H7XlhDfepyWaSS6','45d664d3943baaa04a480511951623b9','Shelly','Bembridge','902-229-7377','17','Falcon Run','','Bedford','NS','B4A 2Y8','July 4, 1974','Female',''),(100071,'mackieke@ccrsb.ca','$2y$10$A/KysNq9apGLk9Y0LvXnKu2SAXbWtD9B3SCxJyAxTRWwh5huIOiVe','86fabfa82059450b7088348c9cf1bd48','Kathryn','Mackie','(902) 921-8613','52','Lovet Cres.','','New Glasgow','NS','B2H 0B2','December 12, 1985','Female',''),(100072,'leblcody@scolaire.ednet.ns.ca','$2y$10$DQWoCsohsE9XqiQ3t/J2h.xHWnKOopyifjFDKRLT.lN3vgvUBUzRC','b98b2fd6c511c635ced5e1a1a5544861','Cody','LeBlanc','(902)896-4500','50 Aberdeen St.','50 Aberdeen St','','Truro','NS','B2N 4V3','February 14, 1984','Male',''),(100073,'rwalker@hrsb.ca','$2y$10$q.KPKmT73.b5l9.WS7XGauk5ENlAxQi/V4xeX1w1CaJMn1ICPOmtK','19884b6a4d143b271f877fce14d9589d','Zeyas','1','(902) 457-8930','45','Plateau Cres','','Halifax','NS','B3M 2V7','April 12, 2003','Male','Mentor'),(100074,'steele01@ns.sympatico.ca','$2y$10$agkatx/EgMYK3bKWgDMjauho7GVkP9jyIZagwLsz4WoaNrMLSogi6','c143d3707ef32e1cb37c5e1704ae5e5b','J\'aime','Steele','9028600580','221 Philip Dr','221 Philip Dr','','Fall River','NS','B2T1H7','April 14, 1976','Female',''),(100075,'kyleandcrista@bellalient.net','$2y$10$PYBsj14V.StBrtIYEtRtH.knuB93svq8/rtYBAL0V1Bfhxm/.THei','d4e3e6639d7286718d2a2ff97d67a1d3','Crista','MacNeil','(902) 389-2519','PO Box 155','1507 Palmer Dr.','','Kingston','NS','B0P 1R0','August 15, 1975','Female',''),(100076,'annelmartin@eastlink.ca','$2y$10$wp0zgbyH877KQ7KzhXuN5Oqy4xk7BiBskNG9wMV8yLmArZHGVa4sK','f86cfce1b87c591d497f03ef7082fc1f','Anne','Martin','902-445-8125','63','Woodward Crescent','','Halifax','NS','B3M 1J6','November 21, 1967','Female',''),(100077,'thesteelesare@gmail.com','$2y$10$iv2yCvPTUomRyTgINGMTi.XblYTSVHTyz0toirgOgy6WyVNSCOArC','cc6de893bf00f90f2a0caacd6993a107','Mark','Steele','(902) 860-0580','221','Philip Dr','','Fall River','NS','B2T 1H7','November 19, 2015','Male',''),(100078,'coordinator@capcbco.ca','$2y$10$WKYjSIdtsGPcWqH2eBb7SeFw9osHYkYxIDllIH379qWI717t7NMwi','071c89f18ea3fecdb86ae3e3604b81c5','Rachael','MacKeigan','(902) 979-0036','8','Crystal Dr.','','Florence','NS','B1Y 1G6','March 5, 1984','Female',''),(100079,'jobs@capcbco.ca','$2y$10$F1qW9yHwe6wWEKzw9zSdMecuydXNurMJiP2Jlz.aEyRGi.fYO5O7O','9e05c5d0c6760136f93fe6da1d74d172','Chelsea','Butts','(902) 979-0036','8','Crystal Dr.','','Florence','NS','B1Y 1G6','October 8, 1991','Female',''),(100080,'currie@gnspes.ca','$2y$10$mM5tMm9FJIoOcZlCQhKvAetRP8wgqM1tetJSLTHiOZvHkz38Nz6.2','7fa000f8af5b196966d9c15380b3130b','Mark','Currie','902 521-2655','3504 Hwy 332','Box 2B-1','RR#1','Rose Bay','NS','B0J 1X0','July 4, 1969','Male','');
/*!40000 ALTER TABLE `Users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `VolunteerPositions`
--

DROP TABLE IF EXISTS `VolunteerPositions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `VolunteerPositions` (
  `position_id` int(10) NOT NULL AUTO_INCREMENT,
  `position` varchar(128) NOT NULL,
  PRIMARY KEY (`position_id`)
) ENGINE=InnoDB AUTO_INCREMENT=100000 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `VolunteerPositions`
--

LOCK TABLES `VolunteerPositions` WRITE;
/*!40000 ALTER TABLE `VolunteerPositions` DISABLE KEYS */;
/*!40000 ALTER TABLE `VolunteerPositions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Volunteers`
--

DROP TABLE IF EXISTS `Volunteers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Volunteers` (
  `volunteer_id` int(10) NOT NULL AUTO_INCREMENT,
  `email` varchar(128) NOT NULL,
  `first_name` varchar(128) NOT NULL,
  `last_name` varchar(128) NOT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `civic_number` varchar(128) DEFAULT NULL,
  `street1` varchar(128) DEFAULT NULL,
  `street2` varchar(128) DEFAULT NULL,
  `city` varchar(128) DEFAULT NULL,
  `province` varchar(128) DEFAULT NULL,
  `postal_code` char(7) DEFAULT NULL,
  `dob` varchar(128) DEFAULT NULL,
  `gender` varchar(30) DEFAULT NULL,
  `medical_info` varchar(255) DEFAULT NULL,
  `shirt_size` varchar(255) NOT NULL,
  `consent` varchar(128) DEFAULT NULL,
  `position` varchar(255) NOT NULL,
  `season_year` varchar(128) NOT NULL,
  PRIMARY KEY (`volunteer_id`,`season_year`),
  KEY `season_year` (`season_year`),
  CONSTRAINT `Volunteers_ibfk_1` FOREIGN KEY (`season_year`) REFERENCES `Seasons` (`year`)
) ENGINE=InnoDB AUTO_INCREMENT=100000 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Volunteers`
--

LOCK TABLES `Volunteers` WRITE;
/*!40000 ALTER TABLE `Volunteers` DISABLE KEYS */;
/*!40000 ALTER TABLE `Volunteers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `responses`
--

DROP TABLE IF EXISTS `responses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `responses` (
  `reset_key` char(32) NOT NULL,
  `secret` char(60) NOT NULL,
  `request_timestamp` datetime NOT NULL,
  `request_ip` varchar(39) NOT NULL,
  `email_address` char(64) NOT NULL,
  `used` tinyint(1) NOT NULL DEFAULT '0',
  `active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`reset_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `responses`
--

LOCK TABLES `responses` WRITE;
/*!40000 ALTER TABLE `responses` DISABLE KEYS */;
INSERT INTO `responses` VALUES ('00bdb530c45367bbc7b9c32bc4d0b97d','$2y$10$LcC0KkDN/aUs1qiXr.eh5eW8SQaOCf0uyXrqacDmhXQuaaUobTKnm','2015-11-20 14:53:32','134.190.172.42','asp.imhotep@dal.ca',1,1),('01cbc2bc866914fe48400200fef50656','$2y$10$R7kIqGktYArbdk5zTLAILOZmSDf1XG9blmgQZRBjh0JG6QGLS4FyG','2015-11-12 16:17:42','131.162.192.32','sharla.rolfe-hunter@nscc.ca',1,0),('024d5d037a6af5b32fafc473c27a6ee9','$2y$10$gBr81E0IOQ.I0BwOC9MBXOE5jfW1Cblky0UxrWPYzSugCBM8oVKq2','2015-11-18 12:58:34','156.65.14.229','kyleandcrista@bellaliant.net',0,0),('03353991990559f3bf78e5b1126597f1','$2y$10$hnn1VipKU6U.k36BSnqKd.IuIaE3c67vxcQ6FEmVaySy80e6dKk3.','2015-11-13 12:54:23','142.177.81.30','sharla.rolfe-hunter@nscc.ca',1,0),('0b50250da913bd8a87c221ffcf3fbfa7','$2y$10$O4w1X.JFmX4YXK/gAszfqO87yqWw3BDLNJeQE6l9kGlyoH0h6sySq','2015-11-03 12:35:48','208.103.238.159','rpc.assistant@acadiau.ca',1,1),('14c33de29bf001d3acc76aef445eb42c','$2y$10$qhuCbI7zRGQvkza9fm2SteEzzGcb6dKRk9zZT3rPZ2ejqi0xdB1uK','2015-11-03 14:20:24','131.162.135.172','sean.morrow@nscc.ca',1,1),('178441f470499d4e8dc22cc27b35c5a7','$2y$10$n78GYz9K0XDdH4in9V4O6.ZYdx8/8olcAF5k0UUyFAoZEe/brNOsy','2015-11-13 15:07:19','131.162.192.32','asp.imhotep@dal.ca',0,0),('26bac7dbbce0ab0cb09ba931c1792840','$2y$10$D1pdsFb5jfHS/PUu7xxjiunIwxa/pnu6GGuQArb5FHN/oudy0WhcK','2015-11-12 16:14:02','131.162.192.32','sharla.rolfe-hunter@nscc.ca',0,0),('2bdcf5202d8478b6813f28c18c17ff1e','$2y$10$VpBb19S15wtk7D2Bk/qQAOvzPzmUcGOQo0P/n0W8NlBrdWlkVQyMy','2015-11-03 10:52:16','131.162.195.126','rpc.assistant@acadiau.ca',0,0),('2c0c5cebdaa5764022528eb50adda8ee','$2y$10$1ZmexGGa..dIe2Mm7qP/GOX16Mf7DjmgEF3CBRvf0Li11LzvKeBU.','2015-11-07 17:43:12','142.167.168.110','mouellette@hrsb.ca',1,1),('2f5a39e587c78c04efc3c8e642c5a8fc','$2y$10$.Ym.hTsp15Bl3xt0iFQqCuCyUhHyc3SUFwIyHCGY8dtWCR7MprTR6','2015-11-09 13:58:56','198.166.214.5','sarahouthitsmith@hotmail.com',1,1),('317f320144b5a6fbd44a9a3678ae324a','$2y$10$3frG1HPxOUDA7RKui03gBueXD8/VlV4hvmFBWWDqV2HvksZJsnBnO','2015-11-18 11:16:36','131.162.198.32','mackieke@ccrsb.ca',0,1),('3d41a6058c0b157591e6cb0417cc53d9','$2y$10$mS1nltKjoJ6RaG.k0/jeLOOyyMqCq0Pbdtbm6zPHAI3oiCi60030W','2015-11-05 22:11:42','156.57.154.175','kimdoconnor@gmail.com',1,1),('48198dcb7fdf0347dc19d24fcbca808c','$2y$10$/etgCVA4Nwvf88SuAmHi3O3RnbEJhfEHR59THbIW0rmNhsbggXT92','2015-11-03 13:54:39','131.162.135.172','sharla.rolfe-hunter@nscc.ca',0,0),('4924eed50d0299ddc22466552fcd8423','$2y$10$XDEmRgeCe6aV5i5it8Unh.HFrY.klOru9ig1tsx9ylV9RvANHkjcy','2015-11-19 16:21:22','131.162.198.32','jobs@capcbco.ca',0,1),('53dd8e51bbda36f1702421134daca2ba','$2y$10$PCIwEtTLCHMbySOY2tul4uKp0Scl2t9KzqIIMkVBRuOjgOX/CIfum','2015-11-19 16:19:39','131.162.198.32','coordinator@capcbco.ca',0,1),('5867675065ed6eab1da72714b710994e','$2y$10$N7SaEL/nAIpZgLOV2Pv3hu/h6NaN66MuFrttU.MbT4hHZ3GnLuci.','2015-11-13 13:09:33','142.177.81.30','sharla.rolfe-hunter@nscc.ca',1,0),('5faa84369cd51d31fef1fcc5b5b97c96','$2y$10$1n1BdWVKfLvx7JhE6k8Ive23kExUOLO9Lxd6PDMEZvNYKXU/z2k8K','2015-11-04 15:52:56','199.188.172.130','darren.andrews@nscc.ca',1,1),('60a109bed9d76782df07829af04ff796','$2y$10$YN1zqKBeX9QcbeswbfhOXuOb.5LGTkszJBPRnFZf6rlIqyBCyk4QG','2015-11-10 16:43:27','142.227.209.1','dybereta@nstu.ca',1,1),('6d50e166b51feefdc7d978f88e5528a7','$2y$10$R4WXPPoHlaiHoL5bTow4NO6FMBiS6doEN7lD/9sUZ6uzYH9xLIEgy','2015-11-19 09:31:54','131.162.198.32','kyleandcrista@bellalient.net',0,1),('705fad15196e5a241731854494581441','$2y$10$2uTW9hlYADBuB1.GDEL/y.DPp4jB7jN7rO9a5dG/YiCuO.jbRRV1e','2015-11-13 08:23:57','131.162.192.32','hale.matthews0998@gmail.com',0,1),('73ef9e22709f1926e430f98c9a4fd03e','$2y$10$oIrw6eS6L1j/CoTmIShfFeRp5BTe6TMfgCLtPUYT76hfaG.LIp0Vu','2015-11-03 12:35:41','208.103.238.159','rpc.assistant@acadiau.ca',0,0),('7bc24d9811813be48e7a4c1af909ffa0','$2y$10$0npiIda.bHiux3kBuGwsXeHr2XvrkeDhDar9DC4l.85v0yLi5nxRO','2015-11-03 14:03:21','131.162.135.172','blair.lipsett@nscc.ca',0,0),('7ebb25bdbf7db6eb381dc64a101efc39','$2y$10$3bByhtVzozx9ZH.nVaE0n.azABPGTriD4mJb7T3e7kjQcDdHhbWLG','2015-11-18 10:02:50','131.162.198.32','shelly.bembridge@gmail.com',0,1),('81364f3e1dbf6ed49f9672e5d9447720','$2y$10$zG3ba4ZdfW8Ljw4JqN92fuKdjrPlrHko2oNaGsii6h43iWdfVUrOe','2015-11-03 12:30:42','208.103.238.159','fady.abdelmohsen@gmail.com',0,0),('888715825960583f5ca06b11cdf213e3','$2y$10$fibNLZKOE8Y9DjnuhyJ.Ze8RFYNmxhHKZiOCCvgzDf8UhmTCyOcni','2015-11-03 14:27:58','131.162.135.172','darren.andrews@nscc.ca',0,0),('8ab71976f48014463e08ac17366993ab','$2y$10$sE8vRDTwsHnLR50XDVK5qebSeK/ZQztGL/GrH2PZnj6VwLR62HGR2','2015-11-09 14:43:57','131.162.192.32','tchampion@gnspes.ca',0,1),('8b24963857c472930d367c629b7fe4ca','$2y$10$Z6uFl52MzBLu33omXAlxK.P99wjK6oPZITAsxHI09YaRDo473cIYu','2015-11-20 12:39:32','134.190.172.42','asp.imhotep@dal.ca',0,0),('8b3f029c2403642a56dd5ad59d54d400','$2y$10$ND39ldSrPHlPFOw8mWU0wOUqMlmIYYUpn3zHzoa1HZR8QLdHByOCq','2015-11-03 12:34:04','208.103.238.159','fady.abdelmohsen@gmail.com',1,1),('9320cbd859345044c1a17ca25d316cd3','$2y$10$HcFKg4.aJdKbEPCXucW5huFM1GYZXfhthr0/4WjEfbbS7eSgFohz2','2015-11-03 12:21:44','208.103.238.159','fady.abdelmohsen@gmail.com',0,0),('94144d937b2bd76cc866acc1c44e64b2','$2y$10$DTUsfRJ7K6rDP6LGWXvgeuOY5OYyQfTZwnf2uf2PBeLexfI9BwaIS','2015-11-16 15:22:07','142.227.138.10','lorieann.mills@gmail.com',0,1),('9474ad8970335319d7687d9448ced0a1','$2y$10$AulXEldhJtqZU97kgrzaEe2OYNPH4q2Y6qP65/Z4z8L67I1nCn13m','2015-11-19 09:37:18','131.162.198.32','steele01@ns.sympatico.ca',0,1),('94d3bcdd448243e5c0686964ca426c55','$2y$10$T04PsndX4bwqHfAufEtcxORjb/7m.1/HocJQCDUlLW3CBgeN0gKYe','2015-11-09 14:50:35','131.162.192.32','greg.fox@avrsb.ca',0,1),('979af9f5ae27e8ce5502a25e4f6dd44c','$2y$10$kr2ihuItwGQ8QhjfssNtS.7r5GGRj6r4OwCPH7km4ovFFGVCN1p2u','2015-11-19 12:15:47','142.177.81.30','sharla.rolfe-hunter@nscc.ca',1,1),('9935af729f3576cc9cd859b8156a7454','$2y$10$a3jLjxTiFG6YiAEJ2aZQ2eBKXhYjI1ybCfBgFi51MXlswip4RNZLm','2015-11-18 16:45:12','142.167.14.127','kyleandcrista@bellaliant.net',0,1),('99dc3ecbb629f6343e1e50323d860644','$2y$10$CiuLsUwJRP34DVSi.vsYu.w27Ybg1mw5UcwPaD05bVKaCZ9swC6Zq','2015-11-13 07:44:51','131.162.192.32','sharla.rolfe-hunter@nscc.ca',0,0),('9c3f257f259df7c222f0fbb85ede4612','$2y$10$FqJu4hDVKBSKkkPXtVEpauv1hfhbhwZ9sbGsB7ifq5yhHVNB85bIK','2015-11-16 15:21:47','142.227.138.10','lorieann.mills@gmail.com',0,0),('ac0d58e09e5a6afd9282ba51d8055785','$2y$10$hhIcFGMx8asMwC.Z8LyF6.sfLR4mXLQ/6/lQClmD1AEocsLVzx8uK','2015-11-03 12:16:47','208.103.238.159','fady.abdelmohsen@gmail.com',0,0),('ca2dc17adf3f681f4acf2dc4860bcfc2','$2y$10$qmGPigTn3dx/juBs0s0uMeaTSFk/uI9GmE6p5LGG2a/2OKF29QvIu','2015-11-18 15:53:32','131.162.198.32','rwalker@hrsb.ca',0,1),('cc043ea3ab8eb884329cb465cf8b9208','$2y$10$hfrw9xaaI8v3t30bxXhih.MtKZanf9ahH.BBj.84Ypr2KHNiRJ4um','2015-11-16 14:36:22','208.103.238.159','sico.scorpion@gmail.com',1,1),('d761163ffcd1112719c828378920b6eb','$2y$10$7qGVoQSYjhaYqH/rUh1.GemkQ5zV/UhxKZkLBOSb/hdglbwNdZHhu','2015-11-19 12:08:52','142.177.81.30','sharla.rolfe-hunter@nscc.ca',1,0),('d915ae7e63afb65aa5579d3c97355d52','$2y$10$Of8HY2EjAsCPupjAWPsVbuKUcPHS0sgYzHa6bc58iGSrwAz96ccky','2015-11-03 12:11:07','208.103.238.159','fady.abdelmohsen@gmail.com',0,0),('da086d63012ed09b956cb092f15aaf8e','$2y$10$PzzyeiiIPA34zUypDgF82uY39wD2CdTZx7CFfBal2ETBiK86Nrf7G','2015-11-16 15:10:27','208.103.238.159','sharla.rolfe-hunter@nscc.ca',0,0),('dbdcbf6a2572409580a193084ca33c25','$2y$10$b7DHtd2O62D3Jh1zzFvsteVrSElzoVnDGlKqMTEDJxuNfkm7iYmIG','2015-11-13 12:59:16','142.177.81.30','sharla.rolfe-hunter@nscc.ca',1,0),('df476721579bc6a43cd958e6a218768f','$2y$10$NdxtJ.enw2S5yVheMnWPkuva5yZGi8TdFmtWPHTZlPxAB9bZ4HJxK','2015-11-03 10:55:43','131.162.135.172','rpc.assistant@acadiau.ca',0,0),('e210056e002a03c750b5bd7b32057953','$2y$10$Xz.mOQf1uoGiLfJqJOXfOeACVyAqd5xkZYzBMVLGYJ03.dCvanyQK','2015-11-20 15:37:53','131.162.198.32','thesteelesare@gmail.com',0,1),('e4f80b235a9778c93960b5bcc813b5e4','$2y$10$zOYqOau2d1zykGhXVSuiV.B6xwf9RaiHB.YYm6bd6ubyoyXl40dhC','2015-11-03 15:18:49','208.103.238.159','blair.lipsett@nscc.ca',1,1),('e5a1e541ea2328171e154ae6ecb6d974','$2y$10$7zdWFxbsF3lwvSiH0pAeM.euvIaQ/GO7aOcZV9RbvBLAuJi0KNw/u','2015-11-20 12:16:11','134.190.172.42','asp.imhotep@dal.ca',0,0),('e63df2e5e139e2b0846083eb7b0657c2','$2y$10$rogp0Mp6aIJ.wEasVWUiOOoMW8cklLBQnYn3ncqQQyEjG0Wfd84A6','2015-11-03 12:32:29','208.103.238.159','fady.abdelmohsen@gmail.com',0,0),('e71a8814da7ee3e2ac1a1199de4e9e44','$2y$10$EYNd9Hb.3lgMPz7qF44FC.XOmXTLGqNsWyW7QJkjhcY3bKi8HAGju','2015-11-05 09:06:48','131.162.192.179','sarahouthitsmith@hotmail.com',0,0),('e92ee0c999155a3c8ab5f4225fcf92d3','$2y$10$0rDtFnq.Lcweblvw9.Y.Iu8JwzqeXCV0bBvF0qwqNC1FkpT.C3qI.','2015-11-17 16:42:23','24.138.30.101','bwalker@eastlink.ca',0,1),('eeb8a0d8b25daa9fd168acfd3ec41f73','$2y$10$SA7BNwDnsVQ2k4vIHE0UB.d19KjRr/pM8ylOFOgiAdCJaKClUjqJi','2015-11-19 13:32:10','131.162.198.32','thesteelesare@gmail.com',0,0),('f0effd33478d42ee7ee8639a7272682c','$2y$10$mr95CAVBYeA/VD12XCi5duYVupooYoQ45y80MHUcmTZVU2fJKDPXW','2015-11-12 14:41:34','142.177.81.30','sharla.rolfe-hunter@nscc.ca',0,0),('f3c36055e370f2442cd93b6523254459','$2y$10$SXstTvYCGw/IzGbSH5EdguxEBKDwpUv44z8KvpKizBTUZZrkKLbSO','2015-11-03 12:53:52','131.162.135.172','mike.duggan@nscc.ca',0,1),('fc1e51604c9d0587b1e35d2a24b54a58','$2y$10$LySM.dfq2hV8q5Fl5.652O9/R3k6SNJ6DQDUQyePIFwoeIqR9qQcq','2015-11-12 15:35:28','131.162.192.32','dickinsond@ccrsb.ca',0,1),('fdcf8458537b7e1c2d2f85fb5149b848','$2y$10$tbxJzfqB3A5.1ta3W794a.1Ny4EkEd9GOd2Zo/sApVdfdVnGbl6Xy','2015-11-12 15:29:04','142.177.81.30','sharla.rolfe-hunter@nscc.ca',0,0),('fdeb9a11b1256b4d9d76c5078c34b9b0','$2y$10$lP98VDqIcmTiOunTUmdSPuLcQXgCCJ0sFH8F3BZc1T0v/IpJWd3Vm','2015-11-16 18:46:16','142.177.81.30','sharla.rolfe-hunter@nscc.ca',1,0),('ffd84ddb60deb90170eba0b00bf58048','$2y$10$Uz8Bb5UEXOEHMDEeAC1mRea2LP389Ir1EtMU4y9ICBcdgVQgHksT2','2015-11-20 10:14:55','131.162.198.32','walkerjc@ccrsb.ca',0,1);
/*!40000 ALTER TABLE `responses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sent_emails`
--

DROP TABLE IF EXISTS `sent_emails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sent_emails` (
  `email_address` char(64) NOT NULL,
  `timestamp` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sent_emails`
--

LOCK TABLES `sent_emails` WRITE;
/*!40000 ALTER TABLE `sent_emails` DISABLE KEYS */;
INSERT INTO `sent_emails` VALUES ('6c15831a4d53273cac8e42f749f51948abdab5c30a65cd9f89c5b7c3fba4d1f3','2015-11-03 10:52:16'),('6c15831a4d53273cac8e42f749f51948abdab5c30a65cd9f89c5b7c3fba4d1f3','2015-11-03 10:55:43'),('f58678714da9a80e435857bc4dd0dbbcf95a9b85664fb8643cfe3a97aa9d4820','2015-11-03 12:11:07'),('f58678714da9a80e435857bc4dd0dbbcf95a9b85664fb8643cfe3a97aa9d4820','2015-11-03 12:16:47'),('f58678714da9a80e435857bc4dd0dbbcf95a9b85664fb8643cfe3a97aa9d4820','2015-11-03 12:21:44'),('f58678714da9a80e435857bc4dd0dbbcf95a9b85664fb8643cfe3a97aa9d4820','2015-11-03 12:30:42'),('f58678714da9a80e435857bc4dd0dbbcf95a9b85664fb8643cfe3a97aa9d4820','2015-11-03 12:32:29'),('f58678714da9a80e435857bc4dd0dbbcf95a9b85664fb8643cfe3a97aa9d4820','2015-11-03 12:34:04'),('6c15831a4d53273cac8e42f749f51948abdab5c30a65cd9f89c5b7c3fba4d1f3','2015-11-03 12:35:41'),('6c15831a4d53273cac8e42f749f51948abdab5c30a65cd9f89c5b7c3fba4d1f3','2015-11-03 12:35:48'),('4ffc2e75d55919788ae0d2e000cdf13ec06805d8eb38a9d8d0c87fe61c9a3590','2015-11-03 12:53:52'),('cb70da7c79be10d0dda38f8d6f3259f944247d431f85b6d121ace728d4fc40a2','2015-11-03 13:54:40'),('99c3a648c2d5097822753d36bd1b68e9bf70a53e5bd6bde17aeec1251de19054','2015-11-03 14:03:21'),('4c047703fe1f86badb52e1944eed184b328a3eec57beab818b6c6112abc89cfc','2015-11-03 14:20:24'),('7f480690742772abb6b3373661c296bfb6992a377cd3f0d69a9a87be27b18409','2015-11-03 14:27:58'),('99c3a648c2d5097822753d36bd1b68e9bf70a53e5bd6bde17aeec1251de19054','2015-11-03 15:18:49'),('7f480690742772abb6b3373661c296bfb6992a377cd3f0d69a9a87be27b18409','2015-11-04 15:52:56'),('eaa53a34f6936954515b00888726cdc9fc1b771c833b8ad1e7e0b19b561adcd5','2015-11-05 09:06:48'),('0c3620149639d3a73d85c80f2cf078a1c3461488664eb2853524b0bdabaef321','2015-11-05 22:11:42'),('89f0d61ff40ad3c4aa677586f70a5f3b3746624d7f059246a4907b3d8782db9d','2015-11-07 17:43:12'),('eaa53a34f6936954515b00888726cdc9fc1b771c833b8ad1e7e0b19b561adcd5','2015-11-09 13:58:56'),('4694893e9998bbd87e5a934e4c92603fa64629fef92ddaca8ddc440ff030026c','2015-11-09 14:43:57'),('52dbb2f74c644c41cba295810dcdb89ccc97989c21985f5ad3925cb2fee1d2ae','2015-11-09 14:50:35'),('ec4cea323507dd7fd97c3e8ec72f279a04a0905159297b69f315e0d378b64cc5','2015-11-10 16:43:28'),('cb70da7c79be10d0dda38f8d6f3259f944247d431f85b6d121ace728d4fc40a2','2015-11-12 14:41:34'),('cb70da7c79be10d0dda38f8d6f3259f944247d431f85b6d121ace728d4fc40a2','2015-11-12 15:29:04'),('3b38db6a6a00df54cb1083b3c1dcdb6bf92be0be09106f74dd0c635d9a9fa5ef','2015-11-12 15:35:28'),('cb70da7c79be10d0dda38f8d6f3259f944247d431f85b6d121ace728d4fc40a2','2015-11-12 16:14:02'),('cb70da7c79be10d0dda38f8d6f3259f944247d431f85b6d121ace728d4fc40a2','2015-11-12 16:17:42'),('cb70da7c79be10d0dda38f8d6f3259f944247d431f85b6d121ace728d4fc40a2','2015-11-13 07:44:51'),('71aa567a8b758349c955177dac607525b74d4f34c020957be515c7f74a47da02','2015-11-13 08:23:57'),('cb70da7c79be10d0dda38f8d6f3259f944247d431f85b6d121ace728d4fc40a2','2015-11-13 12:54:23'),('cb70da7c79be10d0dda38f8d6f3259f944247d431f85b6d121ace728d4fc40a2','2015-11-13 12:59:16'),('cb70da7c79be10d0dda38f8d6f3259f944247d431f85b6d121ace728d4fc40a2','2015-11-13 13:09:33'),('8c3051ff2bc169cd2e1e753843ec9bd33c81a71c4ef874d9da4cf289542f2a27','2015-11-13 15:07:19'),('49f35fb2a12294bcbe7cb4bb8ce1ceb64276bc1ca2342fead32a95d38620f80f','2015-11-16 14:36:22'),('cb70da7c79be10d0dda38f8d6f3259f944247d431f85b6d121ace728d4fc40a2','2015-11-16 15:10:27'),('81d371d3ccd82e43b1e3301c6ff7a28b789bfa5db3828945ff5f12c64035aed3','2015-11-16 15:21:47'),('81d371d3ccd82e43b1e3301c6ff7a28b789bfa5db3828945ff5f12c64035aed3','2015-11-16 15:22:07'),('cb70da7c79be10d0dda38f8d6f3259f944247d431f85b6d121ace728d4fc40a2','2015-11-16 18:46:17'),('47cebe48879a16f21774ebc04d686bd5a686c1afd83421aa5212841575b917e3','2015-11-17 16:42:23'),('8cc5e2de424b616dbbb7c89637da2112949f3f0d7333fb03c2d188cbcd441395','2015-11-18 10:02:50'),('6ad1d38b00a1c7b7de665920e490059acbdb864c90076542978f7bc3dba55cc8','2015-11-18 11:16:36'),('c431f6527b5322dd60877edbd6ee9372b23dd55ba8a3d8afd803081efebfbac9','2015-11-18 12:58:34'),('65e32215a1f8d8d810c681cdaf7e62108a30b2f15ccb37520dab4df9b9834dfe','2015-11-18 15:53:32'),('c431f6527b5322dd60877edbd6ee9372b23dd55ba8a3d8afd803081efebfbac9','2015-11-18 16:45:12'),('5e4dddcf215c0061aa417ba854520dc75e6d24f08cc4d85dca3b476ca6c3e949','2015-11-19 09:31:54'),('cf209bf6d4d3d9ff96800d3da097890cba1e1e460e6c787c6da90b72e71feb32','2015-11-19 09:37:18'),('cb70da7c79be10d0dda38f8d6f3259f944247d431f85b6d121ace728d4fc40a2','2015-11-19 12:08:52'),('cb70da7c79be10d0dda38f8d6f3259f944247d431f85b6d121ace728d4fc40a2','2015-11-19 12:15:47'),('25231260d8594917390f3d3647d8cc51905cb287c460eb9a1da9f42d7d4d2456','2015-11-19 13:32:10'),('73237d7da1bddde868225162153221ada1f32e336ca56e4929580dd8856944f8','2015-11-19 16:19:39'),('019347204b525b2ebb4a7e07c7cf167642169437443eb59f6b3c2117da5804a7','2015-11-19 16:21:22'),('fbde3961f3ed5f08a39897e47ab568eb8d8bd1663594016fc180f55eeb429ed6','2015-11-20 10:14:55'),('8c3051ff2bc169cd2e1e753843ec9bd33c81a71c4ef874d9da4cf289542f2a27','2015-11-20 12:16:11'),('8c3051ff2bc169cd2e1e753843ec9bd33c81a71c4ef874d9da4cf289542f2a27','2015-11-20 12:39:32'),('8c3051ff2bc169cd2e1e753843ec9bd33c81a71c4ef874d9da4cf289542f2a27','2015-11-20 14:53:32'),('25231260d8594917390f3d3647d8cc51905cb287c460eb9a1da9f42d7d4d2456','2015-11-20 15:37:53');
/*!40000 ALTER TABLE `sent_emails` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-11-22  8:47:17
