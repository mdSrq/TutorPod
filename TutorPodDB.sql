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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
INSERT INTO `address` VALUES (1,'B-6/107 Gali No.1','Kabir Nagar','Shahdara','Delhi','Delhi','110094'),(2,'B-6/107 Gali No.2','Kabir Nagari','Shahdara','Delhi','Delhi','110094'),(3,'H.No. - B-6/107, Gali N0. - 1 Kabir Nagar, Shahdara, North East','Delhi','Shahdara','North East Delhi','Delhi','110094');
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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `availability`
--

LOCK TABLES `availability` WRITE;
/*!40000 ALTER TABLE `availability` DISABLE KEYS */;
INSERT INTO `availability` VALUES (1,1,7,NULL,'18:00:00','23:00:00'),(2,1,6,NULL,'16:00:00','23:00:00'),(3,2,4,NULL,'02:03:00','01:04:00'),(4,2,6,NULL,'03:00:00','17:00:00'),(5,1,1,NULL,'05:00:00','08:00:00'),(6,1,2,NULL,'00:00:00','23:59:00'),(7,3,1,NULL,'06:00:00','22:00:00'),(8,3,2,NULL,'06:00:00','23:00:00'),(9,3,3,NULL,'12:00:00','17:00:00');
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bank_acc`
--

LOCK TABLES `bank_acc` WRITE;
/*!40000 ALTER TABLE `bank_acc` DISABLE KEYS */;
INSERT INTO `bank_acc` VALUES (1,'State Bank of India','234424543451','Mohd Shariq','SBIN0004844','0'),(2,'State Bank of India','123412341239','UserName','SBIN0004844','0'),(3,'State Bank of India','123456789101','Mohd Shariq','SBIN0004844','9265'),(4,'State Bank of India','12341234189','SomeOne','SBIN0004841','0');
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
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking`
--

LOCK TABLES `booking` WRITE;
/*!40000 ALTER TABLE `booking` DISABLE KEYS */;
INSERT INTO `booking` VALUES (1,2,2,3,500,1,1,1,'Unscheduled'),(2,1,1,1,500,1,1,3,'Unscheduled'),(3,2,1,3,500,1,1,1,'Unscheduled'),(4,2,1,4,600,2,1,3,'Unscheduled'),(5,2,1,4,600,3,3,5,'Unscheduled'),(6,2,1,4,600,1,15,7,'Unscheduled'),(7,2,1,4,600,4,4,9,'Unscheduled'),(8,2,1,4,600,2,3,11,'Unscheduled'),(9,2,1,5,700,12,90,13,'Unscheduled'),(10,2,1,5,700,24,90,15,'Unscheduled'),(11,2,1,5,700,1,2,17,'Unscheduled'),(14,2,1,4,600,2,2,23,'Unscheduled'),(15,1,2,4,800,1,2,25,'Unscheduled'),(16,1,2,2,500,1,1,27,'Unscheduled'),(17,1,2,3,600,3,1,29,'Unscheduled'),(18,2,1,5,700,2,2,31,'Unscheduled'),(19,2,1,4,600,1,3,33,'Unscheduled'),(20,2,1,3,500,3,2,35,'Unscheduled'),(21,2,1,4,600,2,2,37,'Unscheduled'),(22,2,1,4,600,1,2,39,'Unscheduled'),(23,1,2,3,600,1,2,41,'Unscheduled'),(24,1,2,1,500,1,1,43,'Unscheduled'),(25,1,2,1,500,2,1,45,'Unscheduled'),(26,1,2,3,600,2,1,47,'Unscheduled'),(27,1,2,2,500,1,1,49,'Unscheduled'),(28,2,1,4,600,1,1,2,'Completed'),(29,1,2,5,700,1,1,6,'Completed'),(30,2,1,4,600,1,1,8,'Completed'),(31,1,3,3,600,1,3,12,'Completed'),(32,3,1,2,200,2,4,16,'Completed');
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
INSERT INTO `course` VALUES (1,'Bachelor of Computer Application','BCA','Semester',6),(2,'Master of Computer Applications','MCA','Semester',6);
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_sub`
--

LOCK TABLES `course_sub` WRITE;
/*!40000 ALTER TABLE `course_sub` DISABLE KEYS */;
INSERT INTO `course_sub` VALUES (1,1,1,1),(2,1,1,2),(3,1,1,3),(4,1,1,4),(5,1,1,5);
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `experience`
--

LOCK TABLES `experience` WRITE;
/*!40000 ALTER TABLE `experience` DISABLE KEYS */;
INSERT INTO `experience` VALUES (1,'Education','10th','CBSE','Delhi','Completed 10th ','2014','2015',1),(2,'Education','Diploma','GNDIT','Delhi','Completed Diploma in Computer Engineering','2015','2018',2),(3,'Education','BCA','IGNOU','Delhi','Completed BCA from IGNOU','2015','2018',3);
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
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fees`
--

LOCK TABLES `fees` WRITE;
/*!40000 ALTER TABLE `fees` DISABLE KEYS */;
INSERT INTO `fees` VALUES (1,1,4,800),(2,1,5,700),(3,2,4,600),(4,2,5,700),(5,2,3,500),(6,1,1,500),(7,1,2,500),(8,1,3,600),(11,3,2,200),(12,3,3,1000),(13,3,5,800);
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `language_info`
--

