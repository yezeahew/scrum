$(document).ready(function () {
    // Load modals (need to change)
    $("#load-create-task-modal").click(function (e) {
        e.preventDefault();
        $("#modal-container").load("/createTaskModal", function () {
            // need to change something here, after 'create sprint' done
            $("#create-sprint-modal").modal("show");
        });
    });
    $(document).on("click", ".sprint-card", function (e) {
        e.preventDefault();
        const sprintID = $(this).attr("data-sprint-id");  // Get the sprint ID from  clicked card
        console.log(`Sprint card clicked! ${sprintID}`);
        // load the task modal with details specific to this ID
        $("#modal-container").load("/viewSprintModal/" + sprintID, function () {
            $("#view-sprint-modal").modal("show");
        });
    });

    allSprints = []
    // list of example data for task cards
    // Function to add task card
    function addSprintCard(sprintId, sprintName, sprintStatus, startTime, endTime) {
        const sprintBox = document.createElement("div");
        sprintBox.className = "sprint-card";
        sprintBox.setAttribute("data-sprint-id", sprintId);  // Assign the sprint ID to the card

        const sprintTitle = document.createElement("h3");
        sprintTitle.style.color = "#f99417";
        sprintTitle.textContent = sprintName;

        // add sprint status 
        const sprintStatusDiv = document.createElement("div");
        sprintStatusDiv.textContent = sprintStatus;
        sprintStatusDiv.className = "sprint-status";
        sprintBox.appendChild(sprintStatusDiv);


        // Add sprint start time and end time to the top-right
        const timeBox = document.createElement("div");
        timeBox.className = "time-box";
        timeBox.innerHTML = `Dates: <span class="time">${startTime}</span> to <span class="time">${endTime}</span>`;
        sprintBox.appendChild(timeBox);

        // Add buttons to the bottom-right of the card
        const buttons = ['Sprint Backlog', 'Sprint Graphs'];
        const buttonsDiv = document.createElement("div");
        buttonsDiv.className = "buttons";

        buttons.forEach(btnText => {
            const btn = document.createElement("button");
            btn.className = "sprint-btn";
            btn.textContent = btnText;

            if (btnText === 'Sprint Backlog') {
                btn.addEventListener('click', function () {
                    // window.location.href = `/sprintBacklog`; // Redirects 
                    //console.log(`click /sprintBacklog/${sprintId}`);
                    window.location.href = `/sprintBacklog/${sprintId}`; // Redirects based on sprint ID
                });
            } else if (btnText === 'Sprint Graphs') {
                btn.addEventListener('click', function (event) {
                    event.stopPropagation(); // Prevent the parent .sprint-card click event
                    console.log("clicked")
                    window.location.href = '/burndown_chart/' + sprintId;
                });
            }
            buttonsDiv.appendChild(btn);
        });

        sprintBox.appendChild(buttonsDiv);

        // Append the sprint card to the sprints list
        document.querySelector(".sprints-list").appendChild(sprintBox);


        // Append elements to the task card
        sprintBox.appendChild(sprintTitle);
        sprintBox.appendChild(sprintStatusDiv);
        sprintBox.appendChild(timeBox);
        sprintBox.appendChild(buttonsDiv);

        // Insert the new task card into the Scrum board
        document.querySelector(".sprints-list").appendChild(sprintBox);
    }


    // Function to generate sprint cards
    function generateSprintCards() {
        $.ajax({
            url: "/get_all_sprints",
            method: "GET",
            success: function (fetchedData) {
                console.log(`Fetched ${fetchedData.data.length} sprints`);
                allSprints = fetchedData.data; // save data in a list
                //console.log(allSprints)
                renderSprints(allSprints); // assuming you have a function to render sprints
            },
            error: function (error) {
                console.error("Error fetching sprints:", error);
            }
        });
    }

    // generate list of sprint cards 
    function renderSprints(allSprints) {
        const sprintListContainer = document.querySelector(".sprints-list");
        sprintListContainer.innerHTML = '';  // Clear the existing tasks
        allSprints.forEach(sprint => {
            addSprintCard(sprint.sprintID, sprint.sprintName, sprint.sprintStatus, sprint.sprintStartDate, sprint.sprintEndDate);
        });

        //for (let i=0; i<allSprints.length; i++) {
        //    addSprintCard(values_example[i]["id"], values_example[i]["name"], values_example[i]["status"], values_example[i]["start"], values_example[i]["end"])
        //}
    }

    // Call function to generate tasks
    generateSprintCards();


    // when status is selected for filtering
    document.body.addEventListener("click", function (e) {
        // Check if the clicked element has a 'data-filter' attribute
        if (e.target && e.target.getAttribute("data-filter")) {
            const filterType = e.target.getAttribute("data-filter");
            // console.log(`filter by ${filterType} status`);
            // Filter sprints by the selected status
            const filteredSprints = filterByStatus(filterType.toLowerCase());
            // Render the filtered sprints
            renderSprints(filteredSprints);
        }
    });


    function sortByNewest(a, b) {
        const dateA = a.sprintStartDate === "Not Set" ? new Date(0) : new Date(a.sprintStartDate);
        const dateB = b.sprintStartDate === "Not Set" ? new Date(0) : new Date(b.sprintStartDate);

        return dateB - dateA;
    }

    function sortByOldest(a, b) {
        const dateA = a.sprintStartDate === "Not Set" ? new Date(0) : new Date(a.sprintStartDate);
        const dateB = b.sprintStartDate === "Not Set" ? new Date(0) : new Date(b.sprintStartDate);

        return dateA - dateB;
    }


    function filterByStatus(sprintStatus) {
        return allSprints.filter(sprint => sprint.sprintStatus.toLowerCase().includes(sprintStatus));
    }

});




