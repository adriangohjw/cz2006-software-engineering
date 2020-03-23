from flask_sqlalchemy import SQLAlchemy
from datetime import datetime

db = SQLAlchemy()

class User(db.Model):
    __tablename__ = 'users'
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(255), nullable=False, unique=True)
    encrypted_password = db.Column(db.String(255), nullable=False)
    name = db.Column(db.String(255), nullable=False)
    age = db.Column(db.Integer)
    height = db.Column(db.Integer)  # in cm
    weight = db.Column(db.Integer)  # in cm
    created_at = db.Column(db.DateTime, default=datetime.now)

    def __init__(self, username, encrypted_password, name):
        self.username = username 
        self.encrypted_password = encrypted_password
        self.name = name 

    def asdict(self):
        return {
            'id': self.id,
            'username': self.username,
            'encrypted_password': self.encrypted_password,
            'name': self.name,
            'age': self.age,
            'height': self.height if self.height is not None else '-',
            'weight': self.weight if self.weight is not None else '-',
            'created_at': self.created_at
        }

class Point(db.Model):
    __tablename__ = 'points'
    route_id = db.Column(db.Integer, db.ForeignKey('routes.id'), primary_key=True)
    id = db.Column(db.Integer, primary_key=True)
    latitude = db.Column(db.Float, nullable=False)
    longtitude = db.Column(db.Float, nullable=False)
    created_at = db.Column(db.DateTime, default=datetime.now)

    def __init__(self, route_id, latiitude, longtitude):
        self.route_id = route_id
        self.latitude = latiitude
        self.longtitude = longtitude
    
    def asdict(self):
        return {
            'route': self.route,
            'id': self.id,
            'latitude': self.latitude,
            'longtitude': self.longtitude,
            'created_at': self.created_at
        }

class Route(db.Model):
    __tablename__ = 'routes'
    id = db.Column(db.Integer, primary_key=True)
    distance = db.Column(db.Integer, nullable=False)    # in metre
    purpose = db.Column(db.Boolean, nullable=False)
    elevationLevel = db.Column(db.String(255), nullable=False)
    calories = db.Column(db.Integer)
    ascent = db.Column(db.Integer, nullable=False)
    descent = db.Column(db.Integer, nullable=False)
    points = db.relationship('Point', backref='route')

    def __init__(self, distance, purpose, elevationLevel, ascent, descent):
        self.distance = distance
        self.purpose = purpose
        self.elevationLevel = elevationLevel,
        self.ascent = ascent,
        self.descent = descent

    def asdict(self):
        return {
            'id': self.id,
            'distance': self.distance,
            'purpose': self.purpose,
            'elevationLevel': self.elevationLevel, 
            'calories': self.calories,
            'ascent': self.ascent,
            'descent': self.descent,
            'count_points': len(self.points),
            'points': [p.asdict() for p in self.points]
        }
