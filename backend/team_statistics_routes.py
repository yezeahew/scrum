from flask import Blueprint, jsonify,render_template,request
from backend.db_modules import execute_query,mysql

team_statistics_blueprint = Blueprint('team_statistics', __name__)

# API route to get average hours logged per day
@team_statistics_blueprint.route('/average_hours_logged/<string:start_date>/<string:end_date>', methods=['GET'])
def get_average_hours_logged(start_date, end_date):
    """
    Expected Date Format : dd-mm-yyyy
    """
    try:
        start_date_sql = f"STR_TO_DATE('{start_date}', '%d-%m-%Y')"
        end_date_sql = f"STR_TO_DATE('{end_date}', '%d-%m-%Y')"

        cur = mysql.connection.cursor()
        query = f"""SELECT
            u.userID,
            u.userName,
            u.userEmail,
            ROUND(IFNULL(SUM(h.hoursLogged), 0.00) / (DATEDIFF({end_date_sql}, {start_date_sql}) + 1),5) AS averageTimeSpent
        FROM
            User AS u
        LEFT JOIN
            Hour_Logged AS h ON u.userID = h.userID AND h.logDate BETWEEN {start_date_sql} AND {end_date_sql}
        GROUP BY
            u.userID, u.userName, u.userEmail;
"""
        cur.execute(query)
        average_hours = cur.fetchall()

        result = [{
            "userID": user[0],
            "userName": user[1],
            "userEmail": user[2],
            "averageTimeSpent": user[3]
        } for user in average_hours]

        return jsonify(result), 200
    
    except Exception as e:

        # Handle any database errors that may occur
        return str(e), 500