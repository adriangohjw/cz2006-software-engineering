import sys
from os import path, getcwd
sys.path.append(getcwd())

from flask import request
import unittest
from models import db

from run_test import create_app
app = create_app()
app.app_context().push()
db.init_app(app)

from contracts.algo_contracts import \
    validate_fit_level, validate_route_id, validate_maxDist, \
    routes_search_algo_contracts, popular_routes_algo_contracts


class Test_algo_contracts(unittest.TestCase):

    @classmethod
    def setUpClass(cls):
        print("\n\n{}: starting test...".format(path.basename(__file__)))

    
    def test_validate_route_id(self):
        
        with self.assertRaises(TypeError):
            validate_route_id(None)
            validate_route_id(1.1)
            validate_route_id(True)
            validate_route_id('hello')

        with self.assertRaises(ValueError):
            validate_route_id('')


    def test_validate_fit_level(self):
        
        with self.assertRaises(TypeError):
            validate_fit_level(None)

        with self.assertRaises(ValueError):
            validate_fit_level('')


    def test_validate_maxDist(self):
        
        with self.assertRaises(TypeError):
            validate_maxDist(None)

        with self.assertRaises(ValueError):
            validate_maxDist('')


    def test_routes_search_algo_contracts(self):

        with app.test_request_context('/?startPos_lat=1.0&startPos_long=2.0&endPos_lat=3.0&endPos_long=4.0&fit_level=5&weight=60', method='GET'):
            self.assertEqual(
                routes_search_algo_contracts(request), 
                {
                    'start': '1.0, 2.0',
                    'end': '3.0, 4.0',
                    'fit_level': 5,
                    'weight': 60,
                    'max_dist': None,
                    'cal': None
                }
            )

        with app.test_request_context('/', method='GET'):
            self.assertRaises(TypeError, routes_search_algo_contracts, request)

        with app.test_request_context('/?startPos_lat=&startPos_long=&endPos_lat=&endPos_long=&fit_level=&weight=', method='GET'):
            self.assertRaises(TypeError, routes_search_algo_contracts, request)

        with app.test_request_context('/?startPos_lat=hello&startPos_long=2.0&endPos_lat=3.0&endPos_long=4.0&fit_level=5&weight=60', method='GET'):
            self.assertRaises(TypeError, routes_search_algo_contracts, request)


    def test_popular_routes_algo_contracts(self):
        
        with app.test_request_context('/?weight=1', method='GET'):
            self.assertEqual(
                popular_routes_algo_contracts(request), 
                {
                    'weight': 1
                }
            )

        with app.test_request_context('/', method='GET'):
            self.assertRaises(TypeError, popular_routes_algo_contracts, request)

        with app.test_request_context('/?weight=', method='GET'):
            self.assertRaises(TypeError, popular_routes_algo_contracts, request)

        with app.test_request_context('/?weight=hello', method='GET'):
            self.assertRaises(TypeError, popular_routes_algo_contracts, request)


if __name__ == '__main__':
    unittest.main()
