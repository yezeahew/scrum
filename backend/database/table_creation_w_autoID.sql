-- Change Log:
-- Date : 8/Oct
-- Changes: Remove sprint status and create sprint view
-- Changes made by : Jess

USE `fit2101`;

-- Table `fit2101`.`Sprint`
CREATE TABLE IF NOT EXISTS `fit2101`.`Sprint` (
  `sprintID` INT NOT NULL AUTO_INCREMENT,
  `sprintName` VARCHAR(45) NOT NULL,
--  `sprintStatus` VARCHAR(45) NOT NULL,
  `sprintStartDate` DATETIME NULL DEFAULT NULL,
  `sprintEndDate` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`sprintID`));
  
  -- Table `fit2101`.`user`
CREATE TABLE IF NOT EXISTS `fit2101`.`User` (
  `userID` INT NOT NULL AUTO_INCREMENT,
  `userName` VARCHAR(45) NOT NULL,
  `userEmail` VARCHAR(45) NOT NULL,
  `userPassword` VARCHAR(45) NOT NULL,
  `userRole` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`userID`));


-- Table `fit2101`.`Task`
CREATE TABLE IF NOT EXISTS `fit2101`.`Task` (
  `taskID` INT NOT NULL AUTO_INCREMENT,
  `taskName` VARCHAR(45) NOT NULL,
  `taskType` VARCHAR(45) NOT NULL,
  `taskNumStoryPoint` VARCHAR(45) NOT NULL,
  `taskPriority` VARCHAR(45) NOT NULL,
  `taskStatus` VARCHAR(45) NOT NULL,
  `taskStage` VARCHAR(45) NOT NULL,
  `taskDesc` VARCHAR(500) NULL DEFAULT NULL,
  `assigneeID` INT NULL DEFAULT NULL,
  `taskDateCreated` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `taskActive` char default 'Y',
  PRIMARY KEY (`taskID`),
  INDEX `user_task_fk_idx` (`assigneeID` ASC) VISIBLE,
  CONSTRAINT `user_task_fk`
    FOREIGN KEY (`assigneeID`)
    REFERENCES `fit2101`.`User` (`userID`));

-- Table `fit2101`.`Sprint_Task`
CREATE TABLE IF NOT EXISTS `fit2101`.`Sprint_Task` (
  `sprintTaskID` INT NOT NULL AUTO_INCREMENT,
  `sprintID` INT NOT NULL,
  `taskID` INT NOT NULL UNIQUE,
  `taskCompletedDate` DATETIME DEFAULT NULL,
  PRIMARY KEY (`sprintTaskID`),
  INDEX `sprintID_idx` (`sprintID` ASC) VISIBLE,
  INDEX `taskID_idx` (`taskID` ASC) VISIBLE,
  CONSTRAINT `sprint_task_fk`
    FOREIGN KEY (`sprintID`)
    REFERENCES `fit2101`.`Sprint` (`sprintID`),
  CONSTRAINT `task_sprint_fk`
    FOREIGN KEY (`taskID`)
    REFERENCES `fit2101`.`Task` (`taskID`));

-- Table `fit2101`.`Tag`
CREATE TABLE IF NOT EXISTS `fit2101`.`Tag` (
  `tagID` INT NOT NULL AUTO_INCREMENT,
  `tagName` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`tagID`));

