import sys
from os import path, getcwd
from flask import Flask
from flask import request
sys.path.append(getcwd())

import unittest

from contracts.tests.test_user_contracts import Test_user_contracts
from contracts.tests.test_point_contracts import Test_point_contracts
from contracts.tests.test_route_contracts import Test_route_contracts
from contracts.tests.test_algo_contracts import Test_algo_contracts

if __name__ == '__main__':
    unittest.main()
