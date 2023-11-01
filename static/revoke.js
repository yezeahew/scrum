var revokeModal = new bootstrap.Modal(document.getElementById('revoke-confirmation-modal'));
import { showDynamicModal } from "./dynamicModal.js";

function reloadPage() {
    location.reload();
}

function setupRevokeButtonListeners(task) {
    var revokeButton = document.getElementById("revoke-button");

    if (task.sprintStatus =="Active"){
        revokeButton.style.display = "none"; // hide the button
    }
    else{
        revokeButton.style.display = ""; 
    }
    revokeButton.addEventListener("click", () => {
        revokeModal.show();
    });

    var confirmRevokeButton = document.getElementById("confirm-revoke");
    confirmRevokeButton.addEventListener("click", () => {
        revokeTask(task.taskID);
    });

    var closeButton = document.querySelector("#revoke-confirmation-modal .btn-close");
    closeButton.addEventListener("click", () => {
        revokeModal.hide();
    });

    var cancelButton = document.querySelector("#revoke-confirmation-modal .btn-secondary");
    cancelButton.addEventListener("click", () => {
        revokeModal.hide();
    });
}

function revokeTask(taskId) {
    $.ajax({
        type: "PUT",
        url: `/revoke_sprint_task/${taskId}`,
        success: function (response) {
            if (response.success) {
                showDynamicModal("Alert",`Task ${taskId} along with associated hours logged data, is removed from sprint successfully`,reloadPage,reloadPage);
                // alert(`Task ID "${taskId}" revoked successfully!`);
            } else {
                showDynamicModal("Alert",`Failed to revoke task: ${response.message}`,reloadPage,reloadPage);
                // alert(`Failed to revoke task: ${response.message}`);
            }
            revokeModal.hide();

        },
        error: function (error) {
            showDynamicModal("Alert",`An error occureed while trying to revoke task.\nError message:\n${error.responseText}`,reloadPage,reloadPage);
            revokeModal.hide();
            // alert(`Error occurred: ${error.responseText}`);
        }
    });
}

export { setupRevokeButtonListeners };
