import sys
from os import path, getcwd
sys.path.append(getcwd())

import csv

from models import db
from run_test import create_app
app = create_app()
app.app_context().push()
db.init_app(app)

from operations.user_operations import initialize_user
from operations.route_operations import initialize_route

# empty database to default state with samples
db.session.commit()
db.session.remove()
db.drop_all()
db.create_all()

import time


def add_object(func):
    start_time_local = time.time()
    func()
    print("--- {} seconds ---".format(round(time.time() - start_time_local, 2)))


start_time = time.time()

# add users
def add_users():
    print('\nAdding users...')
    with open('db_populate/users.csv', mode='r') as csv_file:
        csv_reader = csv.DictReader(csv_file, delimiter=',')
        count_user = 0
        for row in csv_reader:
            student = initialize_user(
                username=row['username'],
                plaintext_password=row['plaintext_password'],
                name=row['name']
            )
            student.age = row['age']
            student.height = row['height']
            student.weight = row['weight']
            db.session.add(student)
            count_user += 1
        db.session.commit()
        print('>>> {} users added'.format(count_user))

# add routes
def add_routes():
    print('\nAdding routes...')
    with open('db_populate/routes.csv', mode='r') as csv_file:
        csv_reader = csv.DictReader(csv_file, delimiter=',')
        count_route = 0
        for row in csv_reader:
            route = initialize_route(
                user_id=row['user_id'],
                distance=row['distance'],
                polyline=row['polyline'],
                purpose=row['purpose'],
                calories=row['calories'],
                ascent=row['ascent'],
                descent=row['descent'],
                startPos_latitude=row['startPos_latitude'],
                startPos_longtitude=row['startPos_longtitude'],
                endPos_latitude=row['endPos_latitude'],
                endPos_longtitude=row['endPos_longtitude']
            )
            db.session.add(route)
            count_route += 1
        db.session.commit()
        print('>>> {} routes added'.format(count_route))

add_object(add_users)
add_object(add_routes)

print("\nDB population completed")
print("--- {} seconds ---".format(round(time.time() - start_time, 2)))
