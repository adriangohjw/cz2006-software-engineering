from flask import Flask
from config import Config

def create_app():
    app = Flask(__name__)
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
    app.config['SQLALCHEMY_DATABASE_URI'] = Config.URI

    return app

if __name__ == "__main__":
    app = create_app()

    from models import db 
    db.init_app(app)

    app.run(port=5000, debug=True)