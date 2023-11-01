from flask import Flask,render_template,request,jsonify,session,redirect, url_for
from functools import wraps
from backend.db_modules import init_app as init_db_app
from flask_session import Session
import logging

app = Flask(__name__)
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = 'password123'
app.config['MYSQL_DB'] = 'fit2101'
app.config['SESSION_TYPE'] = 'filesystem'

# Initialize the database module
init_db_app(app)

#initialiaze the session, this is to handle login and logout 
Session(app)

logging.basicConfig(level=logging.DEBUG)

# import these after mysql has been initialized
from backend.user_routes import users_blueprint
from backend.sprint_routes import sprints_blueprint,get_sprint_by_id
from backend.task_routes import tasks_blueprint, get_task
from backend.sprint_backlog_routes import sprint_backlog_blueprint,get_sprint_backlog_task
from backend.team_statistics_routes import team_statistics_blueprint


from backend.db_modules import execute_query, mysql


app.register_blueprint(users_blueprint)
app.register_blueprint(sprints_blueprint)
app.register_blueprint(tasks_blueprint)
app.register_blueprint(sprint_backlog_blueprint)
app.register_blueprint(team_statistics_blueprint)


# this is the function to make sure user is logged-in
def login_required(view):
    @wraps(view)
    def wrapped_view(*args, **kwargs):
        if 'user_id' in session:
            return view(*args, **kwargs)
        else:
            return redirect(url_for('render_login_page'))

    return wrapped_view

@app.route('/productBacklog')
@login_required
def render_product_backlog():
    # return render_template('/productBacklog/productBacklog.html')
    return render_template('/productBacklog.html')

@app.route('/delete')
@login_required
def render_delete_task():
    # return render_template('/productBacklog/delete_task.html')
    return render_template('/delete_task.html')

@app.route('/createTaskModal')
@login_required
def create_task_modal():
    # return render_template('/productBacklog/createTaskModal.html')
    return render_template('/createTaskModal.html')

@app.route('/viewTaskModal/<int:task_id>')
@login_required
def view_task_modal(task_id):
    if not task_id:
        # Handle the scenario where no ID was provided
        return "No task ID provided!", 400
    
    # Fetch the task details using the get_task function
    response = get_task(int(task_id))
    
    if isinstance(response, tuple):  # Checking if the response is a tuple indicating an error
        return response  # This will return the error message and status code
    
    # Else, we got the task details as a JSON. Decode it to a dictionary.
    task = response.get_json()
    
    # return render_template('/productBacklog/viewTaskModal.html', fetchedTask=task)
    return render_template('/viewTaskModal.html', fetchedTask=task)

#API to view task in the sprint
@app.route('/sprintViewTaskModal/<int:task_id>')
@login_required
def sprint_view_task_modal(task_id):
    if not task_id:
        # Handle the scenario where no ID was provided
        return "No task ID provided!", 400
    
    # Fetch the task details using the get_task function
    # response = get_task(int(task_id))
    response = get_sprint_backlog_task(int(task_id))

    if isinstance(response, tuple):  # Checking if the response is a tuple indicating an error
        return response  # This will return the error message and status code
    
    # Else, we got the task details as a JSON. Decode it to a dictionary.
    task = response.get_json()
    
    return render_template('sprintViewTaskModal.html', fetchedTask=task)

@app.route('/addSprintTasksModal')
@login_required
def add_sprint_tasks_modal():
    return render_template('addSprintTasks.html')

@app.route('/createNewSprint')
@login_required
def create_new_sprint():
    #return render_template('createSprintModal.html')
    # return render_template('/scrumBoard/createSprint.html')
    return render_template('/createSprint.html')


#API to view sprint details in the scrum board
@app.route('/viewSprintModal/<int:sprint_id>', methods=['GET'])
@login_required
def view_sprint_modal(sprint_id):
    try:
        response, status_code = get_sprint_by_id(int(sprint_id))
        fetchedData = response.get_json()
        print("view sprint",fetchedData)
        # return render_template('/scrumBoard/viewSprintModal.html', fetchedSprint=fetchedData['data'])
        return render_template('/viewSprintModal.html', fetchedSprint=fetchedData['data'])
    except ValueError as ve:
        app.logger.error(f"ValueError: {ve}")
        return str(ve), 404
    except Exception as e:
        app.logger.error(f"Exception: {e}")
        return str(e), 500

@app.route('/scrumBoard')
@login_required
def scrum_board():
    # return render_template('/scrumBoard/scrumBoard.html')
    return render_template('/scrumBoard.html')

@app.route('/burndown_chart/<int:sprint_id>')
@login_required
def render_burndown_chart(sprint_id):
    return render_template('burndownChartView.html', sprintID = sprint_id)


# Add the default route to redirect to /login
@app.route('/')
def default_route():
    return redirect('/login')


