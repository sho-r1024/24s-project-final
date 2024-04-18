from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db

artists = Blueprint('artists', __name__)

@artists.route('/artist', methods=['GET'])
def get_all_artists():
    cursor = db.get_db().cursor()

    cursor.execute('SELECT artist_id, manager_id, label_id, number_fans FROM Artists')

    column_headers = [x[0] for x in cursor.description]

    json_data = []

    theData = cursor.fetchall()

    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)