LOCK TABLES `language_info` WRITE;
/*!40000 ALTER TABLE `language_info` DISABLE KEYS */;
INSERT INTO `language_info` VALUES (1,1,1),(2,1,2),(3,1,8),(4,2,1),(5,2,2),(6,2,8),(7,3,1),(8,3,2),(9,3,3),(10,3,15);
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
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lesson`
--

LOCK TABLES `lesson` WRITE;
/*!40000 ALTER TABLE `lesson` DISABLE KEYS */;
INSERT INTO `lesson` VALUES (1,14,NULL,NULL,NULL,NULL,NULL,'Unscheduled'),(2,14,NULL,NULL,NULL,NULL,NULL,'Unscheduled'),(3,15,NULL,NULL,NULL,NULL,NULL,'Cancelled'),(4,15,'https://meet.google.com/hms-bhpn-qod ',NULL,'21:00:00','22:00:00','2021-12-25','Scheduled'),(5,16,'www.google.com',NULL,'19:00:00','20:00:00','2021-12-25','Scheduled'),(6,17,'google.com',NULL,'16:00:00','19:00:00','2021-12-25','Scheduled'),(7,18,NULL,NULL,'12:30:00','14:30:00','2021-12-25','Scheduled'),(8,18,NULL,NULL,NULL,NULL,NULL,'Unscheduled'),(9,19,NULL,NULL,'04:00:00','05:00:00','2021-12-25','Scheduled'),(10,19,NULL,NULL,'08:00:00','09:00:00','2021-12-25','Scheduled'),(11,19,NULL,NULL,'16:00:00','17:00:00','2021-12-25','Scheduled'),(12,20,NULL,NULL,NULL,NULL,NULL,'Unscheduled'),(13,20,NULL,NULL,NULL,NULL,NULL,'Cancelled'),(14,21,NULL,NULL,NULL,NULL,NULL,'Cancelled'),(15,21,NULL,NULL,NULL,NULL,NULL,'Cancelled'),(16,22,NULL,NULL,NULL,NULL,NULL,'Cancelled'),(17,22,'google.com',NULL,'05:30:00','06:30:00','2021-12-25','Scheduled'),(18,23,NULL,NULL,'21:00:00','22:00:00','2021-12-26','Scheduled'),(19,23,NULL,NULL,'22:00:00','23:00:00','2021-12-25','Scheduled'),(20,24,'https://www.google.com/',NULL,'04:00:00','05:00:00','2021-12-21','Scheduled'),(21,25,NULL,NULL,NULL,NULL,NULL,'Cancelled'),(22,26,'https://www.google.com/',NULL,'22:00:00','00:00:00','2021-12-21','Completed'),(23,27,NULL,NULL,'23:00:00','00:00:00','2021-12-21','Completed'),(24,28,NULL,NULL,'09:30:00','10:30:00','2021-12-25','Scheduled'),(25,29,NULL,NULL,'20:00:00','21:00:00','2021-12-25','Scheduled'),(26,30,NULL,NULL,NULL,NULL,NULL,'Unscheduled'),(27,31,NULL,NULL,NULL,NULL,NULL,'Unscheduled'),(28,31,NULL,NULL,NULL,NULL,NULL,'Cancelled'),(29,31,NULL,NULL,NULL,NULL,NULL,'Cancelled'),(30,32,NULL,NULL,NULL,NULL,NULL,'Unscheduled'),(31,32,NULL,NULL,NULL,NULL,NULL,'Unscheduled'),(32,32,NULL,NULL,NULL,NULL,NULL,'Unscheduled'),(33,32,NULL,NULL,NULL,NULL,NULL,'Unscheduled');
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
) ENGINE=InnoDB AUTO_INCREMENT=129 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification`
--

