from flask import Blueprint, request, jsonify, make_response
import json
from src import db

music = Blueprint('music', __name__)