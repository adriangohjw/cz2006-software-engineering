import sys
from os import getcwd
sys.path.append(getcwd())

import unittest 

from exceptions import ErrorWithCode

from models import db
from run_test import create_app
app = create_app()
app.app_context().push()
db.init_app(app)

from operations.user_operations import initialize_user

from operations.route_operations import initialize_route, \
    route_read_operation, route_create_operation, route_update_operation, route_delete_operation


class Test_route_operations(unittest.TestCase):

    @classmethod
    def setUpClass(cls):
        print("\n\n{}: starting test...".format(path.basename(__file__)))

    def setUp(self):
        db.session.remove()
        db.drop_all()
        db.create_all()

        u = initialize_user('johndoe', 'password', 'John Doe')
        db.session.add(u)
        db.session.commit()

        r = initialize_route(
            user_id = 1, distance = 10, polyline = 'test', purpose = 'casual', calories = 200, ascent = 2, descent = 3,
            startPos_latitude = 30.0, startPos_longtitude = 40.0, endPos_latitude = 50.0, endPos_longtitude = 60.0
        )
        db.session.add(r)
        db.session.commit()


    def test_route_read_operation(self):

        with self.assertRaises(ErrorWithCode):
            route_read_operation(2)

        self.assertIsNotNone(route_read_operation(1))


    def test_route_create_operation(self):

        with self.assertRaises(ErrorWithCode):
            route_create_operation(
                username = 'johndoe1', distance = 10, polyline = 'test', purpose = 'casual', calories = 200, ascent = 2, descent = 3,
                startPos_latitude = 30.0, startPos_longtitude = 40.0, endPos_latitude = 50.0, endPos_longtitude = 60.0
            )

        self.assertEqual(
            route_create_operation(
                username = 'johndoe', distance = 10, polyline = 'test', purpose = 'casual', calories = 200, ascent = 2, descent = 3,
                startPos_latitude = 30.0, startPos_longtitude = 40.0, endPos_latitude = 50.0, endPos_longtitude = 60.0
            ).id, 2
        )

        self.assertIsNotNone(
            route_create_operation(
                username = 'johndoe', distance = 10, polyline = 'test', purpose = 'casual', calories = 200, ascent = 2, descent = 3,
                startPos_latitude = 30.0, startPos_longtitude = 40.0, endPos_latitude = 50.0, endPos_longtitude = 60.0
            )
        )


    def test_route_update_operation(self):

        with self.assertRaises(ErrorWithCode):
            route_update_operation(2, 300)
            route_update_operation(1, None)

        self.assertEqual(route_update_operation(1, 300).calories, 300)


    def test_route_delete_operation(self):

        with self.assertRaises(ErrorWithCode):
            route_delete_operation(2)
        
        self.assertTrue(route_delete_operation(1))
        self.assertRaises(ErrorWithCode, route_read_operation, 1)


if __name__ == '__main__':
    unittest.main()
    