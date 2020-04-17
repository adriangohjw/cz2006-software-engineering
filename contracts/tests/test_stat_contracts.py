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

from contracts.stat_contracts import daily_calories_read_contract


class Test_stat_contracts(unittest.TestCase):

    maxDiff = None

    @classmethod
    def setUpClass(cls):
        print("\n\n{}: starting test...".format(path.basename(__file__)))


    def test_daily_calories_read_contract(self):

        with app.test_request_context('/?user_id=1', method='GET'):
            self.assertEqual(
                daily_calories_read_contract(request), 
                {
                    'user_id': 1
                }
            )

        with app.test_request_context('/?user_id=', method='GET'):
            self.assertRaises(TypeError, daily_calories_read_contract, request)

        with app.test_request_context('/?user_id=hello', method='GET'):
            self.assertRaises(TypeError, daily_calories_read_contract, request)


if __name__ == '__main__':
    unittest.main()
