from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db

creatives = Blueprint('creatives', __name__)

@creatives.route('/creatives', methods=['GET'])
def get_all_managers():
    cursor = db.get_db().cursor()

    cursor.execute('SELECT * FROM Creatives')

    column_headers = [x[0] for x in cursor.description]

    json_data = []

    theData = cursor.fetchall()

    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)