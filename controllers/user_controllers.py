from flask import jsonify, request
from flask_restful import Resource
from flask.helpers import make_response

from exceptions import ErrorWithCode

from contracts.user_contracts import \
    user_create_contract, user_read_contract, user_update_contract, user_update_password_contract, \
    user_read_contract_byID
    
from operations.user_operations import \
    user_create_operation, user_read_operation, user_update_operation, user_update_password_operation


class userAPI(Resource):

    def get(self):
        
        # contracts
        try:
            u = user_read_contract(request)
        except Exception as e:
            return make_response(
                jsonify (
                    error = str(e),
                ), 400
            )

        # operations
        try:
            user = user_read_operation(
                col='username', value=u['username']
            )
        except ErrorWithCode as e:
            return make_response(
                jsonify (
                    error = e.message
                ), e.status_code
            )
        
        # success case
        return make_response(
            jsonify (user.asdict()), 200
        )


    def post(self):

        # contracts
        try:
            u = user_create_contract(request)
        except Exception as e:
            return make_response(
                jsonify (
                    error = str(e),
                ), 400
            )

        # operations
        try:
            user = user_create_operation(
                u['username'], u['plaintext_password'], u['name']
            )
        except ErrorWithCode as e:
            return make_response(
                jsonify (
                    error = e.message
                ), e.status_code
            )
        
        # success case
        return make_response(
            jsonify(user.asdict()), 200
        )


    def put(self):

        # contracts
        try:
            u = user_update_contract(request)
        except Exception as e:
            return make_response(
                jsonify (
                    error = str(e),
                ), 400
            )    
        
        # operations
        try:
            user = user_update_operation(
                u['username'], u['name'], u['age'], u['height'], u['weight']
            )
        except ErrorWithCode as e:
            return make_response(
                jsonify (
                    error = e.message
                ), e.status_code
            )
        
        # success case
        return make_response(
            jsonify(user.asdict()), 200
        )


class userAPI_byID(Resource):

    def get(self):
        
        # contracts
        try:
            u = user_read_contract_byID(request)
        except Exception as e:
            return make_response(
                jsonify (
                    error = str(e),
                ), 400
            )

        # operations
        try:
            user = user_read_operation(
                col='id', value=u['id']
            )
        except ErrorWithCode as e:
            return make_response(
                jsonify (
                    error = e.message
                ), e.status_code
            )
        
        # success case
        return make_response(
            jsonify (user.asdict()), 200
        )


class userPasswordAPI(Resource):

    def put(self):

        # contracts
        try:
            u = user_update_password_contract(request)
        except Exception as e:
            return make_response(
                jsonify (
                    error = str(e),
                ), 400
            )    
        
        # operations
        try:
            user = user_update_password_operation(
                u['username'], u['current_password'], u['new_password']
            )
        except ErrorWithCode as e:
            return make_response(
                jsonify (
                    error = e.message
                ), e.status_code
            )
        
        # success case
        return make_response(
            jsonify(user.asdict()), 200
        )
