import sys
from os import path, getcwd
sys.path.append(getcwd())

import unittest

from models import db
from run_test import create_app
app = create_app()
app.app_context().push()
db.init_app(app)

from models import User, Route, Point
from operations.user_operations import encrypt
from dao.stat_dao import dailyCaloriesRead

import datetime


class Test_stat_dao(unittest.TestCase):

    @classmethod
    def setUpClass(cls):
        print("\n\n{}: starting test...".format(path.basename(__file__)))


    def setUp(self):

        self.maxDiff = None

        db.session.remove()
        db.drop_all()
        db.create_all()

        # adding users
        user = User('adriangohjw', encrypt('password'), 'Adrian Goh')
        db.session.add(user)

        # add points
        point_1 = Point(30.0, 40.0)
        db.session.add(point_1)
        point_2 = Point(50.0, 60.0)
        db.session.add(point_2)

        # add routes
        route_1 = Route(
            user_id=1,
            distance=10, 
            polyline='evfGin%7CwR%5Cf@%60@Zh@Vb@JfBP%60CJtHd@LgBNiCF%7D@YCXBNe@PUr@i@p@c@lDsBj@c@DKJW@Yi@cA%7B@yBg@wAa@aAWaAg@qAoCaH%5BaAWs@k@OOEO?%5DDuEpBoInDo@TMVGREVRhBPbBH~AAzEAdD?XX@nAH~AJ@UAT_BKcCMHcGAcEUkC%5D%7DCEMPGbCaA%60MuFlDaB%60CuAdJuFnAy@r@a@pDuBtEuC%60CqARIZc@%5E%7B@Py@uB%7BH%7BF_TyAcFbAFbCJnD?@GtAWrCy@jAg@xAe@lDwA%7C@i@HSBe@wBuDNGVOfCsAtAs@%60@K@u@ES%7B@wAi@d@o@%5EXh@LLFFBH?ROZGHm@%5CiAh@e@IIKKQIWAW?WGEMGGGESA%5BFg@J%5DZe@TQNGH?%5CBJEMWMU%7B@b@%5BXSXQb@Kp@@l@Pz@j@jARZbAjBx@tAVL%5EFP?vAaAlD_CrCoBzAgAl@_@l@YvBaAbD%7BAnBs@VKlAS@GtAAfCDbAHtAP~Bh@%60A%5E%60Bz@zC~ApBqD%5EaAFo@EqGImG@%7DACWU_AY_AcBj@e@Ls@N_BTw@HaBDkAC%7DJ%5Dk%5Da@cBBa@DmAXeAXsCjAuG~CiCvAi@%60@q@v@U%5EgAxBU%60@SROLWLg@L_AFkA@g@AYCs@Oq@Ye@UcAYo@C%7D@?SZQXIXPtA%60@dBrGfVtBbHhAhEfDjMd@%7CAVv@tApFx@pCsAb@mA%60@wAr@_DpBu@Xs@d@kDpBy@h@aAl@%7DFzDsDhBSl@Kf@G%7C@jA%7CCz@%60CxAdDeBbA_FpCkBhAGHMPKXI~AUdE',
            purpose='Casual',
            calories=100,
            ascent=1,
            descent=2,
            startPos_id=1,
            endPos_id=2
        )
        db.session.add(route_1)
        route_2 = Route(
            user_id=1,
            distance=10, 
            polyline='evfGin%7CwR%5Cf@%60@Zh@Vb@JfBP%60CJtHd@LgBNiCF%7D@YCXBNe@PUr@i@p@c@lDsBj@c@DKJW@Yi@cA%7B@yBg@wAa@aAWaAg@qAoCaH%5BaAWs@k@OOEO?%5DDuEpBoInDo@TMVGREVRhBPbBH~AAzEAdD?XX@nAH~AJ@UAT_BKcCMHcGAcEUkC%5D%7DCEMPGbCaA%60MuFlDaB%60CuAdJuFnAy@r@a@pDuBtEuC%60CqARIZc@%5E%7B@Py@uB%7BH%7BF_TyAcFbAFbCJnD?@GtAWrCy@jAg@xAe@lDwA%7C@i@HSBe@wBuDNGVOfCsAtAs@%60@K@u@ES%7B@wAi@d@o@%5EXh@LLFFBH?ROZGHm@%5CiAh@e@IIKKQIWAW?WGEMGGGESA%5BFg@J%5DZe@TQNGH?%5CBJEMWMU%7B@b@%5BXSXQb@Kp@@l@Pz@j@jARZbAjBx@tAVL%5EFP?vAaAlD_CrCoBzAgAl@_@l@YvBaAbD%7BAnBs@VKlAS@GtAAfCDbAHtAP~Bh@%60A%5E%60Bz@zC~ApBqD%5EaAFo@EqGImG@%7DACWU_AY_AcBj@e@Ls@N_BTw@HaBDkAC%7DJ%5Dk%5Da@cBBa@DmAXeAXsCjAuG~CiCvAi@%60@q@v@U%5EgAxBU%60@SROLWLg@L_AFkA@g@AYCs@Oq@Ye@UcAYo@C%7D@?SZQXIXPtA%60@dBrGfVtBbHhAhEfDjMd@%7CAVv@tApFx@pCsAb@mA%60@wAr@_DpBu@Xs@d@kDpBy@h@aAl@%7DFzDsDhBSl@Kf@G%7C@jA%7CCz@%60CxAdDeBbA_FpCkBhAGHMPKXI~AUdE',
            purpose='Casual',
            calories=200,
            ascent=1,
            descent=2,
            startPos_id=1,
            endPos_id=2
        )
        db.session.add(route_2)

        db.session.commit()

    
    def test_statRead(self):

        date_today = datetime.date.today()
        date_today_str = date_today.strftime('%Y-%m-%d')

        self.assertEqual(
            dailyCaloriesRead(1),
            [
                (datetime.date(date_today.year, date_today.month, date_today.day), 300)
            ]
        )


if __name__ == '__main__':
    unittest.main()
