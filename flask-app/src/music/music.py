from flask import Blueprint, request, jsonify, make_response
import json
from src import db

music = Blueprint('music', __name__)

# add a new song
@products.route('/music', methods=['POST'])
def add_new_song():
    
    # collecting data from the request object 
    the_data = request.json
    current_app.logger.info(the_data)

    #extracting the variable
    music_id = the_data['music_id']
    artist_id = the_data['artist_id']
    genre = the_data['genre']
    playtime = the_data['playtime']

    # Constructing the query
    query = 'insert into music (music_id, artist_id, genre, playtime) values ("'
    query += music_id + '", "'
    query += artist_id + '", "'
    query += genre + '", '
    query += playtime + ')'
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    return 'Success!'

# remove a song from discography
@products.route('/music', methods=['DELETE'])
def delete_song():
    
    # collecting data from the request object 
    the_data = request.json
    current_app.logger.info(the_data)

    #extracting the variable
    music_id = the_data['music_id']

    # Constructing the query
    query = 'delete from music where '
    query += 'music_id = ' + music_id + ';'
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    return 'Success!'