-- -----------------------------------------------------
-- Table `fit2101`.`Hour_Logged`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fit2101`.`Hour_Logged` (
  `hoursLoggedID` INT NOT NULL AUTO_INCREMENT,
  `sprintTaskID` INT NOT NULL,
  `userID` INT NOT NULL,
  `logDate` DATETIME NOT NULL,
  `hoursLogged` DECIMAL(4,2) NOT NULL,
  PRIMARY KEY (`hoursLoggedID`),
  CONSTRAINT `sprintTask_hours_fk`
    FOREIGN KEY (`sprintTaskID`)
    REFERENCES `fit2101`.`Sprint_Task` (`sprintTaskID`),
CONSTRAINT `sprintTaskUserID`
    FOREIGN KEY (`userID`)
    REFERENCES `fit2101`.`User` (`userID`));



-- -----------------------------------------------------
-- Table `fit2101`.`Task_Tag`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fit2101`.`Task_Tag` (
  `tag_ID` INT NOT NULL,
  `task_ID` INT NOT NULL,
  PRIMARY KEY (`tag_ID`, `task_ID`),
  INDEX `taskID_idx` (`task_ID` ASC) VISIBLE,
  CONSTRAINT `tag_task_fk`
    FOREIGN KEY (`tag_ID`)
    REFERENCES `fit2101`.`Tag` (`tagID`),
  CONSTRAINT `task_tag_fk`
    FOREIGN KEY (`task_ID`)
    REFERENCES `fit2101`.`Task` (`taskID`));



-- View to get tasks with all tags as a list
CREATE VIEW Task_View AS
SELECT 
    t.taskID,
    t.taskName,
    t.taskType,
    t.taskNumStoryPoint,
    t.taskPriority,
    t.taskStatus,
    t.taskStage,
    t.taskDesc,
    IFNULL(GROUP_CONCAT(tag.tagName ORDER BY tag.tagName ASC), '[]') AS taskTags, -- Replace NULL with []
    t.assigneeID,
    u.userName AS assigneeName,  -- Adding assignee's name
    t.taskDateCreated
FROM 
    Task AS t
LEFT JOIN 
    Task_Tag AS tt ON t.taskID = tt.task_ID
LEFT JOIN 
    Tag AS tag ON tt.tag_ID = tag.tagID
LEFT JOIN
    User AS u ON t.assigneeID = u.userID  -- Joining with User table to get assignee's name
GROUP BY 
    t.taskID;

-- View to get information about sprints with their statuses
CREATE VIEW `Sprint_View` AS
SELECT
    `sprintID`,
    `sprintName`,
    CASE
        WHEN `sprintStartDate` IS NULL OR `sprintEndDate` IS NULL THEN 'Not Started'
        WHEN CURDATE() < `sprintStartDate` THEN 'Not Started'
        WHEN CURDATE() BETWEEN `sprintStartDate` AND `sprintEndDate` THEN 'Active'
        WHEN CURDATE() > `sprintEndDate` THEN 'Completed'
        ELSE 'Not Started' -- As default
    END AS `sprintStatus`,
    CASE 
        WHEN `sprintStartDate` IS NOT NULL THEN DATE_FORMAT(`sprintStartDate`, '%d-%m-%Y')
        ELSE 'Not Set'
    END AS `sprintStartDate`,
    CASE 
        WHEN `sprintEndDate` IS NOT NULL THEN DATE_FORMAT(`sprintEndDate`, '%d-%m-%Y')
        ELSE 'Not Set'
    END AS `sprintEndDate`
FROM
    `fit2101`.`Sprint`;

-- View to get sprint tasks with all task details and tags as a list
CREATE VIEW Sprint_Task_View AS
SELECT 
    st.sprintTaskID,
    st.sprintID,
    tvt.taskID,
    tvt.taskName,
    tvt.taskType,
    tvt.taskNumStoryPoint,
    tvt.taskPriority,
    tvt.taskStatus,
    tvt.taskStage,
    tvt.taskDesc,
    tvt.assigneeID,
    tvt.taskDateCreated,
    tvt.taskTags,
    s.sprintStatus,
    s.sprintStartDate,
    s.sprintEndDate
FROM 
    Sprint_Task AS st
INNER JOIN 
    Sprint_View AS s ON s.sprintID = st.sprintID
INNER JOIN 
    Task_View AS tvt ON st.taskID = tvt.taskID;

-- View to get user hours logged data
CREATE VIEW user_hours_logged AS
SELECT
    u.userID,
    u.userName,
    u.userEmail,
    h.logDate,
    h.hoursLogged 
FROM
    `fit2101`.`User` AS u
JOIN
    `fit2101`.`Hour_Logged` AS h ON u.userID = h.userID;

