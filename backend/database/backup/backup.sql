-- MySQL dump 10.13  Distrib 8.1.0, for macos12.6 (arm64)
--
-- Host: localhost    Database: fit2101
-- ------------------------------------------------------
-- Server version	8.0.33

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
-- Table structure for table `Hour_Logged`
--

DROP TABLE IF EXISTS `Hour_Logged`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Hour_Logged` (
  `hoursLoggedID` int NOT NULL AUTO_INCREMENT,
  `sprintTaskID` int NOT NULL,
  `userID` int NOT NULL,
  `logDate` datetime NOT NULL,
  `hoursLogged` decimal(4,2) NOT NULL,
  PRIMARY KEY (`hoursLoggedID`),
  KEY `sprintTask_hours_fk` (`sprintTaskID`),
  KEY `sprintTaskUserID` (`userID`),
  CONSTRAINT `sprintTask_hours_fk` FOREIGN KEY (`sprintTaskID`) REFERENCES `Sprint_Task` (`sprintTaskID`),
  CONSTRAINT `sprintTaskUserID` FOREIGN KEY (`userID`) REFERENCES `User` (`userID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Hour_Logged`
--

LOCK TABLES `Hour_Logged` WRITE;
/*!40000 ALTER TABLE `Hour_Logged` DISABLE KEYS */;
INSERT INTO `Hour_Logged` VALUES (1,6,1,'2023-09-10 00:00:00',3.10),(2,3,1,'2023-09-18 00:00:00',2.40),(3,10,1,'2023-09-20 00:00:00',4.10);
/*!40000 ALTER TABLE `Hour_Logged` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Sprint`
--

DROP TABLE IF EXISTS `Sprint`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Sprint` (
  `sprintID` int NOT NULL AUTO_INCREMENT,
  `sprintName` varchar(45) NOT NULL,
  `sprintStartDate` datetime DEFAULT NULL,
  `sprintEndDate` datetime DEFAULT NULL,
  PRIMARY KEY (`sprintID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Sprint`
--

LOCK TABLES `Sprint` WRITE;
/*!40000 ALTER TABLE `Sprint` DISABLE KEYS */;
INSERT INTO `Sprint` VALUES (1,'Sprint 1','2023-09-01 00:00:00','2023-10-31 00:00:00');
/*!40000 ALTER TABLE `Sprint` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Sprint_Task`
--

