from models import db, Route

def routeCreate(route):
    db.session.add(route)
    try:
        db.session.commit()
        return True
    except Exception as e:
        print(e)
        return False

def routeRead(id):
    return Route.query.filter_by(id=id).first()

def routeUpdate():
    try:
        db.session.commit()
        return True
    except Exception as e:
        print(e)
        return False

def routeDelete(id):
    route = routeRead(id)
    db.session.delete(route)
    try:
        db.session.commit()
        return True
    except Exception as e:
        print(e)
        return False
        