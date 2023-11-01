$(document).ready(function () {
    $("#load-add-team-member-modal").click(function (e) {
        e.preventDefault();
        $("#modal-container").load("/addNewMemberModal", function () {
            $("#add-new-member-modal").modal("show");
        });
    });
});

$(document).ready(function () {
    $("#view-stats-btn").click(function (e) {
        e.preventDefault();
        e.stopPropagation();
        window.location.href = '/teamStatistics';
    });
});

function addUserCard(userID, userName, userEmail, userRole) {
    const userCard = document.createElement("div");
    userCard.className = "user-card";
    userCard.setAttribute("data-user-id", userID);

    const userInfoContainer = document.createElement("div"); // Container for user name and email
    userInfoContainer.className = "user-info-container";

    const user_name = document.createElement("h3");
    user_name.style.color = "#f99417";
    user_name.textContent = userName;

    const user_email = document.createElement("h2");
    user_email.style.color = "#000000";
    user_email.textContent = userEmail;

    const removeContainer = document.createElement("div"); // Container for the remove button
    removeContainer.className = "remove-container";

    const removebtn = document.createElement("button");
    removebtn.className = "btn remove-member";
    removebtn.id = "load-remove-member-modal";
    removebtn.textContent = "Remove"

    removebtn.addEventListener('click', function (event) {
        event.stopPropagation();
        $("#modal-container").load("/removeTeamMemberModal/" + userID, function () {
            // console.log(userID);
            $('#removeModal').modal('show');
            setupRemoveButtonListeners();
        });
    });

    

    userInfoContainer.appendChild(user_name);
    userInfoContainer.appendChild(user_email);

    removeContainer.appendChild(removebtn);

    userCard.appendChild(userInfoContainer);
    userCard.appendChild(removeContainer);

    if (userRole != "Admin") {
        document.querySelector(".team-list").appendChild(userCard);
    }
}

function renderUsers(users) {
    const teamList = document.querySelector(".team-list");
    teamList.innerHTML = '';
    users.forEach(user => {
        // console.log("UserName:", user.userName)
        addUserCard(user.userID, user.userName, user.userEmail, user.userRole);
    });
}
// Function to generate task cards
function generateUserCards() {
    $.ajax({
        url: "/users", // Assuming the frontend and backend are on the same domain
        method: "GET",
        success: function (data) {
            // console.log("Fetched Users:", data);
            allTasks = data; // save data in a list
            renderUsers(allTasks);
        },
        error: function (error) {
            console.error("Error fetching Uers:", error);
        }
    });
}

function setupRemoveButtonListeners() {
    var closeButton = document.querySelector("#removeModal .close");
    var cancelButton = document.querySelector("#removeModal .btn-secondary");

    closeButton.addEventListener("click", () => {
        $('#removeModal').modal('hide');
    });

    cancelButton.addEventListener("click", () => {
        $('#removeModal').modal('hide');
    });
}

// Call function to generate tasks
generateUserCards();