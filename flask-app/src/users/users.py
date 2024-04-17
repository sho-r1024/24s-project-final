from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db

user = Blueprint('user', __name__)

@user.route('/user', methods=['GET'])
def get_all_users():
    # get a cursor object from the database
    cursor = db.get_db().cursor()

    # use cursor to query the database for a list of users
    cursor.execute('SELECT user_id, first_name, last_name, email, bio FROM User')

    # grab the column headers from the returned data
    column_headers = [x[0] for x in cursor.description]

    # create an empty dictionary object to use in 
    # putting column headers together with data
    json_data = []

    # fetch all the data from the cursor
    theData = cursor.fetchall()

    # for each of the rows, zip the data elements together with
    # the column headers. 
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)


@user.route('/user/<userID>', methods=['PUT'])
def update_user(userID):
    # collecting data from the request object 
    the_data = request.json
    current_app.logger.info(the_data)

    #extracting the variable
    first_name = the_data['user_first_name']
    last_name = the_data['user_last_name']
    bio = the_data['user_bio']
    email = the_data['user_email']
    # social_media = the_data['product_category']

    # Constructing the query
    
    query = f"update User " \
        f"set first_name = '{first_name}', set last_name = '{last_name}, set email = '{email}', set bio = '{bio}' " \
        f"where user_id = {userID}"
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    return 'Success!'

@user.route('/user/bio/<userID>', methods=['PUT'])
def update_user_bio(userID):
    # collecting data from the request object 
    the_data = request.json
    current_app.logger.info(the_data)

    #extracting the variable
    bio = the_data['user_bio']
    # social_media = the_data['product_category']

    # Constructing the query
    query = f"update User " \
        f"set bio = '{bio}' " \
        f"where user_id = {userID}"
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    return 'Success!'