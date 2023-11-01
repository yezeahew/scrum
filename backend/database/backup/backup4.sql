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
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Hour_Logged`
--

LOCK TABLES `Hour_Logged` WRITE;
/*!40000 ALTER TABLE `Hour_Logged` DISABLE KEYS */;
INSERT INTO `Hour_Logged` VALUES (1,6,1,'2023-09-10 00:00:00',3.10),(2,3,1,'2023-09-18 00:00:00',2.40),(3,10,1,'2023-09-20 00:00:00',4.10),(4,17,2,'2023-09-12 00:00:00',3.60),(5,4,2,'2023-09-09 00:00:00',4.50),(6,7,2,'2023-09-19 00:00:00',6.30),(7,14,2,'2023-09-21 00:00:00',3.10),(8,5,3,'2023-09-12 00:00:00',4.30),(9,8,3,'2023-09-19 00:00:00',4.20),(10,11,3,'2023-09-19 00:00:00',3.30),(11,2,5,'2023-09-11 00:00:00',3.10),(12,1,5,'2023-09-20 00:00:00',3.20),(13,13,5,'2023-09-21 00:00:00',4.10),(14,12,6,'2023-09-18 00:00:00',3.40),(15,15,6,'2023-09-18 00:00:00',5.00),(16,18,6,'2023-09-21 00:00:00',5.00),(17,16,4,'2023-09-16 00:00:00',5.00),(18,9,4,'2023-09-17 00:00:00',4.00),(19,21,2,'2023-10-18 00:00:00',4.00),(20,24,2,'2023-10-19 00:00:00',5.20),(21,25,2,'2023-10-18 00:00:00',4.40),(22,36,2,'2023-10-18 00:00:00',3.20),(23,16,4,'2023-09-13 00:00:00',7.10),(24,19,4,'2023-10-20 00:00:00',3.30),(25,23,4,'2023-10-19 00:00:00',4.40),(26,31,4,'2023-10-20 00:00:00',4.40),(27,32,4,'2023-10-20 00:00:00',3.30),(28,34,4,'2023-10-19 00:00:00',3.30),(29,28,6,'2023-10-20 00:00:00',4.10),(30,26,6,'2023-10-20 00:00:00',4.30),(31,27,6,'2023-10-21 00:00:00',3.50),(32,20,1,'2023-10-18 00:00:00',4.30),(33,22,3,'2023-10-18 00:00:00',5.30);
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Sprint`
--

LOCK TABLES `Sprint` WRITE;
/*!40000 ALTER TABLE `Sprint` DISABLE KEYS */;
INSERT INTO `Sprint` VALUES (1,'Sprint 1','2023-09-09 00:00:00','2023-09-25 00:00:00'),(2,'Sprint2','2023-10-16 00:00:00','2023-10-28 00:00:00'),(3,'Sprint3','2023-10-29 00:00:00','2023-11-10 00:00:00');
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
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Sprint_Task`
--

LOCK TABLES `Sprint_Task` WRITE;
/*!40000 ALTER TABLE `Sprint_Task` DISABLE KEYS */;
INSERT INTO `Sprint_Task` VALUES (1,1,2,'2023-09-13 14:17:53'),(2,1,1,NULL),(3,1,5,'2023-09-17 14:01:17'),(4,1,4,'2023-09-16 14:17:58'),(5,1,6,'2023-09-18 14:18:02'),(6,1,3,'2023-09-13 14:00:58'),(7,1,8,'2023-09-15 14:18:11'),(8,1,7,'2023-09-15 14:18:06'),(9,1,11,'2023-09-17 14:18:21'),(10,1,10,'2023-09-19 14:01:39'),(11,1,12,'2023-09-20 14:18:26'),(12,1,9,'2023-09-15 14:18:16'),(13,1,13,'2023-09-01 00:00:00'),(14,1,14,'2023-09-14 14:18:36'),(15,1,15,'2023-09-15 14:18:41'),(16,1,19,'2023-09-19 14:18:45'),(17,1,22,NULL),(18,1,20,'2023-09-18 14:18:50'),(19,2,17,NULL),(20,2,16,NULL),(21,2,21,'2023-10-17 15:04:44'),(22,2,45,'2023-10-17 15:05:21'),(23,2,18,NULL),(24,2,46,'2023-10-17 15:05:25'),(25,2,48,'2023-10-18 15:04:53'),(26,2,47,'2023-10-18 15:05:33'),(27,2,49,'2023-10-17 15:05:41'),(28,2,50,NULL),(29,2,51,'2023-10-19 15:05:00'),(30,2,52,NULL),(31,2,53,NULL),(32,2,54,NULL),(33,2,55,NULL),(34,2,56,NULL),(35,2,57,NULL),(36,2,58,NULL),(37,3,59,NULL),(38,3,60,NULL),(39,3,61,NULL),(40,3,64,NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Task`
--

