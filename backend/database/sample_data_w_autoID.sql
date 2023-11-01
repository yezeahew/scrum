-- Change Log:
-- Date : 8/Oct
-- Changes: Changed insertion to not inlcude sprint status
-- Changes made by : Jess

use fit2101;


INSERT INTO user(`userName`, `userEmail`, `userPassword`, `userRole`) 
VALUES
('jesshew','jess@hexadivision.com','Jess@123','Team Member'),
('ranusha','ranusha@hexadivision.com','Ranusha@123','Team Member'),
('huzaima','huzaima@hexadivision.com','Huzaima@123','Team Member'),
('ryan','ryan@hexadivision.com','Ryan@123','Team Member'),
('lim','lim@hexadivision.com','Lim@123','Team Member'),
('hanideepu','hanideepu@hexadivision.com','Hanideepu@123','Team Member'),
('admin','admin@gmail.com','admin123','Admin');

-- ('Jesshew','yhew0003@student.monash.edu','Jess@123','Team Member'),
-- ('Ranusha Liyanage','rliy0007@student.monash.edu','Ranusha@123','Team Member'),
-- ('Huzaima Amir','hami0005@student.monash.edu','Huzaima@123','Team Member'),
-- ('Ryan Choo','rcho0046@student.monash.edu','Ryan@123','Team Member'),
-- ('Lim Zhi Cheng','zlim0052@student.monash.edu','Lim@123','Team Member'),
-- ('Hanideepu Kodi','hkod0003@student.monash.edu','Hanideep@123','Team Member'),
-- ('admin','admin@gmail.com','admin123','Admin');


INSERT INTO task(`taskName`, `taskType`, `taskNumStoryPoint`, `taskPriority`, `taskStatus`, `taskStage`, `taskDesc`, `assigneeID`)
VALUES
('User Registration', 'Story', '5', 'Important', 'Not Started', 'Planning', 'Implement a secure user registration system with email confirmation.', 1);
DO SLEEP(0.2);
INSERT INTO task(`taskName`, `taskType`, `taskNumStoryPoint`, `taskPriority`, `taskStatus`, `taskStage`, `taskDesc`, `assigneeID`)
VALUES
('Login Bug', 'Bug', '3', 'Medium', 'Not Started', 'Development', 'Users report being logged out randomly. Investigate and fix.', 2);
DO SLEEP(0.2);

INSERT INTO task(`taskName`, `taskType`, `taskNumStoryPoint`, `taskPriority`, `taskStatus`, `taskStage`, `taskDesc`, `assigneeID`)
VALUES
('Payment Gateway Integration', 'Story', '8', 'Urgent', 'Not Started', 'Planning', 'Integrate Stripe API for processing user payments.', 3);
DO SLEEP(0.2);

INSERT INTO task(`taskName`, `taskType`, `taskNumStoryPoint`, `taskPriority`, `taskStatus`, `taskStage`, `taskDesc`, `assigneeID`)
VALUES
('UI Revamp', 'Story', '2', 'Low', 'Not Started', 'Testing', 'Update the user interface based on the new design mockups.', 4);

DO SLEEP(0.2);
INSERT INTO task(`taskName`, `taskType`, `taskNumStoryPoint`, `taskPriority`, `taskStatus`, `taskStage`, `taskDesc`, `assigneeID`)
VALUES
('Database Optimization', 'Bug', '5', 'Medium', 'Not Started', 'Development', 'Some queries are taking too long. Need to optimize the database queries.', 5);

DO SLEEP(0.2);
INSERT INTO task(`taskName`, `taskType`, `taskNumStoryPoint`, `taskPriority`, `taskStatus`, `taskStage`, `taskDesc`, `assigneeID`)
VALUES
('User Feedback System', 'Story', '3', 'Low', 'Not Started', 'Testing', 'Create a feedback system where users can submit suggestions and bugs.', 6);
DO SLEEP(0.2);
INSERT INTO task(`taskName`, `taskType`, `taskNumStoryPoint`, `taskPriority`, `taskStatus`, `taskStage`, `taskDesc`, `assigneeID`)
VALUES
('Password Reset Issue', 'Bug', '8', 'Important', 'Not Started', 'Planning', 'Users are not receiving password reset emails.', 1);
DO SLEEP(0.2);

