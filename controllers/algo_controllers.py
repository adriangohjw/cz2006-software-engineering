from flask import jsonify, request
from flask_restful import Resource
from flask.helpers import make_response

from exceptions import ErrorWithCode

from contracts.algo_contracts import \
    routes_search_algo_contracts, popular_routes_algo_contracts, live_stats_algo_contracts

from operations.algo_operations import \
    routes_search_algo_operation, popular_routes_algo_operation, live_stats_algo_operation


class RoutesSearchAlgoAPI(Resource):

    def get(self):

        # contracts
        try:
            r = routes_search_algo_contracts(request)
        except Exception as e:
            return make_response(
                jsonify (
                    error = str(e),
                ), 400
            )

        # operations
        try:
            route = routes_search_algo_operation(
                r['start'], r['end'], r['fit_level'], r['weight']
            )
        except ErrorWithCode as e:
            return make_response(
                jsonify (
                    error = e.message
                ), e.status_code
            )
        
        # success case
        return make_response(
            jsonify (route), 200
        )


class PopularRoutesAlgoAPI(Resource):

    def get(self):

        # contracts
        try:
            p = popular_routes_algo_contracts(request)
        except Exception as e:
            return make_response(
                jsonify (
                    error = str(e),
                ), 400
            )

        # operations
        try:
            point = popular_routes_algo_operation(
                p['weight']
            )
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


class LiveStatsAlgoAPI(Resource):

    def get(self):

        # contracts
        try:
            r = live_stats_algo_contracts(request)
        except Exception as e:
            return make_response(
                jsonify (
                    error = str(e),
                ), 400
            )

        # operations
        try:
            stats = live_stats_algo_operation(
                r['route_id']
            )
        except ErrorWithCode as e:
            return make_response(
                jsonify (
                    error = e.message
                ), e.status_code
            )
        
        # success case
        return make_response(
            jsonify (
                points = stats
            ), 200
        )
