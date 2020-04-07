from flask import request    

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


def validate_latitude(latitude):

    # if not found in params
    if (latitude is None):
        raise TypeError("Request params (latitude) not found")

    # if description params is empty
    if not latitude: 
        raise ValueError("latitude is empty")

    # if not float
    if not isinstance(latitude, float):
        raise TypeError("latitude is not float")


def validate_longtitude(longtitude):

    # if not found in params
    if (longtitude is None):
        raise TypeError("Request params (longtitude) not found")

    # if description params is empty
    if not longtitude: 
        raise ValueError("longtitude is empty")

    # if not float
    if not isinstance(longtitude, float):
        raise TypeError("longtitude is not float")


def point_read_contract(request):    

    id = request.args.get('id', type=int)

    validate_id(id)

    return {
        'id': int(id)
    }


def point_create_contract(request):

    latitude = request.args.get('latitude', type=float)
    longtitude = request.args.get('longtitude', type=float)

    validate_latitude(latitude)
    validate_longtitude(longtitude)

    return {
        'latitude': float(latitude),
        'longtitude': float(longtitude)
    }
