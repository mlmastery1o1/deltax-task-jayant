CREATE DATABASE  IF NOT EXISTS `delstaxdb` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `delstaxdb`;
-- MySQL dump 10.13  Distrib 8.0.28, for Win64 (x86_64)
--
-- Host: localhost    Database: delstaxdb
-- ------------------------------------------------------
-- Server version	8.0.28

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
-- Table structure for table `artist`
--

DROP TABLE IF EXISTS `artist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `artist` (
  `artist_id` int NOT NULL AUTO_INCREMENT,
  `artist_name` varchar(45) DEFAULT NULL,
  `artist_dob` date DEFAULT NULL,
  `artist_bio` text,
  PRIMARY KEY (`artist_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `artist`
--

LOCK TABLES `artist` WRITE;
/*!40000 ALTER TABLE `artist` DISABLE KEYS */;
INSERT INTO `artist` VALUES (1,'Arijit Singh','1987-04-25','One of the best singer\'s of india'),(3,'Tylor Swift','1989-12-13','One of the singers from USA'),(4,'Ed Shreeran','1991-02-17','British singer'),(5,'Atif Aslam','1983-03-12','Atif Aslam was born on 12 March 1983.'),(6,'Javed Ali','1982-07-05','Javed Ali is an Indian playback singer who predominantly sings in Hindi.'),(7,'Shreya Ghoshal','1984-03-12','Shreya Ghoshal is an Indian singer and television personality. One of the highest-paid and well-established playback singers of Hindi cinema.'),(8,'Ajay Gogavale','1976-08-21','Ajay and Atul Gogavale were born to Ashok Gogavale, a Revenue Department officer in Alandi in Pune.'),(9,'Sunidhi Chauhan','1983-08-14','Sunidhi Chauhan is an Indian playback singer. Born in Delhi, she began performing in local gatherings at the age of 5 and made her career debut at the age of 13, with the film Shastra.'),(10,'Sonu Nigam','1973-07-30','Sonu Nigam is an Indian singer, music director and actor. He has been described in the media as one of the most popular and successful playback singers of Hindi Cinema'),(11,'Krishnakumar Kunnath (KK)','1968-08-23','rishnakumar Kunnath, popularly known as KK, was an Indian playback singer. He recorded songs in several languages, including Hindi, Tamil, Telugu, Kannada, Malayalam, Marathi, Odia, Bengali, Assamese and Gujarati.');
/*!40000 ALTER TABLE `artist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ratings`
--

DROP TABLE IF EXISTS `ratings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ratings` (
  `ratings_id` int NOT NULL AUTO_INCREMENT,
  `song_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `rating` int DEFAULT NULL,
  PRIMARY KEY (`ratings_id`),
  KEY `user_id_key_idx` (`user_id`),
  KEY `song_id_key_idx` (`song_id`),
  CONSTRAINT `song_id_key` FOREIGN KEY (`song_id`) REFERENCES `songs` (`song_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `user_id_key` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ratings`
--

LOCK TABLES `ratings` WRITE;
/*!40000 ALTER TABLE `ratings` DISABLE KEYS */;
INSERT INTO `ratings` VALUES (1,16,1,4),(2,17,1,0),(3,18,1,5),(4,19,1,5),(5,20,1,4),(6,16,2,5),(7,17,2,0),(8,21,2,5),(9,22,2,0),(10,23,2,0),(11,24,2,5),(12,25,2,0),(13,26,2,4),(14,18,2,5);
/*!40000 ALTER TABLE `ratings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `song_artists`
--

DROP TABLE IF EXISTS `song_artists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `song_artists` (
  `song_id` int DEFAULT NULL,
  `artist_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `song_artists`
--

LOCK TABLES `song_artists` WRITE;
/*!40000 ALTER TABLE `song_artists` DISABLE KEYS */;
INSERT INTO `song_artists` VALUES (16,3),(16,4),(17,1),(18,1),(19,1),(20,5),(21,6),(22,7),(23,9),(24,8),(25,10),(26,11);
/*!40000 ALTER TABLE `song_artists` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `songs`
--

DROP TABLE IF EXISTS `songs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `songs` (
  `song_id` int NOT NULL AUTO_INCREMENT,
  `song_name` varchar(45) DEFAULT NULL,
  `song_release` date DEFAULT NULL,
  `song_poster` mediumtext,
  PRIMARY KEY (`song_id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `songs`
--

LOCK TABLES `songs` WRITE;
/*!40000 ALTER TABLE `songs` DISABLE KEYS */;
INSERT INTO `songs` VALUES (16,'Everything Has Changed','2013-07-17','1654617790554MV5BNWZmY2NjZjktNWUyNC00NjVmLTg5YzItMjgxMTBiYzI3OTZhXkEyXkFqcGdeQXVyNTQ5MTQ2MTI@._V1_UY98_CR15,0,67,98_AL_.jpg'),(17,'Chunar','2015-06-08','1654619290439218724image.jpg'),(18,'Har Har Gange','2018-09-04','1654619343299Batti_Gul_Meter_Chalu_Poster.jpg'),(19,'Tose Naina','2013-10-12','1654619376133mickey-virus-poster-manish-paul-elli-avram.jpg'),(20,'Dekhte Dekhte','1983-04-12','1654619738106Batti_Gul_Meter_Chalu_Poster.jpg'),(21,'Srivalli','2022-01-04','1654676169756HD-wallpaper-pushpa-the-rise-2021-movie.jpg'),(22,'Param Sundari','2021-07-27','1654676335302Mimi_2021_Hindi_poster.jpg'),(23,'Saami Saami','2022-01-07','1654676447851HD-wallpaper-pushpa-the-rise-2021-movie.jpg'),(24,'Devak Kalji Re','2018-05-07','1654676690252redu-marathi-movie-poster.jpg'),(25,'Abhi Mujhme Kahi','2013-10-26','1654676919487agneepath_132566485312.jpg'),(26,'Aankhon Mein Teri','2007-02-22','165467717787060874108.jpg');
/*!40000 ALTER TABLE `songs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `topartists`
--

DROP TABLE IF EXISTS `topartists`;
/*!50001 DROP VIEW IF EXISTS `topartists`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `topartists` AS SELECT 
 1 AS `artist_name`,
 1 AS `artist_dob`,
 1 AS `artist_bio`,
 1 AS `avgrating`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `topsongs`
--

DROP TABLE IF EXISTS `topsongs`;
/*!50001 DROP VIEW IF EXISTS `topsongs`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `topsongs` AS SELECT 
 1 AS `song_id`,
 1 AS `song_name`,
 1 AS `song_release`,
 1 AS `song_poster`,
 1 AS `avgrating`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `user_name` varchar(45) DEFAULT NULL,
  `user_email` varchar(45) DEFAULT NULL,
  `user_password` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `user_email_UNIQUE` (`user_email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'Jayant','jayant@gmail.com','95d825fd90bb1881687687e24a65b1b6'),(2,'Shyam','shyam@gmail.com','95d825fd90bb1881687687e24a65b1b6');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `topartists`
--

/*!50001 DROP VIEW IF EXISTS `topartists`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `topartists` AS select distinct `art`.`artist_name` AS `artist_name`,`art`.`artist_dob` AS `artist_dob`,`art`.`artist_bio` AS `artist_bio`,`t`.`avgrating` AS `avgrating` from ((`topsongs` `t` join `song_artists` `a` on((`t`.`song_id` = `a`.`song_id`))) join `artist` `art` on((`art`.`artist_id` = `a`.`artist_id`))) order by `t`.`avgrating` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `topsongs`
--

/*!50001 DROP VIEW IF EXISTS `topsongs`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `topsongs` AS select `s`.`song_id` AS `song_id`,`s`.`song_name` AS `song_name`,`s`.`song_release` AS `song_release`,`s`.`song_poster` AS `song_poster`,round(avg(`r`.`rating`),1) AS `avgrating` from (`songs` `s` join `ratings` `r` on((`s`.`song_id` = `r`.`song_id`))) group by `s`.`song_id` order by `avgrating` desc limit 10 */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-06-08 20:45:04
