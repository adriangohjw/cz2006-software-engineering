import sys
from os import path, getcwd
sys.path.append(getcwd())

import unittest

from models import db
from run_test import create_app
app = create_app()
app.app_context().push()
db.init_app(app)

from operations.user_operations import initialize_user
from operations.point_operations import initialize_point
from operations.route_operations import initialize_route

import json 


def res_to_dict(response):
    dict_str = response.data.decode("UTF-8")
    mydata = json.loads(dict_str)
    return mydata


class Test_BaseCase(unittest.TestCase):

    def setUp(self):

        self.maxDiff = None

        self.app = app.test_client()

        db.session.remove()
        db.drop_all()
        db.create_all()

        user_1 = initialize_user('adriangohjw', 'password_1', 'Adrian Goh')
        db.session.add(user_1)

        route_1 = initialize_route(
            user_id=1,
            distance=10,
            polyline=20,
            purpose='Casual',
            calories=30,
            ascent=1,
            descent=2,
            startPos_latitude=40.0,
            startPos_longtitude=50.0,
            endPos_latitude=40.0,
            endPos_longtitude=50.0
        )
        db.session.add(route_1)
        route_2 = initialize_route(
            user_id=1,
            distance=10,
            polyline=20,
            purpose='Casual',
            calories=60,
            ascent=1,
            descent=2,
            startPos_latitude=40.0,
            startPos_longtitude=50.0,
            endPos_latitude=40.0,
            endPos_longtitude=50.0
        )
        db.session.add(route_2)

        db.session.commit()
