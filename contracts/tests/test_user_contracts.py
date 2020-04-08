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

from contracts.user_contracts import \
    validate_id, validate_username, validate_password, validate_name, validate_age, validate_height, validate_weight, \
    user_read_contract, user_create_contract, user_update_contract, user_update_password_contract, \
    user_read_contract_byID


class Test_user_contracts(unittest.TestCase):

    @classmethod
    def setUpClass(cls):
        print("\n\n{}: starting test...".format(path.basename(__file__)))


    def test_validate_id(self):
        
        with self.assertRaises(TypeError):
            validate_id(None)
            validate_id(1)

        with self.assertRaises(ValueError):
            validate_id('')


    def test_validate_username(self):

        with self.assertRaises(TypeError):
            validate_username(None)

        with self.assertRaises(ValueError):
            validate_username('')
        

    def test_validate_password(self):

        with self.assertRaises(TypeError):
            validate_password(None)

        with self.assertRaises(ValueError):
            validate_password('')
        

    def test_validate_name(self):
        
        with self.assertRaises(TypeError):
            validate_name(None)

        with self.assertRaises(ValueError):
            validate_name('')


    def test_validate_age(self):
        
        with self.assertRaises(TypeError):
            validate_age(None)
            validate_age(1)

        with self.assertRaises(ValueError):
            validate_age('')

    
    def test_validate_height(self):
        
        with self.assertRaises(TypeError):
            validate_height(None)
            validate_height(1)

        with self.assertRaises(ValueError):
            validate_height('')


    def test_validate_weight(self):
        
        with self.assertRaises(TypeError):
            validate_weight(None)
            validate_weight(1)

        with self.assertRaises(ValueError):
            validate_weight('')


    def test_user_read_contract(self):

        with app.test_request_context('/?username=johndoe', method='GET'):
            self.assertEqual(
                user_read_contract(request), 
                {
                    'username': 'johndoe'
                }
            )

        with app.test_request_context('/', method='GET'):
            self.assertRaises(TypeError, user_read_contract, request)

        with app.test_request_context('/?username=', method='GET'):
            self.assertRaises(ValueError, user_read_contract, request)
 

    def test_user_create_contract(self):

        with app.test_request_context('/?username=johndoe&password=password&name=John%20Doe', method='POST'):
            self.assertEqual(
                user_create_contract(request), 
                {
                    'username': 'johndoe',
                    'plaintext_password': 'password',
                    'name': 'John Doe'
                }
            )

        with app.test_request_context('/', method='POST'):
            self.assertRaises(TypeError, user_create_contract, request)

        with app.test_request_context('/?username=&password=&name=', method='POST'):
            self.assertRaises(ValueError, user_create_contract, request)

    
    def test_user_update_contract(self):

        with app.test_request_context('/?username=johndoe&name=John%20Doe&age=10&height=20&weight=30', method='PUT'):
            self.assertEqual(
                user_update_contract(request), 
                {
                    'username': 'johndoe',
                    'name': 'John Doe',
                    'age': 10,
                    'height': 20,
                    'weight': 30
                }
            )

        with app.test_request_context('/?username=', method='PUT'):
            self.assertRaises(ValueError, user_update_contract, request)

        with app.test_request_context('/?username=johndoe', method='PUT'):
            self.assertRaises(TypeError, user_update_contract, request)

        with app.test_request_context('/?username=johndoe&age=hello', method='PUT'):
            self.assertRaises(TypeError, user_update_contract, request)


    def test_user_update_password_contract(self):

        with app.test_request_context('/?id=1&current_password=password1&new_password=password2', method='PUT'):
            self.assertEqual(
                user_update_password_contract(request), 
                {
                    'id': 1,
                    'current_password': 'password1',
                    'new_password': 'password2'
                }
            )

        with app.test_request_context('/', method='PUT'):
            self.assertRaises(TypeError, user_update_password_contract, request)

        with app.test_request_context('/?id=&current_password=&new_password=', method='PUT'):
            self.assertRaises(TypeError, user_update_password_contract, request)

        with app.test_request_context('/?id=hello&current_password=password1&new_password=password2', method='PUT'):
            self.assertRaises(TypeError, user_update_password_contract, request)


    def test_user_read_contract_byID(self):

        with app.test_request_context('/?id=1', method='GET'):
            self.assertEqual(
                user_read_contract_byID(request), 
                {
                    'id': 1
                }
            )

        with app.test_request_context('/?id=', method='GET'):
            self.assertRaises(TypeError, user_read_contract_byID, request)

        with app.test_request_context('/?id=hello', method='GET'):
            self.assertRaises(TypeError, user_read_contract_byID, request)
        

if __name__ == '__main__':
    unittest.main()
