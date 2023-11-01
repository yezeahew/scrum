from flask_mysqldb import MySQL
mysql = None

def init_app(app):
    global mysql
    mysql = MySQL(app)

def execute_query(query, params=None):
    cursor = mysql.connection.cursor()
    cursor.execute(query, params)
    rows = cursor.fetchall()
    column_names = [desc[0] for desc in cursor.description]
    result = [dict(zip(column_names, row)) for row in rows]
    return result