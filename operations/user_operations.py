import bcrypt

from models import User

from dao.user_dao import userCreate, userRead, userUpdate

from exceptions import ErrorWithCode


def encrypt(plaintext_password):
    return bcrypt.hashpw(bytes(plaintext_password, "utf8"), bcrypt.gensalt()).decode("utf-8")


def authenticate(plaintext_password, encrypted_password):
    return bcrypt.checkpw(bytes(plaintext_password, "utf-8"), bytes(encrypted_password, "utf-8"))


def initialize_user(username, plaintext_password, name):
    encrypted_password = encrypt(plaintext_password)
    return User(username, encrypted_password, name)


def user_read_operation(col, value):

    user = userRead(col, value)

    # user is not found
    if user is None:
        raise ErrorWithCode(404, "No user found")

    # success case
    return user


def user_create_operation(username, plaintext_password, name):

    user = userRead(col='username', value=username)

    # user existing
    if user is not None:
        raise ErrorWithCode(412, "Existing user found")

    user = initialize_user(username, plaintext_password, name)
    if userCreate(user) == False:
        raise ErrorWithCode(400, "Unsuccessful")

    # success case
    return user
    

def user_update_operation(id, col, value):

    user = userRead(col='id', value=id)

    # user is not found
    if user is None:
        raise ErrorWithCode(404, "No user found")

    if col == 'name':
        user.name = value
    elif col == 'age':
        user.age = value 
    elif col == 'height':
        user.height = value 
    elif col == 'weight':
        user.weight = value 

    if userUpdate() == False:
        raise ErrorWithCode(400, "Unsuccessful")

    # success case
    return user


# passwords are in plaintext
def user_update_operation_operation(id, current_password, new_password):

    user = userRead(col='id', value=id)

    # user is not found
    if user is None:
        raise ErrorWithCode(404, "No user found")
    
    # incorrect password provided
    if authenticate(current_password, user.encrypted_password) is False:
        raise ErrorWithCode(401, "Wrong password provided")

    user.encrypted_password = encrypt(current_password)
    if userUpdate() == False:
        raise ErrorWithCode(400, "Unsuccessful")

    # success case
    return user