INSERT INTO task(`taskName`, `taskType`, `taskNumStoryPoint`, `taskPriority`, `taskStatus`, `taskStage`, `taskDesc`, `assigneeID`)
VALUES
('API Endpoint Protection', 'Bug', '3', 'Medium', 'Not Started', 'Development', 'Some API endpoints are exposed. Need to add authentication.', 2);

INSERT INTO task(`taskName`, `taskType`, `taskNumStoryPoint`, `taskPriority`, `taskStatus`, `taskStage`, `taskDesc`, `assigneeID`)
VALUES
('New Feature Development', 'Story', '5', 'Medium', 'Not Started', 'Planning', 'Develop a new feature based on user requirements.', 3);
DO SLEEP(0.2);

INSERT INTO task(`taskName`, `taskType`, `taskNumStoryPoint`, `taskPriority`, `taskStatus`, `taskStage`, `taskDesc`, `assigneeID`)
VALUES
('Bug Testing', 'Bug', '3', 'Important', 'Not Started', 'Development', 'Conduct extensive testing to identify and fix bugs.', 4);
DO SLEEP(0.2);

INSERT INTO task(`taskName`, `taskType`, `taskNumStoryPoint`, `taskPriority`, `taskStatus`, `taskStage`, `taskDesc`, `assigneeID`)
VALUES
('Documentation Update', 'Story', '2', 'Low', 'Not Started', 'Testing', 'Update project documentation to reflect recent changes.', 5);
DO SLEEP(0.2);

INSERT INTO task(`taskName`, `taskType`, `taskNumStoryPoint`, `taskPriority`, `taskStatus`, `taskStage`, `taskDesc`, `assigneeID`)
VALUES
('Performance Optimization', 'Story', '8', 'Important', 'Not Started', 'Planning', 'Optimize the application for better performance.', 6);
DO SLEEP(0.2);

INSERT INTO task(`taskName`, `taskType`, `taskNumStoryPoint`, `taskPriority`, `taskStatus`, `taskStage`, `taskDesc`, `assigneeID`)
VALUES
('User Account Verification', 'Story', '4', 'Medium', 'Not Started', 'Development', 'Implement user account verification via email.', 1);
DO SLEEP(0.2);

INSERT INTO task(`taskName`, `taskType`, `taskNumStoryPoint`, `taskPriority`, `taskStatus`, `taskStage`, `taskDesc`, `assigneeID`)
VALUES
('User Feedback Implementation', 'Story', '3', 'Low', 'Not Started', 'Testing', 'Integrate user feedback into the application.', 2);
DO SLEEP(0.2);

INSERT INTO task(`taskName`, `taskType`, `taskNumStoryPoint`, `taskPriority`, `taskStatus`, `taskStage`, `taskDesc`, `assigneeID`)
VALUES
('Database Schema Update', 'Story', '6', 'Important', 'Not Started', 'Planning', 'Update the database schema to accommodate new features.', 3);
DO SLEEP(0.2);

INSERT INTO task(`taskName`, `taskType`, `taskNumStoryPoint`, `taskPriority`, `taskStatus`, `taskStage`, `taskDesc`, `assigneeID`)
VALUES
('Security Audit', 'Bug', '7', 'Important', 'Not Started', 'Development', 'Perform a security audit to identify vulnerabilities.', 4);
DO SLEEP(0.2);

INSERT INTO task(`taskName`, `taskType`, `taskNumStoryPoint`, `taskPriority`, `taskStatus`, `taskStage`, `taskDesc`, `assigneeID`)
VALUES
('User Onboarding', 'Story', '4', 'Medium', 'Not Started', 'Testing', 'Create a seamless onboarding process for new users.', 5);
DO SLEEP(0.2);

INSERT INTO task(`taskName`, `taskType`, `taskNumStoryPoint`, `taskPriority`, `taskStatus`, `taskStage`, `taskDesc`, `assigneeID`)
VALUES
('Bug Fixing', 'Bug', '3', 'Low', 'Not Started', 'Planning', 'Address reported bugs and issues in the application.', 6);

