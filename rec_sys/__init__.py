from flask import Flask  
from flask_cors import CORS  
my_app = Flask(__name__)  
CORS(my_app)
from rec_sys import routes