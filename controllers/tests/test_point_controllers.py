import sys
from os import path, getcwd
sys.path.append(getcwd())

from flask import request
import unittest

from models import db
from run_test import create_app

from test_BaseCase import Test_BaseCase, res_to_dict


class Test_point_controllers(Test_BaseCase):

    @classmethod
    def setUpClass(cls):
        print("\n\n{}: starting test...".format(path.basename(__file__)))


    def test_pointAPI_GET(self):
        
        # invalid params input
        response = self.app.get('/routes/points?id=')
        self.assertEqual(response.status_code, 400)

        response = self.app.get('/routes/points?id=hello')
        self.assertEqual(response.status_code, 400)

        # record not found
        response = self.app.get('/routes/points?id=5')
        self.assertEqual(response.status_code, 409)
        
        # success case
        response = self.app.get('/routes/points?id=1')
        res = res_to_dict(response)
        self.assertEqual(response.status_code, 200)
        self.assertEqual(res['latitude'], 40.0)


if __name__ == '__main__':
    unittest.main()
    