from exceptions import ErrorWithCode

from dao.stat_dao import dailyCaloriesRead
from dao.user_dao import userRead


def daily_calories_read_operations(user_id):

    # check if user exist
    if userRead(col='id', value=user_id) is None:
        raise ErrorWithCode(409, "No user found")

    raw_stats = dailyCaloriesRead(user_id)

    stat_dict = {}

    for item in raw_stats:
        i_dict = item._asdict()
        date_str = str(i_dict['Date'])
        stat_dict[date_str] = {
            'total_calories': i_dict['total_calories'],
            'total_distance': i_dict['total_distance']
        }

    return stat_dict
