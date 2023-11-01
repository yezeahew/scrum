import { validateSprintForm } from "./sprint_form_validation.js";

$(document).ready(function () {
    $("#load-create-sprint-modal").click(function (e) {
        e.preventDefault();
        $("#modal-container").load("/createNewSprint", function () {
            $("#create-sprint-modal").modal("show");
            setupCheckboxBehavior();
            document.getElementById("create-sprint-button").addEventListener("click", createSprint);
        });
    });
});

function setupCheckboxBehavior() {
    var setDatesCheckbox = document.getElementById('setDates');
    var startDateInput = document.getElementById('startDateInput');
    var endDateInput = document.getElementById('endDateInput');

    // Add a change event listener to the checkbox
    setDatesCheckbox.addEventListener('change', function () {
        if (setDatesCheckbox.checked) {
            // Enable the date fields when checkbox is checked
            startDateInput.disabled = false;
            endDateInput.disabled = false;
        } else {
            // Disable the date fields when checkbox is unchecked
            startDateInput.disabled = true;
            endDateInput.disabled = true;
        }
    });
}

function createSprint() {
    const data = validateSprintForm();
    // console.log("attempt to get data", data);

    if (data) {
        // Send the create request
        sendCreateRequest(data)
            .then(result => {
                alert(result.message);
                if (result.success) {
                    // You can redirect to a new page or refresh the current page
                    location.reload();
                }
            })
            .catch(() => alert("Failed to create sprint. Please try again."));
    }
}

function sendCreateRequest(payload) {
    return fetch('/create_sprint', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify(payload),
    })
        .then(response => response.json());
}