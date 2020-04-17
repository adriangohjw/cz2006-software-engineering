import sys
from os import path, getcwd
sys.path.append(getcwd())

from flask import request
import unittest

from models import db
from run_test import create_app

from test_BaseCase import Test_BaseCase, res_to_dict

from operations.user_operations import authenticate


class Test_user_controllers(Test_BaseCase):

    @classmethod
    def setUpClass(cls):
        print("\n\n{}: starting test...".format(path.basename(__file__)))

    
    def test_userAPI_GET(self):

        # invalid params input
        response = self.app.get('/users?username=')
        self.assertEqual(response.status_code, 400)

        # user not found
        response = self.app.get('/users?username=adriangohjw_1')
        self.assertEqual(response.status_code, 409)
        
        # success case
        response = self.app.get('/users?username=adriangohjw')
        res = res_to_dict(response)
        self.assertEqual(response.status_code, 200)
        self.assertEqual(res['name'], 'Adrian Goh')
        

    def test_userAPI_POST(self):

        # invalid params input
        response = self.app.post('/users?username=user_2&password=password_2&name=')
        self.assertEqual(response.status_code, 400)

        # existing user
        response = self.app.post('/users?username=adriangohjw&password=password_1&name=Adrian%20Goh')
        self.assertEqual(response.status_code, 409)

         # success case
        response = self.app.post('/users?username=user_2&password=password_2&name=name_2')
        res = res_to_dict(response)
        self.assertEqual(response.status_code, 200)
        self.assertEqual(res['name'], 'name_2')

    
    def test_userAPI_PUT(self):

        # invalid params input
        response = self.app.put('/users?username=user_2&name=')
        self.assertEqual(response.status_code, 400)

        # user not found
        response = self.app.put('/users?username=user_2&name=new_name')
        self.assertEqual(response.status_code, 409)

        # success case
        response = self.app.put('/users?username=adriangohjw&name=new_name')
        res = res_to_dict(response)
        self.assertEqual(response.status_code, 200)
        self.assertEqual('new_name', res['name'])

        response = self.app.put('/users?username=adriangohjw&age=24&height=175')
        res = res_to_dict(response)
        self.assertEqual(response.status_code, 200)
        self.assertEqual(24, res['age'])
        self.assertEqual(175, res['height'])


    def test_userAPI_byID_GET(self):

        # invalid params input
        response = self.app.get('/users/id?id=')
        self.assertEqual(response.status_code, 400)

        response = self.app.get('/users/id?id=hello')
        self.assertEqual(response.status_code, 400)

        # user not found
        response = self.app.get('/users/id?id=2')
        self.assertEqual(response.status_code, 409)

        # success case
        response = self.app.get('/users/id?id=1')
        res = res_to_dict(response)
        self.assertEqual(response.status_code, 200)
        self.assertEqual(res['username'], 'adriangohjw')


    def test_userPasswordAPI_PUT(self):
        
        # invalid params input
        response = self.app.put('/users/password?username=adriangohjw&current_password=password_1&new_password=')
        self.assertEqual(response.status_code, 400)

        # user not found
        response = self.app.put('/users/password?username=user_2&current_password=password_1&new_password=password_2')
        self.assertEqual(response.status_code, 409)

        # wrong password provided
        response = self.app.put('/users/password?username=adriangohjw&current_password=wrong&new_password=password_2')
        self.assertEqual(response.status_code, 401)

        # success case
        response = self.app.put('/users/password?username=adriangohjw&current_password=password_1&new_password=password_2')
        self.assertEqual(response.status_code, 200)


    def test_AuthenticationAPI_GET(self):

        # wrong password provided
        response = self.app.get('/users/auth?username=adriangohjw&password=wrong_password')
        self.assertEqual(response.status_code, 401)

        # invalid params input
        response = self.app.get('/users/auth?username=adriangohjw&password=')
        self.assertEqual(response.status_code, 400)

        # user not found
        response = self.app.get('/users/auth?username=user_2&password=password')
        self.assertEqual(response.status_code, 409)

        # success case
        response = self.app.get('/users/auth?username=adriangohjw&password=password_1')
        self.assertEqual(response.status_code, 200)


if __name__ == '__main__':
    unittest.main()
    