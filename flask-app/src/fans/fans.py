from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db

fans = Blueprint('fans', __name__)

# give feedback to a song
@fans.route('/fans', methods=['POST'])
def rate(song, rating):
    the_data = request.json
    current_app.logger.info(the_data)

    #extracting the variable
    feedback_id = the_data['feedback_id']
    song = the_data['music_id']
    user_id = the_data['user_id']
    rating = the_data['rating']

    # Constructing the query
    query = 'insert into feedback (feedback_id, music_id, user_id, rating) values ("'
    query += feedback_id + '", "'
    query += song + '", "'
    query += user_id + '", '
    query += rating + ');'
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()

    return 'Success!'
