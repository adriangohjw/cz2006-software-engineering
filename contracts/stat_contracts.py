import sys
from os import path, getcwd
sys.path.append(getcwd())

from contracts.user_contracts import validate_id as validate_user_id


def daily_calories_read_contract(request):    

    user_id = request.args.get('user_id', type=int)

    validate_user_id(user_id)

    return {
        'user_id': user_id
    }
