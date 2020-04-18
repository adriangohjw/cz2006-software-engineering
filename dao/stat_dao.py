import sys
from os import path, getcwd
sys.path.append(getcwd())

from sqlalchemy import asc, desc, cast, Float, func, Numeric, Date
from sqlalchemy.sql.functions import sum

from models import db, Route

import datetime 


def dailyCaloriesRead(user_id):

    query = db.session.query(
        cast(Route.created_at, Date).label('Date'),
        sum(Route.calories).label('total_calories'),
        sum(Route.distance).label('total_distance')
    )\
    .filter(Route.user_id == user_id)\
    .group_by(
        cast(Route.created_at, Date)
    )\
    .order_by(
        cast(Route.created_at, Date)
    )

    return query.all()
