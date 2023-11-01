// profile.js
document.addEventListener('DOMContentLoaded', function () {
    var user_id = localStorage.getItem("user_id");

    function getUser(){
        $.ajax({
            url:"/getUser/"+user_id,
            method: "GET",
            success: function(data){
                // console.log("User", data.user);
                updateProfileDetails(data.user);
            },
            error: function (error) {
                console.error("Invalid User ID", error)
            }
        });
    }

    // Function to update profile details
    function updateProfileDetails(data) {
        document.getElementById('username').innerText = data.userName;
        document.getElementById('email').innerText = data.userEmail;
        document.getElementById('role').innerText = data.userRole;
        document.getElementById('password').innerText = data.userPassword;
    }

    getUser();

        // Show the "Change Password" modal when the button is clicked
    document.getElementById("change-password-button").addEventListener("click", function () {
        $('#changePasswordModal').modal('show');
    });

        // Show the logout confirmation modal when Log out button is clicked
    document.querySelector("#logout-button").addEventListener("click", function () {
        $('#logoutConfirmationModal').modal('show');

    });
});
