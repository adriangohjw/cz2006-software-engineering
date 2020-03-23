from flask import request

from contracts.route_contracts import validate_id as validate_route_id
    

def validate_id(id):

    # if not found in params
    if (id is None):
        raise Exception("Request params (id) not found")

    # if description params is empty
    if not id: 
        raise Exception("id is empty")

    # if not integer
    if not isinstance(id, int):
        raise Exception("id is not integer")


def validate_latitude(latitude):

    # if not found in params
    if (latitude is None):
        raise Exception("Request params (latitude) not found")

    # if description params is empty
    if not latitude: 
        raise Exception("latitude is empty")

    # if not float
    if not isinstance(latitude, float):
        raise Exception("latitude is not float")


def validate_longtitude(longtitude):

    # if not found in params
    if (longtitude is None):
        raise Exception("Request params (longtitude) not found")

    # if description params is empty
    if not longtitude: 
        raise Exception("longtitude is empty")

    # if not float
    if not isinstance(longtitude, float):
        raise Exception("latitude is not float")


def point_read_contract(request):    

    route_id = request.args.get('route_id')
    id = request.args.get('id')

    validate_route_id(route_id)
    validate_id(id)

    return {
        'route_id': int(route_id),
        'id': int(id)
    }


def point_create_contract(request):

    route_id = request.args.get('route_id')
    latitude = request.args.get('latitude')
    longtitude = request.args.get('longtitude')

    validate_route_id(route_id)
    validate_latitude(latitude)
    validate_longtitude(longtitude)

    return {
        'route_id': route_id,
        'latitude': latitude,
        'longtitude': longtitude
    }
