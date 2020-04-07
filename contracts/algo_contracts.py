from flask import request 

from contracts.point_contracts import validate_latitude, validate_longtitude
from contracts.user_contracts import validate_weight
from contracts.route_contracts import validate_id as validate_route_id


def validate_fit_level(fit_level):

    # if not found in params
    if (fit_level is None):
        raise Exception("Request params (fit_level) not found")

    # if description params is empty
    if not fit_level: 
        raise Exception("fit_level is empty")


def routes_search_algo_contracts(request):

    startPos_lat = request.args.get('startPos_lat')
    startPos_long = request.args.get('startPos_long')
    endPos_lat = request.args.get('endPos_lat')
    endPos_long = request.args.get('endPos_long')
    fit_level = request.args.get('fit_level')
    weight = request.args.get('weight')

    validate_latitude(startPos_lat)
    validate_longtitude(startPos_long)
    validate_latitude(endPos_lat)
    validate_longtitude(endPos_long)
    validate_fit_level(fit_level)
    validate_weight(weight)

    return {
        'start': str(startPos_lat) + ', ' + str(startPos_long),
        'end': str(endPos_lat) + ', ' + str(endPos_long),
        'fit_level': int(fit_level),
        'weight': int(weight)
    }


def popular_routes_algo_contracts(request):
    return
    

def live_stats_algo_contracts(request):

    route_id = request.args.get('route_id')

    validate_route_id(route_id)

    return {
        'route_id': int(route_id)
    }
    