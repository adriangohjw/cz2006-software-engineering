from models import Point

from dao.point_dao import pointCreate, pointRead, get_last_id

from exceptions import ErrorWithCode


def initialize_point(route_id, latitude, longtitude):
    last_point_id = get_last_id(route_id)
    return Point(
        route_id=route_id, 
        id=last_point_id + 1,
        latitude=latitude, 
        longtitude=longtitude
    )


def point_read_operation(route_id, point_id):

    point = pointRead(route_id, point_id)

    # point is not found
    if point is None:
        raise ErrorWithCode(404, "No point found")

    # success case
    return point


def point_create_operation(route_id, latiitude, longtitude):

    point = initialize_point(route_id, latiitude, longtitude)
    if pointCreate(point) == False:
        raise ErrorWithCode(400, "Unsuccessful")

    # success case
    return point
    