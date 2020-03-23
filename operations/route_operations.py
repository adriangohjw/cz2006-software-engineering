from models import Route

from dao.route_dao import routeCreate, routeRead, routeUpdate, routeDelete

from exceptions import ErrorWithCode


def initialize_route(distance, purpose, elevationLevel, ascent, descent):
    return Route(distance, purpose, elevationLevel, ascent, descent)


def route_read_operation(id):

    route = routeRead(id)

    # route is not found
    if route is None:
        raise ErrorWithCode(404, "No route found")

    # success case
    return route


def route_create_operation(distance, purpose, elevationLevel, ascent, descent):

    route = initialize_route(distance, purpose, elevationLevel, ascent, descent)
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
    