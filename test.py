import sys
from os import path, getcwd
sys.path.append(getcwd())

import unittest

from contracts.tests.test_user_contracts import Test_user_contracts
from contracts.tests.test_point_contracts import Test_point_contracts
from contracts.tests.test_route_contracts import Test_route_contracts
from contracts.tests.test_algo_contracts import Test_algo_contracts

from operations.tests.test_user_operations import Test_users_operations
from operations.tests.test_route_operations import Test_route_operations
from operations.tests.test_point_operations import Test_point_operations

from dao.tests.test_user_dao import Test_user_dao
from dao.tests.test_route_dao import Test_route_dao
from dao.tests.test_point_dao import Test_point_dao

from controllers.tests.test_user_controllers import Test_user_controllers
from controllers.tests.test_route_controllers import Test_route_controllers
from controllers.tests.test_point_controllers import Test_point_controllers

if __name__ == '__main__':
    unittest.main()
