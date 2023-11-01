// teamStatistics.js
import { formatDate, endDateBeforeStartDate } from "./sprint_form_validation.js";

// Function to format decimal hours into "x hours x minutes" format
function formatHoursAndMinutes(decimalHours) {
    let formattedTime = "";

    // Separate the decimal part from the integer part
    const hours = Math.floor(decimalHours);
    const minutes = Math.round((decimalHours - hours) * 60);

    if (hours > 0) {
        formattedTime += `${hours} hour${hours !== 1 ? 's' : ''}`;
    }

    if (minutes > 0) {
        if (formattedTime !== "") {
            formattedTime += " ";
        }
        formattedTime += `${minutes} minute${minutes !== 1 ? 's' : ''}`;
    }

    if (formattedTime === "") {
        formattedTime = "0 hours";
    }

    return formattedTime;
}




$(document).ready(function () {
    var users
    function getUsers() {
        var fetchUsers = new Promise(function(resolve, reject) {
            $.ajax({
                url: "/users" ,
                method: "GET",
                success: function(data) {
                    // console.log("Fetched users:", data);
                    users = data
                    resolve(); // Resolve the promise when the AJAX call is successful
                },
                error: function(error) {
                    console.error("Error fetching sprint:", error);
                    reject(error); // Reject the promise on error
                }
            });
        });
    
        Promise.all([fetchUsers])
        .then(function() {
            populatedDropdown(users)
        })
        .catch(function(error) {
            console.error("Error:", error);
        });
    }
    

    var dropdownList = document.getElementById("team-member-list")
    function populatedDropdown(users){
        for (let i=0; i < users.length; i++) {
            if (users[i].userRole !== "Admin") {
                let option = document.createElement("option")
                option.text = users[i].userName
                option.value = users[i].userID
                dropdownList.appendChild(option);
            }
        }
    }

    
    function getData(userID) {
        var start_Date
        var end_Date
        var logged_hours

        var fetchDates = new Promise(function(resolve, reject) {
            $.ajax({
                url: "/ProjectDateRange" ,
                method: "GET",
                success: function(data) {
                    // console.log("Fetched dates:", data);
                    start_Date = data.startDate.start_date
                    end_Date = data.endDate.end_date
                    resolve(); // Resolve the promise when the AJAX call is successful
                },
                error: function(error) {
                    console.error("Error fetching dates:", error);
                    reject(error); // Reject the promise on error
                }
            });
        });

        var fetchLoggedHours = new Promise(function(resolve, reject) {
            $.ajax({
                url: "/getLoggedHoursByUser/" + userID ,
                method: "GET",
                success: function(data) {
                    // console.log("Fetched logged hours:", data.log_hours);
                    logged_hours = data.log_hours
                    resolve(); // Resolve the promise when the AJAX call is successful
                },
                error: function(error) {
                    console.error("Error fetching logged hours:", error);
                    reject(error); // Reject the promise on error
                }
            });
        });
    
        Promise.all([fetchDates, fetchLoggedHours])
        .then(function() {
            createBarChart(start_Date, end_Date, logged_hours)
        })
        .catch(function(error) {
            console.error("Error:", error);
        });
    }

    function formatDate3(date) {
        const day = date.getUTCDate().toString().padStart(2, '0');
        const month = (date.getUTCMonth() + 1).toString().padStart(2, '0'); // Months are 0-indexed, so add 1
        const year = date.getUTCFullYear();
        return `${day}/${month}/${year}`;
    }
    
    // Used to generate a list of dates from start time to end time for a sprint
    function generateDateList(startDateStr, endDateStr) {
        const startDate = new Date(Date.parse(new Date(startDateStr).toUTCString()));
        const endDate = new Date(Date.parse(new Date(endDateStr).toUTCString()));
        const dateList = [];
    
        if (isNaN(startDate) || isNaN(endDate)) {
            // Check if the input dates are valid
            return dateList;
        }
    
        // Create a loop to generate dates with a 1-day interval
        let currentDate = startDate;
        while (currentDate <= endDate) {
            dateList.push(formatDate3(currentDate));
            currentDate.setUTCDate(currentDate.getUTCDate() + 1); // Increment by 1 day in GMT
        }
    
        return dateList;
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
        
        var logged_hours = []
        // used to get the lastest log date
        for (let i=0; i<dates.length; i++) {
            var totalHours = 0
            for (let j=0; j<hours_logged.length; j++) {
                // if log date is the same, then add the hours logged
                if (formatDate2(hours_logged[j].logDate) == dates[i]) {
                    var hours = getHours(hours_logged[j].hoursLogged)
                    totalHours += hours
                }
            }
            logged_hours.push(totalHours)
        }


        return logged_hours;
        
    }
    
    getUsers()
    getData(0)

    dropdownList.addEventListener("change", function() {
        // Get the selected option
        var selectedOption = dropdownList.options[dropdownList.selectedIndex];

        // Get the value and text of the selected option
        var selectedValue = selectedOption.value;
        var selectedText = selectedOption.text;

        // Display the selected value and text (you can do whatever you want with them)
        getData(selectedValue)

    })

    // Container where the cards will be injected
    const container = document.getElementById('member-cards-container');

    // Function to render a message when no data is available
    function RenderMessage() {
        const card = document.createElement('div');
        card.className = 'card member-card';

        const cardBody = document.createElement('div');
        cardBody.className = 'card-body';

        const cardTitle = document.createElement('h5');
        cardTitle.className = 'card-title';
        cardTitle.textContent = "Alert";

        const cardText = document.createElement('p');
        cardText.className = 'card-text';
        cardText.innerHTML = "Please enter a date range and click search";

        cardBody.appendChild(cardTitle);
        cardBody.appendChild(cardText);
        card.appendChild(cardBody);
        container.appendChild(card);
    }

    // Function to create member cards
    function createMemberCard(member) {
        if (member.userName == "admin") {
            return
        }
        const card = document.createElement('div');
        card.className = 'card member-card';

        const cardBody = document.createElement('div');
        cardBody.className = 'card-body';

        const cardTitle = document.createElement('h5');
        cardTitle.className = 'card-title card-username';
        cardTitle.textContent = member.userName;

        const cardText = document.createElement('p');
        cardText.className = 'card-text';
        cardText.innerHTML = member.userEmail;

        const avgTime = document.createElement('span');
        avgTime.className = 'avg-time';
        const formattedAvgTime = formatHoursAndMinutes(member.averageTimeSpent);
        avgTime.innerHTML = `Average Per Day: ${formattedAvgTime}`;

        cardBody.appendChild(cardTitle);
        cardBody.appendChild(cardText);
        card.appendChild(cardBody);
        container.appendChild(card);
        cardBody.appendChild(avgTime);
    }

    RenderMessage();

    function fetchAverageTimeSpentData(startdate, enddate) {
        // console.log(`/average_hours_logged/${startdate}/${enddate}`);
        // AJAX request to fetch data from the API ( Default date 01-10-2023 - 31-10-2023 )
        $.ajax({
            url: `/average_hours_logged/${startdate}/${enddate}`,
            type: 'GET',
            success: function (data) {
                // Create cards for each member in the API response data
                data.forEach(createMemberCard);
            },
            error: function (error) {
                console.error('Error:', error);
            }
        });
    }

    // Function to fetch and display average time spent data
    function fetchAndDisplayData() {
        const startDateInput = document.getElementById('startDateInput');
        const endDateInput = document.getElementById('endDateInput');

        const startDate = formatDate(startDateInput.value);
        const endDate = formatDate(endDateInput.value);

        if (!endDateBeforeStartDate(new Date(startDateInput.value), new Date(endDateInput.value))) {
            return;
        }

        // Clear existing member cards
        container.innerHTML = '';

        // Call the API with the formatted dates
        fetchAverageTimeSpentData(startDate, endDate);
    }

    // Add a click event listener to the search button
    const searchButton = document.getElementById('search-btn');
    searchButton.addEventListener('click', fetchAndDisplayData);


    
    var myChart; // Declare the chart variable outside the function
    // Function to create bar chart
    function createBarChart(startDate, endDate, loggedHours) {
        var ctx = document.getElementById('myChart').getContext('2d');

        // Sample data - replace this with actual data
        var dates = generateDateList(startDate, endDate) // Dates
        var data = generateHoursLogged(dates, loggedHours)  // Hours clocked
        
        if (myChart) {
            myChart.destroy(); // Destroy the existing chart
        }

        myChart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: dates,
                datasets: [{
                    label: 'Hours Clocked',
                    data: data,
                    backgroundColor: '#FF9417',
                }]
            },
            options: {
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
                            text: 'hours'
                        }
                    }
                }
            }
        });
    }

});
