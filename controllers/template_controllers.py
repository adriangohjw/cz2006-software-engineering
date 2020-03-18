from flask import jsonify, request
from flask_restful import Resource

from flask.helpers import make_response

# from contracts import classReadContract, classCreateContract, classUpdateContract, classDeleteContract
# from operations import classReadOperation, classCreateOperation, classUpdateOperation, classDeleteOperation
from exceptions import ErrorWithCode

class classAPI(Resource):
    def get(self):
        # contracts
        try:
            q = classReadContract(request)
        except Exception as e:
            return make_response(
                jsonify (
                    error = str(e),
                ), 400
            )

        # operations
        try:
            class = classReadOperation(q['id'])
        except ErrorWithCode as e:
            return make_response(
                jsonify (
                    error = e.message
                ), e.status_code
            )
        
        # success case
        return make_response(
            jsonify (class.asdict()), 200
        )

    def post(self):
        # contracts
        try:
            q = classCreateContract(request)
        except Exception as e:
            return make_response(
                jsonify (
                    error = str(e),
                ), 400
            )

        # operations
        try:
            class = classCreateOperation(q['topic_id'], q['lesson_id'], q['description'])
        except ErrorWithCode as e:
            return make_response(
                jsonify (
                    error = e.message
                ), e.status_code
            )
        
        # success case
        return make_response(
            jsonify(class.asdict()), 200
        )

    def put(self):
        # contracts
        try:
            q = classUpdateContract(request)
        except Exception as e:
            return make_response(
                jsonify (
                    error = str(e),
                ), 400
            )    
        
        # operations
        try:
            class = classUpdateOperation(q['id'], q['description'])
        except ErrorWithCode as e:
            return make_response(
                jsonify (
                    error = e.message
                ), e.status_code
            )
        
        # success case
        return make_response(
            jsonify(class.asdict()), 200
        )

    def delete(self):
        # contracts
        try:
            q = classDeleteContract(request)
        except Exception as e:
            return make_response(
                jsonify (
                    error = str(e),
                ), 400
            )    
        
        # operations
        try:
            class = classDeleteOperation(q['id'])
        except ErrorWithCode as e:
            return make_response(
                jsonify (
                    error = e.message
                ), e.status_code
            )
        
        # success case
        return make_response(
            jsonify(
                message = 'Successfully deleted class'
            ), 200
        )