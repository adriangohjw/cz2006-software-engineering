from models import class

# from dao.classsDAO import classCreate, classRead, classUpdate, classDelete
from exceptions import ErrorWithCode

"""
def initializeclass(topic_id, lesson_id, description):
    return class(topic_id, lesson_id, description)
"""

def classReadOperation(id):
    class = classRead(id)

    # class is not found
    if class is None:
        raise ErrorWithCode(404, "No class found")

    # success case
    return class

def classCreateOperation(topic_id, lesson_id, description):
    lesson = lessonRead(topic_id=topic_id, col='id', value=lesson_id)

    # topic and lesson not found
    if lesson is None:
        raise ErrorWithCode(404, "No topic/lesson found")

    class = initializeclass(topic_id, lesson_id, description)
    if classCreate(class) == False:
        raise ErrorWithCode(400, "Unsuccessful")

    # success case
    return class
    
def classUpdateOperation(id, description):
    class = classRead(id)

    # class is not found
    if class is None:
        raise ErrorWithCode(404, "No class found")

    class.description = description
    if classUpdate() == False:
        raise ErrorWithCode(400, "Unsuccessful")

    # success case
    return class

def classDeleteOperation(id):
    class = classRead(id)
    
    # class is not found
    if class is None:
        raise ErrorWithCode(404, "No class found")

    if classDelete(id) == False:
        raise ErrorWithCode(400, "Unsuccessful")

    # success case
    return True