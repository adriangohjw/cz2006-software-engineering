from flask import jsonify, request
from flask_restful import Resource
from flask.helpers import make_response

from exceptions import ErrorWithCode

from contracts.route_contracts import \
    route_create_contract, route_read_contract, route_update_contract, route_delete_contract
    
from operations.route_operations import \
    route_create_operation, route_read_operation, route_update_operation, route_delete_operation


class routeAPI(Resource):

    def get(self):
        
        # contracts
        try:
            r = route_read_contract(request)
        except Exception as e:
            return make_response(
                jsonify (
                    error = str(e),
                ), 400
            )

        # operations
        try:
            route = route_read_operation(r['id'])
        except ErrorWithCode as e:
            return make_response(
                jsonify (
                    error = e.message
                ), e.status_code
            )
        
        # success case
        return make_response(
            jsonify (route.asdict()), 200
        )


    def post(self):

        # contracts
        try:
            r = route_create_contract(request)
        except Exception as e:
            return make_response(
                jsonify (
                    error = str(e),
                ), 400
            )

        # operations
        try:
            route = route_create_operation(
                r['username'], r['distance'], r['polyline'], r['purpose'], r['calories'], r['ascent'], r['descent'],
                r['startPos_latitude'], r['startPos_longtitude'],
                r['endPos_latitude'], r['endPos_longtitude']
            )
        except ErrorWithCode as e:
            return make_response(
                jsonify (
                    error = e.message
                ), e.status_code
            )
        
        # success case
        return make_response(
            jsonify(route.asdict()), 200
        )


    def put(self):

        # contracts
        try:
            u = route_update_contract(request)
        except Exception as e:
            return make_response(
                jsonify (
                    error = str(e),
                ), 400
            )    
        
        # operations
        try:
            route = route_update_operation(
                u['id'], u['calories']
            )
        except ErrorWithCode as e:
            return make_response(
                jsonify (
                    error = e.message
                ), e.status_code
            )
        
        # success case
        return make_response(
            jsonify(route.asdict()), 200
        )

    
    def delete(self):

        # contracts
        try:
            r = route_delete_contract(request)
        except Exception as e:
            return make_response(
                jsonify (
                    error = str(e),
                ), 400
            )    
        
        # operations
        try:
            route = route_delete_operation(r['id'])
        except ErrorWithCode as e:
            return make_response(
                jsonify (
                    error = e.message
                ), e.status_code
            )
        
        # success case
        return make_response(
            jsonify(
                message = 'Successfully deleted route'
            ), 200
        )
