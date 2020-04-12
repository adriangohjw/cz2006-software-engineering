import sys
from os import path, getcwd
sys.path.append(getcwd())

import googlemaps
from datetime import datetime

from config import MAP_QUEST_KEY
from config import GMAPS_KEY

from exceptions import ErrorWithCode

from Algorithms.routes_search_algo import SearchResult
from Algorithms.popular_routes_algo import PopularRoutes


from operations.route_operations import route_read_operation
from operations.point_operations import point_read_operation


def routes_search_algo_operation(start, end, fit_level, weight, max_dist, cal):
    res = SearchResult(start, end, fit_level, weight, max_dist, cal)
    return res.transpose().values.tolist()


def popular_routes_algo_operation(weight):
    res = PopularRoutes(weight)
    return res.transpose().values.tolist()


