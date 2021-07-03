CREATE TABLE user_sessions (
    id INT NOT NULL AUTO_INCREMENT,
    session_id VARCHAR(32) NOT NULL,
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
    session_id VARCHAR(32) NOT NULL,
    question_id INT NOT NULL,
    answer_number INT NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE quizzes (
    quiz_id VARCHAR(32) NOT NULL,
    pretty_name VARCHAR(255) NOT NULL,
    num_questions INT NOT NULL,
    time_limit INT NOT NULL,
    PRIMARY KEY (`quiz_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
