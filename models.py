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
    height = db.Column(db.Integer)
    weight = db.Column(db.Integer)
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

if __name__ == '__main__':
    manager.run()   