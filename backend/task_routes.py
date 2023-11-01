from flask import Blueprint, jsonify,request
from backend.db_modules import execute_query,mysql

tasks_blueprint = Blueprint('tasks', __name__)

# API route to create task
@tasks_blueprint.route('/create_task', methods=['POST'])
def create_task():
    data = request.json
    #print(data)
    cur = mysql.connection.cursor()
    try:
        cur.execute(
            "INSERT INTO Task(taskName, taskType, taskNumStoryPoint, taskPriority, taskStatus, taskStage, taskDesc, assigneeID) VALUES (%s, %s, %s, %s, %s, %s, %s, %s)",
            (data['taskName'], data['taskType'], data['taskNumStoryPoint'], data['taskPriority'], data['taskStatus'], data['taskStage'], data['taskDesc'], data['assigneeID'])
        )
        # Fetch the ID of the last inserted task
        task_id = cur.lastrowid

        # Assuming the tags are sent as a list of tag names under the key 'tags' in the request JSON
        for tag_name in data['tags']:
            # Convert tag name to the format expected in the database
            db_tag_name = ' '.join(word.capitalize() for word in tag_name.split('-'))

            # Perform a lookup in the Tag table to get the tagID for this tagName
            cur.execute("SELECT tagID FROM Tag WHERE tagName = %s", (db_tag_name,))
            result = cur.fetchone()

            # If a matching tagID is found, insert the task-tag relation
            if result:
                tag_id = result[0]
                cur.execute("INSERT INTO Task_Tag(tag_ID, task_ID) VALUES (%s, %s)", (tag_id, task_id))
            else:
                # Handle the case where the tag was not found
                return {"success": False, "message": f"Tag '{tag_name}' not found in the database."}
        mysql.connection.commit()
        return jsonify({"success": True, "message": "Task and tags created successfully"}), 201
    
    except Exception as e:
        mysql.connection.rollback()
        return jsonify({"success": False, "message": "Failed to create task", "error": str(e)}), 500


# API route to get all tasks details
@tasks_blueprint.route('/tasks', methods=['GET'])
def get_all_tasks():
    cur = mysql.connection.cursor()
    cur.execute("select taskID, taskName, taskType, taskNumStoryPoint, taskPriority, taskStatus, taskStage, taskdesc,group_concat(t.tagName),assigneeID from tag t, task_tag tt, task ttt where tt.task_ID = ttt.taskID and t.tagID = tt.tag_ID group by tt.task_ID;")
    tasks = cur.fetchall()
    result = [{
        "taskID": task[0],
        "taskName": task[1],
        "taskType": task[2],
        "taskNumStoryPoint": task[3],
        "taskPriority": task[4],
        "taskStatus": task[5],
        "taskStage": task[6],
        "taskDesc": task[7],
        "taskTags": task[8],
        "assigneeID": task[9]
    } for task in tasks]
    return jsonify(result)

# API route to get all tasks in Product Backlog
# API route to get all tasks details
# This API fetches from task_view, thus the shorter code
@tasks_blueprint.route('/ntasks', methods=['GET'])
def nget_all_tasks():
    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM Task_View")
    tasks = cur.fetchall()
    result = [{
        "taskID": task[0],
        "taskName": task[1],
        "taskType": task[2],
        "taskNumStoryPoint": task[3],
        "taskPriority": task[4],
        "taskStatus": task[5],
        "taskStage": task[6],
        "taskDesc": task[7],
        "taskTags": task[8],
        "assigneeID": task[9],
        "assigneeName":task[10],
        "taskDateCreated":task[11]
    } for task in tasks]
    return jsonify(result)


# API route to get all tasks 
@tasks_blueprint.route('/backlog_tasks', methods=['GET'])
def get_all_backlog_tasks():
    # for task Name, Story point and priority
    cur = mysql.connection.cursor()
    cur.execute("select taskID,taskName, taskNumStoryPoint, taskPriority,group_concat(t.tagName),taskDateCreated from tag t, task_tag tt, task ttt where tt.task_ID = ttt.taskID and t.tagID = tt.tag_ID and ttt.taskActive = 'Y' group by tt.task_ID;")
    tasks = cur.fetchall()

    result = [{
        "taskID":task[0],
        "taskName": task[1],
        "taskNumStoryPoint": task[2],
        "taskPriority": task[3],
        "taskTags": task[4],
        "taskDateCreated":task[5]
    } for task in tasks]
    return jsonify(result)



