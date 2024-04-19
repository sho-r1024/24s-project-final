from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db

artists = Blueprint('artists', __name__)

# Get all the artists from the database
@artists.route('/artists', methods=['GET'])
def get_all_artists():
    cursor = db.get_db().cursor()

    cursor.execute('SELECT artist_id, manager_id, label_id, number_fans FROM Artists')

    column_headers = [x[0] for x in cursor.description]

    json_data = []

    theData = cursor.fetchall()

    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

# Get an artist that matches the applied id
@artists.route('/artists/<artist_id>', methods=['GET'])
def get_single_artist(artistID):
    cursor = db.get_db().cursor()
    
    query = f'SELECT artist_id, manager_id, label_id, number_fans FROM Artists WHERE artist_id = {artistID}'

    cursor.execute(query)

    column_headers = [x[0] for x in cursor.description]

    json_data = []

    theData = cursor.fetchall()

    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

# Gets all music from an artist
@artists.route('/music/<artist_id>', methods=['GET'])
def get_all_music(artist_id):
    cursor = db.get_db().cursor()

    cursor.execute(f"SELECT m.* FROM Music m JOIN Artists a ON m.artist_id = a.artist_id WHERE a.artist_id = %s", 
            (artist_id,))
    
    column_headers = [x[0] for x in cursor.description]

    json_data = []

    theData = cursor.fetchall()

    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

# Add a new song
@artists.route('/music/add_song', methods=['POST'])
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

# Delete a song
@artists.route('/music', methods=['DELETE'])
def delete_song():
    
    # collecting data from the request object 
    the_data = request.json
    current_app.logger.info(the_data)

    #extracting the variable
    music_id = the_data['song_id']

    # Constructing the query
    query = 'delete from Music where '
    query += 'song_id = ' + music_id + ';'
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    return 'Success!'

