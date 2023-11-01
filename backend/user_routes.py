from flask import Blueprint, jsonify, request
from backend.db_modules import execute_query,mysql

users_blueprint = Blueprint('users', __name__)

@users_blueprint.route('/users', methods=['GET'])
def get_users():
    cur = mysql.connection.cursor()
    cur.execute("SELECT userID, userName, userEmail, userRole FROM user")
    users = cur.fetchall()
    result = [{
        "userID": user[0],
        "userName": user[1],
        "userEmail": user[2],
        "userRole": user[3]
    } for user in users]
    return jsonify(result)

# API route to get a specific user ( without userPassword attribute )
@users_blueprint.route('/users/<int:user_id>', methods=['GET'])
def get_user(user_id):
    cur = mysql.connection.cursor()
    cur.execute("SELECT userID, userName, userEmail, userRole FROM user WHERE userID = %s", [user_id])
    user = cur.fetchone()
    if not user:
        return jsonify({"error": "User not found"}), 404

    result = {
        "userID": user[0],
        "userName": user[1],
        "userEmail": user[2],
        "userRole": user[3]
    }
    return jsonify(result)

@users_blueprint.route('/create_member', methods=['POST'])
def create_member():
    data = request.json
    cur = mysql.connection.cursor()
    print(data)
    try:
        cur.execute(f"INSERT INTO User(userName, userEmail, userPassword, userRole) VALUES('{data['memberName']}','{data['memberEmail']}', '{data['memberPassword']}', '{data['memberRole']}')")
        mysql.connection.commit()
        user_id = cur.lastrowid
        return jsonify({"success": True, "message": "User Created successfully", "userID": user_id}), 201
    
    except Exception as e:
        mysql.connection.rollback()
        return jsonify({"success": False, "message": "Failed to create user", "error": str(e)}), 500


@users_blueprint.route('/change_password/<int:user_id>/<string:new_password>', methods=['PUT'])
def change_password(user_id, new_password):
    if not user_id:
        return "No user ID provided", 400
    
    cur = mysql.connection.cursor()
    
    try:
        cur.execute("UPDATE user SET userPassword = %s WHERE userID = %s;", (new_password, user_id))
        mysql.connection.commit()
        
        return jsonify({
            "success": True,
            "message": "Password changed successfully!"
        }), 200
    except Exception as e:
        mysql.connection.rollback()
        return jsonify({
            "success": False,
            "message": "Failed to change password",
            "error": str(e)
        }), 500



    
@users_blueprint.route('/remove_member/<int:user_id>', methods=['DELETE'])
def delete_member(user_id):
    cur = mysql.connection.cursor()
    try:
        cur.execute(f"Update Task set assigneeID = 7 where assigneeID = {user_id};")
        cur.execute(f"DELETE FROM Hour_Logged WHERE userID = {user_id}")
        cur.execute(f"DELETE FROM User WHERE userID = {user_id}")

        mysql.connection.commit()
        return jsonify({"success": True, "message": "User removed successfully"}), 200
    except Exception as e:
        mysql.connection.rollback()
        return jsonify({"success": False, "message": "Failed to remove user", "error": str(e)}), 500