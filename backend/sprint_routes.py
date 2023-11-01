from flask import Blueprint, jsonify,request
from backend.db_modules import execute_query,mysql

sprints_blueprint = Blueprint('sprints', __name__)

@sprints_blueprint.route('/get_all_sprints', methods=['GET'])
def get_all_sprints():
    try:
        query = f"""SELECT 
            sprintID,
            sprintName,
            sprintStatus,
            sprintStartDate,
            sprintEndDate
        FROM Sprint_View"""
        sprints = execute_query(query)
        return jsonify({"success": True, "data": sprints}), 200
    except Exception as e:
        return jsonify({"success": False, "message": f"Failed to fetch sprints: {str(e)}"}), 500


@sprints_blueprint.route('/get_sprint/<int:sprint_id>', methods=['GET'])
def get_sprint_by_id(sprint_id):
    print("get sprint by id", sprint_id)
    try:
        # Use a parameterized query to prevent SQL injection
        query = f"""
       SELECT 
            sprintID,
            sprintName,
            sprintStatus,
            sprintStartDate,
            sprintEndDate
        FROM Sprint_View
        WHERE sprintID = {sprint_id}
        """
        # Execute the query with the sprint_id as a parameter
        result = execute_query(query)
        
        # Check if a sprint with the given ID was found
        if not result:
            return jsonify({"success": False, "message": f"No sprint found with ID: {sprint_id}"}), 404

        return jsonify({"success": True, "data": result[0]}), 200
    except Exception as e:
        return jsonify({"success": False, "message": f"Failed to fetch sprint: {str(e)}"}), 500

@sprints_blueprint.route('/create_sprint', methods=['POST'])
def create_sprint():
    # expected data format 
    # data = {'sprintName' : 'sprintName',
    #         'sprintStatus' : 'Not Started' OR 'Active' OR 'Completed',
    #         'sprintStartDate' : None OR 'dd-mm-yyyy',
    #         'sprintEndDate' : None OR 'dd-mm-yyyy'}
    #
    data = request.json
    cur = mysql.connection.cursor()
    start_date = 'NULL'
    end_date = 'NULL'
    print(data)
    # SQL code to convert into DATE type  
    if data['sprintStartDate']:
        start_date = f"STR_TO_DATE('{data['sprintStartDate']}', \"%d-%m-%Y\")"
    if data['sprintEndDate']:
        end_date = f"STR_TO_DATE('{data['sprintEndDate']}', \"%d-%m-%Y\")"
    try:
        print(f"INSERT INTO Sprint(sprintName, sprintStartDate, sprintEndDate) VALUES ('{data['sprintName']}', {start_date}, {end_date})")
        cur.execute(
            f"INSERT INTO Sprint(sprintName, sprintStartDate, sprintEndDate) VALUES ('{data['sprintName']}', {start_date}, {end_date})"
        )
        mysql.connection.commit()
        # Fetch the ID of the last inserted sprint to return in the response
        sprint_id = cur.lastrowid
        return jsonify({"success": True, "message": "Sprint created successfully", "sprintID": sprint_id}), 201

    except Exception as e:
        mysql.connection.rollback()
        return jsonify({"success": False, "message": "Failed to create sprint", "error": str(e)}), 500

