$(document).ready(function () {

    $("#logout-btn").click(function (e) {
        e.preventDefault();
        $("#modal-container").load("/logoutConfirmation", function () {
            $("#logoutConfirmationModal").modal("show");

            var confirm_logout_btn = document.getElementById("confirm-logout-btn")


            confirm_logout_btn.addEventListener("click", async () => {
                try {
                    // Make an AJAX request to the /logout API
                    const response = await fetch('/logout', {
                        method: 'GET',  // Use the GET method as defined in your Flask route
                    });

                    if (response.ok) {
                        // If the logout is successful, redirect to the login page
                        document.location.replace("/");
                        localStorage.setItem("user_id", null);
                    } else {
                        // Handle any error response here (e.g., display an error message)
                        console.error('Logout failed:', response.statusText);
                    }
                } catch (error) {
                    // Handle network errors or other unexpected errors here
                    console.error('Error:', error);
                }
            });
        });
    });
})

