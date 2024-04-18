from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db

creatives = Blueprint('creatives', __name__)

# Get all the creatives from the database
@creatives.route('/creatives', methods=['GET'])
def get_all_creatives():
    cursor = db.get_db().cursor()

    cursor.execute('SELECT * FROM Creatives')

    column_headers = [x[0] for x in cursor.description]

    json_data = []

    theData = cursor.fetchall()

    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

# Add a portfolio
@creatives.route('/portfolios/add_portfolio', methods=['POST'])
def add_new_portfolio():
    
    # collecting data from the request object 
    the_data = request.json
    current_app.logger.info(the_data)

    #extracting the variable
    portfolio_id = the_data['portfolio']
    author_id = the_data['author']
    title = the_data['title']
    views = the_data['views']

    # Constructing the query
    query = 'insert into portfolios (portfolio_id, author_id, title, views) values ("'
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

# Delete a portfolio
@creatives.route('/portfolios/delete_portfolio', methods=['DELETE'])
def delete_portfolio():
    
    # collecting data from the request object 
    the_data = request.json
    current_app.logger.info(the_data)

    #extracting the variable
    portfolio_id = the_data['portfoio_id']

    # Constructing the query
    query = 'DELETE FROM portfolios where '
    query += 'portfolio_id = ' + portfolio_id + ';'
    current_app.logger.info(query)

    # executing and committing the delete statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    return 'Success!'

# Add a service
@creatives.route('/services/add_service', methods=['POST'])
def add_new_service():
    
    # collecting data from the request object 
    the_data = request.json
    current_app.logger.info(the_data)

    #extracting the variable
    service_id = the_data['portfolio']
    creative_id = the_data['author']
    title = the_data['title']
    price = the_data['views']

    # Constructing the query
    query = 'INSERT INTO services (service_id, creative_id, title, price) VALUES ("'
    query += service_id + '", "'
    query += creative_id + '", "'
    query += title + '", '
    query += price + ')'
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    return 'Success!'

# Get a service that matches the applied id
@creatives.route('/services/<service_id>', methods=['GET'])
def get_single_artist(service_id):
    cursor = db.get_db().cursor()
    
    query = f'SELECT service_id, creative_id, title, price FROM Services WHERE service_id = {service_id}'

    cursor.execute(query)

    column_headers = [x[0] for x in cursor.description]

    json_data = []

    theData = cursor.fetchall()

    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)
