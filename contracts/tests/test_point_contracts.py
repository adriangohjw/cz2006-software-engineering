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

from contracts.point_contracts import \
    validate_id, validate_latitude, validate_longtitude, \
    point_read_contract, point_create_contract


class Test_point_contracts(unittest.TestCase):

    @classmethod
    def setUpClass(cls):
        print("\n\n{}: starting test...".format(path.basename(__file__)))


    def test_validate_id(self):
        
        with self.assertRaises(TypeError):
            validate_id(None)
            validate_id(1.1)
            validate_id(True)
            validate_id('hello')

        with self.assertRaises(ValueError):
            validate_id('')


    def test_validate_latitude(self):
        
        with self.assertRaises(TypeError):
            validate_latitude(None)
            validate_latitude('')


    def test_validate_longtitude(self):
        
        with self.assertRaises(TypeError):
            validate_longtitude(None)
            validate_longtitude('')


    def test_point_read_contract(self):

        with app.test_request_context('/?id=1', method='GET'):
            self.assertEqual(
                point_read_contract(request), 
                {
                    'id': 1
                }
            )

        with app.test_request_context('/?id=', method='GET'):
            self.assertRaises(TypeError, point_read_contract, request)

        with app.test_request_context('/?id=hello', method='GET'):
            self.assertRaises(TypeError, point_read_contract, request)


    def test_point_create_contract(self):

        with app.test_request_context('/?latitude=10.0&longtitude=20.0', method='POST'):
            self.assertEqual(
                point_create_contract(request), 
                {
                    'latitude': 10.0,
                    'longtitude': 20.0
                }
            )

        with app.test_request_context('/?latitude=&longtitude=', method='POST'):
            self.assertRaises(TypeError, point_read_contract, request)

        with app.test_request_context('/?latitude=hello&longtitude=20.0', method='POST'):
            self.assertRaises(TypeError, point_read_contract, request)


if __name__ == '__main__':
    unittest.main()
