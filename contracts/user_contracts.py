from flask import request


def validate_id(id):

    # if not found in params
    if (id is None):
        raise Exception("Request params (id) not found")

    # if description params is empty
    if not id: 
        raise Exception("id is empty")

    # if not integer
    if not isinstance(id, int):
        raise Exception("id is not integer")


def validate_username(username):

    # if not found in params
    if (username is None):
        raise Exception("Request params (username) not found")

    # if description params is empty
    if not username: 
        raise Exception("username is empty")


def validate_password(password):

    # if not found in params
    if (password is None):
        raise Exception("Request params (password) not found")

    # if description params is empty
    if not password: 
        raise Exception("password is empty")


def validate_name(name):
    
    # if not found in params
    if (name is None):
        raise Exception("Request params (name) not found")

    # if description params is empty
    if not name: 
        raise Exception("name is empty")


def validate_age(age):

    # if not found in params
    if (age is None):
        raise Exception("Request params (age) not found")

    # if description params is empty
    if not age: 
        raise Exception("age is empty")

    # if not integer
    if not isinstance(age, int):
        raise Exception("age is not integer")


def validate_height(height):

    # if not found in params
    if (height is None):
        raise Exception("Request params (height) not found")

    # if description params is empty
    if not height: 
        raise Exception("height is empty")

    # if not integer
    if not isinstance(height, int):
        raise Exception("height is not integer")


def validate_weight(weight):

    # if not found in params
    if (weight is None):
        raise Exception("Request params (weight) not found")

    # if description params is empty
    if not weight: 
        raise Exception("weight is empty")

    # if not integer
    if not isinstance(weight, int):
        raise Exception("weight is not integer")


def user_read_contract(request):    

    id = request.args.get('id')

    validate_id(id)

    return {
        'id': int(id)
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

    id = request.args.get('id')
    col = request.args.get('col')
    value = request.args.get('value')

    validate_id(id)

    if col == 'name':
        validate_name(value)
    elif col == 'age':
        validate_age(value)
    elif col == 'height':
        validate_height(value)
    elif col == 'weight':
        validate_weight(value)

    return {
        'id': int(id),
        'col': col,
        'value': value
    }


def user_update_password_contract(request):
    
    id = request.args.get('id')
    current_password = request.args.get('current_password')
    new_password = request.args.get('new_password')

    validate_id(id)
    validate_password(current_password)
    validate_password(new_password)

    return {
        'id': int(id),
        'current_password': current_password,
        'new_password': new_password
    }