LOCK TABLES `Task` WRITE;
/*!40000 ALTER TABLE `Task` DISABLE KEYS */;
INSERT INTO `Task` VALUES (1,'UI for Task Form','story','5','Important','In Progress','stage-planning','Implement the UI of task creation form using Bootstrap according to figma designs.',5,'2023-10-17 05:49:35','N'),(2,'Form Validation','story','3','Important','Completed','stage-planning','Ensure that users input data correctly into the form. Display an error message for any validation failures.',5,'2023-10-17 05:49:35','N'),(3,'Schema Design','story','7','Urgent','Completed','stage-planning','Define the tables and relationships required for the project.',1,'2023-10-17 05:49:35','N'),(4,'MySQL Database Setup','story','6','Important','Completed','stage-planning','Setup the project database on MySQL.',2,'2023-10-17 05:49:35','N'),(5,'Data Insert & Test','story','5','Medium','Completed','stage-planning','Add test data to the database and ensure its functioning as expected.',1,'2023-10-17 05:49:35','N'),(6,'Flask Server Setup','bug','4','Important','Completed','stage-planning','Configure a web server using the Flask framework.',3,'2023-10-17 05:49:35','N'),(7,'Server-DB Connection','story','4','Important','Completed','stage-planning','Ensure that the Flask server can communicate with the project database.',3,'2023-10-17 05:49:35','N'),(8,'Task Creation API','story','6','Urgent','Completed','stage-planning','Develop an API endpoint to process task creation.',2,'2023-10-17 05:49:35','N'),(9,'UI for Backlog','story','5','Medium','Completed','stage-planning','Design the user interface for the product backlog.',6,'2023-10-17 05:49:35','N'),(10,'Tasks List API','story','6','Medium','Completed','stage-planning','Develop an API endpoint to fetch a list of all tasks.',1,'2023-10-17 05:49:35','N'),(11,'UI for Task Details','story','4','Low','Completed','stage-planning','Design the user interface for task details.',4,'2023-10-17 05:49:35','N'),(12,'Task Details API','story','4','Medium','Completed','stage-planning','Develop an API endpoint to fetch details of a specific task.',3,'2023-10-17 05:49:35','N'),(13,'UI for Task Editing','story','5','Medium','Completed','stage-planning','Implement the UI for editing tasks using Bootstrap according to figma designs.',5,'2023-10-17 05:49:35','N'),(14,'Task Editing API','story','5','Medium','Completed','stage-planning','Develop an API endpoint to process task editing.',2,'2023-10-17 05:49:35','N'),(15,'UI for Backlog Assignment','story','4','Low','Completed','stage-planning','Design the user interface for assigning backlog items.',6,'2023-10-17 05:49:35','N'),(16,'Backlog Assignment API','story','5','Medium','In Progress','stage-planning','Develop an API endpoint for backlog item assignment.',1,'2023-10-17 05:49:35','N'),(17,'Task Time Sort','story','4','Low','Not Started','stage-planning','Add functionality to sort tasks based on time.',4,'2023-10-17 05:49:35','N'),(18,'Task Priority Sort','Story','3','Low','Not Started','Planning','Add functionality to sort tasks based on priority.',4,'2023-10-17 05:49:35','N'),(19,'Task Filter by Tags','bug','3','Low','Completed','stage-planning','Add functionality to filter tasks using specific tags.',4,'2023-10-17 05:49:35','N'),(20,'Delete Task Feature','bug','4','Medium','Completed','stage-planning','Design and develop the feature to remove tasks from the system.',6,'2023-10-17 05:49:35','N'),(21,'Task Deletion API','story','5','Medium','Completed','stage-planning','Develop an API endpoint to process task deletion requests.',2,'2023-10-17 05:49:35','N'),(22,'Product Integration','story','8','Urgent','In Progress','stage-planning','Ensure that all components work together for a complete product.',2,'2023-10-17 05:49:35','N'),(45,'Create Sprint FE','story','7','Urgent','Completed','stage-planning','As a team member, I want to create a sprint with essential details.',3,'2023-10-17 06:53:46','N'),(46,'Create Sprint BE','story','7','Urgent','Completed','stage-planning','As a team member, I want to create a sprint with essential details.',2,'2023-10-17 06:53:46','N'),(47,'View Sprints List FE','story','5','Urgent','Completed','stage-planning','As a team member, I want to view the sprints in the scrum board as a list.',6,'2023-10-17 06:53:46','N'),(48,'View Sprints List BE','story','5','Urgent','Completed','stage-planning','As a team member, I want to view the sprints in the scrum board as a list.',2,'2023-10-17 06:53:46','N'),(49,'View Sprint Details FE','story','5','Urgent','Completed','stage-planning','As a team member, I want to view the details of each sprint.',6,'2023-10-17 06:53:46','N'),(50,'View Sprint Details BE','Story','5','Urgent','In Progress','Planning','As a team member, I want to view the details of each sprint.',6,'2023-10-17 06:53:46','N'),(51,'View Burndown Chart FE','story','6','Important','Completed','stage-planning','As a team member, I want to view the burndown chart for each sprint.',5,'2023-10-17 06:53:46','N'),(52,'View Burndown Chart BE','Story','6','Important','Not Started','Planning','As a team member, I want to view the burndown chart for each sprint.',5,'2023-10-17 06:53:46','N'),(53,'Sort Sprints by Date FE','story','4','Low','Not Started','stage-planning','As a team member, I want to sort the sprints by the start date.',4,'2023-10-17 06:53:46','N'),(54,'Sort Sprints by Date BE','Story','4','Low','In Progress','Planning','As a team member, I want to sort the sprints by the start date.',4,'2023-10-17 06:53:46','N'),(55,'Filter Sprints by Stage FE','Story','4','Low','In Progress','Planning','As a team member, I want to filter the sprint by their stage.',4,'2023-10-17 06:53:46','N'),(56,'Filter Sprints by Stage BE','Story','4','Low','In Progress','Planning','As a team member, I want to filter the sprint by their stage.',4,'2023-10-17 06:53:46','N'),(57,'Edit Sprint Details FE','Story','5','Important','Not Started','Planning','As a team member, I want to edit a sprints details.',3,'2023-10-17 06:53:46','N'),(58,'Edit Sprint Details BE','story','5','Important','In Progress','stage-planning','As a team member, I want to edit a sprints details.',2,'2023-10-17 06:53:46','N'),(59,'Add Tasks to Sprint Backlog FE','Story','9','Urgent','Not Started','Planning','As a team member, I want to add tasks from the product backlog to the sprint backlog.',7,'2023-10-17 07:17:45','N'),(60,'Add Tasks to Sprint Backlog BE','Story','9','Urgent','Not Started','Planning','As a team member, I want to add tasks from the product backlog to the sprint backlog.',7,'2023-10-17 07:17:46','N'),(61,'Sort Tasks by Priority in Sprint Backlog FE','Story','4','Medium','Not Started','Planning','As a team member, I want to sort the tasks in the sprint backlog by priority.',3,'2023-10-17 07:17:47','N'),(62,'Sort Tasks by Priority in Sprint Backlog BE','Story','4','Medium','Not Started','Planning','As a team member, I want to sort the tasks in the sprint backlog by priority.',3,'2023-10-17 07:17:48','Y'),(63,'Sort Tasks by Timeline FE','Story','4','Medium','Not Started','Planning','As a team member, I want to sort the tasks in the sprint backlog by timeline.',4,'2023-10-17 07:17:49','Y'),(64,'Sort Tasks by Timeline BE','Story','4','Medium','Not Started','Planning','As a team member, I want to sort the tasks in the sprint backlog by timeline.',4,'2023-10-17 07:17:50','N'),(65,'Filter Tasks by Tags in Sprint Backlog FE','Story','4','Medium','Not Started','Planning','As a team member, I want to filter the tasks in the sprint backlog by tags.',3,'2023-10-17 07:17:51','Y'),(66,'Filter Tasks by Tags in Sprint Backlog BE','Story','4','Medium','Not Started','Planning','As a team member, I want to filter the tasks in the sprint backlog by tags.',3,'2023-10-17 07:17:52','Y'),(67,'Start a Sprint Manually FE','Story','5','Urgent','Not Started','Planning','As a team member, I want to start a sprint manually.',3,'2023-10-17 07:17:53','Y'),(68,'Start a Sprint Manually BE','Story','4','Urgent','Not Started','Planning','As a team member, I want to start a sprint manually.',3,'2023-10-17 07:17:54','Y'),(69,'Edit Tasks in Sprint Backlog FE','Story','4','Urgent','Not Started','Planning','As a team member, I want to be able to edit the tasks at anytime.',7,'2023-10-17 07:17:55','Y'),(70,'Edit Tasks in Sprint Backlog BE','Story','4','Urgent','Not Started','Planning','As a team member, I want to be able to edit the tasks at anytime.',2,'2023-10-17 07:17:56','Y'),(71,'Revoke Tasks to Product Backlog FE','Story','5','Important','Not Started','Planning','As a team member, I want to revoke the tasks to the product backlog before the sprint starts.',7,'2023-10-17 07:17:57','Y'),(72,'Revoke Tasks to Product Backlog BE','Story','5','Important','Not Started','Planning','As a team member, I want to revoke the tasks to the product backlog before the sprint starts.',3,'2023-10-17 07:17:58','Y'),(73,'View Accumulated Effort for Tasks FE','Story','6','Important','Not Started','Planning','As a team member, I want to view accumulation of effort for each task.',5,'2023-10-17 07:17:59','Y'),(74,'View Accumulated Effort for Tasks BE','Story','6','Important','Not Started','Planning','As a team member, I want to view accumulation of effort for each task.',5,'2023-10-17 07:18:40','Y'),(75,'Sort Tasks by Status in Sprint Backlog FE','Story','5','Urgent','Not Started','Planning','As a team member, I want my tasks in the sprint backlog to be sorted by status.',6,'2023-10-17 07:18:41','Y'),(76,'Sort Tasks by Status in Sprint Backlog BE','Story','5','Urgent','Not Started','Planning','As a team member, I want my tasks in the sprint backlog to be sorted by status.',2,'2023-10-17 07:18:42','Y'),(77,'Log Time for Tasks FE','Story','6','Important','Not Started','Planning','As a team member, I want to log the time I spent on a task which I am assigned to.',5,'2023-10-17 07:18:43','Y'),(78,'Log Time for Tasks BE','story','6','Important','Not Started','stage-planning','As a team member, I want to log the time I spent on a task which I am assigned to.',6,'2023-10-17 07:18:44','Y'),(79,'View Task by Clicking on Task Card FE','Story','7','Urgent','Not Started','Planning','As a team member, I want to view the task by clicking on the task card on a sprint backlog.',7,'2023-10-17 07:18:45','Y'),(80,'View Task by Clicking on Task Card BE','Story','7','Urgent','Not Started','Planning','As a team member, I want to view the task by clicking on the task card on a sprint backlog.',6,'2023-10-17 07:17:45','Y');
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
INSERT INTO `Task_Tag` VALUES (1,1),(5,1),(2,2),(4,3),(4,4),(3,5),(4,5),(2,6),(8,6),(2,7),(2,8),(7,8),(1,9),(5,9),(2,10),(7,10),(1,11),(5,11),(2,12),(7,12),(1,13),(5,13),(2,14),(7,14),(1,15),(5,15),(2,16),(7,16),(1,17),(2,17),(1,18),(2,18),(1,19),(2,19),(1,20),(2,20),(2,21),(7,21),(1,22),(2,22),(1,45),(8,45),(2,46),(8,46),(1,47),(8,47),(2,48),(8,48),(1,49),(8,49),(2,50),(8,50),(1,51),(8,51),(2,52),(8,52),(1,53),(8,53),(2,54),(8,54),(1,55),(8,55),(2,56),(8,56),(1,57),(8,57),(2,58),(8,58),(1,59),(3,59),(5,59),(6,59),(2,60),(4,60),(7,60),(1,61),(3,61),(5,61),(6,61),(2,62),(4,62),(7,62),(1,63),(3,63),(5,63),(6,63),(2,64),(4,64),(7,64),(1,65),(3,65),(5,65),(6,65),(2,66),(4,66),(7,66),(1,67),(3,67),(5,67),(6,67),(2,68),(4,68),(7,68),(1,69),(3,69),(5,69),(6,69),(2,70),(4,70),(7,70),(1,71),(3,71),(5,71),(6,71),(2,72),(4,72),(7,72),(1,73),(3,73),(5,73),(6,73),(2,74),(4,74),(7,74),(1,75),(3,75),(5,75),(6,75),(2,76),(4,76),(7,76),(1,77),(3,77),(5,77),(6,77),(2,78),(4,78),(7,78),(1,79),(3,79),(5,79),(6,79),(2,80),(4,80),(7,80);
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
INSERT INTO `User` VALUES (1,'jesshew','jess@hexadivision.com','Jess@123','Team Member'),(2,'ranusha','ranusha@hexadivision.com','Ranusha@123','Team Member'),(3,'huzaima','huzaima@hexadivision.com','Huzaima@123','Team Member'),(4,'ryan','ryan@hexadivision.com','Ryan@123','Team Member'),(5,'lim','lim@hexadivision.com','Lim@123','Team Member'),(6,'hanideepu','hanideepu@hexadivision.com','hani@123','Team Member'),(7,'admin','admin@gmail.com','admin123','Admin');
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

-- Dump completed on 2023-10-17 15:35:33
