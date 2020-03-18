from models import db

def classCreate(class_obj):
    db.session.add(class_obj)
    try:
        db.session.commit()
        return True
    except Exception as e:
        print(e)
        return False

def classRead(id):
    # return Question.query.filter_by(id=id).first()
    return

def classUpdate():
    try:
        db.session.commit()
        return True
    except Exception as e:
        print(e)
        return False

def classDelete(class_obj_attribute):
    class_obj = classRead(class_obj_attribute)
    db.session.delete(class_obj)
    try:
        db.session.commit()
        return True
    except Exception as e:
        print(e)
        return False
        