-- ('Task 1', 'Story', '5', 'Important', 'Not Started', 'Planning', 'Description for Task 1', 1),
-- ('Task 2', 'Bug', '3', 'Medium', 'Not Started', 'Development', 'Description for Task 2', 2),
-- ('Task 3', 'Story', '8', 'Urgent', 'Not Started', 'Planning', 'Description for Task 3', 3),
-- ('Task 4', 'Story', '2', 'Low', 'Not Started', 'Testing', 'Description for Task 4', 4),
-- ('Task 5', 'Bug', '5', 'Medium', 'In Progress', 'Development', 'Description for Task 5', 5),
-- ('Task 6', 'Story', '3', 'Low', 'Not Started', 'Testing', 'Description for Task 6', 6),
-- ('Task 7', 'Bug', '8', 'Important', 'Not Started', 'Planning', 'Description for Task 7', 1),
-- ('Task 8', 'Bug', '3', 'Medium', 'In Progress', 'Development', 'Description for Task 8', 2);


insert into tag(`tagName`) values
	('Front End'),
    ('Back End'),
    ('Testing'),
    ('Database'),
    ('UI'),
    ('UX'),
    ('API'),
    ('Framework');
    
insert into task_tag values
-- For first task
	(1,1),(4,1),(5,1),
-- For second task
	(1,2),(3,2),(5,2),(8,2),
-- For third task
	(2,3),(3,3),
-- For fourth task
	(5,4),(7,4),
-- for fifth task
	(2,5),(3,5),
-- for sixth task
	(2,6),(4,6),(6,6),(8,6),
-- for seventh task
	(1,7),(4,7),(5,7),
-- for eighth task
	(1,8),(7,8);

-- Generate random assignments of tags to tasks (ninth to eighteenth tasks)
INSERT INTO task_tag (`tag_ID`, `task_ID`) VALUES
-- Ninth Task
(2, 9),
(4, 9),
(5, 9),

-- Tenth Task
(1, 10),
(3, 10),
(5, 10),
(8, 10),

-- Eleventh Task
(1, 11),
(4, 11),

-- Twelfth Task
(3, 12),
(7, 12),

-- Thirteenth Task
(3, 13),
(6, 13),

-- Fourteenth Task
(2, 14),
(5, 14),

-- Fifteenth Task
(5, 15),
(7, 15),

-- Sixteenth Task
(1, 16),
(2, 16),
(4, 16),
(7, 16),

-- Seventeenth Task
(4, 17),
(7, 17),
(8, 17),

-- Eighteenth Task
(1, 18),
(3, 18);


-- INSERT INTO sprint(`sprintName`, `sprintStatus`)
-- VALUES
-- ('Sprint1', 'Not Started'),
-- ('Sprint2', 'Not Started'),
-- ('Sprint3', 'Not Started');  
 
INSERT INTO sprint(`sprintName`)
VALUES
('Sprint1'),
('Sprint2'),
('Sprint3');    




-- INSERT INTO Sprint_Task(`sprintID`, `taskID`)
-- VALUES
-- -- For task 1 to task 18
-- -- (1, 1), (1, 2), (1, 3),
-- -- (2, 7), (2, 8), (2, 9),  
-- -- (3, 13), (3, 14), (3, 15);
-- -- For task 1 to task 18
-- -- (1, 1), (1, 2), (1, 3), (1, 4), (1, 5),(1, 6), 
-- -- (2, 7), (2, 8), (2, 9), (2, 10),(2, 11), (2, 12), 
-- -- (3, 13), (3, 14), (3, 15),(3, 16), (3, 17), (3, 18);


-- Inserting test data into Hour_Logged
INSERT INTO `fit2101`.`Hour_Logged` (sprintTaskID, userID, logDate, hoursLogged) VALUES
(1, 1, '2023-10-01', 4.5), -- User 1 logs 4.5 hours on task associated with sprintTaskID 1
(2, 2, '2023-10-01', 3.2), -- User 2 logs 3.2 hours on task associated with sprintTaskID 2
(1, 2, '2023-10-02', 2.0), -- User 2 logs an additional 2 hours on task associated with sprintTaskID 1
(3, 1, '2023-10-02', 6.0), -- User 1 logs 6 hours on task associated with sprintTaskID 3
(4, 3, '2023-10-03', 5.5), -- User 3 logs 5.5 hours on task associated with sprintTaskID 4
(2, 3, '2023-10-04', 2.5), -- User 3 logs 2.5 hours on task associated with sprintTaskID 2
(3, 2, '2023-10-05', 7.0); -- User 2 logs 7 hours on task associated with sprintTaskID 3