# API route to get all tasks 
@tasks_blueprint.route('/nbacklog_tasks', methods=['GET'])
def nget_all_backlog_tasks():
    # for task Name, Story point and priority
    cur = mysql.connection.cursor()
    cur.execute("select taskID,taskName,taskNumStoryPoint,taskPriority,taskTags,taskDateCreated from Task_View;")
    tasks = cur.fetchall()

    result = [{
        "taskID":task[0],
        "taskName": task[1],
        "taskNumStoryPoint": task[2],
        "taskPriority": task[3],
        "taskTags": task[4],
        "taskDateCreated":task[5]
    } for task in tasks]
    return jsonify(result)

# API route to get all tasks in Sprint Backlog
@tasks_blueprint.route('/sprint_backlog_tasks', methods=['GET'])
def get_all_sprint_backlog_tasks():

    # for task Name, Story point and priority
    cur = mysql.connection.cursor()
    cur.execute("select taskID,taskName, taskNumStoryPoint, taskPriority, taskStatus, group_concat(t.tagName),taskDateCreated from tag t, task_tag tt, task ttt where tt.task_ID = ttt.taskID and t.tagID = tt.tag_ID and ttt.taskActive = 'N' group by tt.task_ID;")
    tasks = cur.fetchall()

    result = [{
        "taskID":task[0],
        "taskName": task[1],
        "taskNumStoryPoint": task[2],
        "taskPriority": task[3],
        "taskStatus": task[4],
        "taskTags": task[5],
        "taskDateCreated":task[6]
    } for task in tasks]
    return jsonify(result)


