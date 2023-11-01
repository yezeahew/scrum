// This file used to determine whether manage team button should be shown 
// This file is currently imported into:
// -productBacklog.html
// -scrumBoard.html
// -sprintBacklog.html
// -bundownChartView.html
// To ensure the functionality of this file is working correctly:
// - Make the the manage team button id in the side bar is the same ("manage-team-button")
// - the default display syle of the manage team button is "none" (you can refer to any of the file mentioned above)


var user_id = localStorage.getItem("user_id") // get user id from localStorage which is initialised in the loginPage.html

// get user using userID
function getUser() {
    
    var user

    var fetchuser = new Promise(function (resolve, reject) {
        $.ajax({
            url: "/getUser/" + user_id,
            method: "GET",
            success: function (data) {
                // console.log("User:", data.user);
                user = data.user
                resolve()
                
            },
            error: function (error) {
                console.error("Invalid User ID", error);
                reject()
            }
        });
    })

    Promise.all([fetchuser])
        .then(function () {
            checkAdminStatus(user)
        })
        .catch(function (error) {
            console.error("Error:", error);
        });
}

// check if user is admin
function checkAdminStatus(user) {
    // console.log(user.userRole)
    if (user.userRole == "Admin") {
        // display manage team button if user is an Admin
        var button = document.getElementById("manage-team-button")
        button.style.display = "block"
    }
}

// call the function to get user
getUser()