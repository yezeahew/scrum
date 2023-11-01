function formatDate(dateString) {
    return dateString ? dateString.split('-').reverse().join('-') : null;
}

function endDateBeforeStartDate(startDate,endDate){
    // console.log(endDate,startDate);
    if (endDate <= startDate) {
        alert("End date must be after start date.");
        // console.log("endDateBeforeStartDate returning false");
        return false;
    }
    // console.log("endDateBeforeStartDate returning true");
    return true
}


function isValidDateRange(startDate, endDate) {
    const currentDate = new Date().setHours(0, 0, 0, 0);

    if (endDate < currentDate) {
        alert("End date must not be before today's date.");
        return false;
    }
    if (!endDateBeforeStartDate(startDate, endDate)) {
        return false;
    }
    const oneYearInMillis = 365 * 24 * 60 * 60 * 1000;
    if ((endDate.getTime() - startDate.getTime()) > oneYearInMillis) {
        alert("The duration should not be longer than 1 year.");
        return false;
    }
    return true;
}

function computeSprintStatus(sprintStartDate, sprintEndDate) {
    // console.log("Computing status");
    const currentDate = new Date();
    currentDate.setHours(0, 0, 0, 0);
    let computedStatus = "Not Started";
    if (currentDate >= sprintStartDate && currentDate <= sprintEndDate) {
        computedStatus = "Active";
    } else if (currentDate > sprintEndDate)  {
        computedStatus = "Completed";
    }
    return computedStatus;
}


function validateSprintForm() {
    // Gather data from the form
    const sprintName = document.getElementById("sprintName").textContent;
    const currentDate = new Date().setHours(0, 0, 0, 0);

    let sprintStartDateString = null;
    let sprintEndDateString = null;
    const setDatesCheckbox = document.getElementById('setDates');

    // If setDatesCheckbox exists and is checked, or if it doesn't exist at all
    if (!setDatesCheckbox || (setDatesCheckbox && setDatesCheckbox.checked)) {
        const startDateValue = document.getElementById("startDateInput").value;
        const endDateValue = document.getElementById("endDateInput").value;

        // Only format the dates if they are not empty
        if (startDateValue) {
            sprintStartDateString = formatDate(startDateValue);
        }
        if (endDateValue) {
            sprintEndDateString = formatDate(endDateValue);
        }

        // Check if only one date exists
        if ((sprintStartDateString && !sprintEndDateString) || (!sprintStartDateString && sprintEndDateString)) {
            alert("Both start and end dates are required.");
            return null;
        } else if (sprintStartDateString && sprintEndDateString) { // Only validate the date range if both dates are set
            const sprintStartDate = new Date(sprintStartDateString.split('-').reverse().join('-'));
            const sprintEndDate = new Date(sprintEndDateString.split('-').reverse().join('-'));

            if (!isValidDateRange(sprintStartDate, sprintEndDate)) {
                return null;
            }
        }
    }

    // Set the sprint status based on the dates
    let sprintStatus;
    if (sprintStartDateString && sprintEndDateString) {
        const sprintStartDate = new Date(sprintStartDateString.split('-').reverse().join('-'));
        const sprintEndDate = new Date(sprintEndDateString.split('-').reverse().join('-'));

        if (currentDate >= sprintStartDate && currentDate <= sprintEndDate) {
            sprintStatus = "Active";
        } else {
            sprintStatus = "Not Started";
        }
    }

    // Create the data object
    const data = {
        sprintName,
        sprintStatus,
        sprintStartDate: sprintStartDateString,
        sprintEndDate: sprintEndDateString
    }

    return data;
}


export { formatDate,endDateBeforeStartDate,validateSprintForm,computeSprintStatus }
