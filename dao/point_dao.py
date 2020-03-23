from sqlalchemy import desc 
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

def get_last_id(route_id):
    last_point = Point.query.filter_by(route_id=route_id).order_by(desc(Point.created_at)).first()
    if (last_point):
        return last_point.id 
    else:   
        return 0
