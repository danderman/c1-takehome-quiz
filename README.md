## Setup

1. Install MySQL
2. Run `MYSQL_PWD=(pass) mysql -h (host) -P (port) -u (user) <setup.sql`
3. Run `pip install -r requirements.txt`
4. Enter the database connection details near the top of app.py
5. Run `python3 app.py`

## Routes

* '/' - an html form to gather contact info and start a quiz session
* '/start-quiz/<quiz_id (use "test-quiz" for testing)>' - create and redirect to a quiz session
* '/quiz/<session_id>' - the main quiz page, currently just JSON with the number of questions and the time limit
* '/question/<quiz_id>/<num>' - load the question text and list of answers
* '/response/<session_id>/<question_id>/<answer_number>' - save a response
* '/results/<session_id>' - get the number of questions and the number of correct responses