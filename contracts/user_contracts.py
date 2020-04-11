from flask import request


def validate_id(id):

    # if not found in params
    if (id is None):
        raise TypeError("Request params (id) not found")

    # if description params is empty
    if not id: 
        raise ValueError("id is empty")

    # if not integer
    if not isinstance(id, int):
        raise TypeError("id is not integer")


def validate_username(username):

    # if not found in params
    if (username is None):
        raise TypeError("Request params (username) not found")

    # if description params is empty
    if not username: 
        raise ValueError("username is empty")


def validate_password(password):

    # if not found in params
    if (password is None):
        raise TypeError("Request params (password) not found")

    # if description params is empty
    if not password: 
        raise ValueError("password is empty")


def validate_name(name):
    
    # if not found in params
    if (name is None):
        raise TypeError("Request params (name) not found")

    # if description params is empty
    if not name: 
        raise ValueError("name is empty")


def validate_age(age):

    # if not found in params
    if (age is None):
        raise TypeError("Request params (age) not found")

    # if description params is empty
    if not age: 
        raise ValueError("age is empty")

    # if not integer
    if not isinstance(age, int):
        raise TypeError("age is not integer")


def validate_height(height):

    # if not found in params
    if (height is None):
        raise TypeError("Request params (height) not found")

    # if description params is empty
    if not height: 
        raise ValueError("height is empty")

    # if not integer
    if not isinstance(height, int):
        raise TypeError("height is not integer")


def validate_weight(weight):

    # if not found in params
    if (weight is None):
        raise TypeError("Request params (weight) not found")

    # if description params is empty
    if not weight: 
        raise ValueError("weight is empty")

    # if not integer
    if not isinstance(weight, int):
        raise TypeError("weight is not integer")


def user_read_contract(request):    

    username = request.args.get('username')

    validate_username(username)

    return {
        'username': username
    }


def user_create_contract(request):

    username = request.args.get('username')
    password = request.args.get('password')
    name = request.args.get('name')

    validate_username(username)
    validate_password(password)
    validate_name(name)

    return {
        'username': username,
        'plaintext_password': password,
        'name': name
    }


def user_update_contract(request):

    username = request.args.get('username')
    name = request.args.get('name')
    age = request.args.get('age', type=int)
    height = request.args.get('height', type=int)
    weight = request.args.get('weight', type=int)

    validate_username(username)

    if (name is None) and (age is None) and (height is None) and (weight is None):
        raise TypeError("no params being passed in")         

    if name is not None:
        validate_name(name)
    
    if age is not None:
        validate_age(age)

    if height is not None:
        validate_height(height)

    if weight is not None:
        validate_weight(weight)

    return {
        'username': username,
        'name': name,
        'age': int(age) if age is not None else age,
        'height': int(height) if height is not None else height,
        'weight': int(weight) if weight is not None else weight
    }


def user_update_password_contract(request):
    
    username = request.args.get('username')
    current_password = request.args.get('current_password')
    new_password = request.args.get('new_password')

    validate_username(username)
    validate_password(current_password)
    validate_password(new_password)

    return {
        'username': username,
        'current_password': current_password,
        'new_password': new_password
    }


def user_read_contract_byID(request):    

    id = request.args.get('id', type=int)

    validate_id(id)

    return {
        'id': int(id)
    }