LOCK TABLES `notification` WRITE;
/*!40000 ALTER TABLE `notification` DISABLE KEYS */;
INSERT INTO `notification` VALUES (1,'Welcome to TutorPod :)','#','2021-12-06 13:48:22',1,NULL,1,1),(2,'Complete your profile to begin your learning journey.','./AccountSettings','2021-12-06 13:48:22',1,NULL,1,1),(5,'Welcome to TutorPod :)','#','2021-12-08 17:22:42',2,NULL,1,1),(6,'Your user profile is created. Click to view settings.','./AccountSettings','2021-12-08 17:22:42',2,NULL,1,1),(7,'Your Application is approved now you will apear in the search results. Make sure you add your availabiltiy, Click to add availability','./Availability','2021-12-08 17:29:00',NULL,2,1,1),(8,'Your booking is completed. Click here to schedule your lessons.','./Orders','2021-12-14 15:31:21',1,NULL,1,1),(10,'Your booking is completed. Click here to schedule your lessons.','./Orders','2021-12-14 15:33:51',1,NULL,1,1),(12,'Your booking is completed. Click here to schedule your lessons.','./Orders','2021-12-14 15:34:07',1,NULL,1,1),(14,'Your booking is completed. Click here to schedule your lessons.','./Orders','2021-12-14 15:38:58',2,NULL,1,0),(15,'You have a new booking. Click to see details','./Orders','2021-12-14 15:38:58',NULL,2,1,0),(16,'Your booking is completed. Click here to schedule your lessons.','./Orders','2021-12-14 16:07:09',1,NULL,1,1),(18,'Your booking is completed. Click here to schedule your lessons.','./Orders','2021-12-14 16:09:21',2,NULL,1,0),(20,'Your booking is completed. Click here to schedule your lessons.','./Orders','2021-12-14 16:17:20',2,NULL,1,0),(21,'You have a new booking. Click to see details','./Orders','2021-12-14 16:17:20',NULL,2,1,0),(22,'Your booking is completed. Click here to schedule your lessons.','./Orders','2021-12-14 16:35:07',1,NULL,1,1),(24,'Your booking is completed. Click here to schedule your lessons.','./Orders','2021-12-14 16:40:37',1,NULL,1,1),(25,'You have a new booking. Click to see details','./Orders','2021-12-14 16:40:37',NULL,2,1,1),(26,'Your booking is completed. Click here to schedule your lessons.','./Orders','2021-12-14 17:34:55',1,NULL,1,1),(27,'You have a new booking. Click to see details','./Orders','2021-12-14 17:34:55',NULL,2,1,0),(28,'Your booking is completed. Click here to schedule your lessons.','./Orders','2021-12-14 17:50:32',1,NULL,1,1),(29,'You have a new booking. Click to see details','./Orders','2021-12-14 17:50:32',NULL,2,1,0),(30,'Your booking is completed. Click here to schedule your lessons.','./Orders','2021-12-14 18:02:47',1,NULL,1,1),(31,'You have a new booking. Click to see details','./Orders','2021-12-14 18:02:47',NULL,2,1,0),(32,'Your booking is completed. Click here to schedule your lessons.','./Orders','2021-12-14 18:53:47',1,NULL,1,1),(33,'You have a new booking. Click to see details','./Orders','2021-12-14 18:53:47',NULL,2,1,0),(34,'Your booking is completed. Click here to schedule your lessons.','./Orders','2021-12-14 18:56:11',1,NULL,1,1),(35,'You have a new booking. Click to see details','./Orders','2021-12-14 18:56:11',NULL,2,1,0),(36,'Your booking is completed. Click here to schedule your lessons.','./Orders','2021-12-14 18:57:28',1,NULL,1,1),(37,'You have a new booking. Click to see details','./Orders','2021-12-14 18:57:28',NULL,2,1,0),(39,'You have a new booking. Click to see details','./Orders','2021-12-14 18:58:13',NULL,2,1,0),(41,'You have a new booking. Click to see details','./Orders','2021-12-14 21:01:21',NULL,2,1,0),(45,'You have a new booking. Click to see details','./Orders','2021-12-16 05:38:07',NULL,2,1,1),(46,'Your booking is completed. Click here to schedule your lessons.','./Orders','2021-12-16 11:28:44',2,NULL,1,0),(47,'You have a new booking. Click to see details','./Orders','2021-12-16 11:28:44',NULL,1,1,0),(48,'Your booking is completed. Click here to schedule your lessons.','./Orders','2021-12-16 11:28:59',2,NULL,1,1),(49,'You have a new booking. Click to see details','./Orders','2021-12-16 11:28:59',NULL,1,1,1),(50,'Your booking is completed. Click here to schedule your lessons.','./Orders','2021-12-19 01:52:00',2,NULL,1,0),(51,'You have a new booking. Click to see details','./Orders','2021-12-19 01:52:00',NULL,1,1,1),(53,'You have a new booking. Click to see details','./Orders','2021-12-19 04:33:00',NULL,2,1,0),(55,'You have a new booking. Click to see details','./Orders','2021-12-19 12:57:59',NULL,2,1,0),(57,'You have a new booking. Click to see details','./Orders','2021-12-19 14:56:19',NULL,2,1,0),(58,'Your booking is completed. Click here to schedule your lessons.','./Orders','2021-12-19 18:49:28',1,NULL,1,0),(59,'You have a new booking. Click to see details','./Orders','2021-12-19 18:49:28',NULL,2,1,0),(60,'Your booking is completed. Click here to schedule your lessons.','./Orders','2021-12-19 20:53:14',1,NULL,1,1),(61,'You have a new booking. Click to see details','./Orders','2021-12-19 20:53:14',NULL,2,1,0),(62,'Lesson ID:4 is scheduled by learner. Click to see details','./Lessons','2021-12-20 02:01:18',NULL,1,1,1),(63,'Re-Schedule Request from Mohd Shariq: Hey! I\'m Sorry I have some urgent work at the time of our class can you please consider rescheduling it. Click to go to lessons','./Lessons','2021-12-20 23:18:41',2,NULL,1,0),(64,'User Name has scheduled their lesson. Click to see details','./Lessons','2021-12-20 23:20:10',NULL,1,1,0),(65,'Re-Schedule Request from User Name: Hey can you please re-schedule our class I\'m not feeling well today. Click to go to lessons','./Lessons','2021-12-20 23:21:59',1,NULL,1,1),(66,'User Name has scheduled their lesson. Click to see details','./Lessons','2021-12-20 23:59:30',NULL,1,1,0),(67,'User Name has scheduled their lesson. Click to see details','./Lessons','2021-12-21 00:00:39',NULL,1,1,0),(68,'Re-Schedule Request from Mohd Shariq: Please consider Re-Schedule Click to go to lessons','./Lessons','2021-12-21 00:30:54',2,NULL,1,1),(69,'User Name has scheduled their lesson. Click to see details','./Lessons','2021-12-21 00:33:46',NULL,1,1,0),(70,'Re-Schedule Request from Mohd Shariq: Re-Schedule again\r\n Click to go to lessons','./Lessons','2021-12-21 00:34:29',2,NULL,1,1),(71,'User Name has scheduled their lesson. Click to see details','./Lessons','2021-12-21 00:34:59',NULL,1,1,1),(72,'Re-Schedule Request from Mohd Shariq: Please Re-Schedule This Class Click to go to lessons','./Lessons','2021-12-21 00:47:25',2,NULL,1,1),(73,'User Name has scheduled their lesson. Click to see details','./Lessons','2021-12-21 01:17:33',NULL,1,1,1),(74,'Mohd Shariq has scheduled their lesson. Click to see details','./Lessons','2021-12-21 01:22:09',NULL,2,1,1),(75,'Mohd Shariq has scheduled their lesson. Click to see details','./Lessons','2021-12-21 01:23:05',NULL,2,1,1),(76,'Your booking ( Booking ID:23 ) is completed. Click here to see your bookings.','./Orders','2021-12-21 02:09:05',2,NULL,1,1),(77,'You have a new booking ( Booking ID:\"+booking_id+\" ). Click to see details','./Orders','2021-12-21 02:09:05',NULL,1,1,0),(78,'User Name has scheduled their lesson. Click to see details','./Lessons','2021-12-21 02:09:27',NULL,1,1,0),(79,'User Name has scheduled their lesson. Click to see details','./Lessons','2021-12-21 02:10:21',NULL,1,1,0),(80,'Your booking ( Booking ID:24 ) is completed. Click here to see your bookings.','./Orders','2021-12-21 03:56:52',2,NULL,1,1),(81,'You have a new booking ( Booking ID:\"+booking_id+\" ). Click to see details','./Orders','2021-12-21 03:56:52',NULL,1,1,0),(82,'User Name has scheduled their lesson. Click to see details','./Lessons','2021-12-21 03:57:12',NULL,1,1,0),(83,'Your booking ( Booking ID:25 ) is completed. Click here to see your bookings.','./Orders','2021-12-21 21:10:16',2,NULL,1,1),(84,'You have a new booking ( Booking ID:\"+booking_id+\" ). Click to see details','./Orders','2021-12-21 21:10:16',NULL,1,1,0),(85,'User Name has scheduled their lesson. Click to see details','./Lessons','2021-12-21 21:10:46',NULL,1,1,0),(86,'Your booking ( Booking ID:26 ) is completed. Click here to see your bookings.','./Orders','2021-12-21 22:21:34',2,NULL,1,1),(87,'You have a new booking ( Booking ID:\"+booking_id+\" ). Click to see details','./Orders','2021-12-21 22:21:34',NULL,1,1,0),(88,'User Name has scheduled their lesson. Click to see details','./Lessons','2021-12-21 22:23:48',NULL,1,1,0),(89,'Your booking ( Booking ID:27 ) is completed. Click here to see your bookings.','./Orders','2021-12-21 22:26:54',2,NULL,1,1),(90,'You have a new booking ( Booking ID:\"+booking_id+\" ). Click to see details','./Orders','2021-12-21 22:26:54',NULL,1,1,0),(91,'User Name has scheduled their lesson. Click to see details','./Lessons','2021-12-21 22:29:51',NULL,1,1,1),(92,'User Name has scheduled their lesson. Click to see details','./Lessons','2021-12-21 22:30:46',NULL,1,1,1),(93,'User Name has cancelled lesson (Lesson ID:16). Cancellation Reason: Aise hi ','./Notifications','2021-12-22 02:15:32',1,NULL,1,1),(94,'Refund amount of Rs.600.0 for Lesson ID:16 has been transfered to your wallet. Click to see details','./Wallet','2021-12-22 02:15:32',1,NULL,1,0),(95,'User Name has cancelled lesson (Lesson ID:14). Cancellation Reason: Dil kar rha tha','./Notifications','2021-12-22 02:29:46',1,NULL,1,0),(96,'Refund amount of Rs.1200.0 for Lesson ID:14 has been transfered to your wallet. Click to see details','./Wallet','2021-12-22 02:29:46',1,NULL,1,0),(97,'Mohd Shariq has cancelled lesson (Lesson ID:13). Cancellation Reason: Aise hi dil kar rha tha to kar diya\r\n','./Notifications','2021-12-22 02:35:56',NULL,2,1,1),(98,'Refund amount of Rs.1500.0 for Lesson ID:13 has been transfered to your wallet. Click to see details','./Wallet','2021-12-22 02:35:56',1,NULL,1,0),(99,'User Name has cancelled lesson (Lesson ID:15). Cancellation Reason: Mera bhi dil kiya to kar diya cancel ','./Notifications','2021-12-22 02:39:24',1,NULL,1,1),(100,'Refund amount of Rs.1200.0 for Lesson ID:15 has been transfered to your wallet. Click to see details','./Wallet','2021-12-22 02:39:24',1,NULL,1,1),(101,'Mohd Shariq has cancelled lesson (Lesson ID:21). Cancellation Reason: Mera bhi dil kiya\r\n','./Notifications','2021-12-22 02:40:50',2,NULL,1,0),(102,'Refund amount of Rs.1000.0 for Lesson ID:21 has been transfered to your wallet. Click to see details','./Wallet','2021-12-22 02:40:50',2,NULL,1,1),(103,'Mohd Shariq has cancelled lesson (Lesson ID:3). Cancellation Reason: Some Reason\r\n','./Notifications','2021-12-22 03:03:36',2,NULL,1,1),(104,'Refund amount of Rs.800.0 for Lesson ID:3 has been transfered to your wallet. Click to see details','./Wallet','2021-12-22 03:03:36',2,NULL,1,1),(105,'User Name wrote feedback for Lesson ID:23. Feeback: Some Feedbaack','./Notification','2021-12-22 03:32:35',NULL,1,1,0),(106,'User Name wrote feedback for Lesson ID:22. Feeback: ','./Notification','2021-12-22 03:43:04',NULL,1,1,0),(107,'Mohd Shariq has scheduled their lesson. Click to see details','./Lessons','2021-12-22 23:55:51',NULL,2,1,0),(108,'Your booking ( Booking ID:28 ) is completed. Click here to see your bookings.','./Orders','2021-12-23 03:15:14',1,NULL,1,0),(109,'You have a new booking ( Booking ID:\"+booking_id+\" ). Click to see details','./Orders','2021-12-23 03:15:14',NULL,2,1,1),(110,'Your booking ( Booking ID:29 ) is completed. Click here to see your bookings.','./Orders','2021-12-23 03:19:48',2,NULL,1,1),(111,'You have a new booking ( Booking ID:\"+booking_id+\" ). Click to see details','./Orders','2021-12-23 03:19:48',NULL,1,1,0),(112,'User Name has scheduled their lesson. Click to see details','./Lessons','2021-12-23 03:23:08',NULL,1,1,0),(113,'Mohd Shariq has scheduled their lesson. Click to see details','./Lessons','2021-12-23 03:49:02',NULL,2,0,0),(114,'Your booking ( Booking ID:30 ) is completed. Click here to see your bookings.','./Orders','2021-12-23 03:51:58',1,NULL,1,0),(115,'You have a new booking ( Booking ID:30 ). Click to see details','./Orders','2021-12-23 03:51:58',NULL,2,0,0),(116,'Welcome to TutorPod :)','#','2021-12-24 00:06:12',3,NULL,1,0),(117,'Your user profile is created. Click to view settings.','./AccountSettings','2021-12-24 00:06:12',3,NULL,1,0),(118,'Your Application is approved now you will apear in the search results. Make sure you add your availabiltiy, Click to add availability','./Availability','2021-12-24 00:10:12',NULL,3,1,1),(119,'Your booking ( Booking ID:31 ) is completed. Click here to see your bookings.','./Orders','2021-12-24 00:14:30',3,NULL,1,1),(120,'You have a new booking ( Booking ID:31 ). Click to see details','./Orders','2021-12-24 00:14:30',NULL,1,0,0),(121,'Some One has scheduled their lesson. Click to see details','./Lessons','2021-12-24 00:15:08',NULL,1,0,0),(122,'Some One has scheduled their lesson. Click to see details','./Lessons','2021-12-24 00:15:17',NULL,1,0,0),(123,'Some One has cancelled lesson (Lesson ID:29). Cancellation Reason: Don\'t need this lesson ','./Notifications','2021-12-24 00:15:45',NULL,1,0,0),(124,'Refund amount of Rs.600.0 for Lesson ID:29 has been transfered to your wallet. Click to see details','./Wallet','2021-12-24 00:15:45',3,NULL,1,1),(125,'Some One has cancelled lesson (Lesson ID:28). Cancellation Reason: test cancellation \r\n','./Notifications','2021-12-24 00:21:31',NULL,1,0,0),(126,'Refund amount of Rs.600.0 for Lesson ID:28 has been transfered to your wallet. Click to see details','./Wallet','2021-12-24 00:21:31',3,NULL,1,0),(127,'Your booking ( Booking ID:32 ) is completed. Click here to see your bookings.','./Orders','2021-12-24 02:34:29',1,NULL,0,0),(128,'You have a new booking ( Booking ID:32 ). Click to see details','./Orders','2021-12-24 02:34:29',NULL,3,0,0);
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subject`
--

LOCK TABLES `subject` WRITE;
/*!40000 ALTER TABLE `subject` DISABLE KEYS */;
INSERT INTO `subject` VALUES (1,'English','FEG-02'),(2,'Business Organization','ECO-01'),(3,'Computer Basics and PC Software','BCS-011'),(4,'Basic Mathematics','BCS-012'),(5,'Computer Basics and PC Software Lab','BCSL-013');
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
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction`
--

