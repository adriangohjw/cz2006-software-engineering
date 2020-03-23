from models import db, User

def userCreate(user):
    db.session.add(user)
    try:
        db.session.commit()
        return True
    except Exception as e:
        print(e)
        return False

def userRead(col, value):

    if col == 'id':
        return User.query.filter_by(id=value).first()
    elif col == 'username':
        return User.query.filter_by(username=value).first()
        

def userUpdate():
    try:
        db.session.commit()
        return True
    except Exception as e:
        print(e)
        return False
