var myChart; // Declare the chart variable outside the function

// use to format date
function formatDate(date) {
    const day = date.getUTCDate().toString().padStart(2, '0');
    const month = (date.getUTCMonth() + 1).toString().padStart(2, '0'); // Months are 0-indexed, so add 1
    const year = date.getUTCFullYear();
    return `${day}/${month}/${year}`;
}

// used to generate list of dates from start time to end time for sprint
function generateDateList(startDateStr, endDateStr) {
    const startDate = new Date(Date.parse(startDateStr));
    const endDate = new Date(Date.parse(endDateStr));
    const dateList = [];
    
    if (isNaN(startDate) || isNaN(endDate)) {
        // Check if the input dates are valid
        return dateList;
    }

    // Create a loop to generate dates with a 1-day interval
    let currentDate = startDate;
    while (currentDate <= endDate) {
        dateList.push(formatDate(currentDate));
        currentDate.setUTCDate(currentDate.getUTCDate() + 1); // Increment by 1 day in GMT
    }

    return dateList;
}


// used to generate list of expected storypoints based on start date, end date, and total storypoints
function generateValueList(startDateStr, endDateStr, initialValue) {
    const startDate = new Date(Date.parse(startDateStr));
    const endDate = new Date(Date.parse(endDateStr));
    const valueList = [];
    
    if (isNaN(startDate) || isNaN(endDate)) {
        // Check if the input dates are valid
        return valueList;
    }

    const daysBetween = Math.floor((endDate - startDate) / (24 * 60 * 60 * 1000));

    // Calculate the daily decrement step
    const decrementStep = initialValue / daysBetween;

    // Create a loop to generate values with a daily decrement
    let currentDate = startDate;
    let currentValue = initialValue;
    
    while (currentDate <= endDate) {
        valueList.push(currentValue);
        currentValue -= decrementStep;
        if (currentValue < 0) {
            currentValue = 0;
        }
        currentDate.setUTCDate(currentDate.getUTCDate() + 1); // Increment by 1 day in GMT
    }

    return valueList;
}

// used to calculate total storypoints for all the task in the sprint
function calculateTotalStorypoints(task_list) {
    let totalStorypoints = 0;
        for (var item of task_list) {
            // console.log(item.taskNumStoryPoint)
            totalStorypoints += parseInt(item.taskNumStoryPoint)
            // console.log(totalStorypoints)
        }
        return totalStorypoints;
}

function formatDate2(inputDateStr) {
    const inputDate = new Date(inputDateStr);
    if (isNaN(inputDate)) {
        return "Invalid Date"; // Handle invalid date input
    }
    
    const day = String(inputDate.getUTCDate()).padStart(2, '0');
    const month = String(inputDate.getUTCMonth() + 1).padStart(2, '0'); // Months are zero-indexed
    const year = inputDate.getUTCFullYear();

    return `${day}/${month}/${year}`;
}

function generateObservedValues(dates, completionDates, tasks, totalstorypoints) {
    // store each task in a dictionary
    var task_dict = {}
    for (var item of tasks) {
        task_dict[item.taskID] = item.taskNumStoryPoint
    }

    // get latest date
    var latest_date_index
    for (let i=0; i< dates.length; i++) {
        for (let j=0; j< completionDates.user.length; j++) {
            if (completionDates.user[j].taskCompletedDate != null) {
                if (formatDate2(completionDates.user[j].taskCompletedDate) === dates[i]) {
                    latest_date_index = i
                }
            }
        }
    }
    var observedData = []
    var storypoints = totalstorypoints
    for (let i=0; i< dates.length; i++) {
        for (let j=0; j< completionDates.user.length; j++) {
            
            if (completionDates.user[j].taskCompletedDate != null) {
                if (formatDate2(completionDates.user[j].taskCompletedDate) === dates[i]) {
                    storypoints -= parseInt(task_dict[completionDates.user[j].taskID])
                }
            }
        }
        if (i <= latest_date_index) {
            observedData.push(storypoints)
        }
        else {
            break
        }
        
    }
    return observedData
}

// create the burndown chart 
function createChart(startTime, endTime, tasks, completionDates) {
    // actual code to use
    var dates = generateDateList(startTime, endTime)
    var totalStorypoints = calculateTotalStorypoints(tasks)
    var expected_values = generateValueList(startTime, endTime, totalStorypoints)
    var observed_values = generateObservedValues(dates, completionDates, tasks, totalStorypoints)

    // Data for the chart
    var chartData = {
        labels: dates,
        datasets: [
            {
                label: 'Expected',
                borderColor: 'rgba(255, 0, 0, 1)',
                borderWidth: 1,
                pointBackgroundColor: 'rgba(255, 0, 0, 1)',
                pointRadius: 2,
                data: expected_values
            },
            {
                label: 'Observed',
                borderColor: 'rgba(0, 0, 255, 1)',
                borderWidth: 1,
                pointBackgroundColor: 'rgba(0,0,255, 1)',
                pointRadius: 2,
                data: observed_values
            }
        ]
    };

    // Get the canvas element and create the line chart
    var ctx = document.getElementById('myChart').getContext('2d');

    // Check if there's an existing chart instance
    if (myChart) {
        myChart.destroy(); // Destroy the existing chart
    }
    
    myChart = new Chart(ctx, {
        type: 'line',
        data: chartData,
        options: {
            responsive: true, // Make the chart responsive
            scales: {
                x: {
                    title: {
                        display: true,
                        text: 'date'
                    }
                },
                y: {
                    beginAtZero: true,
                    title: {
                        display: true,
                        text: 'Storypoints'
                    }
                }
            }
        }
    });
}

export { createChart };





