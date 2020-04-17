from exceptions import ErrorWithCode

from dao.stat_dao import dailyCaloriesRead
from dao.user_dao import userRead


def daily_calories_read_operations(user_id):

    # check if user exist
    if userRead(col='id', value=user_id) is None:
        raise ErrorWithCode(409, "No user found")

    raw_stats = dailyCaloriesRead(user_id)

    stat_dict = {}
    stat_dict['activities'] = []

    for item in raw_stats:
        i_dict = item._asdict()
        stat_dict['activities'].append(
            {
                'Date': str(i_dict['Date']),
                'Total Calories': i_dict['total_calories']
            }
        )

    return stat_dict
