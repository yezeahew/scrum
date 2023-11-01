import { fetchUsers, validateTaskForm } from './task_validation.js';

function handleError(error) {
    console.error('Error:', error);
}

function sendCreateRequest(data) {
    return fetch('/create_task', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify(data),
    })
    .then(response => response.json());
}

function handleCreateFormSubmit(e) {
    e.preventDefault();
    var validatedData = validateTaskForm();

    // Log the payload for debugging
    console.log("Sending data:", validatedData);

    sendCreateRequest(validatedData)
        .then(data => {
            if (data.success) {
                alert(data.message);
                location.reload();
                // redirect or update the UI to reflect the created task
            } else {
                alert('Error: ' + data.message);
            }
        })
        .catch(handleError);
}


function setupCreateForm() {
    fetchUsers().then(() => {
        var createTaskForm = document.getElementById("task-form");
        createTaskForm.addEventListener("submit", handleCreateFormSubmit);
    });
}

setupCreateForm();