LOCK TABLES `transaction` WRITE;
/*!40000 ALTER TABLE `transaction` DISABLE KEYS */;
INSERT INTO `transaction` VALUES (1,'User',1,'AdminBankAcc',3,1000,'Money added to wallet by User ID:1','2021-12-23','2021-12-23 03:13:08'),(2,'User',1,'User',2,585,'Booking payment - 2.5%(TutorPod fee)','2021-12-23','2021-12-23 03:15:14'),(3,'Booking',28,'AdminBankAcc',3,30,'Booking payment ID:28','2021-12-23','2021-12-23 03:15:14'),(4,'User',1,'AdminBankAcc',3,1000,'Money added to wallet by User ID:1','2021-12-23','2021-12-23 03:17:28'),(5,'User',2,'AdminBankAcc',3,1000,'Money added to wallet by User ID:2','2021-12-23','2021-12-23 03:18:03'),(6,'User',2,'User',1,682.5,'Booking payment - 2.5%(TutorPod fee)','2021-12-23','2021-12-23 03:19:48'),(7,'Booking',29,'AdminBankAcc',3,35,'Booking payment ID:29','2021-12-23','2021-12-23 03:19:48'),(8,'User',1,'User',2,585,'Booking payment - 2.5%(TutorPod fee)','2021-12-23','2021-12-23 03:51:58'),(9,'Booking',30,'AdminBankAcc',3,30,'Booking payment ID:30','2021-12-23','2021-12-23 03:51:58'),(10,'User',3,'AdminBankAcc',3,1000,'Money added to wallet by User ID:3','2021-12-24','2021-12-24 00:12:25'),(11,'User',3,'AdminBankAcc',3,5000,'Money added to wallet by User ID:3','2021-12-24','2021-12-24 00:12:35'),(12,'User',3,'User',1,1755,'Booking payment - 2.5%(TutorPod fee)','2021-12-24','2021-12-24 00:14:30'),(13,'Booking',31,'AdminBankAcc',3,90,'Booking payment ID:31','2021-12-24','2021-12-24 00:14:30'),(14,'User',1,'User',3,600,'Refund for Lesson ID:29','2021-12-24','2021-12-24 00:15:45'),(15,'User',1,'User',3,600,'Refund for Lesson ID:28','2021-12-24','2021-12-24 00:21:31'),(16,'User',1,'User',3,1560,'Booking payment - 2.5%(TutorPod fee)','2021-12-24','2021-12-24 02:34:29'),(17,'Booking',32,'AdminBankAcc',3,80,'Booking payment ID:32','2021-12-24','2021-12-24 02:34:29');
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tutor`
--

LOCK TABLES `tutor` WRITE;
/*!40000 ALTER TABLE `tutor` DISABLE KEYS */;
INSERT INTO `tutor` VALUES (1,'Some things about me','2021-12-08','Tutor',1,1),(2,'Some things about me\r\n','2021-12-08','Tutor',2,2),(3,'Some Things About Me','2021-12-24','Tutor',3,3);
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'Mohd','Shariq','mdshariq','password','mdshariq614@gmail.com','9971431679','Male',NULL,'2021-12-06',1,1,1),(2,'User','Name','username','password','some@user.com','9900118811','Male',NULL,'2021-12-08',2,2,2),(3,'Some','One','someone','password','some@one.com','9090909090','Male','Some_One_3','2021-12-24',3,501,4);
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
) ENGINE=InnoDB AUTO_INCREMENT=502 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wallet`
--