DROP TABLE IF EXISTS `Sprint_Task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Sprint_Task` (
  `sprintTaskID` int NOT NULL AUTO_INCREMENT,
  `sprintID` int NOT NULL,
  `taskID` int NOT NULL,
  `taskCompletedDate` datetime DEFAULT NULL,
  PRIMARY KEY (`sprintTaskID`),
  UNIQUE KEY `taskID` (`taskID`),
  KEY `sprintID_idx` (`sprintID`),
  KEY `taskID_idx` (`taskID`),
  CONSTRAINT `sprint_task_fk` FOREIGN KEY (`sprintID`) REFERENCES `Sprint` (`sprintID`),
  CONSTRAINT `task_sprint_fk` FOREIGN KEY (`taskID`) REFERENCES `Task` (`taskID`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Sprint_Task`
--

LOCK TABLES `Sprint_Task` WRITE;
/*!40000 ALTER TABLE `Sprint_Task` DISABLE KEYS */;
INSERT INTO `Sprint_Task` VALUES (1,1,2,NULL),(2,1,1,NULL),(3,1,5,'2023-10-17 14:01:17'),(4,1,4,NULL),(5,1,6,NULL),(6,1,3,'2023-10-17 14:00:58'),(7,1,8,NULL),(8,1,7,NULL),(9,1,11,NULL),(10,1,10,'2023-10-17 14:01:39'),(11,1,12,NULL),(12,1,9,NULL),(13,1,13,NULL),(14,1,14,NULL),(15,1,15,NULL),(16,1,19,NULL),(17,1,22,NULL),(18,1,20,NULL);
/*!40000 ALTER TABLE `Sprint_Task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `sprint_task_view`
--

DROP TABLE IF EXISTS `sprint_task_view`;
/*!50001 DROP VIEW IF EXISTS `sprint_task_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `sprint_task_view` AS SELECT 
 1 AS `sprintTaskID`,
 1 AS `sprintID`,
 1 AS `taskID`,
 1 AS `taskName`,
 1 AS `taskType`,
 1 AS `taskNumStoryPoint`,
 1 AS `taskPriority`,
 1 AS `taskStatus`,
 1 AS `taskStage`,
 1 AS `taskDesc`,
 1 AS `assigneeID`,
 1 AS `taskDateCreated`,
 1 AS `taskTags`,
 1 AS `sprintStatus`,
 1 AS `sprintStartDate`,
 1 AS `sprintEndDate`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `sprint_view`
--

DROP TABLE IF EXISTS `sprint_view`;
/*!50001 DROP VIEW IF EXISTS `sprint_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `sprint_view` AS SELECT 
 1 AS `sprintID`,
 1 AS `sprintName`,
 1 AS `sprintStatus`,
 1 AS `sprintStartDate`,
 1 AS `sprintEndDate`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `sprintview`
--

DROP TABLE IF EXISTS `sprintview`;
/*!50001 DROP VIEW IF EXISTS `sprintview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `sprintview` AS SELECT 
 1 AS `sprintID`,
 1 AS `sprintName`,
 1 AS `sprintStatus`,
 1 AS `sprintStartDate`,
 1 AS `sprintEndDate`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `Tag`
--

DROP TABLE IF EXISTS `Tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Tag` (
  `tagID` int NOT NULL AUTO_INCREMENT,
  `tagName` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`tagID`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Tag`
--

LOCK TABLES `Tag` WRITE;
/*!40000 ALTER TABLE `Tag` DISABLE KEYS */;
INSERT INTO `Tag` VALUES (1,'Front End'),(2,'Back End'),(3,'Testing'),(4,'Database'),(5,'UI'),(6,'UX'),(7,'API'),(8,'Framework');
/*!40000 ALTER TABLE `Tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Task`
--

DROP TABLE IF EXISTS `Task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Task` (
  `taskID` int NOT NULL AUTO_INCREMENT,
  `taskName` varchar(45) NOT NULL,
  `taskType` varchar(45) NOT NULL,
  `taskNumStoryPoint` varchar(45) NOT NULL,
  `taskPriority` varchar(45) NOT NULL,
  `taskStatus` varchar(45) NOT NULL,
  `taskStage` varchar(45) NOT NULL,
  `taskDesc` varchar(500) DEFAULT NULL,
  `assigneeID` int DEFAULT NULL,
  `taskDateCreated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `taskActive` char(1) DEFAULT 'Y',
  PRIMARY KEY (`taskID`),
  KEY `user_task_fk_idx` (`assigneeID`),
  CONSTRAINT `user_task_fk` FOREIGN KEY (`assigneeID`) REFERENCES `User` (`userID`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Task`
--

LOCK TABLES `Task` WRITE;
/*!40000 ALTER TABLE `Task` DISABLE KEYS */;
INSERT INTO `Task` VALUES (1,'UI for Task Form','story','5','Important','In Progress','stage-planning','Implement the UI of task creation form using Bootstrap according to figma designs.',5,'2023-10-17 05:49:35','N'),(2,'Form Validation','Story','3','Important','Not Started','Planning','Ensure that users input data correctly into the form. Display an error message for any validation failures.',5,'2023-10-17 05:49:35','N'),(3,'Schema Design','story','7','Urgent','Completed','stage-planning','Define the tables and relationships required for the project.',1,'2023-10-17 05:49:35','N'),(4,'MySQL Database Setup','Story','6','Important','Not Started','Planning','Setup the project database on MySQL.',2,'2023-10-17 05:49:35','N'),(5,'Data Insert & Test','story','5','Medium','Completed','stage-planning','Add test data to the database and ensure its functioning as expected.',1,'2023-10-17 05:49:35','N'),(6,'Flask Server Setup','Bug','4','Important','Not Started','Planning','Configure a web server using the Flask framework.',3,'2023-10-17 05:49:35','N'),(7,'Server-DB Connection','Story','4','Important','Not Started','Planning','Ensure that the Flask server can communicate with the project database.',3,'2023-10-17 05:49:35','N'),(8,'Task Creation API','Story','6','Urgent','Not Started','Planning','Develop an API endpoint to process task creation.',2,'2023-10-17 05:49:35','N'),(9,'UI for Backlog','Story','5','Medium','Not Started','Planning','Design the user interface for the product backlog.',6,'2023-10-17 05:49:35','N'),(10,'Tasks List API','story','6','Medium','Completed','stage-planning','Develop an API endpoint to fetch a list of all tasks.',1,'2023-10-17 05:49:35','N'),(11,'UI for Task Details','Story','4','Low','Not Started','Planning','Design the user interface for task details.',4,'2023-10-17 05:49:35','N'),(12,'Task Details API','Story','4','Medium','Not Started','Planning','Develop an API endpoint to fetch details of a specific task.',3,'2023-10-17 05:49:35','N'),(13,'UI for Task Editing','Story','5','Medium','Not Started','Planning','Implement the UI for editing tasks using Bootstrap according to figma designs.',5,'2023-10-17 05:49:35','N'),(14,'Task Editing API','Story','5','Medium','Not Started','Planning','Develop an API endpoint to process task editing.',2,'2023-10-17 05:49:35','N'),(15,'UI for Backlog Assignment','Story','4','Low','Not Started','Planning','Design the user interface for assigning backlog items.',6,'2023-10-17 05:49:35','N'),(16,'Backlog Assignment API','Story','5','Medium','Not Started','Planning','Develop an API endpoint for backlog item assignment.',7,'2023-10-17 05:49:35','Y'),(17,'Task Time Sort','Story','4','Low','Not Started','Planning','Add functionality to sort tasks based on time.',4,'2023-10-17 05:49:35','Y'),(18,'Task Priority Sort','Story','3','Low','Not Started','Planning','Add functionality to sort tasks based on priority.',4,'2023-10-17 05:49:35','Y'),(19,'Task Filter by Tags','Bug','3','Low','Not Started','Planning','Add functionality to filter tasks using specific tags.',4,'2023-10-17 05:49:35','N'),(20,'Delete Task Feature','Bug','4','Medium','Not Started','Planning','Design and develop the feature to remove tasks from the system.',6,'2023-10-17 05:49:35','N'),(21,'Task Deletion API','Story','5','Medium','Not Started','Planning','Develop an API endpoint to process task deletion requests.',2,'2023-10-17 05:49:35','Y'),(22,'Product Integration','Story','8','Urgent','Not Started','Planning','Ensure that all components work together for a complete product.',2,'2023-10-17 05:49:35','N'),(23,'UI for Task Form','Story','5','Important','Not Started','Planning','Implement the UI of task creation form using Bootstrap according to figma designs.',5,'2023-10-17 05:55:54','Y'),(24,'Form Validation','Story','3','Important','Not Started','Planning','Ensure that users input data correctly into the form. Display an error message for any validation failures.',5,'2023-10-17 05:55:54','Y'),(25,'Schema Design','Story','7','Urgent','Not Started','Planning','Define the tables and relationships required for the project.',7,'2023-10-17 05:55:54','Y'),(26,'MySQL Database Setup','Story','6','Important','Not Started','Planning','Setup the project database on MySQL.',2,'2023-10-17 05:55:54','Y'),(27,'Data Insert & Test','Story','5','Medium','Not Started','Planning','Add test data to the database and ensure its functioning as expected.',7,'2023-10-17 05:55:54','Y'),(28,'Flask Server Setup','Bug','4','Important','Not Started','Planning','Configure a web server using the Flask framework.',3,'2023-10-17 05:55:54','Y'),(29,'Server-DB Connection','Story','4','Important','Not Started','Planning','Ensure that the Flask server can communicate with the project database.',3,'2023-10-17 05:55:54','Y'),(30,'Task Creation API','Story','6','Urgent','Not Started','Planning','Develop an API endpoint to process task creation.',2,'2023-10-17 05:55:54','Y'),(31,'UI for Backlog','Story','5','Medium','Not Started','Planning','Design the user interface for the product backlog.',6,'2023-10-17 05:55:54','Y'),(32,'Tasks List API','Story','6','Medium','Not Started','Planning','Develop an API endpoint to fetch a list of all tasks.',7,'2023-10-17 05:55:54','Y'),(33,'UI for Task Details','Story','4','Low','Not Started','Planning','Design the user interface for task details.',4,'2023-10-17 05:55:54','Y'),(34,'Task Details API','Story','4','Medium','Not Started','Planning','Develop an API endpoint to fetch details of a specific task.',3,'2023-10-17 05:55:54','Y'),(35,'UI for Task Editing','Story','5','Medium','Not Started','Planning','Implement the UI for editing tasks using Bootstrap according to figma designs.',5,'2023-10-17 05:55:54','Y'),(36,'Task Editing API','Story','5','Medium','Not Started','Planning','Develop an API endpoint to process task editing.',2,'2023-10-17 05:55:54','Y'),(37,'UI for Backlog Assignment','Story','4','Low','Not Started','Planning','Design the user interface for assigning backlog items.',6,'2023-10-17 05:55:54','Y'),(38,'Backlog Assignment API','Story','5','Medium','Not Started','Planning','Develop an API endpoint for backlog item assignment.',7,'2023-10-17 05:55:54','Y'),(39,'Task Time Sort','Story','4','Low','Not Started','Planning','Add functionality to sort tasks based on time.',4,'2023-10-17 05:55:54','Y'),(40,'Task Priority Sort','Story','3','Low','Not Started','Planning','Add functionality to sort tasks based on priority.',4,'2023-10-17 05:55:54','Y'),(41,'Task Filter by Tags','Bug','3','Low','Not Started','Planning','Add functionality to filter tasks using specific tags.',4,'2023-10-17 05:55:54','Y'),(42,'Delete Task Feature','Bug','4','Medium','Not Started','Planning','Design and develop the feature to remove tasks from the system.',6,'2023-10-17 05:55:54','Y'),(43,'Task Deletion API','Story','5','Medium','Not Started','Planning','Develop an API endpoint to process task deletion requests.',2,'2023-10-17 05:55:54','Y'),(44,'Product Integration','Story','8','Urgent','Not Started','Planning','Ensure that all components work together for a complete product.',2,'2023-10-17 05:55:54','Y');
/*!40000 ALTER TABLE `Task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Task_Tag`
--

DROP TABLE IF EXISTS `Task_Tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Task_Tag` (
  `tag_ID` int NOT NULL,
  `task_ID` int NOT NULL,
  PRIMARY KEY (`tag_ID`,`task_ID`),
  KEY `taskID_idx` (`task_ID`),
  CONSTRAINT `tag_task_fk` FOREIGN KEY (`tag_ID`) REFERENCES `Tag` (`tagID`),
  CONSTRAINT `task_tag_fk` FOREIGN KEY (`task_ID`) REFERENCES `Task` (`taskID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Task_Tag`
--

LOCK TABLES `Task_Tag` WRITE;
/*!40000 ALTER TABLE `Task_Tag` DISABLE KEYS */;
INSERT INTO `Task_Tag` VALUES (1,1),(5,1),(2,2),(4,3),(4,4),(3,5),(4,5),(2,6),(8,6),(2,7),(2,8),(7,8),(1,9),(5,9),(2,10),(7,10),(1,11),(5,11),(2,12),(7,12),(1,13),(5,13),(2,14),(7,14),(1,15),(5,15),(2,16),(7,16),(1,17),(2,17),(1,18),(2,18),(1,19),(2,19),(1,20),(2,20),(2,21),(7,21),(1,22),(2,22);
/*!40000 ALTER TABLE `Task_Tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `task_view`
--

DROP TABLE IF EXISTS `task_view`;
/*!50001 DROP VIEW IF EXISTS `task_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `task_view` AS SELECT 
 1 AS `taskID`,
 1 AS `taskName`,
 1 AS `taskType`,
 1 AS `taskNumStoryPoint`,
 1 AS `taskPriority`,
 1 AS `taskStatus`,
 1 AS `taskStage`,
 1 AS `taskDesc`,
 1 AS `taskTags`,
 1 AS `assigneeID`,
 1 AS `assigneeName`,
 1 AS `taskDateCreated`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `User`
--

DROP TABLE IF EXISTS `User`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `User` (
  `userID` int NOT NULL AUTO_INCREMENT,
  `userName` varchar(45) NOT NULL,
  `userEmail` varchar(45) NOT NULL,
  `userPassword` varchar(45) NOT NULL,
  `userRole` varchar(45) NOT NULL,
  PRIMARY KEY (`userID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User`
--

LOCK TABLES `User` WRITE;
/*!40000 ALTER TABLE `User` DISABLE KEYS */;
INSERT INTO `User` VALUES (1,'jesshew','jess@hexadivision.com','Jess@123','Team Member'),(2,'ranusha','ranusha@hexadivision.com','Ranusha@123','Team Member'),(3,'huzaima','huzaima@hexadivision.com','Huzaima@123','Team Member'),(4,'ryan','ryan@hexadivision.com','Ryan@123','Team Member'),(5,'lim','lim@hexadivision.com','Lim@123','Team Member'),(6,'hanideepu','hanideepu@hexadivision.com','Hanideepu@123','Team Member'),(7,'admin','admin@gmail.com','admin123','Admin');
/*!40000 ALTER TABLE `User` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `user_average_hours`
--

DROP TABLE IF EXISTS `user_average_hours`;
/*!50001 DROP VIEW IF EXISTS `user_average_hours`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `user_average_hours` AS SELECT 
 1 AS `userID`,
 1 AS `userName`,
 1 AS `logDate`,
 1 AS `hoursLogged`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `user_hours_logged`
--

DROP TABLE IF EXISTS `user_hours_logged`;
/*!50001 DROP VIEW IF EXISTS `user_hours_logged`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `user_hours_logged` AS SELECT 
 1 AS `userID`,
 1 AS `userName`,
 1 AS `userEmail`,
 1 AS `logDate`,
 1 AS `hoursLogged`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `sprint_task_view`
--

/*!50001 DROP VIEW IF EXISTS `sprint_task_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `sprint_task_view` AS select `st`.`sprintTaskID` AS `sprintTaskID`,`st`.`sprintID` AS `sprintID`,`tvt`.`taskID` AS `taskID`,`tvt`.`taskName` AS `taskName`,`tvt`.`taskType` AS `taskType`,`tvt`.`taskNumStoryPoint` AS `taskNumStoryPoint`,`tvt`.`taskPriority` AS `taskPriority`,`tvt`.`taskStatus` AS `taskStatus`,`tvt`.`taskStage` AS `taskStage`,`tvt`.`taskDesc` AS `taskDesc`,`tvt`.`assigneeID` AS `assigneeID`,`tvt`.`taskDateCreated` AS `taskDateCreated`,`tvt`.`taskTags` AS `taskTags`,`s`.`sprintStatus` AS `sprintStatus`,`s`.`sprintStartDate` AS `sprintStartDate`,`s`.`sprintEndDate` AS `sprintEndDate` from ((`sprint_task` `st` join `sprint_view` `s` on((`s`.`sprintID` = `st`.`sprintID`))) join `task_view` `tvt` on((`st`.`taskID` = `tvt`.`taskID`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `sprint_view`
--

/*!50001 DROP VIEW IF EXISTS `sprint_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `sprint_view` AS select `sprint`.`sprintID` AS `sprintID`,`sprint`.`sprintName` AS `sprintName`,(case when ((`sprint`.`sprintStartDate` is null) or (`sprint`.`sprintEndDate` is null)) then 'Not Started' when (curdate() < `sprint`.`sprintStartDate`) then 'Not Started' when (curdate() between `sprint`.`sprintStartDate` and `sprint`.`sprintEndDate`) then 'Active' when (curdate() > `sprint`.`sprintEndDate`) then 'Completed' else 'Not Started' end) AS `sprintStatus`,(case when (`sprint`.`sprintStartDate` is not null) then date_format(`sprint`.`sprintStartDate`,'%d-%m-%Y') else 'Not Set' end) AS `sprintStartDate`,(case when (`sprint`.`sprintEndDate` is not null) then date_format(`sprint`.`sprintEndDate`,'%d-%m-%Y') else 'Not Set' end) AS `sprintEndDate` from `sprint` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `sprintview`
--

/*!50001 DROP VIEW IF EXISTS `sprintview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `sprintview` AS select `sprint`.`sprintID` AS `sprintID`,`sprint`.`sprintName` AS `sprintName`,(case when ((`sprint`.`sprintStartDate` is null) or (`sprint`.`sprintEndDate` is null)) then 'Not Started' when (curdate() < `sprint`.`sprintStartDate`) then 'Not Started' when (curdate() between `sprint`.`sprintStartDate` and `sprint`.`sprintEndDate`) then 'Active' when (curdate() > `sprint`.`sprintEndDate`) then 'Completed' else 'Not Started' end) AS `sprintStatus`,(case when (`sprint`.`sprintStartDate` is not null) then date_format(`sprint`.`sprintStartDate`,'%d-%m-%Y') else 'Not Set' end) AS `sprintStartDate`,(case when (`sprint`.`sprintEndDate` is not null) then date_format(`sprint`.`sprintEndDate`,'%d-%m-%Y') else 'Not Set' end) AS `sprintEndDate` from `sprint` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `task_view`
--

/*!50001 DROP VIEW IF EXISTS `task_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `task_view` AS select `t`.`taskID` AS `taskID`,`t`.`taskName` AS `taskName`,`t`.`taskType` AS `taskType`,`t`.`taskNumStoryPoint` AS `taskNumStoryPoint`,`t`.`taskPriority` AS `taskPriority`,`t`.`taskStatus` AS `taskStatus`,`t`.`taskStage` AS `taskStage`,`t`.`taskDesc` AS `taskDesc`,group_concat(`tag`.`tagName` order by `tag`.`tagName` ASC separator ',') AS `taskTags`,`t`.`assigneeID` AS `assigneeID`,`u`.`userName` AS `assigneeName`,`t`.`taskDateCreated` AS `taskDateCreated` from (((`task` `t` left join `task_tag` `tt` on((`t`.`taskID` = `tt`.`task_ID`))) left join `tag` on((`tt`.`tag_ID` = `tag`.`tagID`))) left join `user` `u` on((`t`.`assigneeID` = `u`.`userID`))) group by `t`.`taskID` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `user_average_hours`
--

/*!50001 DROP VIEW IF EXISTS `user_average_hours`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `user_average_hours` AS select `u`.`userID` AS `userID`,`u`.`userName` AS `userName`,`h`.`logDate` AS `logDate`,`h`.`hoursLogged` AS `hoursLogged` from (`user` `u` join `hour_logged` `h` on((`u`.`userID` = `h`.`userID`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `user_hours_logged`
--

/*!50001 DROP VIEW IF EXISTS `user_hours_logged`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `user_hours_logged` AS select `u`.`userID` AS `userID`,`u`.`userName` AS `userName`,`u`.`userEmail` AS `userEmail`,`h`.`logDate` AS `logDate`,`h`.`hoursLogged` AS `hoursLogged` from (`user` `u` join `hour_logged` `h` on((`u`.`userID` = `h`.`userID`))) */;
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

-- Dump completed on 2023-10-17 14:10:43
