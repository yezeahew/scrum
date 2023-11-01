-- sprint  1
INSERT INTO task(`taskName`, `taskDesc`, `taskType`, `taskNumStoryPoint`, `taskPriority`, `taskStatus`, `taskStage`, `assigneeID`)
VALUES
('UI for Task Form', 'Implement the UI of task creation form using Bootstrap according to figma designs.', 'Story', 5, 'Important', 'Not Started', 'Planning', 5),
('Form Validation', 'Ensure that users input data correctly into the form. Display an error message for any validation failures.', 'Story', 3, 'Important', 'Not Started', 'Planning', 5),
('Schema Design', 'Define the tables and relationships required for the project.', 'Story', 7, 'Urgent', 'Not Started', 'Planning', 7),
('MySQL Database Setup', 'Setup the project database on MySQL.', 'Story', 6, 'Important', 'Not Started', 'Planning', 2),
('Data Insert & Test', 'Add test data to the database and ensure its functioning as expected.', 'Story', 5, 'Medium', 'Not Started', 'Planning', 7),
('Flask Server Setup', 'Configure a web server using the Flask framework.', 'Bug', 4, 'Important', 'Not Started', 'Planning', 3),
('Server-DB Connection', 'Ensure that the Flask server can communicate with the project database.', 'Story', 4, 'Important', 'Not Started', 'Planning', 3),
('Task Creation API', 'Develop an API endpoint to process task creation.', 'Story', 6, 'Urgent', 'Not Started', 'Planning', 2),
('UI for Backlog', 'Design the user interface for the product backlog.', 'Story', 5, 'Medium', 'Not Started', 'Planning', 6),
('Tasks List API', 'Develop an API endpoint to fetch a list of all tasks.', 'Story', 6, 'Medium', 'Not Started', 'Planning', 7),
('UI for Task Details', 'Design the user interface for task details.', 'Story', 4, 'Low', 'Not Started', 'Planning', 4),
('Task Details API', 'Develop an API endpoint to fetch details of a specific task.', 'Story', 4, 'Medium', 'Not Started', 'Planning', 3),
('UI for Task Editing', 'Implement the UI for editing tasks using Bootstrap according to figma designs.', 'Story', 5, 'Medium', 'Not Started', 'Planning', 5),
('Task Editing API', 'Develop an API endpoint to process task editing.', 'Story', 5, 'Medium', 'Not Started', 'Planning', 2),
('UI for Backlog Assignment', 'Design the user interface for assigning backlog items.', 'Story', 4, 'Low', 'Not Started', 'Planning', 6),
('Backlog Assignment API', 'Develop an API endpoint for backlog item assignment.', 'Story', 5, 'Medium', 'Not Started', 'Planning', 7),
('Task Time Sort', 'Add functionality to sort tasks based on time.', 'Story', 4, 'Low', 'Not Started', 'Planning', 4),
('Task Priority Sort', 'Add functionality to sort tasks based on priority.', 'Story', 3, 'Low', 'Not Started', 'Planning', 4),
('Task Filter by Tags', 'Add functionality to filter tasks using specific tags.', 'Bug', 3, 'Low', 'Not Started', 'Planning', 4),
('Delete Task Feature', 'Design and develop the feature to remove tasks from the system.', 'Bug', 4, 'Medium', 'Not Started', 'Planning', 6),
('Task Deletion API', 'Develop an API endpoint to process task deletion requests.', 'Story', 5, 'Medium', 'Not Started', 'Planning', 2),
('Product Integration', 'Ensure that all components work together for a complete product.', 'Story', 8, 'Urgent', 'Not Started', 'Planning', 2);


INSERT INTO task_tag(task_ID, tag_ID) VALUES
-- For 'UI for Task Form'
(1, 1),  -- Front End
(1, 5),  -- UI

-- For 'Form Validation'
(2, 2),  -- Back End

-- For 'Schema Design'
(3, 4),  -- Database

-- For 'MySQL Database Setup'
(4, 4),  -- Database

-- For 'Data Insert & Test'
(5, 4),  -- Database
(5, 3),  -- Testing

-- For 'Flask Server Setup'
(6, 2),  -- Back End
(6, 8),  -- Framework

-- For 'Server-DB Connection'
(7, 2),  -- Back End

-- For 'Task Creation API'
(8, 2),  -- Back End
(8, 7),  -- API

-- For 'UI for Backlog'
(9, 1),  -- Front End
(9, 5),  -- UI

-- For 'Tasks List API'
(10, 2), -- Back End
(10, 7), -- API

-- For 'UI for Task Details'
(11, 1), -- Front End
(11, 5), -- UI

-- For 'Task Details API'
(12, 2), -- Back End
(12, 7), -- API

-- For 'UI for Task Editing'
(13, 1), -- Front End
(13, 5), -- UI

-- For 'Task Editing API'
(14, 2), -- Back End
(14, 7), -- API

-- For 'UI for Backlog Assignment'
(15, 1), -- Front End
(15, 5), -- UI

-- For 'Backlog Assignment API'
(16, 2), -- Back End
(16, 7), -- API

-- For 'Task Time Sort'
(17, 1), -- Front End
(17, 2), -- Back End

-- For 'Task Priority Sort'
(18, 1), -- Front End
(18, 2), -- Back End

-- For 'Task Filter by Tags'
(19, 1), -- Front End
(19, 2), -- Back End

-- For 'Delete Task Feature'
(20, 1), -- Front End
(20, 2), -- Back End

-- For 'Task Deletion API'
(21, 2), -- Back End
(21, 7), -- API

-- For 'Product Integration'
(22, 1), -- Front End
(22, 2); -- Back End

commit;