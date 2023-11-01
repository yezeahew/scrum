var deleteModal = new bootstrap.Modal(document.getElementById('delete-confirmation-modal'));

function setupDeleteButtonListeners(task) {
    var deleteButton = document.getElementById("delete-button");
    deleteButton.addEventListener("click", () => {
        deleteModal.show();
    });

    var confirmDeleteButton = document.getElementById("confirm-delete");
    confirmDeleteButton.addEventListener("click", () => {
        deleteTask(task.taskID);
    });

    var closeButton = document.querySelector("#delete-confirmation-modal .btn-close");
    closeButton.addEventListener("click", () => {
        deleteModal.hide();
    });

    var cancelButton = document.querySelector("#delete-confirmation-modal .btn-secondary");
    cancelButton.addEventListener("click", () => {
        deleteModal.hide();
    });
}

function deleteTask(taskId) {
    $.ajax({
        type: "DELETE",
        url: `/delete_task/${taskId}`,
        success: function(response) {
            if (response.success) {
                alert(`Task ID "${taskId}" deleted successfully!`);
            } else {
                alert(`Failed to delete task from backend: ${response.message}`);
            }
            deleteModal.hide();
            location.reload(); // Refresh the page after the user acknowledges the popup
        },
        error: function(error) {
            alert(`Error occurred: ${error.responseText}`);
        }
    });
}

export { setupDeleteButtonListeners };
