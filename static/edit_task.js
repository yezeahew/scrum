import { stripID,fetchUsers, validateTaskForm } from './task_validation.js';

function populateTaskFields(task){
  // console.log("Edit__task.js, trying to populat task",task);
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
    var tagsArray = task.taskTags.toLowerCase();
  
    // set tags 
    var tags = document.querySelectorAll('input[type="checkbox"][name^="tags"]');
    //console.log(tagsArray);
    for (let i = 0; i < tags.length; i++) {
      if (tagsArray.includes(stripID(tags[i].id))) {
        tags[i].checked = true;
      }
    }
  
    // set priority
    var priority = document.querySelectorAll('input[type="radio"][name^="priority-option"]');
    //console.log(priority);
    for (let i = 0; i < priority.length; i++) {
      //console.log(task.taskPriority.toLowerCase(),i,priority[i],priority[i].id);
      if (stripID(task.taskPriority) == stripID(priority[i].id)) {
        priority[i].checked = true;
      }
    }
  
    var inputs = Array.from(document.getElementsByTagName('input'));
    var statusList = inputs.filter(input => input.type === 'radio' && input.name === 'task-status');
    for (let i = 0; i < statusList.length; i++) {
      //console.log(task.taskStatus.toLowerCase(),i,status[i],status[i].id);
      if (stripID(task.taskStatus) == stripID(statusList[i].id)) {
        statusList[i].checked = true;
      }
    }
  
    // set stage
    var stage = document.querySelectorAll('input[type="radio"][name^="current-stage"]');
    for (let i = 0; i < stage.length; i++) {
      //console.log(task.taskStage.toLowerCase(),i,stage[i],stage[i].id);
      if (stripID(stage[i].id).includes(stripID(task.taskStage))) {
        stage[i].checked = true;
      }
    }
    // set description
    var description = document.getElementById("task-description-input");
    description.value = task.taskDesc;
  
    var assign = document.getElementById("assign-member-input");
    assign.value = task.assigneeName;
  
  }

function handleEditFormSubmission(e, taskId) {
    e.stopPropagation();
    e.preventDefault();
    var payload = validateTaskForm();

    // Log the payload for debugging
    // console.log("Sending data:", payload);

    sendEditRequest(taskId, payload)
        .then(data => {
            if (data.success) {
                alert(data.message);
                location.reload();
                //redirect or update the UI to reflect the edited task
            } else {
                alert('Error: ' + data.message);
            }
        })
        .catch(handleError);
}

function sendEditRequest(taskId, payload) {
  // console.log("Editing task",payload);
    return fetch(`/edit_task/${taskId}`, {
        method: 'PUT',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify(payload),
    })
    .then(response => response.json());
}

function handleError(error) {
    console.error('Error:', error);
}

function setUpEditForm(taskId, taskAssignee) {
    fetchUsers().then(() => {
        var editTaskForm = document.getElementById("task-form");
        editTaskForm.addEventListener("submit", (e) => handleEditFormSubmission(e, taskId));

        // set the assignee name to current assignee 
        var assignSelect = document.getElementById("assign-member");
        Array.from(assignSelect.options).forEach(option => {
            if (option.textContent === taskAssignee) {
                option.selected = true;
            }
        });
    });
}

export { populateTaskFields, setUpEditForm };


