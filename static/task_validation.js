//export DYLD_LIBRARY_PATH=/usr/local/mysql-8.0.33-macos13-arm64/lib/
const dropdown = document.getElementById("assign-member");

/**
 * Transforms a string by:
 * - Removing hyphens.
 * - Capitalizing the first letter of each word.
 */
function formatText(inputText) {
    // Split the string by hyphen
    let words = inputText.split('-');
    
    // Capitalize the first letter of each word and join them back
    return words.map(word => word.charAt(0).toUpperCase() + word.slice(1).toLowerCase()).join(' ');
}

function stripID(id) {
    return id.toLowerCase().replace('-', ' ').toLowerCase();
}

// Function to populate the dropdown with users
function populateDropdown(users) {
    if (users.length === 0) {
        alert('No users found. Please refresh and try again.');
        return;
    }
    users.forEach(user => {
        const newOption = document.createElement("option");
        newOption.value = user.userID; 
        newOption.textContent = user.userName;
        dropdown.appendChild(newOption);
    });
}

// Fetch users from API and populate dropdown
function fetchUsers() {
    return new Promise(async (resolve, reject) => {
        try {
            const response = await fetch('/users');
            const users = await response.json();
            console.log(`Fetched ${users.length} Users`);
            populateDropdown(users);
            resolve();
        } catch (error) {
            console.error("Error fetching users:", error);
            reject(error);
        }
    });
};

function validateTaskForm(){

// dictionary to store input values
const values = {
    "name" : "",
    "type" : "",
    "storypoints" : "",
    "tags" : "",
    "priority" : "",
    "status" : "",
    "stage" : "",
    "description" : "",
    "assignedTo" : "",
};

// check if name is valid, if not valid display warning message
var taskName = document.getElementById("task-name-input");
var taskNameInput = taskName.value;
var validName = true;
if (taskNameInput === "") {
    validName = false;
    var output = document.getElementById("invalid-task-name");
    output.style.display = "block";
}


// check if at least one tag is selected, if not display warning message
var taskTags = document.querySelectorAll('input[type="checkbox"][name^="tags"]');
var validTags = false;
for (let i = 0; i < taskTags.length; i++) {
    if (taskTags[i].checked) {
        validTags = true;
    }
}
if (validTags == false) {
    var output = document.getElementById("invalid-tags");
    output.style.display = "block";
}

// check if task description is valid, if not display warning message
var taskDescription = document.getElementById("task-description-input");
var taskDescriptionInput = taskDescription.value;
var validDescription = true;
if (taskDescriptionInput === "") {
    validDescription = false;
    var output = document.getElementById("invalid-description");
    output.style.display = "block";
}

// if all the inputs are valid, submit the form
if (validName && validTags && validDescription) {

    // add values to dictionary
    values["name"] = taskNameInput;

    // add type
    var type = document.querySelectorAll('input[type="radio"][name^="task-type-option"]');
    for (let i = 0; i < type.length; i++) {
        if (type[i].checked) {
            values["type"] = type[i].id
        }
    }
    
    // add storypoints
    var storypoints = document.querySelectorAll('input[type="radio"][name^="numerical-storypoints"]');
    for (let i = 0; i < storypoints.length; i++) {
        if (storypoints[i].checked) {
            values["storypoints"] = storypoints[i].id
        }
    }

    // add tags
    const chosenTags = [];
    document.querySelectorAll('input[name="tags"]:checked').forEach(tag => {
        chosenTags.push(tag.id);
    });
    values["tags"] = chosenTags;

    // add priority
    var priority = document.querySelectorAll('input[type="radio"][name^="priority-option"]');
    for (let i = 0; i < priority.length; i++) {
        if (priority[i].checked) {
            values["priority"] = priority[i].id
        }
    }

    // add current status
    var status = document.querySelectorAll('input[type="radio"][name^="task-status"]');
    for (let i = 0; i < status.length; i++) {
        if (status[i].checked) {
            values["status"] = status[i].id
        }
    }

    // add current stage
    var stage = document.querySelectorAll('input[type="radio"][name^="current-stage"]');
    for (let i = 0; i < stage.length; i++) {
        if (stage[i].checked) {
            values["stage"] = stage[i].id
        }
    }

    // add description
    values["description"] = taskDescriptionInput;

    // add assigned member
    var assign = document.getElementById("assign-member");
    values["assignedTo"] = assign.value;

    const payload = {
    taskName: values["name"],
    taskType: values["type"],
    taskNumStoryPoint: values["storypoints"],
    taskPriority: formatText(values["priority"]),
    taskStatus: formatText(values["status"]),
    taskStage: values["stage"],
    taskDesc: values["description"],
    assigneeID: values["assignedTo"],
    tags: values["tags"]
    };

    return payload; 
    }
    }

export{stripID,populateDropdown,fetchUsers,validateTaskForm};
