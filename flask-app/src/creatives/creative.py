from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db

creatives = Blueprint('creatives', __name__)

# Get all the creatives from the database
@creatives.route('/creatives', methods=['GET'])
def get_all_creatives():
    cursor = db.get_db().cursor()

    cursor.execute('SELECT creative_id FROM Creatives')

    column_headers = [x[0] for x in cursor.description]

    json_data = []

    theData = cursor.fetchall()

    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

# Add a portfolio
@creatives.route('/portfolios/add_portfolio', methods=['POST'])
def add_new_song():
    
    # collecting data from the request object 
    the_data = request.json
    current_app.logger.info(the_data)

    #extracting the variable
    portfolio_id = the_data['portfolio']
    author_id = the_data['author']
    title = the_data['title']
    views = the_data['views']

    # Constructing the query
    query = 'insert into portfolios (music_id, artist_id, genre, playtime) values ("'
    query += portfolio_id + '", "'
    query += author_id + '", "'
    query += title + '", '
    query += views + ')'
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    return 'Success!'