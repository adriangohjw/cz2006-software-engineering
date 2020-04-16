from flask import Flask
from config import ConfigTest
from flask_cors import CORS

def create_app():
    app = Flask(__name__)
    CORS(app)
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
    app.config['SQLALCHEMY_DATABASE_URI'] = ConfigTest.URI
    app.config['DEBUG'] = True
    app.config['TESTING'] = True
    app.url_map.strict_slashes = False

    return app
