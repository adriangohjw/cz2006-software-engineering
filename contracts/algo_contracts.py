from flask import request 

from contracts.point_contracts import validate_latitude, validate_longtitude
from contracts.user_contracts import validate_weight


def validate_route_id(route_id):

    # if not found in params
    if (route_id is None):
        raise TypeError("Request params (route_id) not found")

    # if description params is empty
    if not route_id: 
        raise ValueError("route_id is empty")

    # if not integer
    if not isinstance(route_id, int):
        raise TypeError("route_id is not integer")


def validate_fit_level(fit_level):

    # if not found in params
    if (fit_level is None):
        raise TypeError("Request params (fit_level) not found")

    # if description params is empty
    if not fit_level: 
        raise ValueError("fit_level is empty")
        
# if (fit_level is None) and (if not fit_level) mean the same thing

def validate_maxDist(max_dist):

    # if not found in params
    if (max_dist is None):
        raise TypeError("Request params (max_dist) not found")

    # if description params is empty
    if not max_dist: 
        raise ValueError("max_dist is empty")

        
        
def validate_calories(cal):

    # if not found in params
    if (cal is None):
        raise TypeError("Request params (cal) not found")

    # if description params is empty
    if not cal: 
        raise ValueError("cal is empty")

    # if not integer
    if not isinstance(cal, int):
        raise TypeError("cal is not integer")
        
def routes_search_algo_contracts(request):

    startPos_lat = request.args.get('startPos_lat', type=float)
    startPos_long = request.args.get('startPos_long', type=float)
    endPos_lat = request.args.get('endPos_lat', type=float)
    endPos_long = request.args.get('endPos_long', type=float)
    fit_level = request.args.get('fit_level')
    weight = request.args.get('weight', type=int)
    max_dist = request.args.get('max_dist', type=float) 
    cal = request.args.get('cal', type=int) 
    
    validate_latitude(startPos_lat)
    validate_longtitude(startPos_long)
    validate_latitude(endPos_lat)
    validate_longtitude(endPos_long)
    validate_fit_level(fit_level)
    validate_weight(weight)
    if max_dist is not None:
        validate_maxDist(max_dist)
    if cal is not None:
        validate_calories(cal)

    return {
        'start': str(startPos_lat) + ', ' + str(startPos_long),
        'end': str(endPos_lat) + ', ' + str(endPos_long),
        'fit_level': int(fit_level),
        'weight': int(weight),
        'max_dist': float(max_dist) if max_dist is not None else max_dist,
        'cal': int(cal) if cal is not None else cal
    }


def popular_routes_algo_contracts(request):

    weight = request.args.get('weight', type=int)

    validate_weight(weight)

    return {
        'weight': int(weight)
    }

