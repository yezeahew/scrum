from flask import Blueprint, jsonify,render_template,request
from backend.db_modules import execute_query,mysql

sprint_backlog_blueprint = Blueprint('sprint_backlog', __name__)

# API route to get all tasks in Sprint Backlog
@sprint_backlog_blueprint.route('/sprint_backlog_tasks/<int:sprint_id>', methods=['GET'])
def get_all_sprint_backlog_tasks(sprint_id):

    # for task Name, Story point and priority
    cur = mysql.connection.cursor()
    cur.execute(f"select * from sprint_task_view where sprintID = {sprint_id};")
    tasks = cur.fetchall()

    result = [{
        "sprintTaskID":task[0],
        "sprintID": task[1],
        "taskID": task[2],
        "taskName": task[3],
        "taskType": task[4],
        "taskNumStoryPoint": task[5],
        "taskPriority":task[6],
        "taskStatus":task[7],
        "taskStage":task[8],
        "taskDesc":task[9],
        "assigneeID":task[10],
        "taskDateCreated":task[11],
        "taskTags":task[12],
        "sprintStatus":task[13]
    } for task in tasks]
    return jsonify(result)

# API or getting the sprint status for displaying in the sprint backlog
@sprint_backlog_blueprint.route('/get_sprint_status/<int:sprint_id>', methods=['GET'])
def get_sprint_status(sprint_id):
    if not sprint_id:
        return "No Sprint ID", 400
    
    cur = mysql.connection.cursor()
    cur.execute(f"select sprintStatus from sprint_view where sprintID = {sprint_id};")
    sprint_status = cur.fetchone()
    result = {"sprintStatus": sprint_status[0]}
    return jsonify(result)

@sprint_backlog_blueprint.route('/sprintBacklog/<int:sprint_id>')
def sprint_backlog_modal(sprint_id):
    return render_template('sprintBacklog.html', sprintID = sprint_id)

@sprint_backlog_blueprint.route('/addSprintTasksModal/<int:sprint_id>')
def add_sprint_tasks_modal(sprint_id):
    return render_template('addSprintTasks.html',sprintID = sprint_id)

@sprint_backlog_blueprint.route('/startSprintManually')
def start_sprint_manually():
    return render_template('startSprintManuallyModal.html')

#API to add tasks to sprint
@sprint_backlog_blueprint.route('/add_sprint_task/<int:task_id>/<int:sprint_id>',methods=['PUT'])
def add_sprint_task(task_id,sprint_id):
    if not task_id:
        # Handle the scenario where no ID was provided
        return "No task ID provided!", 400
    
    cur = mysql.connection.cursor()
    cur.execute("UPDATE task SET taskActive = 'N' WHERE taskID = %s;", [task_id])
    cur.execute(f"INSERT INTO Sprint_Task(`sprintID`, `taskID`) VALUES ({sprint_id}, {task_id})")
    mysql.connection.commit()

    return jsonify({
            "success": True,
            "message": "Task added to sprint successfully"
        }), 200

@sprint_backlog_blueprint.route('/revoke_sprint_task/<int:task_id>', methods=['PUT'])
def revoke_sprint_task(task_id):
    if not task_id:
        # Handle the scenario where no ID was provided
        return "No task ID provided!", 400
    
    cur = mysql.connection.cursor()

    # Retrieve the sprintTaskID associated with the task
    cur.execute("SELECT sprintTaskID FROM Sprint_Task WHERE taskID = %s", [task_id])
    sprint_task_id = cur.fetchone()

    if not sprint_task_id:
        return "Task not found in any sprint!", 404

    sprint_task_id = sprint_task_id[0]

    try:
        # Set task to active so it displays on product backlog
        cur.execute("UPDATE task SET taskActive = 'Y' WHERE taskID = %s;", [task_id])

        # Delete all hours logged data for the sprint task
        cur.execute("DELETE FROM Hour_Logged WHERE sprintTaskID = %s", [sprint_task_id])

        # Delete the task from the Sprint_Task table
        cur.execute("DELETE FROM Sprint_Task WHERE taskID = %s", [task_id])

        mysql.connection.commit()

        return jsonify({
            "success": True,
            "message": "Task removed from sprint successfully along with associated hours logged data"
        }), 200

    except Exception as e:
        # Handle any database errors that may occur
        return str(e), 500

# get details of sprint for burndown chart
@sprint_backlog_blueprint.route('/burndown_chart/sprint_details/<int:sprint_id>', methods=['GET'])
def get_burndown_chart_sprint_data(sprint_id):
    if not sprint_id:
        # Handle the scenario where no ID was provided
        return "No sprint ID provided!", 400
    
    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM Sprint WHERE sprintID = %s", [sprint_id])
    sprint = cur.fetchone()
    if not sprint:
        return jsonify({"error": "Sprint not found"}), 404

    # Sprint table has columns named sprintName, sprintStatus, startTime, and endTime
    return jsonify({
        "sprintID": sprint[0],
        "sprintName": sprint[1],
        "startTime": sprint[2],
        "endTime": sprint[3]
    })

@sprint_backlog_blueprint.route('/logHoursModal/<int:task_id>')
def log_hours_modal(task_id):
    if not task_id:
        # Handle the scenario where no ID was provided
        return "No task ID provided!", 400

    cur = mysql.connection.cursor()
    # cur.execute("SELECT s.sprintTaskID, t.assigneeID FROM Sprint_Task s INNER JOIN task t ON s.taskID = t.taskID WHERE t.taskID = %s", [task_id])
    cur.execute("SELECT sprintTaskID, assigneeID,sprintStartDate,sprintEndDate FROM Sprint_Task_View WHERE taskID = %s", [task_id])

    row = cur.fetchone()
    sprintTask = {
        "sprintTaskID" : row[0],
        "userID" : row[1],
        "sprintStartDate":row[2],
        "sprintEndDate":row[3]
    }
    return render_template("logHoursModal.html", sprintTask=sprintTask)

