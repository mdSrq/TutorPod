CREATE DATABASE  IF NOT EXISTS `tutorpod` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `tutorpod`;
-- MySQL dump 10.13  Distrib 8.0.26, for Win64 (x86_64)
--
-- Host: localhost    Database: tutorpod
-- ------------------------------------------------------
-- Server version	8.0.26

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `address` (
  `address_id` int NOT NULL AUTO_INCREMENT,
  `street_address` varchar(100) NOT NULL,
  `locality` varchar(50) NOT NULL,
  `district` varchar(50) NOT NULL,
  `city` varchar(50) NOT NULL,
  `state` varchar(50) NOT NULL,
  `pincode` varchar(6) NOT NULL,
  PRIMARY KEY (`address_id`),
  UNIQUE KEY `UC_address` (`street_address`,`locality`,`pincode`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
INSERT INTO `address` VALUES (1,'B-6/107 Gali No.1','Kabir Nagar','Shahdara','Delhi','Delhi','110094'),(2,'B-6/107 Gali No.2','Kabir Nagari','Shahdara','Delhi','Delhi','110094'),(3,'H.No. - B-6/107, Gali N0. - 1 Kabir Nagar, Shahdara, North East','Delhi','Shahdara','North East Delhi','Delhi','110094'),(4,'B-6/107 Gali No.1 Kabir Nagar','Kabir Nagar','Shahdara','Delhi','Delhi','110094'),(5,'B-6/107 Gali No.1','Kabir Nagar','Shahadara','Delhi','Delhi','110093');
/*!40000 ALTER TABLE `address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin` (
  `admin_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `password` varchar(20) NOT NULL,
  PRIMARY KEY (`admin_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` VALUES (1,'admin','admin');
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin_bank_acc`
--

DROP TABLE IF EXISTS `admin_bank_acc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin_bank_acc` (
  `admin_bank_acc_id` int NOT NULL AUTO_INCREMENT,
  `admin_id` int NOT NULL,
  `bank_acc_id` int NOT NULL,
  `selected` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`admin_bank_acc_id`),
  UNIQUE KEY `UC_admin_bank_acc` (`admin_id`,`bank_acc_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_bank_acc`
--

LOCK TABLES `admin_bank_acc` WRITE;
/*!40000 ALTER TABLE `admin_bank_acc` DISABLE KEYS */;
INSERT INTO `admin_bank_acc` VALUES (1,1,3,1);
/*!40000 ALTER TABLE `admin_bank_acc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `availability`
--

DROP TABLE IF EXISTS `availability`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `availability` (
  `availability_id` int NOT NULL AUTO_INCREMENT,
  `tutor_id` int NOT NULL,
  `day_of_week` int DEFAULT NULL,
  `avail_date` date DEFAULT NULL,
  `time_from` time NOT NULL,
  `time_to` time NOT NULL,
  PRIMARY KEY (`availability_id`),
  UNIQUE KEY `UC_availability_weekday` (`day_of_week`,`tutor_id`),
  UNIQUE KEY `UC_availability_date` (`avail_date`,`tutor_id`),
  CONSTRAINT `availability_chk_1` CHECK ((((`day_of_week` is null) or (`avail_date` is null)) and ((`day_of_week` is not null) or (`avail_date` is not null))))
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `availability`
--

LOCK TABLES `availability` WRITE;
/*!40000 ALTER TABLE `availability` DISABLE KEYS */;
INSERT INTO `availability` VALUES (1,1,7,NULL,'18:00:00','23:00:00'),(2,1,6,NULL,'01:30:00','23:30:00'),(3,2,4,NULL,'02:03:00','01:04:00'),(4,2,6,NULL,'03:00:00','17:00:00'),(5,1,1,NULL,'05:00:00','08:00:00'),(6,1,2,NULL,'00:00:00','23:59:00'),(7,3,1,NULL,'06:00:00','22:00:00'),(8,3,2,NULL,'06:00:00','23:00:00'),(9,3,3,NULL,'12:00:00','17:00:00'),(10,1,4,NULL,'22:00:00','23:30:00'),(12,2,5,NULL,'22:00:00','23:30:00'),(13,4,1,NULL,'17:00:00','22:00:00'),(14,4,7,NULL,'09:00:00','23:00:00');
/*!40000 ALTER TABLE `availability` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bank_acc`
--

DROP TABLE IF EXISTS `bank_acc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bank_acc` (
  `bank_acc_id` int NOT NULL AUTO_INCREMENT,
  `bank_name` varchar(50) NOT NULL,
  `acc_no` varchar(20) NOT NULL,
  `holder_name` varchar(50) NOT NULL,
  `ifsc_code` varchar(15) NOT NULL,
  `balance` mediumtext NOT NULL,
  PRIMARY KEY (`bank_acc_id`),
  UNIQUE KEY `UC_bank_acc` (`bank_name`,`acc_no`,`ifsc_code`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bank_acc`
--

LOCK TABLES `bank_acc` WRITE;
/*!40000 ALTER TABLE `bank_acc` DISABLE KEYS */;
INSERT INTO `bank_acc` VALUES (1,'State Bank of India','234424543451','Mohd Shariq','SBIN0004844','11500'),(2,'State Bank of India','123412341239','UserName','SBIN0004844','0'),(3,'State Bank of India','123456789101','Mohd Shariq','SBIN0004844','34625'),(4,'State Bank of India','12341234189','SomeOne','SBIN0004841','0'),(5,'State Bank of India','98237491931','User1','SBIN0004844','0'),(6,'State Bank of India','7923290981','User2','SBIN009927','0');
/*!40000 ALTER TABLE `bank_acc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `booking`
--

DROP TABLE IF EXISTS `booking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `booking` (
  `booking_id` int NOT NULL AUTO_INCREMENT,
  `tutor_id` int NOT NULL,
  `user_id` int NOT NULL,
  `subject_id` int NOT NULL,
  `price` double NOT NULL,
  `duration` double NOT NULL,
  `no_of_lesson` int NOT NULL,
  `transaction_id` int NOT NULL,
  `booking_status` varchar(20) NOT NULL,
  PRIMARY KEY (`booking_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking`
--

LOCK TABLES `booking` WRITE;
/*!40000 ALTER TABLE `booking` DISABLE KEYS */;
INSERT INTO `booking` VALUES (1,1,2,2,500,2,2,5,'Completed'),(2,2,1,4,600,1,2,13,'Completed'),(3,2,1,3,500,2,2,20,'Completed'),(4,1,2,1,500,2,1,22,'Completed'),(5,2,1,4,600,1,1,24,'Completed'),(6,2,1,4,600,1,2,26,'Completed'),(7,1,4,1,500,1,1,30,'Completed'),(8,1,4,4,800,2,1,33,'Completed'),(9,3,1,5,800,2,1,37,'Completed'),(10,1,2,3,600,1,2,40,'Completed'),(11,2,1,4,600,1,1,42,'Completed'),(12,2,6,4,600,2,2,49,'Completed');
/*!40000 ALTER TABLE `booking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course`
--

DROP TABLE IF EXISTS `course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course` (
  `course_id` int NOT NULL AUTO_INCREMENT,
  `course_name` varchar(80) NOT NULL,
  `name_abbr` varchar(6) NOT NULL,
  `duration_type` varchar(10) NOT NULL,
  `duration` int NOT NULL,
  PRIMARY KEY (`course_id`),
  UNIQUE KEY `course_name` (`course_name`),
  UNIQUE KEY `name_abbr` (`name_abbr`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course`
--

LOCK TABLES `course` WRITE;
/*!40000 ALTER TABLE `course` DISABLE KEYS */;
INSERT INTO `course` VALUES (1,'Bachelor of Computer Application','BCA','Semester',6),(2,'Master of Computer Applications','MCA','Semester',4);
/*!40000 ALTER TABLE `course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_sub`
--

DROP TABLE IF EXISTS `course_sub`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course_sub` (
  `course_sub_id` int NOT NULL AUTO_INCREMENT,
  `course_id` int NOT NULL,
  `duration_no` int NOT NULL,
  `subject_id` int NOT NULL,
  PRIMARY KEY (`course_sub_id`),
  UNIQUE KEY `UC_course_sub` (`course_id`,`subject_id`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_sub`
--

LOCK TABLES `course_sub` WRITE;
/*!40000 ALTER TABLE `course_sub` DISABLE KEYS */;
INSERT INTO `course_sub` VALUES (1,1,1,1),(2,1,1,2),(3,1,1,3),(4,1,1,4),(5,1,1,5),(6,1,2,6),(7,1,2,7),(8,1,2,8),(9,1,2,9),(10,1,2,10),(11,1,2,11),(12,1,2,12),(13,1,3,13),(14,1,3,14),(15,1,3,15),(16,1,3,16),(17,1,3,17),(18,1,3,18),(19,1,3,19),(20,1,4,20),(21,1,4,21),(22,1,4,22),(23,1,4,23),(24,1,4,24),(25,1,4,25),(26,1,4,26),(27,1,4,27),(28,1,5,28),(29,1,5,29),(30,1,5,30),(31,1,5,31),(32,1,5,32),(33,1,5,33),(34,1,5,34),(35,1,5,35),(36,1,6,36),(37,1,6,37),(38,1,6,38),(39,1,6,39),(40,2,1,40),(41,2,1,41),(42,2,1,42),(43,2,1,43),(44,2,1,44),(45,2,1,45),(46,2,1,46),(47,2,2,47),(48,2,2,48),(49,2,2,49),(50,2,2,50),(51,2,2,51),(52,2,2,52),(53,2,3,53),(54,2,3,54),(55,2,3,55),(56,2,3,56),(57,2,3,57),(58,2,3,58),(59,2,4,59),(60,2,4,60),(61,2,4,61);
/*!40000 ALTER TABLE `course_sub` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `experience`
--

DROP TABLE IF EXISTS `experience`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `experience` (
  `experience_id` int NOT NULL AUTO_INCREMENT,
  `experience_type` varchar(15) NOT NULL,
  `title` varchar(30) NOT NULL,
  `institution` varchar(80) DEFAULT NULL,
  `location` varchar(25) DEFAULT NULL,
  `description` varchar(300) DEFAULT NULL,
  `start_year` varchar(4) DEFAULT NULL,
  `end_year` varchar(5) DEFAULT NULL,
  `tutor_id` int NOT NULL,
  PRIMARY KEY (`experience_id`),
  UNIQUE KEY `UC_experience` (`title`,`start_year`,`tutor_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `experience`
--

LOCK TABLES `experience` WRITE;
/*!40000 ALTER TABLE `experience` DISABLE KEYS */;
INSERT INTO `experience` VALUES (1,'Education','10th','CBSE','Delhi','Completed 10th ','2014','2015',1),(2,'Education','Diploma','GNDIT','Delhi','Completed Diploma in Computer Engineering','2015','2018',2),(3,'Education','BCA','IGNOU','Delhi','Completed BCA from IGNOU','2015','2018',3),(4,'Work Experience','Some','Some','Some','some','2019','2020',1),(5,'Education','BCA','IGNOU','Delhi','In BCA final semester ','2019','2022',4),(6,'Education','BCA','IGNOU','Delhi','A Student of BCA and a passionate teacher','2019','2022',5);
/*!40000 ALTER TABLE `experience` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fees`
--

DROP TABLE IF EXISTS `fees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fees` (
  `fees_id` int NOT NULL AUTO_INCREMENT,
  `tutor_id` int NOT NULL,
  `subject_id` int NOT NULL,
  `fee` double NOT NULL,
  PRIMARY KEY (`fees_id`),
  UNIQUE KEY `UC_fees` (`tutor_id`,`subject_id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fees`
--

LOCK TABLES `fees` WRITE;
/*!40000 ALTER TABLE `fees` DISABLE KEYS */;
INSERT INTO `fees` VALUES (1,1,4,800),(2,1,5,700),(3,2,4,600),(4,2,5,900),(5,2,3,800),(6,1,1,500),(7,1,2,500),(8,1,3,600),(11,3,2,200),(12,3,3,1000),(13,3,5,800),(14,2,1,900),(15,2,2,700),(16,4,5,200),(17,4,9,250),(18,5,4,200),(19,5,3,150);
/*!40000 ALTER TABLE `fees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `language`
--

DROP TABLE IF EXISTS `language`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `language` (
  `language_id` int NOT NULL AUTO_INCREMENT,
  `language_name` varchar(20) NOT NULL,
  PRIMARY KEY (`language_id`),
  UNIQUE KEY `language_name` (`language_name`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `language`
--

LOCK TABLES `language` WRITE;
/*!40000 ALTER TABLE `language` DISABLE KEYS */;
INSERT INTO `language` VALUES (13,'Assamese'),(3,'Bengali'),(16,'Bhili/Bhilodi'),(15,'Bhojpuri'),(2,'English'),(7,'Gujarati'),(1,'Hindi'),(9,'Kannada'),(18,'Kashmiri'),(14,'Maithili'),(11,'Malayalam'),(4,'Marathi'),(19,'Nepali'),(10,'Odia'),(12,'Punjabi'),(17,'Santali'),(20,'Sindhi'),(6,'Tamil'),(5,'Telugu'),(8,'Urdu');
/*!40000 ALTER TABLE `language` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `language_info`
--

DROP TABLE IF EXISTS `language_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `language_info` (
  `lang_info_id` int NOT NULL AUTO_INCREMENT,
  `tutor_id` int NOT NULL,
  `language_id` int NOT NULL,
  PRIMARY KEY (`lang_info_id`),
  UNIQUE KEY `UC_language_info` (`tutor_id`,`language_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `language_info`
--

LOCK TABLES `language_info` WRITE;
/*!40000 ALTER TABLE `language_info` DISABLE KEYS */;
INSERT INTO `language_info` VALUES (1,1,1),(2,1,2),(3,1,8),(4,2,1),(5,2,2),(6,2,8),(7,3,1),(8,3,2),(9,3,3),(10,3,15),(11,4,1),(12,4,2),(13,4,8),(14,5,1),(15,5,2),(16,5,8);
/*!40000 ALTER TABLE `language_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lesson`
--

DROP TABLE IF EXISTS `lesson`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lesson` (
  `lesson_id` int NOT NULL AUTO_INCREMENT,
  `booking_id` int NOT NULL,
  `meeting_link` varchar(120) DEFAULT NULL,
  `notes` varchar(16) DEFAULT NULL,
  `time_from` time DEFAULT NULL,
  `time_to` time DEFAULT NULL,
  `date` date DEFAULT NULL,
  `status` varchar(20) NOT NULL,
  PRIMARY KEY (`lesson_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lesson`
--

LOCK TABLES `lesson` WRITE;
/*!40000 ALTER TABLE `lesson` DISABLE KEYS */;
INSERT INTO `lesson` VALUES (1,1,'https://zoom.us?meeting-link=aZkha1972mA',NULL,NULL,NULL,NULL,'Unscheduled'),(2,1,'https://meet.google.com/zdp-mkym-hza',NULL,'01:30:00','03:30:00','2021-12-25','Scheduled'),(3,2,'https://www.twilio.com/blog/java-json-with-gson',NULL,'21:15:00','22:15:00','2021-12-24','Completed'),(4,2,'https://www.twilio.com/blog/java-json-with-gson',NULL,'21:14:00','22:14:00','2021-12-24','Completed'),(5,3,NULL,NULL,'14:30:00','16:30:00','2022-01-01','Scheduled'),(6,3,NULL,NULL,'15:00:00','17:00:00','2021-12-25','Completed'),(7,4,NULL,NULL,'00:00:00','00:00:00','2021-12-27','Scheduled'),(8,5,NULL,NULL,NULL,NULL,NULL,'Unscheduled'),(9,6,NULL,NULL,'12:30:00','13:30:00','2022-01-01','Scheduled'),(10,6,NULL,NULL,'11:00:00','12:00:00','2022-01-01','Scheduled'),(11,7,NULL,NULL,NULL,NULL,NULL,'Unscheduled'),(12,8,'https://meet.google.com/hms-bhpn-qod',NULL,'18:00:00','20:00:00','2022-01-01','Scheduled'),(13,9,NULL,NULL,'17:00:00','19:00:00','2022-01-03','Scheduled'),(14,10,NULL,NULL,NULL,NULL,NULL,'Unscheduled'),(15,10,NULL,NULL,NULL,NULL,NULL,'Unscheduled'),(16,11,NULL,NULL,'14:00:00','15:00:00','2022-01-08','Scheduled'),(17,12,NULL,NULL,NULL,NULL,NULL,'Unscheduled'),(18,12,NULL,NULL,'11:00:00','13:00:00','2022-01-08','Scheduled');
/*!40000 ALTER TABLE `lesson` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification`
--

DROP TABLE IF EXISTS `notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notification` (
  `notification_id` int NOT NULL AUTO_INCREMENT,
  `notification` varchar(900) DEFAULT NULL,
  `link` varchar(100) NOT NULL,
  `datetime` datetime NOT NULL,
  `user_id` int DEFAULT NULL,
  `tutor_id` int DEFAULT NULL,
  `seen` tinyint(1) NOT NULL,
  `clicked` tinyint(1) NOT NULL,
  PRIMARY KEY (`notification_id`),
  CONSTRAINT `notification_chk_1` CHECK ((((`user_id` is null) or (`tutor_id` is null)) and ((`user_id` is not null) or (`tutor_id` is not null))))
) ENGINE=InnoDB AUTO_INCREMENT=209 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification`
--

LOCK TABLES `notification` WRITE;
/*!40000 ALTER TABLE `notification` DISABLE KEYS */;
INSERT INTO `notification` VALUES (1,'Welcome to TutorPod :)','#','2021-12-06 13:48:22',1,NULL,1,1),(2,'Complete your profile to begin your learning journey.','./AccountSettings','2021-12-06 13:48:22',1,NULL,1,1),(5,'Welcome to TutorPod :)','#','2021-12-08 17:22:42',2,NULL,1,1),(6,'Your user profile is created. Click to view settings.','./AccountSettings','2021-12-08 17:22:42',2,NULL,1,1),(8,'Your booking is completed. Click here to schedule your lessons.','./Orders','2021-12-14 15:31:21',1,NULL,1,1),(10,'Your booking is completed. Click here to schedule your lessons.','./Orders','2021-12-14 15:33:51',1,NULL,1,1),(12,'Your booking is completed. Click here to schedule your lessons.','./Orders','2021-12-14 15:34:07',1,NULL,1,1),(14,'Your booking is completed. Click here to schedule your lessons.','./Orders','2021-12-14 15:38:58',2,NULL,1,0),(16,'Your booking is completed. Click here to schedule your lessons.','./Orders','2021-12-14 16:07:09',1,NULL,1,1),(18,'Your booking is completed. Click here to schedule your lessons.','./Orders','2021-12-14 16:09:21',2,NULL,1,0),(20,'Your booking is completed. Click here to schedule your lessons.','./Orders','2021-12-14 16:17:20',2,NULL,1,0),(22,'Your booking is completed. Click here to schedule your lessons.','./Orders','2021-12-14 16:35:07',1,NULL,1,1),(24,'Your booking is completed. Click here to schedule your lessons.','./Orders','2021-12-14 16:40:37',1,NULL,1,1),(26,'Your booking is completed. Click here to schedule your lessons.','./Orders','2021-12-14 17:34:55',1,NULL,1,1),(28,'Your booking is completed. Click here to schedule your lessons.','./Orders','2021-12-14 17:50:32',1,NULL,1,1),(30,'Your booking is completed. Click here to schedule your lessons.','./Orders','2021-12-14 18:02:47',1,NULL,1,1),(32,'Your booking is completed. Click here to schedule your lessons.','./Orders','2021-12-14 18:53:47',1,NULL,1,1),(34,'Your booking is completed. Click here to schedule your lessons.','./Orders','2021-12-14 18:56:11',1,NULL,1,1),(36,'Your booking is completed. Click here to schedule your lessons.','./Orders','2021-12-14 18:57:28',1,NULL,1,1),(46,'Your booking is completed. Click here to schedule your lessons.','./Orders','2021-12-16 11:28:44',2,NULL,1,0),(47,'You have a new booking. Click to see details','./Orders','2021-12-16 11:28:44',NULL,1,1,0),(48,'Your booking is completed. Click here to schedule your lessons.','./Orders','2021-12-16 11:28:59',2,NULL,1,1),(49,'You have a new booking. Click to see details','./Orders','2021-12-16 11:28:59',NULL,1,1,1),(50,'Your booking is completed. Click here to schedule your lessons.','./Orders','2021-12-19 01:52:00',2,NULL,1,0),(51,'You have a new booking. Click to see details','./Orders','2021-12-19 01:52:00',NULL,1,1,1),(58,'Your booking is completed. Click here to schedule your lessons.','./Orders','2021-12-19 18:49:28',1,NULL,1,0),(60,'Your booking is completed. Click here to schedule your lessons.','./Orders','2021-12-19 20:53:14',1,NULL,1,1),(62,'Lesson ID:4 is scheduled by learner. Click to see details','./Lessons','2021-12-20 02:01:18',NULL,1,1,1),(63,'Re-Schedule Request from Mohd Shariq: Hey! I\'m Sorry I have some urgent work at the time of our class can you please consider rescheduling it. Click to go to lessons','./Lessons','2021-12-20 23:18:41',2,NULL,1,0),(64,'User Name has scheduled their lesson. Click to see details','./Lessons','2021-12-20 23:20:10',NULL,1,1,0),(65,'Re-Schedule Request from User Name: Hey can you please re-schedule our class I\'m not feeling well today. Click to go to lessons','./Lessons','2021-12-20 23:21:59',1,NULL,1,1),(66,'User Name has scheduled their lesson. Click to see details','./Lessons','2021-12-20 23:59:30',NULL,1,1,0),(67,'User Name has scheduled their lesson. Click to see details','./Lessons','2021-12-21 00:00:39',NULL,1,1,0),(68,'Re-Schedule Request from Mohd Shariq: Please consider Re-Schedule Click to go to lessons','./Lessons','2021-12-21 00:30:54',2,NULL,1,1),(69,'User Name has scheduled their lesson. Click to see details','./Lessons','2021-12-21 00:33:46',NULL,1,1,0),(70,'Re-Schedule Request from Mohd Shariq: Re-Schedule again\r\n Click to go to lessons','./Lessons','2021-12-21 00:34:29',2,NULL,1,1),(71,'User Name has scheduled their lesson. Click to see details','./Lessons','2021-12-21 00:34:59',NULL,1,1,1),(72,'Re-Schedule Request from Mohd Shariq: Please Re-Schedule This Class Click to go to lessons','./Lessons','2021-12-21 00:47:25',2,NULL,1,1),(73,'User Name has scheduled their lesson. Click to see details','./Lessons','2021-12-21 01:17:33',NULL,1,1,1),(76,'Your booking ( Booking ID:23 ) is completed. Click here to see your bookings.','./Orders','2021-12-21 02:09:05',2,NULL,1,1),(77,'You have a new booking ( Booking ID:\"+booking_id+\" ). Click to see details','./Orders','2021-12-21 02:09:05',NULL,1,1,0),(78,'User Name has scheduled their lesson. Click to see details','./Lessons','2021-12-21 02:09:27',NULL,1,1,0),(79,'User Name has scheduled their lesson. Click to see details','./Lessons','2021-12-21 02:10:21',NULL,1,1,0),(80,'Your booking ( Booking ID:24 ) is completed. Click here to see your bookings.','./Orders','2021-12-21 03:56:52',2,NULL,1,1),(81,'You have a new booking ( Booking ID:\"+booking_id+\" ). Click to see details','./Orders','2021-12-21 03:56:52',NULL,1,1,0),(82,'User Name has scheduled their lesson. Click to see details','./Lessons','2021-12-21 03:57:12',NULL,1,1,0),(83,'Your booking ( Booking ID:25 ) is completed. Click here to see your bookings.','./Orders','2021-12-21 21:10:16',2,NULL,1,1),(84,'You have a new booking ( Booking ID:\"+booking_id+\" ). Click to see details','./Orders','2021-12-21 21:10:16',NULL,1,1,0),(85,'User Name has scheduled their lesson. Click to see details','./Lessons','2021-12-21 21:10:46',NULL,1,1,0),(86,'Your booking ( Booking ID:26 ) is completed. Click here to see your bookings.','./Orders','2021-12-21 22:21:34',2,NULL,1,1),(87,'You have a new booking ( Booking ID:\"+booking_id+\" ). Click to see details','./Orders','2021-12-21 22:21:34',NULL,1,1,0),(88,'User Name has scheduled their lesson. Click to see details','./Lessons','2021-12-21 22:23:48',NULL,1,1,0),(89,'Your booking ( Booking ID:27 ) is completed. Click here to see your bookings.','./Orders','2021-12-21 22:26:54',2,NULL,1,1),(90,'You have a new booking ( Booking ID:\"+booking_id+\" ). Click to see details','./Orders','2021-12-21 22:26:54',NULL,1,1,0),(91,'User Name has scheduled their lesson. Click to see details','./Lessons','2021-12-21 22:29:51',NULL,1,1,1),(92,'User Name has scheduled their lesson. Click to see details','./Lessons','2021-12-21 22:30:46',NULL,1,1,1),(93,'User Name has cancelled lesson (Lesson ID:16). Cancellation Reason: Aise hi ','./Notifications','2021-12-22 02:15:32',1,NULL,1,1),(94,'Refund amount of Rs.600.0 for Lesson ID:16 has been transfered to your wallet. Click to see details','./Wallet','2021-12-22 02:15:32',1,NULL,1,0),(95,'User Name has cancelled lesson (Lesson ID:14). Cancellation Reason: Dil kar rha tha','./Notifications','2021-12-22 02:29:46',1,NULL,1,0),(96,'Refund amount of Rs.1200.0 for Lesson ID:14 has been transfered to your wallet. Click to see details','./Wallet','2021-12-22 02:29:46',1,NULL,1,0),(98,'Refund amount of Rs.1500.0 for Lesson ID:13 has been transfered to your wallet. Click to see details','./Wallet','2021-12-22 02:35:56',1,NULL,1,0),(99,'User Name has cancelled lesson (Lesson ID:15). Cancellation Reason: Mera bhi dil kiya to kar diya cancel ','./Notifications','2021-12-22 02:39:24',1,NULL,1,1),(100,'Refund amount of Rs.1200.0 for Lesson ID:15 has been transfered to your wallet. Click to see details','./Wallet','2021-12-22 02:39:24',1,NULL,1,1),(101,'Mohd Shariq has cancelled lesson (Lesson ID:21). Cancellation Reason: Mera bhi dil kiya\r\n','./Notifications','2021-12-22 02:40:50',2,NULL,1,0),(102,'Refund amount of Rs.1000.0 for Lesson ID:21 has been transfered to your wallet. Click to see details','./Wallet','2021-12-22 02:40:50',2,NULL,1,1),(103,'Mohd Shariq has cancelled lesson (Lesson ID:3). Cancellation Reason: Some Reason\r\n','./Notifications','2021-12-22 03:03:36',2,NULL,1,1),(104,'Refund amount of Rs.800.0 for Lesson ID:3 has been transfered to your wallet. Click to see details','./Wallet','2021-12-22 03:03:36',2,NULL,1,1),(105,'User Name wrote feedback for Lesson ID:23. Feeback: Some Feedbaack','./Notification','2021-12-22 03:32:35',NULL,1,1,0),(106,'User Name wrote feedback for Lesson ID:22. Feeback: ','./Notification','2021-12-22 03:43:04',NULL,1,1,0),(108,'Your booking ( Booking ID:28 ) is completed. Click here to see your bookings.','./Orders','2021-12-23 03:15:14',1,NULL,1,0),(110,'Your booking ( Booking ID:29 ) is completed. Click here to see your bookings.','./Orders','2021-12-23 03:19:48',2,NULL,1,1),(111,'You have a new booking ( Booking ID:\"+booking_id+\" ). Click to see details','./Orders','2021-12-23 03:19:48',NULL,1,1,0),(112,'User Name has scheduled their lesson. Click to see details','./Lessons','2021-12-23 03:23:08',NULL,1,1,0),(114,'Your booking ( Booking ID:30 ) is completed. Click here to see your bookings.','./Orders','2021-12-23 03:51:58',1,NULL,1,1),(116,'Welcome to TutorPod :)','#','2021-12-24 00:06:12',3,NULL,1,0),(117,'Your user profile is created. Click to view settings.','./AccountSettings','2021-12-24 00:06:12',3,NULL,1,0),(118,'Your Application is approved now you will apear in the search results. Make sure you add your availabiltiy, Click to add availability','./Availability','2021-12-24 00:10:12',NULL,3,1,1),(119,'Your booking ( Booking ID:31 ) is completed. Click here to see your bookings.','./Orders','2021-12-24 00:14:30',3,NULL,1,1),(120,'You have a new booking ( Booking ID:31 ). Click to see details','./Orders','2021-12-24 00:14:30',NULL,1,1,0),(121,'Some One has scheduled their lesson. Click to see details','./Lessons','2021-12-24 00:15:08',NULL,1,1,0),(122,'Some One has scheduled their lesson. Click to see details','./Lessons','2021-12-24 00:15:17',NULL,1,1,0),(123,'Some One has cancelled lesson (Lesson ID:29). Cancellation Reason: Don\'t need this lesson ','./Notifications','2021-12-24 00:15:45',NULL,1,1,0),(124,'Refund amount of Rs.600.0 for Lesson ID:29 has been transfered to your wallet. Click to see details','./Wallet','2021-12-24 00:15:45',3,NULL,1,1),(125,'Some One has cancelled lesson (Lesson ID:28). Cancellation Reason: test cancellation \r\n','./Notifications','2021-12-24 00:21:31',NULL,1,1,0),(126,'Refund amount of Rs.600.0 for Lesson ID:28 has been transfered to your wallet. Click to see details','./Wallet','2021-12-24 00:21:31',3,NULL,1,0),(127,'Your booking ( Booking ID:32 ) is completed. Click here to see your bookings.','./Orders','2021-12-24 02:34:29',1,NULL,1,1),(128,'You have a new booking ( Booking ID:32 ). Click to see details','./Orders','2021-12-24 02:34:29',NULL,3,0,0),(129,'Withdrawal request of Rs.500.0 has been approved, amount is transferred to your bank account.','./Notification','2021-12-24 17:16:50',1,NULL,1,0),(130,'Withdrawal request of Rs.300.0 has been approved, amount is transferred to your bank account.','./Notification','2021-12-24 17:17:03',1,NULL,1,0),(131,'Withdrawal request of Rs.300.0 has been approved, amount is transferred to your bank account.','./Notification','2021-12-24 17:27:40',1,NULL,1,1),(132,'Withdrawal request of Rs.200.0 has been approved, amount is transferred to your bank account.','./Notifications','2021-12-24 18:16:49',1,NULL,1,0),(133,'Withdrawal request of Rs.500.0 has been approved, amount is transferred to your bank account.','./Notifications','2021-12-24 18:16:58',1,NULL,1,1),(134,'Withdrawal request of Rs.0.0 has been approved, amount is transferred to your bank account.','./Notifications','2021-12-24 19:03:12',1,NULL,1,0),(135,'Withdrawal request of Rs.5.0 has been approved, amount is transferred to your bank account.','./Notifications','2021-12-24 19:03:14',1,NULL,1,0),(136,'Withdrawal request of Rs.10.0 has been approved, amount is transferred to your bank account.','./Notifications','2021-12-24 19:03:17',1,NULL,1,0),(137,'Withdrawal request of Rs.50.0 has been approved, amount is transferred to your bank account.','./Notifications','2021-12-24 19:03:19',1,NULL,1,0),(138,'Withdrawal request of Rs.200.0 has been approved, amount is transferred to your bank account.','./Notifications','2021-12-24 19:03:22',1,NULL,1,0),(139,'Withdrawal request of Rs.2000.0 has been approved, amount is transferred to your bank account.','./Notifications','2021-12-24 19:03:24',1,NULL,1,0),(140,'Withdrawal request of Rs.5000.0 has been approved, amount is transferred to your bank account.','./Notifications','2021-12-24 19:03:26',1,NULL,1,0),(141,'Withdrawal request of Rs.10000.0 has been approved, amount is transferred to your bank account.','./Notifications','2021-12-24 19:03:28',1,NULL,1,0),(142,'Withdrawal request of Rs.50000.0 has been approved, amount is transferred to your bank account.','./Notifications','2021-12-24 19:03:31',1,NULL,1,0),(143,'Withdrawal request of Rs.15000.0 has been approved, amount is transferred to your bank account.','./Notifications','2021-12-24 19:03:33',1,NULL,1,0),(144,'Withdrawal request of Rs.10000.0 has been approved, amount is transferred to your bank account.','./Notifications','2021-12-24 19:03:36',1,NULL,1,0),(145,'Withdrawal request of Rs.5000.0 has been approved, amount is transferred to your bank account.','./Notifications','2021-12-24 19:03:38',1,NULL,1,0),(146,'Withdrawal request of Rs.1000.0 has been approved, amount is transferred to your bank account.','./Notifications','2021-12-24 19:03:40',1,NULL,1,0),(147,'Withdrawal request of Rs.500.0 has been approved, amount is transferred to your bank account.','./Notifications','2021-12-24 19:03:43',1,NULL,1,0),(148,'Withdrawal request of Rs.1500.0 has been approved, amount is transferred to your bank account.','./Notifications','2021-12-24 19:03:45',1,NULL,1,0),(149,'Withdrawal request of Rs.1000.0 has been approved, amount is transferred to your bank account.','./Notifications','2021-12-24 19:03:49',1,NULL,1,0),(150,'Withdrawal request of Rs.500.0 has been approved, amount is transferred to your bank account.','./Notifications','2021-12-24 21:33:32',1,NULL,1,0),(151,'Your booking ( Booking ID:1 ) is completed. Click here to see your bookings.','./Orders','2021-12-24 21:39:16',2,NULL,1,1),(152,'You have a new booking ( Booking ID:1 ). Click to see details','./Orders','2021-12-24 21:39:16',NULL,1,1,0),(153,'Withdrawal request of Rs.200.0 has been approved, amount is transferred to your bank account.','./Notifications','2021-12-24 21:45:08',1,NULL,1,0),(154,'Withdrawal request of Rs.10000.0 has been approved, amount is transferred to your bank account.','./Notifications','2021-12-24 21:46:13',1,NULL,1,1),(155,'Your booking ( Booking ID:2 ) is completed. Click here to see your bookings.','./Orders','2021-12-24 21:57:24',1,NULL,1,1),(156,'You have a new booking ( Booking ID:2 ). Click to see details','./Orders','2021-12-24 21:57:24',NULL,2,1,1),(157,'Mohd Shariq has scheduled their lesson. Click to see details','./Lessons','2021-12-24 22:00:54',NULL,2,1,0),(158,'Mohd Shariq has scheduled their lesson. Click to see details','./Lessons','2021-12-24 22:13:32',NULL,2,1,1),(159,'User Name has scheduled their lesson. Click to see details','./Lessons','2021-12-25 01:26:52',NULL,1,1,1),(160,'Re-Schedule Request from Mohd Shariq: Please Re-Schedule This Lesson Click to go to lessons','./Lessons','2021-12-25 01:27:27',2,NULL,1,0),(161,'User Name has scheduled their lesson. Click to see details','./Lessons','2021-12-25 01:33:59',NULL,1,1,0),(162,'Your Withdrawal Request of Rs.200.0 has been dismissed. Reason: You don\'t deserve this.','./Notifications','2021-12-25 14:01:48',1,NULL,1,1),(163,'Your Withdrawal Request of Rs.200.0 has been dismissed. Reason: Aise hi \r\n','./Notifications','2021-12-25 14:22:02',1,NULL,1,1),(164,'Your Withdrawal Request of Rs.200.0 has been dismissed. Reason: Aise hi \r\n','./Notifications','2021-12-25 14:23:27',1,NULL,1,1),(165,'Withdrawal request of Rs.200.0 has been approved, amount is transferred to your bank account.','./Notifications','2021-12-25 15:01:26',1,NULL,1,0),(166,'Withdrawal request of Rs.300.0 has been approved, amount is transferred to your bank account.','./Notifications','2021-12-25 15:01:29',1,NULL,1,0),(167,'Your Withdrawal Request of Rs.200.0 has been dismissed. Reason: You don\'t deserve it.','./Notifications','2021-12-25 15:01:54',1,NULL,1,0),(168,'Withdrawal request of Rs.200.0 has been approved, amount is transferred to your bank account.','./Notifications','2021-12-25 15:01:58',1,NULL,1,0),(169,'Your booking ( Booking ID:3 ) is completed. Click here to see your bookings.','./Orders','2021-12-25 15:26:46',1,NULL,1,0),(170,'You have a new booking ( Booking ID:3 ). Click to see details','./Orders','2021-12-25 15:26:46',NULL,2,1,0),(171,'Mohd Shariq has scheduled their lesson. Click to see details','./Lessons','2021-12-25 15:30:39',NULL,2,1,0),(172,'Mohd Shariq has scheduled their lesson. Click to see details','./Lessons','2021-12-25 15:33:39',NULL,2,1,0),(173,'Your booking ( Booking ID:4 ) is completed. Click here to see your bookings.','./Orders','2021-12-27 00:36:40',2,NULL,1,0),(174,'You have a new booking ( Booking ID:4 ). Click to see details','./Orders','2021-12-27 00:36:40',NULL,1,1,0),(175,'User Name has scheduled their lesson. Click to see details','./Lessons','2021-12-27 00:37:21',NULL,1,1,0),(176,'User Name has scheduled their lesson. Click to see details','./Lessons','2021-12-27 00:38:07',NULL,1,1,0),(177,'Your booking ( Booking ID:5 ) is completed. Click here to see your bookings.','./Orders','2021-12-28 20:27:52',1,NULL,1,0),(178,'You have a new booking ( Booking ID:5 ). Click to see details','./Orders','2021-12-28 20:27:52',NULL,2,1,0),(179,'Your booking ( Booking ID:6 ) is completed. Click here to see your bookings.','./Orders','2021-12-28 23:55:36',1,NULL,1,1),(180,'You have a new booking ( Booking ID:6 ). Click to see details','./Orders','2021-12-28 23:55:36',NULL,2,1,0),(181,'Mohd Shariq has scheduled their lesson. Click to see details','./Lessons','2021-12-28 23:56:13',NULL,2,1,0),(182,'Mohd Shariq has scheduled their lesson. Click to see details','./Lessons','2021-12-28 23:57:41',NULL,2,1,0),(183,'Welcome to TutorPod :)','#','2021-12-29 00:21:45',4,NULL,1,0),(184,'Complete your profile to begin your learning journey.','./AccountSettings','2021-12-29 00:21:45',4,NULL,1,0),(185,'Your booking ( Booking ID:7 ) is completed. Click here to see your bookings.','./Orders','2021-12-29 00:23:29',4,NULL,1,0),(186,'You have a new booking ( Booking ID:7 ). Click to see details','./Orders','2021-12-29 00:23:29',NULL,1,1,0),(187,'Your booking ( Booking ID:8 ) is completed. Click here to see your bookings.','./Orders','2021-12-29 00:24:20',4,NULL,1,0),(188,'You have a new booking ( Booking ID:8 ). Click to see details','./Orders','2021-12-29 00:24:20',NULL,1,1,0),(189,'one one has scheduled their lesson. Click to see details','./Lessons','2021-12-29 01:12:24',NULL,1,1,0),(190,'Your booking ( Booking ID:9 ) is completed. Click here to see your bookings.','./Orders','2021-12-29 22:37:17',1,NULL,1,0),(191,'You have a new booking ( Booking ID:9 ). Click to see details','./Orders','2021-12-29 22:37:17',NULL,3,0,0),(192,'Mohd Shariq has scheduled their lesson. Click to see details','./Lessons','2021-12-29 22:37:50',NULL,3,0,0),(193,'Withdrawal request of Rs.100.0 has been approved, amount is transferred to your bank account.','./Notifications','2021-12-31 03:31:37',1,NULL,1,1),(194,'Your booking ( Booking ID:10 ) is completed. Click here to see your bookings.','./Orders','2022-01-04 15:39:51',2,NULL,1,1),(195,'You have a new booking ( Booking ID:10 ). Click to see details','./Orders','2022-01-04 15:39:51',NULL,1,0,0),(196,'Your booking ( Booking ID:11 ) is completed. Click here to see your bookings.','./Orders','2022-01-04 16:38:32',1,NULL,1,1),(197,'You have a new booking ( Booking ID:11 ). Click to see details','./Orders','2022-01-04 16:38:32',NULL,2,0,0),(198,'Mohd Shariq has scheduled their lesson. Click to see details','./Lessons','2022-01-04 16:39:44',NULL,2,0,0),(199,'Welcome to TutorPod :)','#','2022-01-04 17:43:44',5,NULL,1,0),(200,'Complete your profile to begin your learning journey.','./AccountSettings','2022-01-04 17:43:44',5,NULL,1,1),(201,'Some reasons','./AccountSettings','2022-01-04 18:07:22',NULL,4,1,1),(202,'Your Application is approved now you will apear in the search results. Make sure you add your availabiltiy, Click to add availability','./Availability','2022-01-04 18:09:39',NULL,4,1,1),(203,'Welcome to TutorPod :)','#','2022-01-04 18:13:46',6,NULL,1,0),(204,'Your user profile is created. Click to view settings.','./AccountSettings','2022-01-04 18:13:46',6,NULL,1,1),(205,'Your Application is approved now you will apear in the search results. Make sure you add your availabiltiy, Click to add availability','./Availability','2022-01-04 18:16:36',NULL,5,1,1),(206,'Your booking ( Booking ID:12 ) is completed. Click here to see your bookings.','./Orders','2022-01-04 18:36:55',6,NULL,1,1),(207,'You have a new booking ( Booking ID:12 ). Click to see details','./Orders','2022-01-04 18:36:55',NULL,2,0,0),(208,'User Two has scheduled their lesson. Click to see details','./Lessons','2022-01-04 18:46:56',NULL,2,0,0);
/*!40000 ALTER TABLE `notification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review`
--

DROP TABLE IF EXISTS `review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `review` (
  `review_id` int NOT NULL AUTO_INCREMENT,
  `no_of_stars` int NOT NULL,
  `title` varchar(30) DEFAULT NULL,
  `review` varchar(150) DEFAULT NULL,
  `user_id` int NOT NULL,
  `tutor_id` int NOT NULL,
  PRIMARY KEY (`review_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review`
--

LOCK TABLES `review` WRITE;
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
/*!40000 ALTER TABLE `review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subject`
--

DROP TABLE IF EXISTS `subject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subject` (
  `subject_id` int NOT NULL AUTO_INCREMENT,
  `subject_name` varchar(80) NOT NULL,
  `subject_code` varchar(10) NOT NULL,
  PRIMARY KEY (`subject_id`),
  UNIQUE KEY `subject_code` (`subject_code`),
  FULLTEXT KEY `subject_name` (`subject_name`,`subject_code`),
  FULLTEXT KEY `subject_name_2` (`subject_name`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subject`
--

LOCK TABLES `subject` WRITE;
/*!40000 ALTER TABLE `subject` DISABLE KEYS */;
INSERT INTO `subject` VALUES (1,'English','FEG-02'),(2,'Business Organization','ECO-01'),(3,'Computer Basics and PC Software','BCS-011'),(4,'Basic Mathematics','BCS-012'),(5,'Computer Basics and PC Software Lab','BCSL-013'),(6,'Accountancy-1','ECO-02'),(7,'Problem Solving and Programming','MCS-011'),(8,'Computer Organization and Assembly Language Programming','MCS-012'),(9,'Discrete Mathematics','MCS-013'),(10,'Communication Skills','MCS-015'),(11,'C Language Programming Lab','BCSL-021'),(12,'Assembly Language Programming Lab','BCSL-022'),(13,'Systems Analysis and Design','MCS-014'),(14,'Data and File Structures','MCS-021'),(15,'Introduction to Database Management Systems','MCS-023'),(16,'Programming in C++','BCS-031'),(17,'C++ Programming Lab','BCSL-032'),(18,'Data and File Structures Lab','BCSL-033'),(19,'DBMS Lab','BCSL-034'),(20,'Statistical Techniques','BCS-040'),(21,'Object Oriented Technologies and Java Programming','MCS-024'),(22,'Fundamentals of Computer Networks','BCS-041'),(23,'Introduction to Algorithm Design','BCS-042'),(24,'Internet Concepts and Web Design','MCSL-016'),(25,'Java Programming Lab','BCSL-043'),(26,'Statistical Techniques Lab','BCSL-044'),(27,'Algorithm Design Lab','BCSL-045'),(28,'Introduction to Software Engineering','BCS-051'),(29,'Network Programming and Administration','BCS-052'),(30,'Web Programming','BCS-053'),(31,'Computer Oriented Numerical Techniques','BCS-054'),(32,'Business Communication','BCS-055'),(33,'Network Programming and Administration Lab','BCSL-056'),(34,'Web Programming Lab','BCSL-057'),(35,'Computer Oriented Numerical Techniques Lab','BCSL-058'),(36,'E-Commerce','BCS-062'),(37,'Operating System Concepts and Networking Management','MCS-022'),(38,'Operating System Concepts and Networking Management Lab','BCSL-063'),(39,'Project','BCSP-064'),(40,'Design and Analysis of Algorithms','MCS-211'),(41,'Discrete Mathematics','MCS-212'),(42,'Software Engineering','MCS-213'),(43,'Professional Skills and Ethics','MCS-214'),(44,'Security and Cyber Laws','MCS-215'),(45,'DAA and Web Design Lab','MCSL-216'),(46,'Software Engineering Lab','MCSL-217'),(47,'Data Communication and Computer Networks','MCS-218'),(48,'Object Oriented Analysis and Design','MCS-219'),(49,'Web Technologies','MCS-220'),(50,'Data Warehousing and Data Mining','MCS-221'),(51,'OOAD and Web Technologies Lab','MCSL-222'),(52,'Computer Networks and Data Mining Lab','MCSL-223'),(53,'Artificial Intelligence and Machine Learning','MCS-224'),(54,'Accountancy and Financial Management','MCS-225'),(55,'Data Science and Big Data','MCS-226'),(56,'Cloud Computing and IoT','MCS-227'),(57,'AI and Machine Learning Lab','MCSL-228'),(58,'Cloud and Data Science Lab','MCSL-229'),(59,'Digital Image Processing and Computer Vision','MCS-230'),(60,'Mobile Computing','MCS-231'),(61,'Project','MCSP-232');
/*!40000 ALTER TABLE `subject` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction`
--

DROP TABLE IF EXISTS `transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transaction` (
  `transaction_id` int NOT NULL AUTO_INCREMENT,
  `payer` varchar(20) NOT NULL,
  `payer_id` int NOT NULL,
  `receiver` varchar(20) NOT NULL,
  `receiver_id` int NOT NULL,
  `amount` double DEFAULT NULL,
  `description` varchar(150) NOT NULL,
  `date` date NOT NULL,
  `datetime` datetime NOT NULL,
  PRIMARY KEY (`transaction_id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction`
--

LOCK TABLES `transaction` WRITE;
/*!40000 ALTER TABLE `transaction` DISABLE KEYS */;
INSERT INTO `transaction` VALUES (1,'User',1,'AdminBankAcc',3,10000,'Money added to wallet by User ID:1','2021-12-24','2021-12-24 21:32:02'),(2,'User',1,'AdminBankAcc',3,500,'Money added to wallet by User ID:1','2021-12-24','2021-12-24 21:33:04'),(3,'AdminBankAcc',3,'User',1,500,'Money withdrawn by User ID:1','2021-12-24','2021-12-24 21:33:32'),(4,'User',2,'AdminBankAcc',3,10000,'Money added to wallet by User ID:2','2021-12-24','2021-12-24 21:39:04'),(5,'User',2,'User',1,1950,'Booking payment - 2.5%(TutorPod fee)','2021-12-24','2021-12-24 21:39:16'),(6,'Booking',1,'AdminBankAcc',3,100,'Booking payment ID:1','2021-12-24','2021-12-24 21:39:16'),(7,'AdminBankAcc',3,'User',1,200,'Money withdrawn by User ID:1','2021-12-24','2021-12-24 21:45:08'),(8,'User',1,'AdminBankAcc',3,200,'Money added to wallet by User ID:1','2021-12-24','2021-12-24 21:45:21'),(9,'AdminBankAcc',3,'User',1,10000,'Money withdrawn by User ID:1','2021-12-24','2021-12-24 21:46:13'),(10,'User',1,'AdminBankAcc',3,1500,'Money added to wallet by User ID:1','2021-12-24','2021-12-24 21:50:23'),(11,'User',1,'AdminBankAcc',3,500,'Money added to wallet by User ID:1','2021-12-24','2021-12-24 21:50:39'),(12,'User',1,'AdminBankAcc',3,8000,'Money added to wallet by User ID:1','2021-12-24','2021-12-24 21:50:48'),(13,'User',1,'User',2,1170,'Booking payment - 2.5%(TutorPod fee)','2021-12-24','2021-12-24 21:57:24'),(14,'Booking',2,'AdminBankAcc',3,60,'Booking payment ID:2','2021-12-24','2021-12-24 21:57:24'),(15,'User',1,'AdminBankAcc',3,2330,'Money added to wallet by User ID:1','2021-12-25','2021-12-25 14:51:44'),(16,'User',1,'AdminBankAcc',3,5000,'Money added to wallet by User ID:1','2021-12-25','2021-12-25 15:00:31'),(17,'AdminBankAcc',3,'User',1,200,'Money withdrawn by User ID:1','2021-12-25','2021-12-25 15:01:26'),(18,'AdminBankAcc',3,'User',1,300,'Money withdrawn by User ID:1','2021-12-25','2021-12-25 15:01:29'),(19,'AdminBankAcc',3,'User',1,200,'Money withdrawn by User ID:1','2021-12-25','2021-12-25 15:01:58'),(20,'User',1,'User',2,1950,'Booking payment - 2.5%(TutorPod fee)','2021-12-25','2021-12-25 15:26:46'),(21,'Booking',3,'AdminBankAcc',3,100,'Booking payment ID:3','2021-12-25','2021-12-25 15:26:46'),(22,'User',2,'User',1,975,'Booking payment - 2.5%(TutorPod fee)','2021-12-27','2021-12-27 00:36:40'),(23,'Booking',4,'AdminBankAcc',3,50,'Booking payment ID:4','2021-12-27','2021-12-27 00:36:40'),(24,'User',1,'User',2,585,'Booking payment - 2.5%(TutorPod fee)','2021-12-28','2021-12-28 20:27:52'),(25,'Booking',5,'AdminBankAcc',3,30,'Booking payment ID:5','2021-12-28','2021-12-28 20:27:52'),(26,'User',1,'User',2,1170,'Booking payment - 2.5%(TutorPod fee)','2021-12-28','2021-12-28 23:55:36'),(27,'Booking',6,'AdminBankAcc',3,60,'Booking payment ID:6','2021-12-28','2021-12-28 23:55:36'),(28,'User',4,'AdminBankAcc',3,100,'Money added to wallet by User ID:4','2021-12-29','2021-12-29 00:23:07'),(29,'User',4,'AdminBankAcc',3,900,'Money added to wallet by User ID:4','2021-12-29','2021-12-29 00:23:22'),(30,'User',4,'User',1,487.5,'Booking payment - 2.5%(TutorPod fee)','2021-12-29','2021-12-29 00:23:29'),(31,'Booking',7,'AdminBankAcc',3,25,'Booking payment ID:7','2021-12-29','2021-12-29 00:23:29'),(32,'User',4,'AdminBankAcc',3,2000,'Money added to wallet by User ID:4','2021-12-29','2021-12-29 00:24:08'),(33,'User',4,'User',1,1560,'Booking payment - 2.5%(TutorPod fee)','2021-12-29','2021-12-29 00:24:20'),(34,'Booking',8,'AdminBankAcc',3,80,'Booking payment ID:8','2021-12-29','2021-12-29 00:24:20'),(35,'User',4,'AdminBankAcc',3,200,'Money added to wallet by User ID:4','2021-12-29','2021-12-29 01:14:28'),(36,'User',4,'AdminBankAcc',3,100,'Money added to wallet by User ID:4','2021-12-29','2021-12-29 01:18:37'),(37,'User',1,'User',3,1560,'Booking payment - 2.5%(TutorPod fee)','2021-12-29','2021-12-29 22:37:17'),(38,'Booking',9,'AdminBankAcc',3,80,'Booking payment ID:9','2021-12-29','2021-12-29 22:37:17'),(39,'AdminBankAcc',3,'User',1,100,'Money withdrawn by User ID:1','2021-12-31','2021-12-31 03:31:37'),(40,'User',2,'User',1,1170,'Booking payment - 2.5%(TutorPod fee)','2022-01-04','2022-01-04 15:39:50'),(41,'Booking',10,'AdminBankAcc',3,60,'Booking payment ID:10','2022-01-04','2022-01-04 15:39:50'),(42,'User',1,'User',2,585,'Booking payment - 2.5%(TutorPod fee)','2022-01-04','2022-01-04 16:38:32'),(43,'Booking',11,'AdminBankAcc',3,30,'Booking payment ID:11','2022-01-04','2022-01-04 16:38:32'),(44,'User',5,'AdminBankAcc',3,-1,'Money added to wallet by User ID:5','2022-01-04','2022-01-04 17:51:27'),(45,'User',6,'AdminBankAcc',3,500,'Money added to wallet by User ID:6','2022-01-04','2022-01-04 18:20:30'),(46,'User',6,'AdminBankAcc',3,1000,'Money added to wallet by User ID:6','2022-01-04','2022-01-04 18:20:39'),(47,'User',6,'AdminBankAcc',3,500,'Money added to wallet by User ID:6','2022-01-04','2022-01-04 18:36:39'),(48,'User',6,'AdminBankAcc',3,1000,'Money added to wallet by User ID:6','2022-01-04','2022-01-04 18:36:48'),(49,'User',6,'User',2,2340,'Booking payment - 2.5%(TutorPod fee)','2022-01-04','2022-01-04 18:36:55'),(50,'Booking',12,'AdminBankAcc',3,120,'Booking payment ID:12','2022-01-04','2022-01-04 18:36:55'),(51,'User',5,'AdminBankAcc',3,1001,'Money added to wallet by User ID:5','2022-01-04','2022-01-04 18:39:00');
/*!40000 ALTER TABLE `transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tutor`
--

DROP TABLE IF EXISTS `tutor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tutor` (
  `tutor_id` int NOT NULL AUTO_INCREMENT,
  `bio` varchar(300) NOT NULL,
  `approval_date` date DEFAULT NULL,
  `profile_status` varchar(20) NOT NULL,
  `user_id` int NOT NULL,
  `address_id` int DEFAULT NULL,
  PRIMARY KEY (`tutor_id`),
  UNIQUE KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tutor`
--

LOCK TABLES `tutor` WRITE;
/*!40000 ALTER TABLE `tutor` DISABLE KEYS */;
INSERT INTO `tutor` VALUES (1,'Some things about me','2021-12-08','Tutor',1,1),(2,'Some things about me\r\n','2021-12-08','Tutor',2,2),(3,'Some Things About Me','2021-12-24','Tutor',3,3),(4,'Some Things About Me','2022-01-04','Tutor',5,4),(5,'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. ','2022-01-04','Tutor',6,5);
/*!40000 ALTER TABLE `tutor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `fname` varchar(25) NOT NULL,
  `lname` varchar(25) DEFAULT NULL,
  `username` varchar(20) NOT NULL,
  `password` varchar(20) NOT NULL,
  `email_id` varchar(255) NOT NULL,
  `mobile_no` varchar(13) NOT NULL,
  `gender` enum('Male','Female','Other') NOT NULL,
  `photo` varchar(60) DEFAULT NULL,
  `joining_date` date NOT NULL,
  `tutor_id` int DEFAULT NULL,
  `wallet_id` int DEFAULT NULL,
  `bank_acc_id` int DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email_id` (`email_id`),
  UNIQUE KEY `mobile_no` (`mobile_no`),
  FULLTEXT KEY `fname` (`fname`,`lname`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'Mohd','Shariq','mdshariq','password','mdshariq614@gmail.com','9971431679','Male','Mohd_Shariq_1','2021-12-06',1,1,1),(2,'User','Name','username','password','some@user.com','9900118811','Male','User_Name_2','2021-12-08',2,2,2),(3,'Some','One','someone','password','some@one.com','9090909090','Male',NULL,'2021-12-24',3,501,4),(4,'one','one','one','password','one@one.com','11111111111','Male',NULL,'2021-12-29',NULL,502,NULL),(5,'User','One','user1','password','user1@gmail.com','9988554493','Male','User_One_5','2022-01-04',4,503,5),(6,'User','Two','user2','password','user2@gmail.com','9981446677','Male','User_Two_6','2022-01-04',5,504,6);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wallet`
--

DROP TABLE IF EXISTS `wallet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wallet` (
  `wallet_id` int NOT NULL AUTO_INCREMENT,
  `balance` double DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`wallet_id`),
  UNIQUE KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=505 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wallet`
--

LOCK TABLES `wallet` WRITE;
/*!40000 ALTER TABLE `wallet` DISABLE KEYS */;
INSERT INTO `wallet` VALUES (1,15292.5,1),(2,13495,2),(501,1560,3),(502,1147.5,4),(503,1000,5),(504,540,6);
/*!40000 ALTER TABLE `wallet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wallet_transaction`
--

DROP TABLE IF EXISTS `wallet_transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wallet_transaction` (
  `wallet_transaction_id` int NOT NULL AUTO_INCREMENT,
  `wallet_id` int NOT NULL,
  `amount` double NOT NULL,
  `credit` tinyint(1) DEFAULT NULL,
  `debit` tinyint(1) DEFAULT NULL,
  `balance` double NOT NULL,
  `comment` varchar(120) NOT NULL,
  `status` enum('Completed','Pending','Failed') NOT NULL,
  `datetime` datetime NOT NULL,
  PRIMARY KEY (`wallet_transaction_id`)
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wallet_transaction`
--

LOCK TABLES `wallet_transaction` WRITE;
/*!40000 ALTER TABLE `wallet_transaction` DISABLE KEYS */;
INSERT INTO `wallet_transaction` VALUES (1,1,10000,1,0,10000,'Money Added by Self','Completed','2021-12-24 21:32:02'),(2,1,500,0,1,10000,'Withdrawal Request','Completed','2021-12-24 21:32:31'),(3,1,500,1,0,10500,'Money Added by Self','Completed','2021-12-24 21:33:04'),(4,2,10000,1,0,10000,'Money Added by Self','Completed','2021-12-24 21:39:04'),(5,2,2050,0,1,7950,'Booking Made with ID:1','Completed','2021-12-24 21:39:16'),(6,1,1950,1,0,11950,'Booking payment - 2.5%(TutorPod fee) for Booking ID:1','Completed','2021-12-24 21:39:16'),(7,1,200,0,1,11950,'Withdrawal Request','Completed','2021-12-24 21:44:40'),(8,1,200,1,0,11950,'Money Added by Self','Completed','2021-12-24 21:45:21'),(9,1,10000,0,1,11950,'Withdrawal Request','Completed','2021-12-24 21:45:44'),(10,1,1500,1,0,3450,'Money Added by Self','Completed','2021-12-24 21:50:23'),(11,1,500,1,0,3950,'Money Added by Self','Completed','2021-12-24 21:50:39'),(12,1,8000,1,0,11950,'Money Added by Self','Completed','2021-12-24 21:50:48'),(13,1,1230,0,1,10720,'Booking Made with ID:2','Completed','2021-12-24 21:57:24'),(14,2,1170,1,0,9120,'Booking payment - 2.5%(TutorPod fee) for Booking ID:2','Completed','2021-12-24 21:57:24'),(15,1,200,0,1,10720,'Withdrawal Request','Pending','2021-12-25 01:20:15'),(16,1,200,0,1,10720,'Withdrawal Request','Pending','2021-12-25 14:18:49'),(17,1,200,0,1,10720,'Withdrawal Request','Failed','2021-12-25 14:21:51'),(18,1,200,0,1,10720,'Withdrawal Request','Failed','2021-12-25 14:23:13'),(19,1,2330,1,0,13050,'Money Added by Self','Completed','2021-12-25 14:51:44'),(20,1,1100,0,1,13050,'Withdrawal Request','Pending','2021-12-25 14:52:07'),(21,1,5000,1,0,18050,'Money Added by Self','Completed','2021-12-25 15:00:31'),(22,1,100,0,1,18050,'Withdrawal Request','Pending','2021-12-25 15:00:36'),(23,1,100,0,1,18050,'Withdrawal Request','Pending','2021-12-25 15:00:37'),(24,1,100,0,1,18050,'Withdrawal Request','Pending','2021-12-25 15:00:38'),(25,1,100,0,1,18050,'Withdrawal Request','Pending','2021-12-25 15:00:39'),(26,1,100,0,1,18050,'Withdrawal Request','Pending','2021-12-25 15:00:41'),(27,1,100,0,1,18050,'Withdrawal Request','Completed','2021-12-25 15:00:42'),(28,1,200,0,1,18050,'Withdrawal Request','Completed','2021-12-25 15:00:43'),(29,1,200,0,1,18050,'Withdrawal Request','Failed','2021-12-25 15:00:44'),(30,1,300,0,1,18050,'Withdrawal Request','Completed','2021-12-25 15:00:46'),(31,1,200,0,1,18050,'Withdrawal Request','Completed','2021-12-25 15:00:50'),(32,1,2050,0,1,15300,'Booking Made with ID:3','Completed','2021-12-25 15:26:46'),(33,2,1950,1,0,11070,'Booking payment - 2.5%(TutorPod fee) for Booking ID:3','Completed','2021-12-25 15:26:46'),(34,2,1025,0,1,10045,'Booking Made with ID:4','Completed','2021-12-27 00:36:40'),(35,1,975,1,0,16275,'Booking payment - 2.5%(TutorPod fee) for Booking ID:4','Completed','2021-12-27 00:36:40'),(36,1,615,0,1,15660,'Booking Made with ID:5','Completed','2021-12-28 20:27:52'),(37,2,585,1,0,10630,'Booking payment - 2.5%(TutorPod fee) for Booking ID:5','Completed','2021-12-28 20:27:52'),(38,1,1230,0,1,14430,'Booking Made with ID:6','Completed','2021-12-28 23:55:36'),(39,2,1170,1,0,11800,'Booking payment - 2.5%(TutorPod fee) for Booking ID:6','Completed','2021-12-28 23:55:36'),(40,502,100,1,0,100,'Money Added by Self','Completed','2021-12-29 00:23:07'),(41,502,900,1,0,1000,'Money Added by Self','Completed','2021-12-29 00:23:22'),(42,502,512.5,0,1,487.5,'Booking Made with ID:7','Completed','2021-12-29 00:23:29'),(43,1,487.5,1,0,14917.5,'Booking payment - 2.5%(TutorPod fee) for Booking ID:7','Completed','2021-12-29 00:23:29'),(44,502,2000,1,0,2487.5,'Money Added by Self','Completed','2021-12-29 00:24:08'),(45,502,1640,0,1,847.5,'Booking Made with ID:8','Completed','2021-12-29 00:24:20'),(46,1,1560,1,0,16477.5,'Booking payment - 2.5%(TutorPod fee) for Booking ID:8','Completed','2021-12-29 00:24:20'),(47,502,200,1,0,1047.5,'Money Added by Self','Completed','2021-12-29 01:14:28'),(48,502,100,1,0,1147.5,'Money Added by Self','Completed','2021-12-29 01:18:37'),(49,1,1640,0,1,14837.5,'Booking Made with ID:9','Completed','2021-12-29 22:37:17'),(50,501,1560,1,0,1560,'Booking payment - 2.5%(TutorPod fee) for Booking ID:9','Completed','2021-12-29 22:37:17'),(51,2,1230,0,1,10570,'Booking Made with ID:10','Completed','2022-01-04 15:39:50'),(52,1,1170,1,0,15907.5,'Booking payment - 2.5%(TutorPod fee) for Booking ID:10','Completed','2022-01-04 15:39:50'),(53,1,615,0,1,15292.5,'Booking Made with ID:11','Completed','2022-01-04 16:38:32'),(54,2,585,1,0,11155,'Booking payment - 2.5%(TutorPod fee) for Booking ID:11','Completed','2022-01-04 16:38:32'),(55,503,-1,1,0,-1,'Money Added by Self','Completed','2022-01-04 17:51:27'),(56,504,500,1,0,500,'Money Added by Self','Completed','2022-01-04 18:20:30'),(57,504,1000,1,0,1500,'Money Added by Self','Completed','2022-01-04 18:20:39'),(58,504,500,1,0,2000,'Money Added by Self','Completed','2022-01-04 18:36:39'),(59,504,1000,1,0,3000,'Money Added by Self','Completed','2022-01-04 18:36:48'),(60,504,2460,0,1,540,'Booking Made with ID:12','Completed','2022-01-04 18:36:55'),(61,2,2340,1,0,13495,'Booking payment - 2.5%(TutorPod fee) for Booking ID:12','Completed','2022-01-04 18:36:55'),(62,503,1001,1,0,1000,'Money Added by Self','Completed','2022-01-04 18:39:00');
/*!40000 ALTER TABLE `wallet_transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `withdraw_request`
--

DROP TABLE IF EXISTS `withdraw_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `withdraw_request` (
  `request_id` int NOT NULL AUTO_INCREMENT,
  `wallet_id` int NOT NULL,
  `wallet_transaction_id` int NOT NULL,
  `amount` double NOT NULL,
  `status` varchar(20) NOT NULL,
  `remarks` varchar(80) DEFAULT NULL,
  `date` date NOT NULL,
  PRIMARY KEY (`request_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `withdraw_request`
--

LOCK TABLES `withdraw_request` WRITE;
/*!40000 ALTER TABLE `withdraw_request` DISABLE KEYS */;
INSERT INTO `withdraw_request` VALUES (1,1,2,500,'Completed','Withdrawl Request of 500.0 from Mohd Shariq','2021-12-24'),(2,1,7,200,'Completed','Withdrawl Request of 200.0 from Mohd Shariq','2021-12-24'),(3,1,9,10000,'Completed','Withdrawl Request of 10000.0 from Mohd Shariq','2021-12-24'),(4,1,15,200,'Dimissed','Withdrawl Request of 200.0 from Mohd Shariq','2021-12-25'),(5,1,16,200,'Dimissed','Withdrawl Request of 200.0 from Mohd Shariq','2021-12-25'),(6,1,17,200,'Dimissed','Withdrawl Request of 200.0 from Mohd Shariq','2021-12-25'),(7,1,18,200,'Dimissed','Withdrawl Request of 200.0 from Mohd Shariq','2021-12-25'),(8,1,20,1100,'Pending','Withdrawl Request of 1100.0 from Mohd Shariq','2021-12-25'),(9,1,22,100,'Pending','Withdrawl Request of 100.0 from Mohd Shariq','2021-12-25'),(10,1,23,100,'Pending','Withdrawl Request of 100.0 from Mohd Shariq','2021-12-25'),(11,1,24,100,'Pending','Withdrawl Request of 100.0 from Mohd Shariq','2021-12-25'),(12,1,25,100,'Pending','Withdrawl Request of 100.0 from Mohd Shariq','2021-12-25'),(13,1,26,100,'Pending','Withdrawl Request of 100.0 from Mohd Shariq','2021-12-25'),(14,1,27,100,'Completed','Withdrawl Request of 100.0 from Mohd Shariq','2021-12-25'),(15,1,28,200,'Completed','Withdrawl Request of 200.0 from Mohd Shariq','2021-12-25'),(16,1,29,200,'Dimissed','Withdrawl Request of 200.0 from Mohd Shariq','2021-12-25'),(17,1,30,300,'Completed','Withdrawl Request of 300.0 from Mohd Shariq','2021-12-25'),(18,1,31,200,'Completed','Withdrawl Request of 200.0 from Mohd Shariq','2021-12-25');
/*!40000 ALTER TABLE `withdraw_request` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-01-04 19:30:17
