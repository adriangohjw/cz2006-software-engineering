from models import Route

from dao.route_dao import routeCreate, routeRead, routeUpdate, routeDelete
from dao.user_dao import userRead
from operations.point_operations import point_create_operation

from exceptions import ErrorWithCode


def initialize_route(
    user_id, distance, polyline, purpose, calories, ascent, descent,
    startPos_latitude, startPos_longtitude,
    endPos_latitude, endPos_longtitude
):

    startPos = point_create_operation(startPos_latitude, startPos_longtitude)
    endPos = point_create_operation(endPos_latitude, endPos_longtitude)
    
    return Route(user_id, distance, polyline, purpose, calories, ascent, descent, startPos.id, endPos.id)


def route_read_operation(id):

    route = routeRead(id)

    # route is not found
    if route is None:
        raise ErrorWithCode(409, "No route found")

    # success case
    return route


def route_create_operation(
    username, distance, polyline, purpose, calories, ascent, descent,
    startPos_latitude, startPos_longtitude,
    endPos_latitude, endPos_longtitude
):

    user = userRead(col='username', value=username)

    # if dependency record is not found
    if user is None:
        raise ErrorWithCode(409, "No user found")

    route = initialize_route(
        user.id, distance, polyline, purpose, calories, ascent, descent,
        startPos_latitude, startPos_longtitude,
        endPos_latitude, endPos_longtitude
    )

    if routeCreate(route) == False:
        raise ErrorWithCode(503, "Unsuccessful")

    # success case
    return route
    

def route_update_operation(id, calories):

    route = routeRead(id)

    # route is not found
    if route is None:
        raise ErrorWithCode(409, "No route found")

    if calories is not None:
        route.calories = calories

    if routeUpdate() == False:
        raise ErrorWithCode(503, "Unsuccessful")

    # success case
    return route


def route_delete_operation(id):

    route = routeRead(id)
    
    # route is not found
    if route is None:
        raise ErrorWithCode(409, "No route found")

    if routeDelete(id) == False:
        raise ErrorWithCode(503, "Unsuccessful")

    # success case
    return True
    