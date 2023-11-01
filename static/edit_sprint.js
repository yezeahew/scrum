import { validateSprintForm } from "./sprint_form_validation.js";

function populateSprintDetails(sprint) {
    // Populate sprint name
    document.getElementById("sprintName").textContent = sprint.sprintName;
    // Populate sprint status
    // document.getElementById("sprintStatus").textContent = sprint.sprintStatus;
    switch (sprint.sprintStatus) {
        case "Not Started":
            document.getElementById("not-started").checked = true;
            break;
        case "Active":
            document.getElementById("active").checked = true;
            break;
        case "Completed":
            document.getElementById("completed").checked = true;
            break;
    }
    // Populate time range
    document.getElementById("startDateDisplay").textContent = sprint.sprintStartDate;
    document.getElementById("endDateDisplay").textContent = sprint.sprintEndDate;

    var edit_btn = document.getElementById("edit-sprint-button");
    var delete_btn = document.getElementById("delete-button");

    if (sprint.sprintStatus == "Active") {
        edit_btn.style.display = "none";
        delete_btn.style.display = "none";
    }
    else {
        edit_btn.style.display = "";
        delete_btn.style.display = "";
    }
}


// Function to toggle edit mode
function toggleEditMode(sprint) {
    let elementsToEdit = ["sprintName", "startDateDisplay", "endDateDisplay"];
    let isEditable = document.getElementById("sprintName").contentEditable === "true";
    let editButton = document.getElementById("edit-sprint-button");
    if (isEditable) {
        // Switching to view mode
        for (let id of elementsToEdit) {
            document.getElementById(id).contentEditable = "false";
            populateSprintDetails(sprint)
        }

        // Toggle status between <p> and <select>
        // toggleStatusEditMode(isEditable,sprint.sprintStatus);
        toggleStatusEditMode(isEditable);
        toggleDateEditMode(isEditable);

        // Toggle the visibility of the Save button
        document.getElementById("save-sprint-button").style.visibility = "hidden";

        // Change the button text back to "Edit"
        editButton.textContent = "Edit";

        // Close the modal (assuming you're using Bootstrap modal)
        $(this).modal('hide'); // Replace 'yourModalId' with the actual ID of your modal

    } else {
        // Switching to edit mode
        for (let id of elementsToEdit) {
            document.getElementById(id).contentEditable = "true";
        }
        toggleDateEditMode(isEditable);
        // Toggle the visibility of the Save button
        document.getElementById("save-sprint-button").style.visibility = "visible";
        // Change the button text to "Cancel Edit"
        editButton.textContent = "Cancel Edit";
    }
}


/**
 * Toggles the display mode for the start and end date elements.
 * In view mode, the dates are displayed as text.
 * In edit mode, the dates are displayed as input fields for editing.
 * 
 *  @param {boolean} isEditable - Indicates whether the current mode is editable.
 */
function toggleDateEditMode(isEditable) {
    // Define the pairs of display and input elements for start and end dates.
    const elements = [
        { display: "startDateDisplay", input: "startDateInput" },
        { display: "endDateDisplay", input: "endDateInput" }
    ];

    // Iterate over each pair of elements.
    elements.forEach(element => {
        // Get the display and input elements for the current pair.
        const displayElement = document.getElementById(element.display);
        const inputElement = document.getElementById(element.input);

        if (isEditable) {
            // If in view mode:
            // - Show the display element (text representation of the date).
            // - Hide the input element (input field for date).
            displayElement.style.display = "inline";
            inputElement.style.display = "none";
        } else {
            // If in edit mode:
            // - Hide the display element.
            // - Show and populate the input element with the current date value.
            displayElement.style.display = "none";
            inputElement.style.display = "inline";

            //set date
            if (displayElement.textContent !== "Not Set") {
                const dateParts = displayElement.textContent.split("-");
                inputElement.value = `${dateParts[2]}-${dateParts[1]}-${dateParts[0]}`; // Convert to 'YYYY-MM-DD' format.
            } else {
                inputElement.value = ""; // Clear the input if the date is "Not Set".
            }
        }
    });
}


function saveSprintDetails(sprintId) {
    const data = validateSprintForm();
    console.log("attempt to get data", data);

    if (data) {
        // Send the edit request
        sendEditRequest(sprintId, data)
            .then(result => {
                alert(result.message);
                if (result.success) location.reload();
            })
            .catch(() => alert("Failed to save sprint details. Please try again."));
    }

}

function sendEditRequest(sprintId, payload) {
    return fetch(`/edit_sprint/${sprintId}`, {
        method: 'PUT',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify(payload),
    })
        .then(response => response.json());
}
export { toggleEditMode, populateSprintDetails, saveSprintDetails }