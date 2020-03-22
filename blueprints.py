from flask import Blueprint
from flask_restful import Api

from controllers import \
    user_controllers

user_bp = Blueprint('user', __name__)
api_user = Api(user_bp)
api_user.add_resource(user_controllers.userAPI, '/')
api_user.add_resource(user_controllers.userPasswordAPI, '/password')
