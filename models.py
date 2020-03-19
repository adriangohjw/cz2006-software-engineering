from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from datetime import datetime
from config import Config
from flask_script import Manager
from flask_migrate import Migrate, MigrateCommand
from sqlalchemy.ext.hybrid import hybrid_property

from run import create_app
app = create_app()

db = SQLAlchemy(app)
migrate = Migrate(app, db)

manager = Manager(app)
manager.add_command('db', MigrateCommand)

class User(db.Model):
    __tablename__ = 'users'
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(255), nullable=False)
    encrypted_password = db.Column(db.String(255), nullable=False)
    name = db.Column(db.String(255), nullable=False)
    age = db.Column(db.Integer)
    height = db.Column(db.Integer)  # in cm
    weight = db.Column(db.Integer)  # in cm
    created_at = db.Column(db.DateTime, default=datetime.now)

    def __init__(self, username, encrypted_password, name, age):
        self.username = username 
        self.encrypted_password = encrypted_password
        self.name = name 
        self.age = age 

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

class Location(db.Model):
    __tablename__ = 'locations'
    id = db.Column(db.Integer, primary_key=True)
    latitude = db.Column(db.Float)
    longtitude = db.Column(db.Float)

    def __init__(self, latiitude, longtitude):
        self.latitude = latiitude
        self.longtitude = longtitude
    
    def asdict(self):
        return {
            'id': self.id,
            'latitude': self.latitude,
            'longtitude': self.longtitude
        }

class Route(db.Model):
    __tablename__ = 'routes'
    id = db.Column(db.Integer, primary_key=True)
    startingPos = db.Column(db.Integer, db.ForeignKey('locations.id'), nullable=False)
    endingPos = db.Column(db.Integer, db.ForeignKey('locations.id'), nullable=False)
    distance = db.Column(db.Integer, nullable=False)
    purpose = db.Column(db.Boolean, nullable=False)
    elevationLevel = db.Column(db.String(255), nullable=False)
    calories = db.Column(db.Integer)
    time = db.Column(db.Integer)    # in seconds
    ascent = db.Column(db.Integer)
    descent = db.Column(db.Integer)

    def __init__(self, startingPos, endingPos, distance, purpose, elevationLevel):
        self.startingPos = startingPos
        self.endingPos = endingPos
        self.distance = distance
        self.purpose = purpose
        self.elevationLevel = elevationLevel

    def asdict(self):
        return {
            'id': self.id,
            'startingPos': self.startingPos,
            'endingPos': self.endingPos,
            'distance': self.distance,
            'purpose': self.purpose,
            'elevationLevel': self.elevationLevel, 
            'calories': self.calories,
            'time': self.time,
            'ascent': self.ascent,
            'descent': self.descent
        }

if __name__ == '__main__':
    manager.run()   