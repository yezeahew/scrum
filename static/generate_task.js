$(document).ready(function(){
    // Load modals
    $("#load-create-task-modal").click(function(e){
        e.preventDefault();
        $("#modal-container").load("/createTaskModal", function() {
            $("#create-task-modal").modal("show");
        });
    });
    
    $(document).on("click", ".task-card", function(e) {
        e.preventDefault();
        console.log("Task card clicked!");
        const taskId = $(this).attr("data-task-id");  // Get the task ID from  clicked card
        // load the task modal with details specific to this ID
        $("#modal-container").load("/viewTaskModal/" + taskId, function() {
            $("#view-task-modal").modal("show");
        });
    });

    allTasks = []

    // Function to add task card
    function addTaskCard(taskId,taskName, priority, taskTags, taskStoryPoints) {
        const taskBox = document.createElement("div");
        taskBox.className = "task-card";
        taskBox.setAttribute("data-task-id", taskId);  // Assign the task ID to the card

        const taskTitle = document.createElement("h3");
        taskTitle.style.color = "#f99417";
        taskTitle.textContent = taskName;

        const taskPriority = document.createElement("div");
        taskPriority.textContent = priority;
        // Set priority color class
        switch(priority.toLowerCase()) {
            case 'low':
                taskPriority.classList.add('priority-low');
                break;
            case 'medium':
                taskPriority.classList.add('priority-medium');
                break;
            case 'important':
                taskPriority.classList.add('priority-important');
                break;
            case 'urgent':
                taskPriority.classList.add('priority-urgent');
                break;
        }

        const tagsDiv = document.createElement("div");
        tagsDiv.className = "tags";
        taskTags.split(',').forEach(tag => {
            const tagElement = document.createElement("span");
            tagElement.className = "tag";
            tagElement.textContent = tag.trim();
            tagsDiv.appendChild(tagElement);
        });

        const storyPointsLabel = document.createElement("span");
        storyPointsLabel.className = "story-points-label";
        storyPointsLabel.textContent = "Story points :";

        const storyPoints = document.createElement("span");
        storyPoints.className = "story-points";
        storyPoints.textContent = taskStoryPoints;


        // Append elements to the task card
        taskBox.appendChild(taskTitle);
        taskBox.appendChild(taskPriority);
        taskBox.appendChild(tagsDiv);
        taskBox.appendChild(storyPoints);
        taskBox.appendChild(storyPointsLabel);

        // Insert the new task card into the Product Backlog
        document.querySelector(".tasks-list").appendChild(taskBox);
    }

    function renderTasks(tasks) {
        const tasksList = document.querySelector(".tasks-list");
        tasksList.innerHTML = '';  // Clear the existing tasks
        tasks.forEach(task => {
            addTaskCard(task.taskID, task.taskName, task.taskPriority, task.taskTags, task.taskNumStoryPoint);
        });
    }

    // Function to generate task cards
    function generateTaskCards() {
        $.ajax({
            url: "/backlog_tasks", // Assuming the frontend and backend are on the same domain
            method: "GET",
            success: function(data) {
                console.log("Fetched tasks:", data);
                allTasks = data; // save data in a list
                renderTasks(allTasks);
            },
            error: function(error) {
                console.error("Error fetching tasks:", error);
            }
        });
    }
    // Call function to generate tasks
    generateTaskCards();


    // when tag is selected for filtering
    document.body.addEventListener("click", function(e) {
        // Check if the clicked element has a 'data-filter' attribute
        if (e.target && e.target.getAttribute("data-filter")) {
            const filterType = e.target.getAttribute("data-filter");
            // console.log(`filter by ${filterType} tags`);
            // Filter tasks by the selected tag
            const filteredTasks = filterByTag(filterType.toLowerCase());
            // Render the filtered tasks
            renderTasks(filteredTasks);
        }
    });

    const priorityMap = {
        "urgent": 4,
        "important": 3,
        "medium": 2,
        "low": 1
    };
    

    function sortByNewest(a, b) {
        // Extracting date from the 'taskDateCreated' attribute
        return new Date(b.taskDateCreated) - new Date(a.taskDateCreated);
    }

    function sortByOldest(a, b) {
        return new Date(a.taskDateCreated) - new Date(b.taskDateCreated);
    }

    function sortByLowToUrgent(a, b) {
        return priorityMap[a.taskPriority.toLowerCase()] - priorityMap[b.taskPriority.toLowerCase()];
    }
    
    function sortByUrgentToLow(a, b) {
        return priorityMap[b.taskPriority.toLowerCase()] - priorityMap[a.taskPriority.toLowerCase()];
    }
    

    function filterByTag(tag) {
        return allTasks.filter(task => task.taskTags.toLowerCase().includes(tag));
    }

    // When sort new to old is selected
    const sortNewToOldButton = document.getElementById("sortNewToOld");
    sortNewToOldButton.addEventListener("click", () => {
        allTasks.sort(sortByNewest); // Sort the array using the newest sorting function
        renderTasks(allTasks); // Re-render tasks
        // console.log("Sorted the data from newest to oldest");
    });

    // When sort old to new is selected
    const sortOldToNewButton = document.getElementById("sortOldToNew");
    sortOldToNewButton.addEventListener("click", () => {
        allTasks.sort(sortByOldest); // Sort the array using the oldest sorting function
        renderTasks(allTasks); // Re-render tasks
        // console.log("Sorted the data from oldest to newest");
    });

    // when sort low to urgent is selected
    const sortLowToUrgentButton = document.getElementById("sortLowToUrgent");
    sortLowToUrgentButton.addEventListener("click", () => {
        allTasks.sort(sortByLowToUrgent); // Sort the array using the low-to-urgent sorting function
        renderTasks(allTasks); // Re-render tasks
        // console.log("Sorted the data from low to urgent");
    });

    // when sort urgent to low is selected
    const sortUrgentToLowButton = document.getElementById("sortUrgentToLow");
    sortUrgentToLowButton.addEventListener("click", () => {
        allTasks.sort(sortByUrgentToLow); // Sort the array using the urgent-to-low sorting function
        renderTasks(allTasks); // Re-render tasks
        // console.log("Sorted the data from urgent to low");
    });


});


