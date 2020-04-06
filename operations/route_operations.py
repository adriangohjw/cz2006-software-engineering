from models import Route

from dao.route_dao import routeCreate, routeRead, routeUpdate, routeDelete
from dao.user_dao import userRead
from operations.point_operations import point_create_operation

from exceptions import ErrorWithCode


def initialize_route(
    user_id, distance, polyline, purpose, ascent, descent,
    startPos_latitude, startPos_longtitude,
    endPos_latitude, endPos_longtitude
):

    startPos = point_create_operation(startPos_latitude, startPos_longtitude)
    endPos = point_create_operation(endPos_latitude, endPos_longtitude)
    
    return Route(user_id, distance, polyline, purpose, ascent, descent, startPos.id, endPos.id)


def route_read_operation(id):

    route = routeRead(id)

    # route is not found
    if route is None:
        raise ErrorWithCode(404, "No route found")

    # success case
    return route


def route_create_operation(
    user_id, distance, polyline, purpose, ascent, descent,
    startPos_latitude, startPos_longtitude,
    endPos_latitude, endPos_longtitude
):

    user = userRead(col='id', value=user_id)

    if user is None:
        raise ErrorWithCode(404, "No user found")

    route = initialize_route(
        user_id, distance, polyline, purpose, ascent, descent,
        startPos_latitude, startPos_longtitude,
        endPos_latitude, endPos_longtitude
    )

    if routeCreate(route) == False:
        raise ErrorWithCode(400, "Unsuccessful")

    # success case
    return route
    

def route_update_operation(id, col, value):

    route = routeRead(id)

    # route is not found
    if route is None:
        raise ErrorWithCode(404, "No route found")

    if col == 'calories':
        route.calories = value

    if routeUpdate() == False:
        raise ErrorWithCode(400, "Unsuccessful")

    # success case
    return route


def route_delete_operation(id):

    route = routeRead(id)
    
    # route is not found
    if route is None:
        raise ErrorWithCode(404, "No route found")

    if routeDelete(id) == False:
        raise ErrorWithCode(400, "Unsuccessful")

    # success case
    return True
    