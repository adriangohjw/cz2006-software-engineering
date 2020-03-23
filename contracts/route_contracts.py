from flask import request


def validate_id(id):

    # if not found in params
    if (id is None):
        raise Exception("Request params () not found")

    # if description params is empty
    if not id: 
        raise Exception("id is empty")

    # if not integer
    if not isinstance(id, int):
        raise Exception("id is not integer")


def validate_distance(distance):

    # if not found in params
    if (distance is None):
        raise Exception("Request params (distance) not found")

    # if description params is empty
    if not distance: 
        raise Exception("distance is empty")

    # if not integer
    if not isinstance(distance, int):
        raise Exception("distance is not integer")


def validate_purpose(purpose):

    # if not found in params
    if (purpose is None):
        raise Exception("Request params (purpose) not found")

    # if description params is empty
    if not purpose: 
        raise Exception("purpose is empty")


def validate_elevationLevel(elevationLevel):

    # if not found in params
    if (elevationLevel is None):
        raise Exception("Request params (elevationLevel) not found")

    # if description params is empty
    if not elevationLevel: 
        raise Exception("elevationLevel is empty")


def validate_calories(calories):

    # if not found in params
    if (calories is None):
        raise Exception("Request params (calories) not found")

    # if description params is empty
    if not calories: 
        raise Exception("calories is empty")

    # if not integer
    if not isinstance(calories, int):
        raise Exception("calories is not integer")


def validate_ascent(ascent):

    # if not found in params
    if (ascent is None):
        raise Exception("Request params (ascent) not found")

    # if description params is empty
    if not ascent: 
        raise Exception("ascent is empty")

    # if not integer
    if not isinstance(ascent, int):
        raise Exception("ascent is not integer")


def validate_descent(descent):

    # if not found in params
    if (descent is None):
        raise Exception("Request params (descent) not found")

    # if description params is empty
    if not descent: 
        raise Exception("descent is empty")

    # if not integer
    if not isinstance(descent, int):
        raise Exception("descent is not integer")


def route_read_contract(request):    

    id = request.args.get('id')

    validate_id(id)

    return {
        'id': int(id)
    }


def route_create_contract(request):

    distance = request.args.get('distance')
    purpose = request.args.get('purpose')
    elevationLevel = request.args.get('elevationLevel')
    ascent = request.args.get('ascent')
    descent = request.args.get('descent')

    validate_distance(distance)
    validate_purpose(purpose)
    validate_elevationLevel(elevationLevel)
    validate_ascent(ascent)
    validate_descent(descent)

    return {
        'distance': distance,
        'purpose': purpose,
        'elevationLevel': elevationLevel,
        'ascent': ascent,
        'descent': descent
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