def checkUsernameAndPassword(username, password):
    # Create a cursor
    cur = mysql.connection.cursor()

    # Check if the username exists in the database
    result = cur.execute('SELECT userID,userPassword FROM User WHERE userName = %s', [username])

    # If result is 0, then user doesn't exist
    if result == 0:
        return False

    # Fetch hashed password from database
    data = cur.fetchone()
    userID,userPassword = data[0],data[1]

    # Close the connection
    cur.close()

    if password == userPassword:
        return userID  # Return the userID when the password matches
    else:
        return False

@app.route('/log_user_in', methods=['POST'])
def log_user_in():
    try:
        # Get the login data from the request JSON
        login_data = request.get_json()

        # Ensure data exists
        if not login_data:
            return jsonify({'message': 'Bad request. No data provided.'}), 400

        # Extract the username and password from the login data
        username = login_data.get('username')
        password = login_data.get('password')

        # Ensure both username and password are provided
        if not username or not password:
            return jsonify({'message': 'Bad request. Missing username or password.'}), 400

        userID = checkUsernameAndPassword(username, password)
        # Perform your login validation logic here (e.g., checkUsernameAndPassword)
        if userID:
            # If the login is successful, you can return a success response
            session['user_id'] = userID
            return jsonify({'user_id': userID}), 200
        else:
            # If the login fails, you can return an error response with a meaningful message
            return jsonify({'message': 'Invalid username or password'}), 401

    except Exception as e:
        # Catch-all for unexpected errors. In a real production environment, you'd likely want
        # to log this error for debugging.
        print(str(e))
        return jsonify({'message': 'Internal server error', 'error': str(e)}), 500



@app.route('/login')
def render_login_page():
    # return render_template('/loginPage/loginPage.html')
    return render_template('/loginPage.html')

#Manage Team API's(Start from here)
@app.route('/manageTeam')
@login_required
def manageTeam():
    return render_template('manageTeam.html')

@app.route('/addNewMemberModal')
@login_required
def add_new_member_modal():
    return render_template('addNewMemberModal.html')

@app.route('/removeTeamMemberModal/<int:user_id>')
@login_required
def remove_member_modal(user_id):
    return render_template('removeMember.html',userID = user_id)


@app.route('/getUserP/<string:password>', methods=['GET'])
@login_required
def get_user_using_password(password):
    if not password:
        # Handle the scenario where no password was provided
        return "password not provided!", 400
    
    query = f"SELECT * FROM user WHERE userPassword = '{password}'"
    
    user = execute_query(query)

    if len(user) > 0:
        return jsonify({"user": user[0]}), 200
    else:
        return jsonify({"user" : user}), 200

@app.route('/getUser/<int:user_id>', methods=['GET'])
@login_required
def get_user_using_id(user_id):
    if not user_id:
        # Handle the scenario where no ID was provided
        return "id not provided!", 400
    
    query = f"SELECT * FROM user WHERE userID = {user_id}"
    
    user = execute_query(query)

    if len(user) > 0:
        return jsonify({"user": user[0]}), 200
    else:
        return jsonify({"user" : user}), 200
    
@app.route('/CompletedDate/<int:sprint_id>', methods=['GET'])
@login_required
def get_tasks_completed_date(sprint_id):
    if not sprint_id:
        # Handle the scenario where no ID was provided
        return "id not provided!", 400
    
    query = f"SELECT * FROM sprint_task WHERE sprintID = {sprint_id}"
    
    user = execute_query(query)

    return jsonify({"user": user}), 200

@app.route('/teamStatistics')
@login_required
def render_statistics_page():
    return render_template('/teamStatistics.html')

@app.route('/ProjectDateRange', methods=['GET'])
@login_required
def get_project_date_range():
    query = f"SELECT MIN(sprintStartDate) AS start_date FROM sprint"

    start_date = execute_query(query)

    query = f"SELECT MAX(sprintEndDate) AS end_date FROM sprint"
    end_date = execute_query(query)

    return jsonify({
        "startDate" : start_date[0],
        "endDate" : end_date[0]
        })

@app.route('/getLoggedHoursByUser/<int:user_id>', methods=['GET'])
@login_required
def get_logged_hours_using_user_id(user_id):
    
    if user_id == 0:
        query = f"SELECT userID, logDate, hoursLogged FROM hour_logged"
        loggedHours = execute_query(query)
    else:
        query = f"SELECT userID, logDate, hoursLogged FROM hour_logged WHERE userID = {user_id}"
        loggedHours = execute_query(query)

    return jsonify({
        "log_hours": loggedHours
        })


@app.route('/profile')
@login_required
def render_profile_page():
    return render_template('/profile.html')

@app.route('/logoutConfirmation')
@login_required
def render_logout_modal():
    return render_template('/logoutConfirmationModal.html')

@app.route('/logout')
def logout():
    session.pop('user_id', None)  # Remove the user_id from the session
    return redirect('/login')  # Redirect to the login page

if __name__ == '__main__':
    app.run(debug=True)