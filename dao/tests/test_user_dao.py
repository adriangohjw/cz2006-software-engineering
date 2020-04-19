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

from models import User
from operations.user_operations import encrypt
from dao.user_dao import userCreate, userRead, userUpdate


class Test_user_dao(unittest.TestCase):

    @classmethod
    def setUpClass(cls):
        print("\n\n{}: starting test...".format(path.basename(__file__)))

    def setUp(self):
        db.session.remove()
        db.drop_all()
        db.create_all()

    
    def test_userCreate(self):

        self.assertEqual(len(User.query.all()), 0)

        user = User('johndoe', encrypt('password'), 'John Doe')

        # successfully added record
        self.assertTrue(userCreate(user))

        self.assertEqual(len(User.query.all()), 1)


    def test_userRead(self):

        self.assertIsNone(userRead(col='id', value=1))

        user = User('johndoe', encrypt('password'), 'John Doe')
        db.session.add(user)
        db.session.commit()

        self.assertEqual(userRead(col='id', value=1).name, 'John Doe')
        self.assertEqual(userRead(col='username', value='johndoe').name, 'John Doe')

    
    def test_userUpdate(self):

        user = User('johndoe', encrypt('password'), 'John Doe')
        db.session.add(user)
        db.session.commit()

        user.name = 'John Doe Tan'
        
        # successfully added record
        self.assertTrue(userUpdate())

        self.assertEqual(User.query.filter_by(username='johndoe').first().name, 'John Doe Tan')
        

if __name__ == '__main__':
    unittest.main()
