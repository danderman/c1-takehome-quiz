CREATE DATABASE `flask` DEFAULT CHARACTER SET = `utf8`;
USE `flask`;

CREATE TABLE user_sessions (
    id INT NOT NULL AUTO_INCREMENT,
    session_id VARCHAR(48) NOT NULL,
    quiz_id VARCHAR(32) NOT NULL,
    first_name VARCHAR(32) NOT NULL,
    last_name VARCHAR(32) NOT NULL,
    email VARCHAR(32) NOT NULL,
    start_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE questions (
    id INT NOT NULL AUTO_INCREMENT,
    quiz_id VARCHAR(32) NOT NULL,
    question_number INT NOT NULL,
    question_text TEXT,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE answers (
    id INT NOT NULL AUTO_INCREMENT,
    question_id INT NOT NULL,
    answer_number INT NOT NULL,
    answer_text TEXT,
    is_correct TINYINT DEFAULT 0,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE responses (
    id INT NOT NULL AUTO_INCREMENT,
    session_id VARCHAR(48) NOT NULL,
    question_id INT NOT NULL,
    answer_number INT NOT NULL,
    response_timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE quizzes (
    quiz_id VARCHAR(32) NOT NULL,
    pretty_name VARCHAR(255) NOT NULL,
    num_questions INT NOT NULL,
    time_limit INT NOT NULL,
    PRIMARY KEY (`quiz_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


INSERT INTO quizzes VALUES (
    "test-quiz",
    "Test Quiz",
    3,
    3600
);

INSERT INTO questions (id, quiz_id, question_number, question_text) VALUES 
    (1, "test-quiz", 1, "How many roads must a man walk down?"),
    (2, "test-quiz", 2, "What is your favorite color?"),
    (3, "test-quiz", 3, "What is the wingspeed velocity of an unladen swallow?")
;

INSERT INTO answers (question_id, answer_number, answer_text, is_correct) VALUES 
    (1, 1, "42", 1),
    (1, 2, "pi", 0),
    (1, 3, "What you get if you multiply 6 by 9", 0),

    (2, 1, "grue", 0),
    (2, 2, "purple", 0),
    (2, 3, "white", 0),
    (2, 4, "rainbow", 1),

    (3, 1, "5 m/s", 0),
    (3, 2, "I don't know", 0),
    (3, 3, "African or European Swallow?", 1)
;