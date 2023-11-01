function stripID(id) {
    return id.toLowerCase().replace(' ', '-');
}

var sprint = `{{ fetchedSprint | tojson }}`;

// Populate sprint name
document.getElementById("sprintName").textContent = sprint.sprintName;

// Populate sprint status
document.getElementById("sprintStatus").textContent = sprint.sprintStatus;

// Populate time range
document.getElementById("sprintTimeRange").textContent = sprint.startTime ? `${sprint.startTime} to ${sprint.endTime}` : 'Not Set';

// Populate task list
var taskList = document.getElementById("sprintTaskList");
if (sprint.tasks && sprint.tasks.length) {
    sprint.tasks.forEach(task => {
        var li = document.createElement("li");
        li.textContent = task;
        taskList.appendChild(li);
    });
} else {
    taskList.textContent = 'No tasks assigned.';
}