@sprints_blueprint.route('/edit_sprint/<int:sprint_id>', methods=['PUT'])
def edit_sprint(sprint_id):
    # expected data format 
    # data = {'sprintName' : 'sprintName',
    #         'sprintStatus' : 'Not Started' OR 'Active' OR 'Completed',
    #         'sprintStartDate' : None OR 'dd-mm-yyyy',
    #         'sprintEndDate' : None OR 'dd-mm-yyyy'}
    data = request.json
    cur = mysql.connection.cursor()
    start_date = 'NULL'
    end_date = 'NULL'
    print(data)

    # SQL code to convert into DATE type  
    if data['sprintStartDate']:
        start_date = f"STR_TO_DATE('{data['sprintStartDate']}', \"%d-%m-%Y\")"
    if data['sprintEndDate']:
        end_date = f"STR_TO_DATE('{data['sprintEndDate']}', \"%d-%m-%Y\")"
    try:
        print(f"UPDATE Sprint SET sprintName = '{data['sprintName']}', sprintStartDate = {start_date}, sprintEndDate = {end_date} WHERE sprintID = {sprint_id}"
)
        cur.execute(
            f"UPDATE Sprint SET sprintName = '{data['sprintName']}', sprintStartDate = {start_date}, sprintEndDate = {end_date} WHERE sprintID = {sprint_id}"
    )
        mysql.connection.commit()
        return jsonify({"success": True, "message": "Sprint updated successfully"}), 200

    except Exception as e:
        mysql.connection.rollback()
        return jsonify({"success": False, "message": "Failed to update sprint", "error": str(e)}), 500

@sprints_blueprint.route('/sprint_backlog/not_started/sprintID=<int:sprint_id>/', methods=['GET'])
def get_not_started_tasks(sprint_id):
    return get_tasks_by_status(sprint_id, 'Not Started')

@sprints_blueprint.route('/sprint_backlog/in_progress/sprintID=<int:sprint_id>/', methods=['GET'])
def get_in_progress_tasks(sprint_id):
    return get_tasks_by_status(sprint_id, 'In Progress')

@sprints_blueprint.route('/sprint_backlog/completed/sprintID=<int:sprint_id>/', methods=['GET'])
def get_completed_tasks(sprint_id):
    return get_tasks_by_status(sprint_id, 'Completed')

def get_tasks_by_status(sprint_id, status):
    try:
        # Generic SQL query for tasks by status
        query = f"""
        SELECT t.*
        FROM Task_View t
        INNER JOIN Sprint_Task st ON t.taskID = st.taskID
        WHERE st.sprintID = {sprint_id}
        AND t.taskStatus = "{status}";
        """
        
        # Execute the query and store the results
        tasks = execute_query(query)
        
        return jsonify(tasks), 200

    except Exception as e:
        return jsonify({"error": f"Failed to fetch {status} tasks: {str(e)}"}), 500
    
    #API to add tasks to sprint
@sprints_blueprint.route('/add_sprint_task/<int:task_id>',methods=['PUT'])
def add_sprint_task(task_id):
    if not task_id:
        # Handle the scenario where no ID was provided
        return "No task ID provided!", 400
    
    cur = mysql.connection.cursor()
    cur.execute("UPDATE task SET taskActive = 'N' WHERE taskID = %s;", [task_id])
    mysql.connection.commit()

    return jsonify({
            "success": True,
            "message": "Task added to sprint successfully"
        }), 200

@sprints_blueprint.route('/delete_sprint/<int:sprint_id>', methods=['DELETE'])
def delete_sprint(sprint_id):
    print(sprint_id)
    cur = mysql.connection.cursor()
    try:
        # First, check if the sprint exists
        cur.execute("SELECT * FROM Sprint WHERE sprintID = %s", [sprint_id])
        sprint = cur.fetchone()
        if not sprint:
            print("Sprint not found")
            return jsonify({"success": False, "message": "Sprint not found"}), 404

        # Delete the sprint
        cur.execute("DELETE FROM Sprint WHERE sprintID = %s", [sprint_id])
        mysql.connection.commit()

        return jsonify({"success": True, "message": "Sprint deleted successfully"}), 200

    except Exception as e:
        mysql.connection.rollback()
        # Check if the error is due to a foreign key constraint
        if "foreign key constraint fails" in str(e).lower():
            return jsonify({"success": False, "message": "Cannot delete sprint as it has associated tasks. Please remove or reassign the tasks first."}), 400
        return jsonify({"success": False, "message": f"Failed to delete sprint: {str(e)}"}), 500
