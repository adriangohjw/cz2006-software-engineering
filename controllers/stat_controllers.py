import sys
from os import path, getcwd
sys.path.append(getcwd())

from flask import jsonify, request
from flask_restful import Resource
from flask.helpers import make_response

from exceptions import ErrorWithCode

from contracts.stat_contracts import daily_calories_read_contract
    
from operations.stat_operations import daily_calories_read_operations


class dailyCaloriesAPI(Resource):

    def get(self):
        
        # contracts
        try:
            s = daily_calories_read_contract(request)
        except Exception as e:
            return make_response(
                jsonify (
                    error = str(e),
                ), 400
            )

        # operations
        try:
            stats = daily_calories_read_operations(
                s['user_id']
            )
        except ErrorWithCode as e:
            return make_response(
                jsonify (
                    error = e.message
                ), e.status_code
            )
        
        # success case
        return make_response(
            jsonify (stats), 200
        )
