from models import db, Point

def pointCreate(point):
    db.session.add(point)
    try:
        db.session.commit()
        return True
    except Exception as e:
        print(e)
        return False

def pointRead(route_id, point_id):
    return Point.query.filter_by(route_id=route_id).filter_by(id=point_id).first()
