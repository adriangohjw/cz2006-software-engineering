from models import Point

from dao.point_dao import pointCreate, pointRead

from exceptions import ErrorWithCode


def initialize_point(latitude, longtitude):
    return Point(
        latitude=latitude, 
        longtitude=longtitude
    )


def point_read_operation(point_id):

    point = pointRead(point_id)

    # point is not found
    if point is None:
        raise ErrorWithCode(409, "No point found")

    # success case
    return point


def point_create_operation(latiitude, longtitude):

    point = initialize_point(latiitude, longtitude)
    if pointCreate(point) == False:
        raise ErrorWithCode(503, "Unsuccessful")

    # success case
    return point
    