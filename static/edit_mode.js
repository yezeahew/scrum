var editButton = document.getElementById('edit-task-button');

function enableEditMode() {
    // Check the current mode based on the button's text
    if (editButton.innerText === "Edit Task") {
        // Code for enabling edit mode:

        // Remove the disabled attribute from all inputs and selects
        var disabledElements = document.querySelectorAll('#edit-task-button, input[disabled], select[disabled], textarea[disabled]');
        disabledElements.forEach(element => {
            element.removeAttribute('disabled');
        });

        // Toggle the visibility of Assignee
        // Normal mode - Input 
        // Edit mode - Drop Down select button
        var normalModeInput = document.querySelector('.input-normal-mode');
        var editModeSelect = document.querySelector('.input-group-lg:not(.input-normal-mode)');
        normalModeInput.style.display = 'none';
        editModeSelect.style.display = 'block';

        // Make the Save button visible
        var saveButton = document.getElementById('save-task-button');
        saveButton.style.visibility = 'visible';

        // Change the button text to "Cancel Edit"
        editButton.innerText = "Cancel Edit";
    } else {
        // Code for canceling the edit mode:
        cancelEditMode();
    }
}

function cancelEditMode() {
    // close modal and reload the entire page
    // is this ugly? help 
    location.reload();
}

