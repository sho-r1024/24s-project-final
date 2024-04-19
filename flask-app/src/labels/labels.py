from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db

labels = Blueprint('labels', __name__)

# Gets all labels from the database
@labels.route('/labels', methods=['GET'])
def get_all_labels():
    cursor = db.get_db().cursor()

    cursor.execute('SELECT * FROM Labels')

    column_headers = [x[0] for x in cursor.description]

    json_data = []

    theData = cursor.fetchall()

    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

# registers a new label
@labels.route('/labels', methods=['POST'])
def add_label():
    the_data = request.json
    current_app.logger.info(the_data)

    #extracting the variable
    label_id = the_data['label_id']

    # Constructing the query
    query = 'INSERT INTO Labels (user_id) VALUES ("'
    query += label_id + ');'
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()

    return 'Success!'

# Gets all artists of a label 
@labels.route('/label/<label_id>', methods=['GET'])
def artists_of_label(label_id):
    cursor = db.get_db().cursor()

    cursor.execute(f'SELECT * FROM Artists WHERE label_id = {label_id}')

    column_headers = [x[0] for x in cursor.description]

    json_data = []

    theData = cursor.fetchall()

    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)