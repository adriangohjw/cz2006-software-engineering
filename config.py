POSTGRES_USER = 'postgres'
POSTGRES_PW = 'localhostdbpassword'
POSTGRES_URL = '127.0.0.1:5432'
POSTGRES_DB = 'cz2006'

class Config:
    URI = 'postgresql+psycopg2://{user}:{pw}@{url}/{db}'.format(user=POSTGRES_USER,pw=POSTGRES_PW,url=POSTGRES_URL,db=POSTGRES_DB) 


POSTGRES_DB_TEST = 'cz2006_test'

class ConfigTest:
    URI = 'postgresql+psycopg2://{user}:{pw}@{url}/{db}'.format(user=POSTGRES_USER,pw=POSTGRES_PW,url=POSTGRES_URL,db=POSTGRES_DB_TEST)


MAP_QUEST_KEY = 'EMDjCJrwFiN8lUuF8AajAuyVXuCo0biy'
GMAPS_KEY = 'AIzaSyA3YCs9pJnxE9gXAAkGDO3vNxxOsVgjWw8'
