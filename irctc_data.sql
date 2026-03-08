-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: localhost    Database: irctc_db
-- ------------------------------------------------------
-- Server version	8.0.43

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `accounts_user`
--

DROP TABLE IF EXISTS `accounts_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `email` varchar(254) NOT NULL,
  `name` varchar(100) NOT NULL,
  `is_admin` tinyint(1) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_user`
--

LOCK TABLES `accounts_user` WRITE;
/*!40000 ALTER TABLE `accounts_user` DISABLE KEYS */;
INSERT INTO `accounts_user` VALUES (1,'pbkdf2_sha256$1200000$rddlokCwNxFe24C5aVgjUq$zpke+kTTT7rVyGpE/yNvlCf9Ng+10SCvajH98o7VV9s=',NULL,0,'testuser1@mail.com','Test User',0,0,1,'2026-01-08 14:40:44.785415'),(2,'pbkdf2_sha256$1200000$I6WkT1tVQHBgWA98Bskja6$2pa9tkYTe0uggqwgfOVOgc8Dcf1KujqEZ8Ei6fXV5JE=','2026-01-13 05:37:07.458566',1,'admin@example.com','admin',1,1,1,'2026-01-08 14:56:16.931626'),(3,'pbkdf2_sha256$1200000$Hpmtj91EOgcyjpr6YmSalo$O3remGbV+6pbzsLBTlmEgqWyBQRgOHk05XT/bA13mh0=',NULL,0,'isha@example.com','isha',0,0,1,'2026-01-08 18:09:40.193094'),(4,'pbkdf2_sha256$1200000$BjjusO1cugpmXJWvSj0f9v$ilGrBnpePr2Wmigu1usm6O222nzjASVK5PZ7n2v5T3k=',NULL,0,'Ravi@example.com','Ravi',0,0,1,'2026-01-13 06:06:58.648952'),(5,'pbkdf2_sha256$1200000$HSfddQ6eQsC79dPkMF1Xag$VkuP9bcGYFLrT7RQx4zM9TM/W4bZG8xiuB0otuChv2Q=',NULL,0,'Geeta@example.com','Geeta',0,0,1,'2026-01-13 07:39:17.762298'),(6,'',NULL,0,'test@gmail.com','Test User',0,0,1,'2026-01-15 11:00:12.543174'),(8,'',NULL,0,'test2@gmail.com','TestUser',0,0,1,'2026-02-14 05:33:02.940374'),(10,'',NULL,0,'demo123@gmail.com','Demo User',0,0,1,'2026-02-14 05:34:27.251466'),(12,'pbkdf2_sha256$1200000$BO99oTz1LbvmezcEgxnPJz$6WVfo7adGj3PAfyKRfQoKWvbSdazAWjxVN780PyWsvQ=',NULL,0,'shinjan@test.com','Shinjan',0,0,1,'2026-02-27 17:55:45.866244'),(13,'pbkdf2_sha256$1200000$33QpRnD7i1A4XHIMiQhLui$CFN4PX+GT6o3YNCOAqYq70OeLJs/BeQJkjQVjlk02HM=','2026-03-07 15:50:26.345180',1,'test1@gmail.com','test',1,1,1,'2026-03-06 18:08:59.943161'),(14,'pbkdf2_sha256$1200000$SeJW5TYvsRYkp7Jib5l7ir$RmY+eY+JmDTr6QfUICIXG67oP5qeQcvP594tTmX6rAM=',NULL,0,'abhi@gmail.com','Abhi',0,0,1,'2026-03-06 20:28:43.607474'),(15,'pbkdf2_sha256$1200000$7zcVZyG5x3nqUeRLaspmsl$z/kxjs7/mnvYMmExLSopESPZMWdvXXN33XvmM0+0oHs=',NULL,0,'isha@gmail.com','isha',0,0,1,'2026-03-07 09:12:40.847797');
/*!40000 ALTER TABLE `accounts_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts_user_groups`
--

DROP TABLE IF EXISTS `accounts_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `accounts_user_groups_user_id_group_id_59c0b32f_uniq` (`user_id`,`group_id`),
  KEY `accounts_user_groups_group_id_bd11a704_fk_auth_group_id` (`group_id`),
  CONSTRAINT `accounts_user_groups_group_id_bd11a704_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `accounts_user_groups_user_id_52b62117_fk` FOREIGN KEY (`user_id`) REFERENCES `accounts_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_user_groups`
--

LOCK TABLES `accounts_user_groups` WRITE;
/*!40000 ALTER TABLE `accounts_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `accounts_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts_user_user_permissions`
--

DROP TABLE IF EXISTS `accounts_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `accounts_user_user_permi_user_id_permission_id_2ab516c2_uniq` (`user_id`,`permission_id`),
  KEY `accounts_user_user_p_permission_id_113bb443_fk_auth_perm` (`permission_id`),
  CONSTRAINT `accounts_user_user_p_permission_id_113bb443_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `accounts_user_user_permissions_user_id_e4f0a161_fk` FOREIGN KEY (`user_id`) REFERENCES `accounts_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_user_user_permissions`
--

LOCK TABLES `accounts_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `accounts_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `accounts_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',3,'add_permission'),(6,'Can change permission',3,'change_permission'),(7,'Can delete permission',3,'delete_permission'),(8,'Can view permission',3,'view_permission'),(9,'Can add group',2,'add_group'),(10,'Can change group',2,'change_group'),(11,'Can delete group',2,'delete_group'),(12,'Can view group',2,'view_group'),(13,'Can add content type',4,'add_contenttype'),(14,'Can change content type',4,'change_contenttype'),(15,'Can delete content type',4,'delete_contenttype'),(16,'Can view content type',4,'view_contenttype'),(17,'Can add session',5,'add_session'),(18,'Can change session',5,'change_session'),(19,'Can delete session',5,'delete_session'),(20,'Can view session',5,'view_session'),(21,'Can add user',6,'add_user'),(22,'Can change user',6,'change_user'),(23,'Can delete user',6,'delete_user'),(24,'Can view user',6,'view_user'),(25,'Can add train',7,'add_train'),(26,'Can change train',7,'change_train'),(27,'Can delete train',7,'delete_train'),(28,'Can view train',7,'view_train'),(29,'Can add booking',8,'add_booking'),(30,'Can change booking',8,'change_booking'),(31,'Can delete booking',8,'delete_booking'),(32,'Can view booking',8,'view_booking'),(33,'Can add train class',9,'add_trainclass'),(34,'Can change train class',9,'change_trainclass'),(35,'Can delete train class',9,'delete_trainclass'),(36,'Can view train class',9,'view_trainclass'),(37,'Can add train availability',10,'add_trainavailability'),(38,'Can change train availability',10,'change_trainavailability'),(39,'Can delete train availability',10,'delete_trainavailability'),(40,'Can view train availability',10,'view_trainavailability');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bookings_booking`
--

DROP TABLE IF EXISTS `bookings_booking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bookings_booking` (
  `id` int NOT NULL AUTO_INCREMENT,
  `seats_booked` int unsigned NOT NULL,
  `booked_at` datetime(6) NOT NULL,
  `train_id` int NOT NULL,
  `user_id` int NOT NULL,
  `train_class_id` int DEFAULT NULL,
  `travel_date` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `bookings_booking_user_id_834dfc23_fk` (`user_id`),
  KEY `bookings_booking_train_id_1a16aafb_fk` (`train_id`),
  KEY `bookings_booking_train_class_id_e0ab963d_fk` (`train_class_id`),
  CONSTRAINT `bookings_booking_train_class_id_e0ab963d_fk` FOREIGN KEY (`train_class_id`) REFERENCES `trains_trainclass` (`id`),
  CONSTRAINT `bookings_booking_train_id_1a16aafb_fk` FOREIGN KEY (`train_id`) REFERENCES `trains_train` (`id`),
  CONSTRAINT `bookings_booking_user_id_834dfc23_fk` FOREIGN KEY (`user_id`) REFERENCES `accounts_user` (`id`),
  CONSTRAINT `bookings_booking_chk_1` CHECK ((`seats_booked` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookings_booking`
--

LOCK TABLES `bookings_booking` WRITE;
/*!40000 ALTER TABLE `bookings_booking` DISABLE KEYS */;
INSERT INTO `bookings_booking` VALUES (28,1,'2026-03-07 17:00:18.611160',3,15,5,'2026-01-01'),(29,1,'2026-03-07 17:01:16.671189',3,15,1,'2026-01-01'),(30,1,'2026-03-07 17:10:47.981116',3,15,5,'2026-03-10'),(31,1,'2026-03-07 17:17:31.437140',3,15,5,'2026-04-11'),(32,1,'2026-03-07 18:13:19.089210',3,15,5,'2026-04-07'),(33,1,'2026-03-07 18:17:10.992588',3,15,5,'2026-03-07'),(34,1,'2026-03-07 18:20:04.456388',3,15,1,'2026-03-11'),(35,1,'2026-03-08 08:00:06.847024',3,15,1,'2026-03-11');
/*!40000 ALTER TABLE `bookings_booking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk` FOREIGN KEY (`user_id`) REFERENCES `accounts_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2026-03-07 10:21:03.323619','3','12302 - Howrah Rajdhani',1,'[{\"added\": {}}]',7,13),(2,'2026-03-07 10:22:02.109484','3','12302 - Howrah Rajdhani',2,'[]',7,13),(3,'2026-03-07 10:26:51.834147','3','12302 - Howrah Rajdhani',2,'[{\"changed\": {\"fields\": [\"Destination\"]}}]',7,13),(4,'2026-03-07 11:30:17.723309','3','12302 - Howrah Rajdhani',2,'[{\"changed\": {\"fields\": [\"Price\"]}}]',7,13),(5,'2026-03-07 15:51:13.908975','3','12302 - Howrah Rajdhani',2,'[{\"changed\": {\"fields\": [\"Price\"]}}]',7,13),(6,'2026-03-07 15:51:52.440220','3','12302 - Howrah Rajdhani',2,'[]',7,13),(7,'2026-03-07 16:35:58.760792','1','Howrah Rajdhani - GEN',1,'[{\"added\": {}}]',9,13),(8,'2026-03-07 16:36:18.820539','1','Howrah Rajdhani - GEN',2,'[]',9,13),(9,'2026-03-07 16:37:03.672605','1','Howrah Rajdhani - GEN',2,'[{\"changed\": {\"fields\": [\"Price\"]}}]',9,13),(10,'2026-03-07 16:37:31.754554','2','Howrah Rajdhani - SL',1,'[{\"added\": {}}]',9,13),(11,'2026-03-07 16:37:50.707526','3','Howrah Rajdhani - 3A',1,'[{\"added\": {}}]',9,13),(12,'2026-03-07 16:38:17.202115','4','Howrah Rajdhani - 2A',1,'[{\"added\": {}}]',9,13),(13,'2026-03-07 16:38:33.920829','5','Howrah Rajdhani - 1A',1,'[{\"added\": {}}]',9,13),(14,'2026-03-07 16:59:04.334033','27','isha@gmail.com - 12302 - Howrah Rajdhani - Howrah Rajdhani - SL',3,'',8,13),(15,'2026-03-07 16:59:04.334114','26','isha@gmail.com - 12302 - Howrah Rajdhani - Howrah Rajdhani - 1A',3,'',8,13),(16,'2026-03-07 16:59:04.334154','25','isha@gmail.com - 12302 - Howrah Rajdhani - None',3,'',8,13),(17,'2026-03-07 16:59:04.334185','24','isha@gmail.com - 12302 - Howrah Rajdhani - None',3,'',8,13),(18,'2026-03-07 16:59:04.334212','23','isha@gmail.com - 12302 - Howrah Rajdhani - None',3,'',8,13),(19,'2026-03-07 16:59:04.334240','22','isha@gmail.com - 12302 - Howrah Rajdhani - None',3,'',8,13),(20,'2026-03-07 16:59:04.334266','21','isha@gmail.com - 12302 - Howrah Rajdhani - None',3,'',8,13),(21,'2026-03-07 16:59:04.334290','20','isha@gmail.com - 12302 - Howrah Rajdhani - None',3,'',8,13),(22,'2026-03-07 16:59:04.334313','19','isha@gmail.com - 12302 - Howrah Rajdhani - None',3,'',8,13),(23,'2026-03-07 16:59:04.334336','18','isha@gmail.com - 12302 - Howrah Rajdhani - None',3,'',8,13),(24,'2026-03-07 16:59:04.334359','17','isha@gmail.com - 12302 - Howrah Rajdhani - None',3,'',8,13),(25,'2026-03-07 16:59:04.334383','16','isha@gmail.com - 12302 - Howrah Rajdhani - None',3,'',8,13),(26,'2026-03-07 16:59:04.334406','15','isha@gmail.com - 12302 - Howrah Rajdhani - None',3,'',8,13),(27,'2026-03-07 16:59:04.334428','14','isha@gmail.com - 12302 - Howrah Rajdhani - None',3,'',8,13),(28,'2026-03-07 16:59:04.334452','13','isha@gmail.com - 12302 - Howrah Rajdhani - None',3,'',8,13),(29,'2026-03-07 16:59:04.334476','12','isha@gmail.com - 12302 - Howrah Rajdhani - None',3,'',8,13),(30,'2026-03-07 16:59:04.334498','11','isha@gmail.com - 12345 - Rajdhani Express - None',3,'',8,13),(31,'2026-03-07 16:59:04.334521','10','test1@gmail.com - 12345 - Rajdhani Express - None',3,'',8,13),(32,'2026-03-07 16:59:04.334544','9','test1@gmail.com - 12345 - Rajdhani Express - None',3,'',8,13),(33,'2026-03-07 16:59:04.334565','8','test1@gmail.com - 12345 - Rajdhani Express - None',3,'',8,13),(34,'2026-03-07 16:59:04.334588','7','test1@gmail.com - 12345 - Rajdhani Express - None',3,'',8,13),(35,'2026-03-07 16:59:04.334611','6','test1@gmail.com - 12345 - Rajdhani Express - None',3,'',8,13),(36,'2026-03-07 16:59:04.334633','5','test1@gmail.com - 12345 - Rajdhani Express - None',3,'',8,13),(37,'2026-03-07 16:59:04.334656','4','Geeta@example.com - 12345 - Rajdhani Express - None',3,'',8,13),(38,'2026-03-07 16:59:04.334678','3','Ravi@example.com - 12345 - Rajdhani Express - None',3,'',8,13),(39,'2026-03-07 16:59:04.334700','2','isha@example.com - 12345 - Rajdhani Express - None',3,'',8,13),(40,'2026-03-07 16:59:04.334723','1','admin@example.com - 12345 - Rajdhani Express - None',3,'',8,13);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (6,'accounts','user'),(1,'admin','logentry'),(2,'auth','group'),(3,'auth','permission'),(8,'bookings','booking'),(4,'contenttypes','contenttype'),(5,'sessions','session'),(7,'trains','train'),(10,'trains','trainavailability'),(9,'trains','trainclass');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2026-01-08 13:17:24.023338'),(2,'contenttypes','0002_remove_content_type_name','2026-01-08 13:17:24.184545'),(3,'auth','0001_initial','2026-01-08 13:17:24.622776'),(4,'auth','0002_alter_permission_name_max_length','2026-01-08 13:17:24.745556'),(5,'auth','0003_alter_user_email_max_length','2026-01-08 13:17:24.755611'),(6,'auth','0004_alter_user_username_opts','2026-01-08 13:17:24.766860'),(7,'auth','0005_alter_user_last_login_null','2026-01-08 13:17:24.780653'),(8,'auth','0006_require_contenttypes_0002','2026-01-08 13:17:24.786437'),(9,'auth','0007_alter_validators_add_error_messages','2026-01-08 13:17:24.802748'),(10,'auth','0008_alter_user_username_max_length','2026-01-08 13:17:24.812400'),(11,'auth','0009_alter_user_last_name_max_length','2026-01-08 13:17:24.821738'),(12,'auth','0010_alter_group_name_max_length','2026-01-08 13:17:24.844492'),(13,'auth','0011_update_proxy_permissions','2026-01-08 13:17:24.855668'),(14,'auth','0012_alter_user_first_name_max_length','2026-01-08 13:17:24.864631'),(15,'accounts','0001_initial','2026-01-08 13:17:25.392540'),(16,'admin','0001_initial','2026-01-08 13:17:25.627069'),(17,'admin','0002_logentry_remove_auto_add','2026-01-08 13:17:25.637905'),(18,'admin','0003_logentry_add_action_flag_choices','2026-01-08 13:17:25.650911'),(19,'trains','0001_initial','2026-01-08 13:17:25.711311'),(20,'bookings','0001_initial','2026-01-08 13:17:26.001681'),(21,'sessions','0001_initial','2026-01-08 13:17:26.062091'),(22,'trains','0002_train_price','2026-03-07 10:20:44.764222'),(23,'trains','0003_remove_train_available_seats_remove_train_price_and_more','2026-03-07 16:33:10.037085'),(24,'bookings','0002_booking_train_class','2026-03-07 16:33:10.213455'),(25,'bookings','0003_booking_travel_date','2026-03-07 17:04:47.920135'),(26,'trains','0004_trainavailability','2026-03-07 17:15:13.495627'),(27,'accounts','0002_alter_user_id','2026-03-08 18:19:32.558485'),(28,'bookings','0004_alter_booking_id','2026-03-08 18:19:32.702987'),(29,'trains','0005_alter_train_id_alter_trainavailability_id_and_more','2026-03-08 18:19:34.163505');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('ffara8ewdilweprqtq8ul91slltlvype','.eJxVjDsOwjAUBO_iGln-xJ9Q0nMGa-1n4wCKpTipEHeHSCmg3ZnZFwvY1hq2npcwETszqdnpd4xIjzzvhO6Yb42nNq_LFPmu8IN2fm2Un5fD_Tuo6PVbFzcIRQJ2zCRssWPSSUo4r2X2Iwysi_DGDqVAU1Eg5TyMkEp5JUDs_QEGhjf6:1vytv8:X1mZnklOoWFell2xuPZ7jJ_CMSDtLEq7Ym1li9veR6w','2026-03-21 15:50:26.355511'),('rwobsn3i6obx47nf3xxhv0xs00bfeyv5','.eJxVjDsOAiEUAO9CbQg8_pb2ewby-MmqgWTZrYx3NyRbaDszmTfxeOzVHyNvfk3kSoBcflnA-MxtivTAdu809rZva6AzoacddOkpv25n-zeoOOrcSmMBTEDGhLBgGTcWrXQ8OBGV0sUJbaBEyaAkrgIHi6iNA20iSyjI5wuZDzZQ:1vfX5X:1tqG3H1mmSdJ2GwGLTin2-xBaecw97qLkd3Nfdwsqjw','2026-01-27 05:37:07.464835');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trains_train`
--

DROP TABLE IF EXISTS `trains_train`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trains_train` (
  `id` int NOT NULL AUTO_INCREMENT,
  `train_number` varchar(10) NOT NULL,
  `name` varchar(100) NOT NULL,
  `source` varchar(50) NOT NULL,
  `destination` varchar(50) NOT NULL,
  `departure_time` time(6) NOT NULL,
  `arrival_time` time(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `train_number` (`train_number`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trains_train`
--

LOCK TABLES `trains_train` WRITE;
/*!40000 ALTER TABLE `trains_train` DISABLE KEYS */;
INSERT INTO `trains_train` VALUES (1,'12345','Rajdhani Express','Delhi','Kolkata','10:00:00.000000','18:00:00.000000'),(2,'4567','Shatabdi Express','Mumbai','Delhi','10:00:00.000000','10:00:00.000000'),(3,'12302','Howrah Rajdhani','Howrah','New Delhi','16:50:00.000000','10:05:00.000000');
/*!40000 ALTER TABLE `trains_train` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trains_trainavailability`
--

DROP TABLE IF EXISTS `trains_trainavailability`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trains_trainavailability` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `available_seats` int NOT NULL,
  `train_class_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `trains_trainavailability_train_class_id_date_9bda0c15_uniq` (`train_class_id`,`date`),
  CONSTRAINT `trains_trainavailability_train_class_id_0f8ba6b2_fk` FOREIGN KEY (`train_class_id`) REFERENCES `trains_trainclass` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trains_trainavailability`
--

LOCK TABLES `trains_trainavailability` WRITE;
/*!40000 ALTER TABLE `trains_trainavailability` DISABLE KEYS */;
INSERT INTO `trains_trainavailability` VALUES (1,'2026-04-07',19,5),(2,'2026-03-07',19,5),(3,'2026-03-11',198,1);
/*!40000 ALTER TABLE `trains_trainavailability` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trains_trainclass`
--

DROP TABLE IF EXISTS `trains_trainclass`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trains_trainclass` (
  `id` int NOT NULL AUTO_INCREMENT,
  `class_type` varchar(5) NOT NULL,
  `total_seats` int NOT NULL,
  `available_seats` int NOT NULL,
  `price` decimal(8,2) NOT NULL,
  `train_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `trains_trainclass_train_id_class_type_e3064e59_uniq` (`train_id`,`class_type`),
  CONSTRAINT `trains_trainclass_train_id_f1a09da4_fk` FOREIGN KEY (`train_id`) REFERENCES `trains_train` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trains_trainclass`
--

LOCK TABLES `trains_trainclass` WRITE;
/*!40000 ALTER TABLE `trains_trainclass` DISABLE KEYS */;
INSERT INTO `trains_trainclass` VALUES (1,'GEN',200,199,299.00,3),(2,'SL',150,149,599.00,3),(3,'3A',100,100,1199.00,3),(4,'2A',50,50,1799.00,3),(5,'1A',20,16,2999.00,3);
/*!40000 ALTER TABLE `trains_trainclass` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-09  0:17:04
