import sys
from os import path, getcwd
sys.path.append(getcwd())

from flask import request
import unittest

from models import db
from run_test import create_app

from test_BaseCase import Test_BaseCase, res_to_dict


class Test_route_controllers(Test_BaseCase):

    @classmethod
    def setUpClass(cls):
        print("\n\n{}: starting test...".format(path.basename(__file__)))


    def test_routeAPI_GET(self):

        # invalid params input
        response = self.app.get('/routes?id=')
        self.assertEqual(response.status_code, 400)

        response = self.app.get('/routes?id=hello')
        self.assertEqual(response.status_code, 400)

        # record not found
        response = self.app.get('/routes?id=3')
        self.assertEqual(response.status_code, 409)
        
        # success case
        response = self.app.get('/routes?id=1')
        res = res_to_dict(response)
        self.assertEqual(response.status_code, 200)
        self.assertEqual(res['startPos']['latitude'], 40.0)


    def test_routeAPI_POST(self):

        # invalid params input
        response = self.app.post('/routes?username=adriangohjw&distance=10&purpose=casual&calories=20&polyline=test&ascent=30&descent=40&startPos_latitude=50.0&startPos_longtitude=60.0&endPos_latitude=70.0&endPos_longtitude=')
        self.assertEqual(response.status_code, 400)

        # dependency record not found
        response = self.app.post('/routes?username=adriangohjw_1&distance=10&purpose=casual&calories=20&polyline=test&ascent=30&descent=40&startPos_latitude=50.0&startPos_longtitude=60.0&endPos_latitude=70.0&endPos_longtitude=80.0')
        self.assertEqual(response.status_code, 409)

        # success case
        response = self.app.post('/routes?username=adriangohjw&distance=10&purpose=casual&calories=20&polyline=test&ascent=30&descent=40&startPos_latitude=50.0&startPos_longtitude=60.0&endPos_latitude=70.0&endPos_longtitude=80.0')
        res = res_to_dict(response)
        self.assertEqual(response.status_code, 200)
        self.assertEqual(res['startPos']['latitude'], 50.0)


    def test_routeAPI_PUT(self):

        # invalid params input
        response = self.app.put('/routes?id=1&calories=')
        self.assertEqual(response.status_code, 400)

        # record not found
        response = self.app.put('/routes?id=3&calories=100')
        self.assertEqual(response.status_code, 409)

        # success case
        response = self.app.put('/routes?id=1&calories=100')
        res = res_to_dict(response)
        self.assertEqual(response.status_code, 200)
        self.assertEqual(100, res['calories'])


    def test_routeAPI_DELETE(self):

        # invalid params input
        response = self.app.delete('/routes?id=')
        self.assertEqual(response.status_code, 400)

        # record not found
        response = self.app.delete('/routes?id=3')
        self.assertEqual(response.status_code, 409)

        # success case
        response = self.app.delete('/routes?id=1')
        res = res_to_dict(response)
        self.assertEqual(response.status_code, 200)
        self.assertEqual(res['message'], 'Successfully deleted route')


if __name__ == '__main__':
    unittest.main()
    