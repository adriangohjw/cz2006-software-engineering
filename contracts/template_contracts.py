from flask import request

def validate_something(something):
    # if no 'something' found in params
    if (something is None):
        raise Exception("Request params (something) not found")

    # if description params is empty
    if not something: 
        raise Exception("something is empty")

def classReadContract(request):    
    something = request.args.get('something')

    validate_something(something)

    return {
        'something': something
    }

def classCreateContract(request):
    something = request.args.get('something')

    validate_something(something)

    return {
        'something': something
    }

def classUpdateContract(request):
    something = request.args.get('something')

    validate_something(something)

    return {
        'something': something
    }

def classDeleteContract(request):
    something = request.args.get('something')

    validate_something(something)

    return {
        'something': something
    }
