DROP TABLE IF EXISTS 'groups';
DROP TABLE IF EXISTS 'sqlite_sequence';
DROP TABLE IF EXISTS 'student';
DROP TABLE IF EXISTS 'students_marks';
CREATE TABLE groups(
id INTEGER PRIMARY KEY AUTOINCREMENT,
name VARCHAR(255) NOT NULL,
description VARCHAR(255)
);
INSERT INTO 'groups' VALUES(1,'БВТ2301','лучшая группа(потому что тут я)');
INSERT INTO 'groups' VALUES(2,'БВТ2302','лучшая группа(потому что тут я)');
INSERT INTO 'groups' VALUES(3,'БВТ2303','лучшая группа(потому что тут я)');
CREATE TABLE sqlite_sequence(name,seq);
INSERT INTO 'sqlite_sequence' VALUES('groups',3);
INSERT INTO 'sqlite_sequence' VALUES('student',3);
CREATE TABLE student (
id INTEGER PRIMARY KEY AUTOINCREMENT,
name VARCHAR(255),
group_id int NOT NULL REFERENCES groups (id)
);
INSERT INTO 'student' VALUES(1,'Глыгало Егор',2);
INSERT INTO 'student' VALUES(2,'Иванов Иван',1);
INSERT INTO 'student' VALUES(3,'Павлов Павел',3);
CREATE TABLE students_marks(
student_id INTEGER PRIMARY KEY REFERENCES student (id),
math_mark_average FLOAT,
physics_mark_average FLOAT,
python_mark_average FLOAT
);
INSERT INTO 'students_marks' VALUES(1,2.5,4,5);
INSERT INTO 'students_marks' VALUES(2,3.5,2.5,2);
INSERT INTO 'students_marks' VALUES(3,2.3,4.1,2.5);
