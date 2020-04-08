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

from operations.point_operations import initialize_point, \
    point_read_operation, point_create_operation


class Test_point_operations(unittest.TestCase):

    @classmethod
    def setUpClass(cls):
        print("\n\n{}: starting test...".format(path.basename(__file__)))

    def setUp(self):
        db.session.remove()
        db.drop_all()
        db.create_all()

        p = initialize_point(10.0, 20.0)
        db.session.add(p)
        db.session.commit()


    def test_point_read_operation(self):

        with self.assertRaises(ErrorWithCode):
            point_read_operation(2)

        self.assertIsNotNone(point_read_operation(1))

    
    def test_point_create_operation(self):
        
        self.assertIsNotNone(point_create_operation(10.0, 20.0))
        self.assertEqual(point_create_operation(10.0, 20.0).latitude, 10.0)
        self.assertEqual(point_create_operation(10.0, 20.0).longtitude, 20.0)


if __name__ == '__main__':
    unittest.main()
    