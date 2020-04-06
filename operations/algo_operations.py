import sys
from os import path, getcwd
sys.path.append(getcwd())

from exceptions import ErrorWithCode

from Algorithms.routes_search_algo import SearchResult


def routes_search_algo_operation(start, end, fit_level, weight):
    res = SearchResult(start, end, fit_level, weight)
    return res.values.tolist()[0][0]


def popular_routes_algo_operation():
    return


def live_stats_algo_operation():
    return
