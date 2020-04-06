from flask import request

from contracts.user_contracts import validate_username as validate_user_username
from contracts.point_contracts import validate_latitude, validate_longtitude


def validate_id(id):

    # if not found in params
    if (id is None):
        raise Exception("Request params () not found")

    # if description params is empty
    if not id: 
        raise Exception("id is empty")

    # if not integer
    if not isinstance(int(id), int):
        raise Exception("id is not integer")


def validate_distance(distance):

    # if not found in params
    if (distance is None):
        raise Exception("Request params (distance) not found")

    # if description params is empty
    if not distance: 
        raise Exception("distance is empty")

    # if not integer
    if not isinstance(int(distance), int):
        raise Exception("distance is not integer")


def validate_purpose(purpose):

    # if not found in params
    if (purpose is None):
        raise Exception("Request params (purpose) not found")

    # if description params is empty
    if not purpose: 
        raise Exception("purpose is empty")


def validate_polyline(polyline):

    # if not found in params
    if (polyline is None):
        raise Exception("Request params (polyline) not found")

    # if description params is empty
    if not polyline: 
        raise Exception("polyline is empty")


def validate_calories(calories):

    # if not found in params
    if (calories is None):
        raise Exception("Request params (calories) not found")

    # if description params is empty
    if not calories: 
        raise Exception("calories is empty")

    # if not integer
    if not isinstance(int(calories), int):
        raise Exception("calories is not integer")


def validate_ascent(ascent):

    # if not found in params
    if (ascent is None):
        raise Exception("Request params (ascent) not found")

    # if description params is empty
    if not ascent: 
        raise Exception("ascent is empty")

    # if not integer
    if not isinstance(int(ascent), int):
        raise Exception("ascent is not integer")


def validate_descent(descent):

    # if not found in params
    if (descent is None):
        raise Exception("Request params (descent) not found")

    # if description params is empty
    if not descent: 
        raise Exception("descent is empty")

    # if not integer
    if not isinstance(int(descent), int):
        raise Exception("descent is not integer")


def route_read_contract(request):    

    id = request.args.get('id')

    validate_id(id)

    return {
        'id': int(id)
    }


def route_create_contract(request):

    username = request.args.get('username')
    distance = request.args.get('distance')
    purpose = request.args.get('purpose')
    polyline = request.args.get('polyline')
    ascent = request.args.get('ascent')
    descent = request.args.get('descent')
    startPos_latitude = request.args.get('startPos_latitude')
    startPos_longtitude = request.args.get('startPos_longtitude')
    endPos_latitude = request.args.get('endPos_latitude')
    endPos_longtitude = request.args.get('endPos_longtitude')

    validate_user_username(username)
    validate_distance(distance)
    validate_purpose(purpose)
    validate_polyline(polyline)
    validate_ascent(ascent)
    validate_descent(descent)
    validate_latitude(startPos_latitude)
    validate_longtitude(startPos_longtitude)
    validate_latitude(endPos_latitude)
    validate_longtitude(endPos_longtitude)

    return {
        'username': username,
        'distance': distance,
        'purpose': purpose,
        'polyline': polyline,
        'ascent': ascent,
        'descent': descent,
        'startPos_latitude': startPos_latitude,
        'startPos_longtitude': startPos_longtitude,
        'endPos_latitude': endPos_latitude,
        'endPos_longtitude': endPos_longtitude,
    }


def route_update_contract(request):

    id = request.args.get('id')
    col = request.args.get('col')
    value = request.args.get('value')

    validate_id(id)

    if col == 'calories':
        validate_calories(value)

    return {
        'id': int(id),
        'col': col,
        'value': value
    }

def route_delete_contract(request):
    
    id = request.args.get('id')
    
    validate_id(id)

    return {
        'id': int(id)
    }
