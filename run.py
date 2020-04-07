from flask import Flask
from config import Config
from flask_cors import CORS

def create_app():
    app = Flask(__name__)
    CORS(app)
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
    app.config['SQLALCHEMY_DATABASE_URI'] = Config.URI

    return app

if __name__ == "__main__":

    app = create_app()

    from models import db 
    db.init_app(app)

    from blueprints import user_bp, route_bp, algo_bp
    app.register_blueprint(user_bp, url_prefix='/users')
    app.register_blueprint(route_bp, url_prefix='/routes')
    app.register_blueprint(algo_bp, url_prefix='/algo')

    app.run(port=5000, debug=True)
    