from models import db, User

def userCreate(user):
    db.session.add(user)
    try:
        db.session.commit()
        return True
    except Exception as e:
        print(e)
        return False

def userRead(id):
    return User.query.filter_by(id=id).first()

def userUpdate():
    try:
        db.session.commit()
        return True
    except Exception as e:
        print(e)
        return False
