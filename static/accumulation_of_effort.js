function parseDate(dateStr) {
    const parts = dateStr.split('-');
    if (parts.length === 3) {
        const day = parseInt(parts[0], 10);
        const month = parseInt(parts[1], 10) - 1; // Months are zero-indexed
        const year = parseInt(parts[2], 10);
        return new Date(year, month, day);
    }
    return null;
}

function generateDateList(startDateStr, endDateStr) {
    const startDate = parseDate(startDateStr);
    const endDate = parseDate(endDateStr);
    const dateList = [];
    
    // console.log("IN FUNCTION");
    // console.log(startDate);
    // console.log(endDate);
    
    if (!startDate || !endDate || startDate > endDate) {
        // Check if the input dates are valid
        return dateList;
    }

    // Create a loop to generate dates with a 1-day interval
    let currentDate = new Date(startDate);
    while (currentDate <= endDate) {
        dateList.push(formatDate(currentDate));
        currentDate.setDate(currentDate.getDate() + 1); // Increment by 1 day
    }

    return dateList;
}

function formatDate(date) {
    const year = date.getFullYear();
    const month = String(date.getMonth() + 1).padStart(2, '0');
    const day = String(date.getDate()).padStart(2, '0');
    return `${day}/${month}/${year}`;
}

// used to get the total numbers of hours from an input of "hh.mm"
function getHours(value) {
    var time = value.toString()
    time = time.split(".")
    var hours = time[0]
    var minutes = time[1]
    var hours = parseFloat(hours) + (parseFloat(minutes)/60)
    return hours
}

// used to format date in generateHoursLogged (slightly different from the first one)
function formatDate2(inputDateString) {
    const inputDate = new Date(inputDateString);
  
    if (isNaN(inputDate)) {
      return 'Invalid Date'; // Return this if the input is not a valid date string
    }
  
    const day = inputDate.getDate();
    const month = inputDate.getMonth() + 1;
    const year = inputDate.getFullYear();
  
    const formattedDate = `${day.toString().padStart(2, '0')}/${month.toString().padStart(2, '0')}/${year}`;
    
    return formattedDate;
  }
  
// used to generate list of accumulated hours until the lastest log date
function generateHoursLogged(dates, hours_logged) {

    // used to get the lastest log date
    for (let i=0; i<dates.length; i++) {
        for (let j=0; j<hours_logged.length; j++) {
            if (formatDate2(hours_logged[j].LogDate) == dates[i]) {
                var latestDateIndex = i
            }
        }
    }

    // create accumulated list
    var accumulated_hours = []
    var previousValue = 0
    for (let i=0; i<latestDateIndex + 1; i++) {
        var totalHours = 0
        for (let j=0; j<hours_logged.length; j++) {
            // if log date is the same, then add the hours logged
            if (formatDate2(hours_logged[j].LogDate) == dates[i]) {
                var hours = getHours(hours_logged[j].LogHours)
                totalHours += hours;
            }
        }
        accumulated_hours.push(previousValue + totalHours);
        var previousValue = previousValue + totalHours;
    }

    return accumulated_hours;
    
}

var myChart; // Declare the chart variable outside the function

// create the accumulation of effort graph
function createChart(startTime, endTime, hours_logged) {
    
    // console.log("START DATE: " + startTime)
    // console.log("END DATE :" + endTime)
    // console.log("HOURS LGOGED" + hours_logged)
    var hours_clocked = []
    var dates = []

    dates = generateDateList(startTime, endTime)
    hours_clocked = generateHoursLogged(dates, hours_logged)
    // console.log(dates)
    // console.log(hours_clocked)

    // Data for the chart
    var chartData = {
        labels: dates,
        datasets: [
            {
                label: 'Accumulated Hours Clocked',
                borderColor: 'rgba(255, 0, 0, 1)',
                borderWidth: 1,
                pointBackgroundColor: 'rgba(255, 0, 0, 1)',
                pointRadius: 2,
                data: hours_clocked
            },
        ]
    };

    // Get the canvas element and create the line chart
    var ctx = document.getElementById('aoe-graph').getContext('2d');

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
                        text: 'Hours Clocked'
                    }
                }
            }
        }
    });
}

export { createChart };