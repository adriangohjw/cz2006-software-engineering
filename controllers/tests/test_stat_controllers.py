import sys
from os import path, getcwd
sys.path.append(getcwd())

from flask import request
import unittest

from models import db, User, Route, Point
from run_test import create_app

from test_BaseCase import Test_BaseCase, res_to_dict

from operations.user_operations import encrypt


class Test_stat_controllers(Test_BaseCase):

    @classmethod
    def setUpClass(cls):
        print("\n\n{}: starting test...".format(path.basename(__file__)))

    
    def test_dailyCaloriesAPI_GET(self):

        import datetime
        date_today = datetime.date.today()
        date_today_str = date_today.strftime('%Y-%m-%d')

        # invalid params input
        response = self.app.get('/stats/daily_calories?user_id=')
        self.assertEqual(response.status_code, 400)

        # user not found
        response = self.app.get('/stats/daily_calories?user_id=2')
        self.assertEqual(response.status_code, 409)
        
        # success case
        response = self.app.get('/stats/daily_calories?user_id=1')
        res = res_to_dict(response)
        self.assertEqual(response.status_code, 200)
        self.assertEqual(res[date_today_str]['total_calories'], 90)
        self.assertEqual(res[date_today_str]['total_distance'], 20)


if __name__ == '__main__':
    unittest.main()
    