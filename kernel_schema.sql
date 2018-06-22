-- CREATE DATABASE kernel_schema;
-- USE kernel_schema;

-- Core Tables
CREATE TABLE university (
id BIGINT NOT NULL PRIMARY KEY,
name VARCHAR(45) NOT NULL,
street VARCHAR(45) NOT NULL,
city VARCHAR(45) NOT NULL,
country VARCHAR(45) NOT NULL,
email_end1 VARCHAR(45) NOT NULL UNIQUE,
email_end2 VARCHAR(45)
);

CREATE TABLE lecturer (
id BIGINT NOT NULL PRIMARY KEY,
fname VARCHAR(45) NOT NULL,
lname VARCHAR(45) NOT NULL,
email VARCHAR(45) NOT NULL UNIQUE,
password VARCHAR(45) NOT NULL
);

CREATE TABLE student (
id BIGINT NOT NULL PRIMARY KEY,
fname VARCHAR(45) NOT NULL,
lname VARCHAR(45) NOT NULL,
college_id VARCHAR(45) NOT NULL UNIQUE,
email VARCHAR(45) NOT NULL UNIQUE,
password VARCHAR(45) NOT NULL,
course_code1 VARCHAR(45) NOT NULL,
course_code2 VARCHAR(45)
);

CREATE TABLE module (
id BIGINT NOT NULL PRIMARY KEY,
name VARCHAR(45) NOT NULL,
code VARCHAR(45) NOT NULL
);

-- Tables between University & Module (visual schema)
-- ===================================================
CREATE TABLE university_room (
room_code VARCHAR(45) NOT NULL PRIMARY KEY,
university_id BIGINT NOT NULL,
FOREIGN KEY (university_id) REFERENCES university(id)
);

CREATE TABLE room_pi (
pi_id VARCHAR(45) NOT NULL PRIMARY KEY,
university_id BIGINT NOT NULL,
room_code VARCHAR(45) NOT NULL,
FOREIGN KEY (university_id) REFERENCES university(id),
FOREIGN KEY (room_code) REFERENCES university_room(room_code)
);

CREATE TABLE pi_module (
module_id BIGINT NOT NULL,
pi_id VARCHAR(45),
FOREIGN KEY (module_id) REFERENCES module(id),
FOREIGN KEY (pi_id) REFERENCES room_pi(pi_id)
);

CREATE TABLE schedule_pi (
module_id BIGINT NOT NULL,
time_start TIME NOT NULL,
time_end TIME NOT NULL,
day_of_week BIGINT,
FOREIGN KEY (module_id) REFERENCES module(id)
);

-- ===========================================================

-- Tables between Lecturer & Module (visual schema)
-- ===================================================
CREATE TABLE lecturer_module (
lecturer_id BIGINT NOT NULL,
module_id BIGINT NOT NULL,
FOREIGN KEY (lecturer_id) REFERENCES lecturer(id),
FOREIGN KEY (module_id) REFERENCES module(id)
);
-- ===========================================================

-- Tables between Student & Module (visual schema)
-- ===================================================
CREATE TABLE student_module (
student_id BIGINT NOT NULL,
module_id BIGINT NOT NULL,
FOREIGN KEY (student_id) REFERENCES student(id),
FOREIGN KEY (module_id) REFERENCES module(id)
);

CREATE TABLE schedule_student (
schedule_id BIGINT NOT NULL PRIMARY KEY,
student_id BIGINT NOT NULL,
module_id BIGINT NOT NULL,
time_start TIME NOT NULL,
time_finish TIME NOT NULL,
day_of_week BIGINT,
FOREIGN KEY (student_id) REFERENCES student(id),
FOREIGN KEY (module_id) REFERENCES module(id)
);

CREATE TABLE unverified (
student_id BIGINT NOT NULL,
module_id BIGINT NOT NULL,
device_mac_addr VARCHAR(45),
FOREIGN KEY (student_id) REFERENCES student(id),
FOREIGN KEY (module_id) REFERENCES module(id)
);

CREATE TABLE verified (
verification_id BIGINT NOT NULL PRIMARY KEY,
student_id BIGINT NOT NULL,
module_id BIGINT NOT NULL,
first_verification BINARY NOT NULL DEFAULT 0,
second_verification BINARY NOT NULL DEFAULT 0,
third_verification BINARY NOT NULL DEFAULT 0,
device_mac_addr VARCHAR(45) NOT NULL
);