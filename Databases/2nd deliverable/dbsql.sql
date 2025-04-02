DROP SCHEMA IF EXISTS `neurosync_db`;
CREATE SCHEMA `neurosync_db`;
USE `neurosync_db`;
-- MySQL dump 10.13  Distrib 8.0.25, for Win64 (x86_64)
--
-- Host: localhost    Database: neurosync_db
-- ------------------------------------------------------
-- Server version	8.0.25

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
-- Table structure for table `activated_neurons`
--

DROP TABLE IF EXISTS `activated_neurons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `activated_neurons` (
  `activationID` int NOT NULL,
  `neuronID` int DEFAULT NULL,
  `experimentID` int DEFAULT NULL,
  `duration` float DEFAULT NULL,
  `activationStrength` float DEFAULT NULL,
  PRIMARY KEY (`activationID`),
  KEY `neuronID` (`neuronID`),
  KEY `experimentID` (`experimentID`),
  CONSTRAINT `activated_neurons_ibfk_1` FOREIGN KEY (`neuronID`) REFERENCES `neurons` (`neuronID`),
  CONSTRAINT `activated_neurons_ibfk_2` FOREIGN KEY (`experimentID`) REFERENCES `experiments` (`experimentID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activated_neurons`
--

LOCK TABLES `activated_neurons` WRITE;
/*!40000 ALTER TABLE `activated_neurons` DISABLE KEYS */;
INSERT INTO `activated_neurons` VALUES (6029,4015,5012,10,1.2),(6061,4088,5033,5,0.8),(6205,4203,5208,15,1.5);
/*!40000 ALTER TABLE `activated_neurons` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `activated_neurons_BEFORE_INSERT` BEFORE INSERT ON `activated_neurons` FOR EACH ROW BEGIN
	IF (NEW.duration < 0) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'invalid data';
	END IF;
    
	IF (NEW.activationStrength < 0) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'invalid data';
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `activated_neurons_BEFORE_UPDATE` BEFORE UPDATE ON `activated_neurons` FOR EACH ROW BEGIN
	IF (NEW.duration < 0) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'invalid data';
	END IF;
    
	IF (NEW.activationStrength < 0) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'invalid data';
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `brain_regions`
--

DROP TABLE IF EXISTS `brain_regions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `brain_regions` (
  `regionID` int NOT NULL,
  `regionName` varchar(25) DEFAULT NULL,
  `regionFunction` varchar(25) DEFAULT NULL,
  `regionDescription` text,
  PRIMARY KEY (`regionID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `brain_regions`
--

LOCK TABLES `brain_regions` WRITE;
/*!40000 ALTER TABLE `brain_regions` DISABLE KEYS */;
INSERT INTO `brain_regions` VALUES (3005,'Hippocampus','Memory Processing','Region associated with memory'),(3021,'Cortex','Sensory Processing','Process sensory inputs'),(3099,'Amygdala','Emotion Processing','Key role in emotions and fear');
/*!40000 ALTER TABLE `brain_regions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `emitted_neurotransmitters`
--

DROP TABLE IF EXISTS `emitted_neurotransmitters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `emitted_neurotransmitters` (
  `emissionID` int NOT NULL,
  `activationID` int DEFAULT NULL,
  `neurotransmitterID` int DEFAULT NULL,
  `concentration` float DEFAULT NULL,
  PRIMARY KEY (`emissionID`),
  KEY `activationID` (`activationID`),
  KEY `neurotransmitterID` (`neurotransmitterID`),
  CONSTRAINT `emitted_neurotransmitters_ibfk_1` FOREIGN KEY (`activationID`) REFERENCES `activated_neurons` (`activationID`),
  CONSTRAINT `emitted_neurotransmitters_ibfk_2` FOREIGN KEY (`neurotransmitterID`) REFERENCES `neurotransmitters` (`neurotransmitterID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `emitted_neurotransmitters`
--

LOCK TABLES `emitted_neurotransmitters` WRITE;
/*!40000 ALTER TABLE `emitted_neurotransmitters` DISABLE KEYS */;
INSERT INTO `emitted_neurotransmitters` VALUES (9003,6029,8001,0.15),(9057,6061,8020,0.1),(9102,6205,8125,0.2);
/*!40000 ALTER TABLE `emitted_neurotransmitters` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `emitted_neurotransmitters_BEFORE_INSERT` BEFORE INSERT ON `emitted_neurotransmitters` FOR EACH ROW BEGIN
	IF (NEW.concentration < 0) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'invalid data';
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `emitted_neurotransmitters_BEFORE_UPDATE` BEFORE UPDATE ON `emitted_neurotransmitters` FOR EACH ROW BEGIN
	IF (NEW.concentration < 0) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'invalid data';
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `experiment_observations`
--

DROP TABLE IF EXISTS `experiment_observations`;
/*!50001 DROP VIEW IF EXISTS `experiment_observations`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `experiment_observations` AS SELECT 
 1 AS `experimentID`,
 1 AS `stimulusType`,
 1 AS `SubjectSpecies`,
 1 AS `observation`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `experiment_results`
--

DROP TABLE IF EXISTS `experiment_results`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `experiment_results` (
  `resultID` int NOT NULL,
  `experimentID` int DEFAULT NULL,
  `resultDescription` text,
  `significanceScore` float DEFAULT NULL,
  PRIMARY KEY (`resultID`),
  KEY `experimentID` (`experimentID`),
  CONSTRAINT `experiment_results_ibfk_1` FOREIGN KEY (`experimentID`) REFERENCES `experiments` (`experimentID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `experiment_results`
--

LOCK TABLES `experiment_results` WRITE;
/*!40000 ALTER TABLE `experiment_results` DISABLE KEYS */;
INSERT INTO `experiment_results` VALUES (10002,5012,'Increased activity in neurons',0.95),(10019,5033,'Minimal response observed',0.2),(10085,5208,'Temporary alertness improvement',0.85);
/*!40000 ALTER TABLE `experiment_results` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `experiment_results_BEFORE_INSERT` BEFORE INSERT ON `experiment_results` FOR EACH ROW BEGIN
	IF (NEW.significanceScore < 0) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'invalid data';
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `experiment_results_BEFORE_UPDATE` BEFORE UPDATE ON `experiment_results` FOR EACH ROW BEGIN
	IF (NEW.significanceScore < 0) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'invalid data';
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `experiments`
--

DROP TABLE IF EXISTS `experiments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `experiments` (
  `experimentID` int NOT NULL,
  `subjectID` int DEFAULT NULL,
  `stimulusID` int DEFAULT NULL,
  `experimentDateTime` datetime DEFAULT NULL,
  `observation` text,
  PRIMARY KEY (`experimentID`),
  KEY `subjectID` (`subjectID`),
  KEY `stimulusID` (`stimulusID`),
  CONSTRAINT `experiments_ibfk_1` FOREIGN KEY (`subjectID`) REFERENCES `subjects` (`subjectID`),
  CONSTRAINT `experiments_ibfk_2` FOREIGN KEY (`stimulusID`) REFERENCES `stimuli` (`stimulusID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `experiments`
--

LOCK TABLES `experiments` WRITE;
/*!40000 ALTER TABLE `experiments` DISABLE KEYS */;
INSERT INTO `experiments` VALUES (5012,2003,1001,'2024-11-01 17:10:03','Significant increase in activity'),(5033,2010,1057,'2024-10-20 19:55:10','No observable change'),(5208,2507,1103,'2024-09-25 11:30:25','Temporary increase in alertness');
/*!40000 ALTER TABLE `experiments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `long_activations`
--

DROP TABLE IF EXISTS `long_activations`;
/*!50001 DROP VIEW IF EXISTS `long_activations`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `long_activations` AS SELECT 
 1 AS `activationID`,
 1 AS `neuronID`,
 1 AS `experimentID`,
 1 AS `activationStrength`,
 1 AS `duration`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `neurons`
--

DROP TABLE IF EXISTS `neurons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `neurons` (
  `neuronID` int NOT NULL,
  `regionID` int DEFAULT NULL,
  `neuronType` varchar(25) DEFAULT NULL,
  `thresholdPotential` float DEFAULT NULL,
  PRIMARY KEY (`neuronID`),
  KEY `regionID` (`regionID`),
  CONSTRAINT `neurons_ibfk_1` FOREIGN KEY (`regionID`) REFERENCES `brain_regions` (`regionID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `neurons`
--

LOCK TABLES `neurons` WRITE;
/*!40000 ALTER TABLE `neurons` DISABLE KEYS */;
INSERT INTO `neurons` VALUES (4015,3005,'Pyramidal',-55),(4088,3021,'Interneuron',-60),(4203,3099,'MotorNeuron',-52);
/*!40000 ALTER TABLE `neurons` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `neurons_BEFORE_INSERT` BEFORE INSERT ON `neurons` FOR EACH ROW BEGIN
	IF (NEW.thresholdPotential > 0) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'invalid data';
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `neurons_BEFORE_UPDATE` BEFORE UPDATE ON `neurons` FOR EACH ROW BEGIN
	IF (NEW.thresholdPotential > 0) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'invalid data';
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `neurotransmitters`
--

DROP TABLE IF EXISTS `neurotransmitters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `neurotransmitters` (
  `neurotransmitterID` int NOT NULL,
  `neurotransmitterName` varchar(25) DEFAULT NULL,
  `effectType` varchar(25) DEFAULT NULL,
  `neurotransmitterDescription` text,
  PRIMARY KEY (`neurotransmitterID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `neurotransmitters`
--

LOCK TABLES `neurotransmitters` WRITE;
/*!40000 ALTER TABLE `neurotransmitters` DISABLE KEYS */;
INSERT INTO `neurotransmitters` VALUES (8001,'Dopamine','Excilatory','Increases neural activation'),(8020,'GABA','Inhibitory','Reduces neural activation'),(8125,'Serotonin','Modulatory','Regulates mood and behavior');
/*!40000 ALTER TABLE `neurotransmitters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `neurotransmitters_stimuli`
--

DROP TABLE IF EXISTS `neurotransmitters_stimuli`;
/*!50001 DROP VIEW IF EXISTS `neurotransmitters_stimuli`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `neurotransmitters_stimuli` AS SELECT 
 1 AS `neurotransmitterID`,
 1 AS `stimulusName`,
 1 AS `stimulusID`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `region_experiments`
--

DROP TABLE IF EXISTS `region_experiments`;
/*!50001 DROP VIEW IF EXISTS `region_experiments`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `region_experiments` AS SELECT 
 1 AS `regionName`,
 1 AS `experimentID`,
 1 AS `observation`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `region_threshold_avg`
--

DROP TABLE IF EXISTS `region_threshold_avg`;
/*!50001 DROP VIEW IF EXISTS `region_threshold_avg`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `region_threshold_avg` AS SELECT 
 1 AS `regionName`,
 1 AS `regionDescription`,
 1 AS `AvgThreshold`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `stimuli`
--

DROP TABLE IF EXISTS `stimuli`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stimuli` (
  `stimulusID` int NOT NULL,
  `stimulusType` varchar(25) DEFAULT NULL,
  `stimulusName` varchar(25) DEFAULT NULL,
  `stimulusDescription` text,
  `intensityOrDose` float DEFAULT NULL,
  PRIMARY KEY (`stimulusID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stimuli`
--

LOCK TABLES `stimuli` WRITE;
/*!40000 ALTER TABLE `stimuli` DISABLE KEYS */;
INSERT INTO `stimuli` VALUES (1001,'Chemical','Dopamine','Neurotransmitter stimulus',5.2),(1057,'Electrical','Shock','Short electrical pulse',3),(1103,'Visual','Light Flash','High-intensity white light',2.5);
/*!40000 ALTER TABLE `stimuli` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `stimuli_BEFORE_INSERT` BEFORE INSERT ON `stimuli` FOR EACH ROW BEGIN
	IF (NEW.intensityOrDose < 0) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'invalid data';
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `stimuli_BEFORE_UPDATE` BEFORE UPDATE ON `stimuli` FOR EACH ROW BEGIN
	IF (NEW.intensityOrDose < 0) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'invalid data';
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `subjects`
--

DROP TABLE IF EXISTS `subjects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subjects` (
  `subjectID` int NOT NULL,
  `species` varchar(25) DEFAULT NULL,
  `age` int DEFAULT NULL,
  `gender` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`subjectID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subjects`
--

LOCK TABLES `subjects` WRITE;
/*!40000 ALTER TABLE `subjects` DISABLE KEYS */;
INSERT INTO `subjects` VALUES (2003,'Rat',12,'Male'),(2010,'Mouse',8,'Female'),(2507,'Human',25,'Male');
/*!40000 ALTER TABLE `subjects` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `subjects_BEFORE_INSERT` BEFORE INSERT ON `subjects` FOR EACH ROW BEGIN
	IF (NEW.age < 0) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'invalid data';
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `subjects_BEFORE_UPDATE` BEFORE UPDATE ON `subjects` FOR EACH ROW BEGIN
	IF (NEW.age < 0) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'invalid data';
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `synapses`
--

DROP TABLE IF EXISTS `synapses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `synapses` (
  `synapseID` int NOT NULL,
  `PreSynapticNeuronID` int DEFAULT NULL,
  `PostSynapticNeuronID` int DEFAULT NULL,
  `strength` float DEFAULT NULL,
  PRIMARY KEY (`synapseID`),
  KEY `PreSynapticNeuronID` (`PreSynapticNeuronID`),
  KEY `PostSynapticNeuronID` (`PostSynapticNeuronID`),
  CONSTRAINT `synapses_ibfk_1` FOREIGN KEY (`PreSynapticNeuronID`) REFERENCES `neurons` (`neuronID`),
  CONSTRAINT `synapses_ibfk_2` FOREIGN KEY (`PostSynapticNeuronID`) REFERENCES `neurons` (`neuronID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `synapses`
--

LOCK TABLES `synapses` WRITE;
/*!40000 ALTER TABLE `synapses` DISABLE KEYS */;
INSERT INTO `synapses` VALUES (7002,4015,4088,0.75),(7098,4088,4203,0.65),(7205,4203,4015,0.85);
/*!40000 ALTER TABLE `synapses` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `synapses_BEFORE_INSERT` BEFORE INSERT ON `synapses` FOR EACH ROW BEGIN
	IF (NEW.strength < 0) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'invalid data';
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `synapses_BEFORE_UPDATE` BEFORE UPDATE ON `synapses` FOR EACH ROW BEGIN
	IF (NEW.strength < 0) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'invalid data';
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `experiment_observations`
--

/*!50001 DROP VIEW IF EXISTS `experiment_observations`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `experiment_observations` AS select `e`.`experimentID` AS `experimentID`,`s`.`stimulusType` AS `stimulusType`,`sub`.`species` AS `SubjectSpecies`,`e`.`observation` AS `observation` from ((`experiments` `e` join `stimuli` `s` on((`e`.`stimulusID` = `s`.`stimulusID`))) join `subjects` `sub` on((`e`.`subjectID` = `sub`.`subjectID`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `long_activations`
--

/*!50001 DROP VIEW IF EXISTS `long_activations`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `long_activations` AS select `an`.`activationID` AS `activationID`,`an`.`neuronID` AS `neuronID`,`an`.`experimentID` AS `experimentID`,`an`.`activationStrength` AS `activationStrength`,`an`.`duration` AS `duration` from `activated_neurons` `an` where (`an`.`duration` > 10.0) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `neurotransmitters_stimuli`
--

/*!50001 DROP VIEW IF EXISTS `neurotransmitters_stimuli`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `neurotransmitters_stimuli` AS select `en`.`neurotransmitterID` AS `neurotransmitterID`,`st`.`stimulusName` AS `stimulusName`,`st`.`stimulusID` AS `stimulusID` from (((`emitted_neurotransmitters` `en` join `activated_neurons` `an` on((`en`.`activationID` = `an`.`activationID`))) join `experiments` `e` on((`an`.`experimentID` = `e`.`experimentID`))) join `stimuli` `st` on((`e`.`stimulusID` = `st`.`stimulusID`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `region_experiments`
--

/*!50001 DROP VIEW IF EXISTS `region_experiments`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `region_experiments` AS select `br`.`regionName` AS `regionName`,`e`.`experimentID` AS `experimentID`,`e`.`observation` AS `observation` from (((`brain_regions` `br` join `neurons` `n` on((`br`.`regionID` = `n`.`regionID`))) join `activated_neurons` `an` on((`n`.`neuronID` = `an`.`neuronID`))) join `experiments` `e` on((`an`.`experimentID` = `e`.`experimentID`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `region_threshold_avg`
--

/*!50001 DROP VIEW IF EXISTS `region_threshold_avg`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `region_threshold_avg` AS select `br`.`regionName` AS `regionName`,`br`.`regionDescription` AS `regionDescription`,avg(`n`.`thresholdPotential`) AS `AvgThreshold` from (`brain_regions` `br` join `neurons` `n` on((`br`.`regionID` = `n`.`regionID`))) group by `br`.`regionName`,`br`.`regionDescription` */;
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

-- Dump completed on 2024-12-24 13:56:37