# API route to get a specific tasks (this is to display, so i want the assignee name too)
@tasks_blueprint.route('/tasks/<int:task_id>', methods=['GET'])
def get_task(task_id):
    cur = mysql.connection.cursor()

    cur.execute("""
        SELECT 
        t.taskID,
        t.taskName,
        t.taskType,
        t.taskNumStoryPoint,
        t.taskPriority,
        t.taskStatus,
        t.taskStage,
        t.taskDesc,
        u.userName AS assigneeName,  -- Retrieving the assignee's name
        GROUP_CONCAT(tag.tagName ORDER BY tag.tagName ASC) AS tagList,
        taskDateCreated
    FROM
        Task AS t
    LEFT JOIN
        Task_Tag AS tt ON t.taskID = tt.task_ID
    LEFT JOIN
        Tag AS tag ON tt.tag_ID = tag.tagID
    LEFT JOIN
        User AS u ON t.assigneeID = u.userID  -- Joining Task and User tables
    WHERE 
        t.taskID = %s
    GROUP BY
        t.taskID;
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
        "taskDateCreated":task[10]
    }

    return jsonify(result)

# API route to get a specific tasks (this is to display, so i want the assignee name too)
@tasks_blueprint.route('/ntasks/<int:task_id>', methods=['GET'])
def nget_task(task_id):
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
        assigneeName, 
        taskTags,
        taskDateCreated
    FROM
        Task_View
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
        "taskDateCreated":task[10]
    }

    return jsonify(result)

# API to edit task
@tasks_blueprint.route('/edit_task/<int:task_id>', methods=['PUT'])
def edit_task(task_id):
    try:
        data = request.json
        cur = mysql.connection.cursor()

        attributes = ["taskName", "taskType", "taskNumStoryPoint", "taskPriority", 
                      "taskStatus", "taskStage", "taskDesc", "assigneeID","taskTags"]
        
        for attr in attributes:
            if attr in data:
                cur.execute(f"UPDATE Task SET {attr} = %s WHERE taskID = %s", (data[attr], task_id))

        # check if task is accociated to a sprint and updated completed date accordingly            
        update_task_completed_date(task_id)
        # Handling Task_Tag changes
        # Step 1: Delete the current tags associated with the task
        cur.execute("DELETE FROM Task_Tag WHERE task_ID = %s", [task_id])

        # Step 2: Add the new tags from the request
        if 'tags' in data:
            for tag_name in data['tags']:
                # Convert tag name to the format expected in the database
                db_tag_name = ' '.join(word.capitalize() for word in tag_name.split('-'))
                
                # Perform a lookup in the Tag table to get the tagID for this tagName
                cur.execute("SELECT tagID FROM Tag WHERE tagName = %s", (db_tag_name,))
                result = cur.fetchone()

                # If a matching tagID is found, insert the task-tag relation
                if result:
                    tag_id = result[0]
                    cur.execute("INSERT INTO Task_Tag(tag_ID, task_ID) VALUES (%s, %s)", (tag_id, task_id))
                else:
                    # Handle the case where the tag was not found
                    return jsonify({"success": False, "message": f"Tag '{tag_name}' not found in the database."}), 400
        

        mysql.connection.commit()

        # Return  
        return jsonify({
            "success": True,
            "message": "Task updated successfully"
        }), 200

    except Exception as e:
        return jsonify({
            "success": False,
            "message": str(e),
            "error": str(e)
        }), 500


# always call this function when editting task to determine whether comleted date needs to be updated 
def update_task_completed_date(task_id):
    try:
        cur = mysql.connection.cursor()

        # Check if task exists in the Sprint_Task table
        cur.execute("SELECT taskID, taskStatus FROM Sprint_Task_View WHERE taskID = %s", [task_id])
        sprint_task = cur.fetchone()

        if sprint_task:
            # If task status is 'completed', set current date as the completed date
            if sprint_task[1] == 'Completed':
                cur.execute("UPDATE Sprint_Task SET taskCompletedDate = NOW() WHERE taskID = %s", [task_id])
            # If task status is not 'completed', set completed date to NULL
            else:
                cur.execute("UPDATE Sprint_Task SET taskCompletedDate = NULL WHERE taskID = %s", [task_id])
            mysql.connection.commit()
        # Return success
        return {"success": True, "message": "Task completed date updated successfully."}
    except Exception as e:
        return {"success": False, "message": str(e), "error": str(e)}


# API route to change assingnee 
@tasks_blueprint.route('/change_task_asignee/<int:task_id>', methods=['PUT'])
def edit_task_assignee(task_id,assignee_id):
    try:
        data = request.json
        cur = mysql.connection.cursor()

        attributes = ["assigneeID"]

        for attr in attributes:
            if attr in data:
                cur.execute(f"UPDATE Task SET {attr} = %s where taskID = %s",(assignee_id,task_id))
        mysql.connection.commit()
        
        cur.execute("SELECT * FROM user WHERE userID = %s", [assignee_id])
        task = cur.fetchone()
        if not task:
            return jsonify({"error": "User not found"}), 404

        return jsonify({
            "success": True,
            "message": "Assignee updated successfully",
            "task": {
                "taskID": task[0],
                "taskName": task[1],
                "taskType": task[2],
                "taskNumStoryPoint": task[3],
                "taskPriority": task[4],
                "taskStatus": task[5],
                "taskStage": task[6],
                "taskDesc": task[7],
                "assigneeID": task[8]
            }
        }), 200

    except Exception as e:
        return jsonify({
            "success": False,
            "message": "Failed to Edit Assignee",
            "error": str(e)
        }), 500

# API route to delete tasks 
@tasks_blueprint.route('/delete_task/<int:task_id>', methods=['DELETE'])
def delete_task(task_id):
    try:
        cur = mysql.connection.cursor()

        # First check if task exists
        cur.execute("SELECT * FROM Task WHERE taskID = %s", [task_id])
        task = cur.fetchone()

        if not task:
            return jsonify({
                "success": False,
                "message": "Task not found"
            }), 404
        
        # Delete the associated tags from the task_tag table
        cur.execute("DELETE FROM task_tag WHERE task_ID = %s", [task_id])

        # Delete the task
        cur.execute("DELETE FROM Task WHERE taskID = %s", [task_id])
        mysql.connection.commit()

        return jsonify({
            "success": True,
            "message": "Task deleted successfully"
        }), 200

    except Exception as e:
        return jsonify({
            "success": False,
            "message": "Failed to delete task",
            "error": str(e)
        }), 500