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

from contracts.route_contracts import \
    validate_id, validate_distance, validate_purpose, validate_polyline, \
    validate_calories, validate_ascent, validate_descent, \
    route_read_contract, route_create_contract, route_update_contract, route_delete_contract


class Test_route_contracts(unittest.TestCase):

    maxDiff = None

    @classmethod
    def setUpClass(cls):
        print("\n\n{}: starting test...".format(path.basename(__file__)))

    
    def test_validate_id(self):
        
        with self.assertRaises(TypeError):
            validate_id(None)
            validate_id(1)

        with self.assertRaises(ValueError):
            validate_id('')


    def test_validate_distance(self):
        
        with self.assertRaises(TypeError):
            validate_distance(None)
            validate_distance(1)

        with self.assertRaises(ValueError):
            validate_distance('')

    
    def test_validate_purpose(self):
        
        with self.assertRaises(TypeError):
            validate_purpose(None)

        with self.assertRaises(ValueError):
            validate_purpose('')


    def test_validate_polyline(self):
        
        with self.assertRaises(TypeError):
            validate_polyline(None)

        with self.assertRaises(ValueError):
            validate_polyline('')


    def test_validate_calories(self):
        
        with self.assertRaises(TypeError):
            validate_calories(None)
            validate_calories(1)

        with self.assertRaises(ValueError):
            validate_calories('')


    def test_validate_ascent(self):
        
        with self.assertRaises(TypeError):
            validate_ascent(None)
            validate_ascent(1)

        with self.assertRaises(ValueError):
            validate_ascent('')


    def test_validate_descent(self):
        
        with self.assertRaises(TypeError):
            validate_descent(None)
            validate_descent(1)

        with self.assertRaises(ValueError):
            validate_descent('')


    def test_route_read_contract(self):

        with app.test_request_context('/?id=1', method='GET'):
            self.assertEqual(
                route_read_contract(request), 
                {
                    'id': 1
                }
            )

        with app.test_request_context('/?id=', method='GET'):
            self.assertRaises(TypeError, route_read_contract, request)

        with app.test_request_context('/?id=hello', method='GET'):
            self.assertRaises(TypeError, route_read_contract, request)


    def test_route_create_contract(self):

        with app.test_request_context('/?username=johndoe&distance=10&purpose=casual&calories=20&polyline=test&ascent=30&descent=40&startPos_latitude=50.0&startPos_longtitude=60.0&endPos_latitude=70.0&endPos_longtitude=80.0', method='POST'):
            self.assertEqual(
                route_create_contract(request), 
                {
                    'username': 'johndoe',
                    'distance': 10,
                    'purpose': 'casual',
                    'calories': 20,
                    'polyline': 'test',
                    'ascent': 30,
                    'descent': 40,
                    'startPos_latitude': 50.0,
                    'startPos_longtitude': 60.0,
                    'endPos_latitude': 70.0,
                    'endPos_longtitude': 80.0
                }
            )

        with app.test_request_context('/?username=&distance=&purpose=&calories=&polyline=&ascent=&descent=&startPos_latitude=&startPos_longtitude=&endPos_latitude=&endPos_longtitude=', method='POST'):
            self.assertRaises(ValueError, route_create_contract, request)

        with app.test_request_context('/?username=johndoe&distance=hello&purpose=casual&calories=20&polyline=test&ascent=30&descent=40&startPos_latitude=50.0&startPos_longtitude=60.0&endPos_latitude=70.0&endPos_longtitude=80.0', method='POST'):
            self.assertRaises(TypeError, route_create_contract, request)


    def test_route_update_contract(self):

        with app.test_request_context('/?id=1&calories=10', method='PUT'):
            self.assertEqual(
                route_update_contract(request), 
                {
                    'id': 1,
                    'calories': 10
                }
            )

        with app.test_request_context('/?id=&calories=', method='PUT'):
            self.assertRaises(TypeError, route_update_contract, request)

        with app.test_request_context('/?id=hello&calories=10', method='PUT'):
            self.assertRaises(TypeError, route_update_contract, request)


if __name__ == '__main__':
    unittest.main()
