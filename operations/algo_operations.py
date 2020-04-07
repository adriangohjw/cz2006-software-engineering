import sys
from os import path, getcwd
sys.path.append(getcwd())

import googlemaps
from datetime import datetime

from config import GMAPS_KEY

from exceptions import ErrorWithCode

from Algorithms.routes_search_algo import SearchResult
from Algorithms.live_stats_algo import LiveStats

from operations.route_operations import route_read_operation
from operations.point_operations import point_read_operation


def routes_search_algo_operation(start, end, fit_level, weight):
    res = SearchResult(start, end, fit_level, weight)
    return res.values.tolist()[0][0]


def popular_routes_algo_operation():
    return


def live_stats_algo_operation(route_id):

    route = route_read_operation(route_id)
    startPos = point_read_operation(route.startPos_id)
    endPos = point_read_operation(route.endPos_id)
    
    gmaps = googlemaps.Client(key=GMAPS_KEY)
    routes = gmaps.directions(
        origin = str(startPos.latitude) + ', ' + str(startPos.longtitude),
        destination = str(endPos.latitude) + ', ' + str(endPos.longtitude),
        departure_time = datetime.now(), 
        alternatives= False
    )

    res = LiveStats(routes)
    return res.to_dict('records')
