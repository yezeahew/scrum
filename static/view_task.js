function stripID(id) {
    return id.toLowerCase().replace(' ', '-');
}

function deleteTask(taskId) {
    $.ajax({
        type: "DELETE",
        url: `/delete_task/${taskId}`,
        success: function(response) {
            if (response.success) {
                console.log(`Task ID "${taskId}" deleted successfully!`);
            } else {
                console.error(`Failed to delete task from backend: ${response.message}`);
            }
            deleteModal.hide();
        },
        error: function(error) {
            console.error(`Error occurred: ${error.responseText}`);
        }
    });
}

// Warning Handlers
function CheckName() {
    document.getElementById("invalid-task-name").style.display = "none";
}

function CheckTags() {
    document.getElementById("invalid-tags").style.display = "none";
}

function CheckDescription() {
    document.getElementById("invalid-description").style.display = "none";
}

// Populating form values from fetched task
var task = `{{ fetchedTask | tojson }}`;

// set name value
document.getElementById("task-name-input").value = task.taskName;

// set type
var type = document.querySelectorAll('input[type="radio"][name^="task-type-option"]');
for (let i = 0; i < type.length; i++) {
    if (task.taskType.toLowerCase() == type[i].id) {
        type[i].checked = true;
    }
}

// set storypoints
var storypoints = document.querySelectorAll('input[type="radio"][name^="numerical-storypoints"]');
for (let i = 0; i < storypoints.length; i++) {
    if (task.taskNumStoryPoint == storypoints[i].id) {
        storypoints[i].checked = true;
    }
}

// Convert taskTags string into an array
var tagsArray = task.taskTags.split(',').map(tag => stripID(tag.trim()));

// set tags 
var tags = document.querySelectorAll('input[type="checkbox"][name^="tags"]');
for (let i = 0; i < tags.length; i++) {
    if (tagsArray.includes(tags[i].id)) {
        tags[i].checked = true;
    }
}

// set priority
var priority = document.querySelectorAll('input[type="radio"][name^="priority-option"]');
for (let i = 0; i < priority.length; i++) {
    if (task.taskPriority.toLowerCase() == stripID(priority[i].id)) {
        priority[i].checked = true;
    }
}

// set status
var status = document.querySelectorAll('input[type="radio"][name^="task-status"]');
for (let i = 0; i < status.length; i++) {
    if (task.taskStatus.toLowerCase() == stripID(status[i].id)) {
        print(task.taskStatus.toLowerCase(),stripID(status[i].id))
        status[i].checked = true;
    }
}

// set stage
var stage = document.querySelectorAll('input[type="radio"][name^="current-stage"]');
for (let i = 0; i < stage.length; i++) {
    if (task.taskStage.toLowerCase() == stripID(stage[i].id)) {
        print(task.taskStage.toLowerCase(),stripID(stage[i].id))
        stage[i].checked = true;
    }
}
// set description
document.getElementById("task-description-input").value = task.taskDesc;

var assign = document.getElementById("assign-member");
// set assigned team member
assign.value = task.assigneeName;