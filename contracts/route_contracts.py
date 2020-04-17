from flask import request

from contracts.user_contracts import validate_username as validate_user_username
from contracts.point_contracts import validate_latitude, validate_longtitude


def validate_id(id):

    # if not found in params
    if (id is None):
        raise TypeError("Request params (id) not found")

    # if description params is empty
    if not id: 
        raise ValueError("id is empty")

    # if not integer
    if not isinstance(id, int):
        raise TypeError("id is not integer")


def validate_distance(distance):

    # if not found in params
    if (distance is None):
        raise TypeError("Request params (distance) not found")

    # if not integer
    if not isinstance(distance, int):
        raise TypeError("distance is not int")


def validate_purpose(purpose):

    # if not found in params
    if (purpose is None):
        raise TypeError("Request params (purpose) not found")

    # if description params is empty
    if not purpose: 
        raise ValueError("purpose is empty")


def validate_polyline(polyline):

    # if not found in params
    if (polyline is None):
        raise TypeError("Request params (polyline) not found")

    # if description params is empty
    if not polyline: 
        raise ValueError("polyline is empty")


def validate_calories(calories):

    # if not found in params
    if (calories is None):
        raise TypeError("Request params (calories) not found")

    # if not integer
    if not isinstance(calories, int):
        raise TypeError("calories is not integer")


def validate_ascent(ascent):

    # if not found in params
    if (ascent is None):
        raise TypeError("Request params (ascent) not found")

    # if not integer
    if not isinstance(ascent, int):
        raise TypeError("ascent is not int")


def validate_descent(descent):

    # if not found in params
    if (descent is None):
        raise TypeError("Request params (ascent) not found")

    # if not integer
    if not isinstance(descent, int):
        raise TypeError("descent is not int")


def route_read_contract(request):    

    id = request.args.get('id', type=int)

    validate_id(id)

    return {
        'id': int(id)
    }


def route_create_contract(request):

    username = request.args.get('username')
    distance = request.args.get('distance', type=int)
    print('>>>>>')
    print(distance)
    purpose = request.args.get('purpose')
    calories = request.args.get('calories', type=int)
    polyline = request.args.get('polyline')
    ascent = request.args.get('ascent', type=int)
    descent = request.args.get('descent', type=int)
    startPos_latitude = request.args.get('startPos_latitude', type=float)
    startPos_longtitude = request.args.get('startPos_longtitude', type=float)
    endPos_latitude = request.args.get('endPos_latitude', type=float)
    endPos_longtitude = request.args.get('endPos_longtitude', type=float)

    validate_user_username(username)

    if distance is not None:
        validate_distance(distance)
    else:
        distance = 0

    validate_purpose(purpose)
    
    if calories is not None:
        validate_calories(calories)
    else:
        calories = 0

    validate_polyline(polyline)
    
    if ascent is not None:
        validate_ascent(ascent)
    else:
        ascent = 0

    if descent is not None:
        validate_descent(descent)
    else:
        descent = 0

    validate_latitude(startPos_latitude)
    validate_longtitude(startPos_longtitude)
    validate_latitude(endPos_latitude)
    validate_longtitude(endPos_longtitude)

    return {
        'username': username,
        'distance': distance,
        'purpose': purpose,
        'calories': calories,
        'polyline': polyline,
        'ascent': ascent,
        'descent': descent,
        'startPos_latitude': float(startPos_latitude),
        'startPos_longtitude': float(startPos_longtitude),
        'endPos_latitude': float(endPos_latitude),
        'endPos_longtitude': float(endPos_longtitude),
    }


def route_update_contract(request):

    id = request.args.get('id', type=int)
    calories = request.args.get('calories', type=int)

    validate_id(id)

    if (calories is None):
        raise TypeError("no params being passed in")

    if (calories is not None):
        validate_calories(calories)

    return {
        'id': int(id),
        'calories': int(calories)
    }


def route_delete_contract(request):
    
    id = request.args.get('id', type=int)
    
    validate_id(id)

    return {
        'id': int(id)
    }
