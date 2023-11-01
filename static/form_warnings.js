// This script contains function to remove warning messages in the 
// Create Task / Edit Task process
// this script is used in createTaskModal and viewTaskModal


// used to remove the warning message when the user inputs a name
function CheckName() {
    var warningMsg = document.getElementById("invalid-task-name")
    warningMsg.style.display = "none";
}

// used to remove the warning message when the user selects a tag
function CheckTags() {
    var warningMsg = document.getElementById("invalid-tags")
    warningMsg.style.display = "none";
}

// used to remove the warning message when the user inputs description
function CheckDescription() {
    var warningMsg = document.getElementById("invalid-description")
    warningMsg.style.display = "none";
}