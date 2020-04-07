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

from models import Point
from dao.point_dao import pointCreate, pointRead


class Test_point_dao(unittest.TestCase):

    @classmethod
    def setUpClass(cls):
        print("\n\n{}: starting test...".format(path.basename(__file__)))

    def setUp(self):
        db.session.remove()
        db.drop_all()
        db.create_all()

    
    def test_pointCreate(self):

        self.assertEqual(len(Point.query.all()), 0)

        point = Point(10.0, 20.0)
        pointCreate(point)

        self.assertEqual(len(Point.query.all()), 1)

    
    def test_pointRead(self):

        self.assertIsNone(pointRead(1))

        point = Point(10.0, 20.0)
        db.session.add(point)
        db.session.commit()

        self.assertEqual(pointRead(1).latitude, 10.0)


if __name__ == '__main__':
    unittest.main()