LOCK TABLES `wallet` WRITE;
/*!40000 ALTER TABLE `wallet` DISABLE KEYS */;
INSERT INTO `wallet` VALUES (1,1166,1),(2,867.5,2),(501,6915,3);
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
) ENGINE=InnoDB AUTO_INCREMENT=105 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wallet_transaction`
--

LOCK TABLES `wallet_transaction` WRITE;
/*!40000 ALTER TABLE `wallet_transaction` DISABLE KEYS */;
INSERT INTO `wallet_transaction` VALUES (1,1,1000,1,0,1000,'Money Added by Self','Completed','2021-12-14 16:37:39'),(2,1,512.5,0,1,487.5,'Booking Made with ID:3','Completed','2021-12-14 16:40:37'),(3,2,487.5,1,0,487.5,'Booking payment - 2.5%(TutorPod fee) for Booking ID:3','Completed','2021-12-14 16:40:37'),(4,1,1000,1,0,1487.5,'Money Added by Self','Completed','2021-12-14 17:34:32'),(5,1,1230,0,1,257.5,'Booking Made with ID:4','Completed','2021-12-14 17:34:55'),(6,2,1170,1,0,1657.5,'Booking payment - 2.5%(TutorPod fee) for Booking ID:4','Completed','2021-12-14 17:34:55'),(7,1,1500,1,0,1757.5,'Money Added by Self','Completed','2021-12-14 17:37:54'),(8,1,4000,1,0,5757.5,'Money Added by Self','Completed','2021-12-14 17:50:20'),(9,1,5535,0,1,222.5,'Booking Made with ID:5','Completed','2021-12-14 17:50:32'),(10,2,5265,1,0,6922.5,'Booking payment - 2.5%(TutorPod fee) for Booking ID:5','Completed','2021-12-14 17:50:32'),(11,1,500,1,0,722.5,'Money Added by Self','Completed','2021-12-14 17:51:13'),(12,1,1000,1,0,1722.5,'Money Added by Self','Completed','2021-12-14 18:01:59'),(13,1,900,1,0,2622.5,'Money Added by Self','Completed','2021-12-14 18:02:18'),(14,1,9000,1,0,11622.5,'Money Added by Self','Completed','2021-12-14 18:02:24'),(15,1,9225,0,1,2397.5,'Booking Made with ID:6','Completed','2021-12-14 18:02:47'),(16,2,8775,1,0,15697.5,'Booking payment - 2.5%(TutorPod fee) for Booking ID:6','Completed','2021-12-14 18:02:47'),(17,1,100,1,0,2497.5,'Money Added by Self','Completed','2021-12-14 18:34:37'),(18,1,300,1,0,2797.5,'Money Added by Self','Completed','2021-12-14 18:53:18'),(19,1,1000,1,0,3797.5,'Money Added by Self','Completed','2021-12-14 18:53:26'),(20,1,1000,1,0,4797.5,'Money Added by Self','Completed','2021-12-14 18:53:33'),(21,1,9000,1,0,13797.5,'Money Added by Self','Completed','2021-12-14 18:53:40'),(22,1,9840,0,1,3957.5,'Booking Made with ID:7','Completed','2021-12-14 18:53:47'),(23,2,9360,1,0,25057.5,'Booking payment - 2.5%(TutorPod fee) for Booking ID:7','Completed','2021-12-14 18:53:47'),(24,1,100,1,0,4057.5,'Money Added by Self','Completed','2021-12-14 18:54:26'),(25,1,3690,0,1,367.5,'Booking Made with ID:8','Completed','2021-12-14 18:56:11'),(26,2,3510,1,0,28567.5,'Booking payment - 2.5%(TutorPod fee) for Booking ID:8','Completed','2021-12-14 18:56:11'),(27,1,1000000,1,0,1000367.5,'Money Added by Self','Completed','2021-12-14 18:56:43'),(28,1,10000000,1,0,11000367.5,'Money Added by Self','Completed','2021-12-14 18:56:58'),(29,1,774900,0,1,10225467.5,'Booking Made with ID:9','Completed','2021-12-14 18:57:28'),(30,2,737100,1,0,765667.5,'Booking payment - 2.5%(TutorPod fee) for Booking ID:9','Completed','2021-12-14 18:57:28'),(31,1,1549800,0,1,8675667.5,'Booking Made with ID:10','Completed','2021-12-14 18:58:13'),(32,2,1474200,1,0,2239867.5,'Booking payment - 2.5%(TutorPod fee) for Booking ID:10','Completed','2021-12-14 18:58:13'),(33,1,100000,1,0,8775667.5,'Money Added by Self','Completed','2021-12-14 18:58:52'),(34,1,1435,0,1,8774232.5,'Booking Made with ID:11','Completed','2021-12-14 21:01:21'),(35,2,1365,1,0,2241232.5,'Booking payment - 2.5%(TutorPod fee) for Booking ID:11','Completed','2021-12-14 21:01:21'),(38,1,2460,0,1,8771772.5,'Booking Made with ID:14','Completed','2021-12-16 05:38:07'),(39,2,2340,1,0,2243572.5,'Booking payment - 2.5%(TutorPod fee) for Booking ID:14','Completed','2021-12-16 05:38:07'),(40,2,1640,0,1,2241932.5,'Booking Made with ID:15','Completed','2021-12-16 11:28:43'),(41,1,1560,1,0,8773332.5,'Booking payment - 2.5%(TutorPod fee) for Booking ID:15','Completed','2021-12-16 11:28:43'),(42,2,512.5,0,1,2241420,'Booking Made with ID:16','Completed','2021-12-16 11:28:59'),(43,1,487.5,1,0,8773820,'Booking payment - 2.5%(TutorPod fee) for Booking ID:16','Completed','2021-12-16 11:28:59'),(44,2,1845,0,1,2239575,'Booking Made with ID:17','Completed','2021-12-19 01:52:00'),(45,1,1755,1,0,8775575,'Booking payment - 2.5%(TutorPod fee) for Booking ID:17','Completed','2021-12-19 01:52:00'),(46,1,2870,0,1,8772705,'Booking Made with ID:18','Completed','2021-12-19 04:33:00'),(47,2,2730,1,0,2242305,'Booking payment - 2.5%(TutorPod fee) for Booking ID:18','Completed','2021-12-19 04:33:00'),(48,1,1845,0,1,8770860,'Booking Made with ID:19','Completed','2021-12-19 12:57:48'),(49,2,1755,1,0,2244060,'Booking payment - 2.5%(TutorPod fee) for Booking ID:19','Completed','2021-12-19 12:57:48'),(50,1,3075,0,1,8767785,'Booking Made with ID:20','Completed','2021-12-19 14:56:19'),(51,2,2925,1,0,2246985,'Booking payment - 2.5%(TutorPod fee) for Booking ID:20','Completed','2021-12-19 14:56:19'),(52,1,2460,0,1,8765325,'Booking Made with ID:21','Completed','2021-12-19 18:49:28'),(53,2,2340,1,0,2249325,'Booking payment - 2.5%(TutorPod fee) for Booking ID:21','Completed','2021-12-19 18:49:28'),(54,1,1230,0,1,8764095,'Booking Made with ID:22','Completed','2021-12-19 20:53:14'),(55,2,1170,1,0,2250495,'Booking payment - 2.5%(TutorPod fee) for Booking ID:22','Completed','2021-12-19 20:53:14'),(56,2,1230,0,1,2249265,'Booking Made with ID:23','Completed','2021-12-21 02:09:05'),(57,1,1170,1,0,8765265,'Booking payment - 2.5%(TutorPod fee) for Booking ID:23','Completed','2021-12-21 02:09:05'),(58,2,512.5,0,1,2248752.5,'Booking Made with ID:24','Completed','2021-12-21 03:56:52'),(59,1,487.5,1,0,8765752.5,'Booking payment - 2.5%(TutorPod fee) for Booking ID:24','Completed','2021-12-21 03:56:52'),(60,2,1025,0,1,2247727.5,'Booking Made with ID:25','Completed','2021-12-21 21:10:16'),(61,1,975,1,0,8766727.5,'Booking payment - 2.5%(TutorPod fee) for Booking ID:25','Completed','2021-12-21 21:10:16'),(62,2,1230,0,1,2246497.5,'Booking Made with ID:26','Completed','2021-12-21 22:21:34'),(63,1,1170,1,0,8767897.5,'Booking payment - 2.5%(TutorPod fee) for Booking ID:26','Completed','2021-12-21 22:21:34'),(64,2,512.5,0,1,2245985,'Booking Made with ID:27','Completed','2021-12-21 22:26:54'),(65,1,487.5,1,0,8768385,'Booking payment - 2.5%(TutorPod fee) for Booking ID:27','Completed','2021-12-21 22:26:54'),(66,2,600,0,1,2245385,'Refund Paid for Lesson ID:16','Completed','2021-12-22 02:15:32'),(67,1,600,1,0,8768985,'Refund Received for Lesson ID:16','Completed','2021-12-22 02:15:32'),(68,2,1200,0,1,2244185,'Refund Paid for Lesson ID:14','Completed','2021-12-22 02:29:46'),(69,1,1200,1,0,8770185,'Refund Received for Lesson ID:14','Completed','2021-12-22 02:29:46'),(70,2,1500,0,1,2242685,'Refund Paid for Lesson ID:13','Completed','2021-12-22 02:35:56'),(71,1,1500,1,0,8771685,'Refund Received for Lesson ID:13','Completed','2021-12-22 02:35:56'),(72,2,1200,0,1,2241485,'Refund Paid for Lesson ID:15','Completed','2021-12-22 02:39:24'),(73,1,1200,1,0,8772885,'Refund Received for Lesson ID:15','Completed','2021-12-22 02:39:24'),(74,1,1000,0,1,8771885,'Refund Paid for Lesson ID:21','Completed','2021-12-22 02:40:50'),(75,2,1000,1,0,2242485,'Refund Received for Lesson ID:21','Completed','2021-12-22 02:40:50'),(76,1,1000,0,1,8771885,'Withdrawal Request','Pending','2021-12-22 03:00:02'),(77,1,99999,0,1,8771885,'Withdrawal Request','Pending','2021-12-22 03:00:14'),(78,1,999999,0,1,8771885,'Withdrawal Request','Pending','2021-12-22 03:00:26'),(79,1,800,0,1,8771085,'Refund Paid for Lesson ID:3','Completed','2021-12-22 03:03:36'),(80,2,800,1,0,2243285,'Refund Received for Lesson ID:3','Completed','2021-12-22 03:03:36'),(81,1,1000,1,0,8772085,'Money Added by Self','Completed','2021-12-23 03:13:08'),(82,1,615,0,1,8771470,'Booking Made with ID:28','Completed','2021-12-23 03:15:14'),(83,2,585,1,0,2243870,'Booking payment - 2.5%(TutorPod fee) for Booking ID:28','Completed','2021-12-23 03:15:14'),(84,1,1000,1,0,1000,'Money Added by Self','Completed','2021-12-23 03:17:28'),(85,2,1000,1,0,1000,'Money Added by Self','Completed','2021-12-23 03:18:03'),(86,2,717.5,0,1,282.5,'Booking Made with ID:29','Completed','2021-12-23 03:19:48'),(87,1,682.5,1,0,1682.5,'Booking payment - 2.5%(TutorPod fee) for Booking ID:29','Completed','2021-12-23 03:19:48'),(88,1,200,0,1,1682.5,'Withdrawal Request','Pending','2021-12-23 03:42:45'),(89,1,615,0,1,1067.5,'Booking Made with ID:30','Completed','2021-12-23 03:51:58'),(90,2,585,1,0,867.5,'Booking payment - 2.5%(TutorPod fee) for Booking ID:30','Completed','2021-12-23 03:51:58'),(91,501,1000,1,0,1000,'Money Added by Self','Completed','2021-12-24 00:12:25'),(92,501,5000,1,0,6000,'Money Added by Self','Completed','2021-12-24 00:12:35'),(93,501,1845,0,1,4155,'Booking Made with ID:31','Completed','2021-12-24 00:14:30'),(94,1,1755,1,0,2822.5,'Booking payment - 2.5%(TutorPod fee) for Booking ID:31','Completed','2021-12-24 00:14:30'),(95,1,1.5,0,1,2821,'Refund Paid for Lesson ID:29','Completed','2021-12-24 00:15:45'),(96,501,600,1,0,4755,'Refund Received for Lesson ID:29','Completed','2021-12-24 00:15:45'),(97,1,15,0,1,2806,'Refund Paid for Lesson ID:28','Completed','2021-12-24 00:21:31'),(98,501,600,1,0,5355,'Refund Received for Lesson ID:28','Completed','2021-12-24 00:21:31'),(99,1,1000,0,1,2806,'Withdrawal Request','Pending','2021-12-24 01:10:18'),(100,1,1500,0,1,2806,'Withdrawal Request','Pending','2021-12-24 01:10:22'),(101,1,300,0,1,2806,'Withdrawal Request','Pending','2021-12-24 01:10:25'),(102,1,500,0,1,2806,'Withdrawal Request','Pending','2021-12-24 01:10:26'),(103,1,1640,0,1,1166,'Booking Made with ID:32','Completed','2021-12-24 02:34:29'),(104,501,1560,1,0,6915,'Booking payment - 2.5%(TutorPod fee) for Booking ID:32','Completed','2021-12-24 02:34:29');
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `withdraw_request`
--

LOCK TABLES `withdraw_request` WRITE;
/*!40000 ALTER TABLE `withdraw_request` DISABLE KEYS */;
INSERT INTO `withdraw_request` VALUES (1,1,88,200,'Pending','Withdrawl Request of 200.0 from Shariq Shariq','2021-12-23'),(2,1,99,1000,'Pending','Withdrawl Request of 1000.0 from Mohd Shariq','2021-12-24'),(3,1,100,1500,'Pending','Withdrawl Request of 1500.0 from Mohd Shariq','2021-12-24'),(4,1,101,300,'Pending','Withdrawl Request of 300.0 from Mohd Shariq','2021-12-24'),(5,1,102,500,'Pending','Withdrawl Request of 500.0 from Mohd Shariq','2021-12-24');
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

-- Dump completed on 2021-12-24 11:37:23
