from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db

managers = Blueprint('managers', __name__)

@managers.route('/managers', methods=['GET'])
def get_all_managers():
    cursor = db.get_db().cursor()

    cursor.execute('SELECT * FROM Managers')

    column_headers = [x[0] for x in cursor.description]

    json_data = []

    theData = cursor.fetchall()

    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

@managers.route('/manager/<manager_id>', methods=['GET'])
def get_single_manager(managerID):
    cursor = db.get_db().cursor()
    
    query = f'SELECT * Managers WHERE user = {managerID}'

    cursor.execute(query)

    column_headers = [x[0] for x in cursor.description]

    json_data = []

    theData = cursor.fetchall()

    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

@managers.route('/manager', methods=['POST'])
def add_new_manager():
    the_data = request.json
    current_app.logger.info(the_data)

    #extracting the variable
    user_id = the_data['manager_user_id']

    # Constructing the query
    query = 'INSERT INTO Managers (user_id) VALUES ("'
    query += user_id + ');'
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()

    return 'Success!'

@managers.route('/labels', methods=['POST'])
def register_new_label():
    the_data = request.json
    current_app.logger.info(the_data)

    #extracting the variable
    label_name = the_data['label_name']
    label_address = the_data['label_address']
    manager_id = the_data['manager_id']

    # Constructing the query
    query = 'INSERT INTO Labels (name, address) VALUES ("'
    query += label_name + '", "'
    query += label_address + ');'
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()

    query = f'UPDATE Managers ' \
        f'SET label_id = l.label_id FROM (SELECT label_id FROM Labels WHERE label_name = {label_name} AND label_address = {label_address}) l ' 
    
    cursor.execute(query)
    db.get_db().commit()

    return 'Success!'