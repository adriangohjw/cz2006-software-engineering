from flask import jsonify, request
from flask_restful import Resource
from flask.helpers import make_response

from exceptions import ErrorWithCode

from contracts.point_contracts import point_read_contract
    
from operations.point_operations import point_read_operation


class pointAPI(Resource):

    def get(self):
        
        # contracts
        try:
            p = point_read_contract(request)
        except Exception as e:
            return make_response(
                jsonify (
                    error = str(e),
                ), 400
            )

        # operations
        try:
            point = point_read_operation(p['id'])
        except ErrorWithCode as e:
            return make_response(
                jsonify (
                    error = e.message
                ), e.status_code
            )
        
        # success case
        return make_response(
            jsonify (point.asdict()), 200
        )
