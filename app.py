from flask import Flask, render_template, request
from werkzeug.utils import redirect
from flask_mysqldb import MySQL
import json

app = Flask(__name__)

app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = ''
app.config['MYSQL_DB'] = 'flask'

mysql = MySQL(app)

@app.route('/')
def welcome():
    return render_template("welcome.html")

@app.route('/start-quiz/<quiz_id>')
def quiz(quiz_id):
    if request.method == 'POST':
        session_id = create_session(quiz_id, request.form)
        redirect(f"/quiz/%s" % session_id)

def create_session(form):
    pass

@app.route('/question/<quiz_id>/<num>')
def question(quiz_id, num):
    pass

@app.route('/response/<session_id>/<question_id>/<response_id>')
def response():
    pass