# get tasks for a sprint for burndown chart
@sprint_backlog_blueprint.route('/burndown_chart/sprint_task_details/<int:sprint_id>', methods=['GET'])
def get_burndown_chart_tasks_data(sprint_id):
    if not sprint_id:
        # Handle the scenario where no ID was provided
        return "No sprint ID provided!", 400
    
    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM sprint_task_view WHERE sprintID = %s", [sprint_id])
    tasks = cur.fetchall()
    if not tasks:
        return jsonify({"error": "task not found"}), 404

    # tasks 
    result = [{
        "taskID": task[2],
        "taskName": task[3],
        "taskType": task[4],
        "taskNumStoryPoint": task[5],
        "taskPriority": task[6],
        "taskStatus": task[7],
        "taskStage": task[8],
        "taskDesc": task[9],
        "assigneeID": task[10],
        "taskDateCreated": task[11],
        "taskTags": task[12],
        
    } for task in tasks]
    return jsonify(result)

# get sprint details for accumulation of effort graph
@sprint_backlog_blueprint.route('/AOE_graph/sprint_details/<int:task_id>')
def get_sprint_details_AOE(task_id):
    if not task_id:
        # Handle the scenario where no ID was provided
        return "No sprint ID provided!", 400
    
    cur = mysql.connection.cursor()
    cur.execute("SELECT sprintID FROM sprint_task_view WHERE taskID = %s", [task_id])
    sprint_id = cur.fetchone()
    if not sprint_id:
        return jsonify({"error": "task not found"}), 404
    
    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM sprint_view WHERE sprintID = %s", [sprint_id])
    sprint = cur.fetchone()

    return jsonify({
        "sprintID": sprint[0],
        "sprintName": sprint[1],
        "sprintStatus": sprint[2],
        "startTime": sprint[3],
        "endTime": sprint[4]
        })

# get sprint details for accumulation of effort graph
@sprint_backlog_blueprint.route('/AOE_graph/hours_logged/<int:task_id>')
def get_hours_logged(task_id):
    if not task_id:
        # Handle the scenario where no ID was provided
        return "No sprint ID provided!", 400
    
    cur = mysql.connection.cursor()
    cur.execute("SELECT sprintTaskID FROM sprint_task WHERE taskID = %s", [task_id])
    sprint_task_id = cur.fetchone()
    if not sprint_task_id:
        return jsonify({"error": "task not found"}), 404
    
    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM hour_logged WHERE sprintTaskID = %s", [sprint_task_id])
    hours_logged = cur.fetchall()

    # tasks 
    result = [{
        "LogDate": log[3],
        "LogHours": log[4],
        
    } for log in hours_logged]
    return jsonify(result)

def get_sprint_backlog_task(task_id):
    cur = mysql.connection.cursor()

    cur.execute("""
        SELECT 
        taskID,
        taskName,
        taskType,
        taskNumStoryPoint,
        taskPriority,
        taskStatus,
        taskStage,
        taskDesc,
        u.userName AS assigneeName,  -- Retrieving the assignee's name
        taskTags,
        taskDateCreated,
        sprintStatus
    FROM
        Sprint_Task_View 
    LEFT JOIN
        User AS u ON assigneeID = u.userID  -- Joining Sprint_Task_View and User tables
    WHERE 
        taskID = %s;
""", [task_id])

    task = cur.fetchone()
    if not task:
        return jsonify({"error": "Task not found"}), 404

    result = {
        "taskID": task[0],
        "taskName": task[1],
        "taskType": task[2],
        "taskNumStoryPoint": task[3],
        "taskPriority": task[4],
        "taskStatus": task[5],
        "taskStage": task[6],
        "taskDesc": task[7],
        "assigneeName": task[8],
        "taskTags":task[9],
        "taskDateCreated":task[10],
        "sprintStatus":task[11]
    }

    return jsonify(result)

@sprint_backlog_blueprint.route('/log_hours', methods=['POST'])
def log_hours():
    # expected data format 
    # data = {'sprintTaskID' : 'Id',
    #         'userID': id,
    #         'logDate' : 'dd-mm-yyyy',
    #         'hoursLogged' : 'xx.xx'
    #
    data = request.json
    cur = mysql.connection.cursor()
    log_date = None
    print("log_hours",data)
    # SQL code to convert into DATE type  
    if data['logDate']:
        log_date = f"STR_TO_DATE('{data['logDate']}', \"%d-%m-%Y\")"
    try:
        query = f"INSERT INTO Hour_Logged(`sprintTaskID`,`userID`, `logDate`, `hoursLogged`) VALUES ({data['sprintTaskID']}, {data['userID']},{log_date}, {data['hoursLogged']})"
        print(f"SQL Query: {query}")

        cur.execute(query)
            
        mysql.connection.commit()
        # Fetch the ID of the last inserted sprint to return in the response
        logID = cur.lastrowid
        return jsonify({"success": True, "message": "Hours logged successfully", "Log ID": logID}), 201

    except Exception as e:
        mysql.connection.rollback()
        return jsonify({"success": False, "message": str(e), "error": str(e)}), 500
