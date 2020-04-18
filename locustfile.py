from locust import HttpLocust, TaskSequence, seq_task, task, between


class UserBehaviour(TaskSequence):

    # user login
    @seq_task(1)
    @task(1)
    def login(self):
        self.client.get('/users/auth?username=richardhendricks&password=password')


    # find routes 3 times
    @seq_task(3)
    @task(3)
    def load_lesson(self):
        self.client.get('/algo/routes_search?startPos_lat=1.35027&startPos_long=103.69781&endPos_lat=1.34877&endPos_long=103.6992&fit_level=10&weight=70')


class WebsiteUser(HttpLocust):
    task_set = UserBehaviour
    wait_time = between(1, 10)
