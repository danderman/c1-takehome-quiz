from flask import Flask, render_template, request
from flask.json import jsonify
from flask.wrappers import Response
from werkzeug.utils import redirect
from flask_mysqldb import MySQL
import json
from uuid import uuid4

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
def start_quiz(quiz_id):
    if request.method == 'POST':
        session_id = create_session(quiz_id, request.form)
        if session_id:
            redirect(f"/quiz/%s" % session_id)
        else:
            return Response("Could not create quiz session", 500)
    else:
        # error out
        pass


@app.route('/quiz/<session_id>')
def quiz(session_id):
    # TODO use join to save a db call
    session = get_session(session_id)
    if not session:
        return jsonify(
            error = f"no session matching %s" % session_id
        )
    quiz = get_quiz(session['quiz_id'])
    if not quiz:
        return jsonify(
            error = f"no quiz matching %s" % quiz_id
        )
    return jsonify(
        time_limit = quiz['time_limit'],
        total_questions = quiz['num_questions']
    )

@app.route('/question/<quiz_id>/<num>')
def question(quiz_id, num):
    quiz = get_quiz(quiz_id)
    if not quiz:
        return jsonify(
            error = f"no quiz matching %s" % quiz_id
        )
    qsql = '''SELECT * FROM questions WHERE quiz_id = %s AND question_number = %s'''
    q = get_sql_rows(qsql, (quiz_id, num))
    if q:
        q = q[0]
        asql = '''SELECT answer_number, answer_text FROM answers WHERE question_id = %s'''
        ans = get_sql_rows(asql, (q['id'],))
        if ans:
            return jsonify(
                question_text = q['question_text'],
                answers = ans,
                total_questions = quiz['num_questions']
            )
    return jsonify(
        error = f"could not load question %s" % num
    )


@app.route('/response/<session_id>/<question_id>/<response_id>')
def response():
    pass

def create_session(quiz_id, form):
    quiz = get_quiz(quiz_id)
    if not quiz:
        return False
    uuid = uuid4()
    sql = '''INSERT INTO user_sessions (session_id, quiz_id, first_name, last_name, email) 
        VALUES (%s, %s, %s, %s, %s)'''
    result = insert_sql_rows(sql, ((uuid, quiz_id, form['first_name'], form['last_name'], form['email'])))
    if result:
        return uuid
    else:
        return False

def get_quiz(quiz_id):
    sql = '''SELECT * FROM quizzes WHERE quiz_id = %s'''
    quiz = get_sql_rows(sql, (quiz_id,))
    if not quiz:
        return False
    return quiz[0]

def get_session(session_id):
    sql = '''SELECT * FROM sessions WHERE session_id = %s'''
    session = get_sql_rows(sql, (session_id,))
    if not session:
        return False
    return session[0]

def get_sql_rows(sql, vars):
    pass

def insert_sql_rows(sql, rows):
    pass