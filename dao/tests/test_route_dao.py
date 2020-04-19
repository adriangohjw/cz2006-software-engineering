import sys
from os import path, getcwd
sys.path.append(getcwd())

import unittest 

from exceptions import ErrorWithCode

from models import db
from run_test import create_app
app = create_app()
app.app_context().push()
db.init_app(app)

from models import Route, User, Point
from operations.user_operations import encrypt
from dao.route_dao import routeCreate, routeRead, routeUpdate, routeDelete


class Test_route_dao(unittest.TestCase):

    @classmethod
    def setUpClass(cls):
        print("\n\n{}: starting test...".format(path.basename(__file__)))

    def setUp(self):
        db.session.remove()
        db.drop_all()
        db.create_all()

        user = User('johndoe', encrypt('password'), 'John Doe')
        db.session.add(user)

        start_point = Point(10.0, 20.0)
        db.session.add(start_point)

        end_point = Point(30.0, 40.0)
        db.session.add(end_point)

        db.session.commit()


    def test_routeCreate(self):

        self.assertEqual(len(Route.query.all()), 0)

        route = Route(1, 10, 'test', 'casual', 200, 20, 30, 1, 2)
        
        # record successfully created
        self.assertTrue(routeCreate(route))

        self.assertEqual(len(Route.query.all()), 1)


    def test_routeRead(self):

        self.assertIsNone(routeRead(1))

        route = Route(1, 10, 'test', 'casual', 200, 20, 30, 1, 2)
        db.session.add(route)
        db.session.commit()

        self.assertEqual(routeRead(1).distance, 10)

    
    def test_routeUpdate(self):

        route = Route(1, 10, 'test', 'casual', 200, 20, 30, 1, 2)
        db.session.add(route)
        db.session.commit()

        route.distance = 100
        routeUpdate()

        self.assertEqual(Route.query.filter_by(id=1).first().distance, 100)


    def test_routeDelete(self):

        route = Route(1, 10, 'test', 'casual', 200, 20, 30, 1, 2)
        db.session.add(route)
        db.session.commit()

        self.assertEqual(len(Route.query.all()), 1)

        routeDelete(1)

        self.assertEqual(len(Route.query.all()), 0)


if __name__ == '__main__':
    unittest.main()
