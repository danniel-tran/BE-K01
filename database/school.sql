SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS = 0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE = 'TRADITIONAL,ALLOW_INVALID_DATES';

------------------------------------------ CREATE DATABASE --------------------------------------------------------
DROP DATABASE IF EXISTS `school`;
CREATE DATABASE IF NOT EXISTS `school`;
USE `school`;

CREATE TABLE IF NOT EXISTS proffessor (
    `prof_id` INT AUTO_INCREMENT PRIMARY KEY,
    `prof_lname` VARCHAR(50) NOT NULL,
    `prof_fname` VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS student (
    `stud_id` INT AUTO_INCREMENT PRIMARY KEY,
    `stud_fname` VARCHAR(10) NOT NULL,
    `stud_lname` VARCHAR(10) NOT NULL,
    `stud_street` VARCHAR(10) DEFAULT NULL,
    `stud_city` VARCHAR(10) NULL DEFAULT NULL,
    `stud_zip` VARCHAR(10) NULL DEFAULT NULL
);

CREATE TABLE IF NOT EXISTS course (
    `course_id` INT AUTO_INCREMENT PRIMARY KEY,
    `course_name` VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS class(
    `class_id` INT AUTO_INCREMENT PRIMARY KEY,
    `class_name` VARCHAR(255),
    `prof_id` INT,
    `course_id` INT,
    FOREIGN KEY (`prof_id`) REFERENCES `proffessor` (`prof_id`) ON UPDATE RESTRICT ON DELETE RESTRICT,
    FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`) ON UPDATE RESTRICT ON DELETE RESTRICT 
);

CREATE TABLE IF NOT EXISTS room (
    `room_id` INT AUTO_INCREMENT PRIMARY KEY,
    `room_loc` VARCHAR(50),
    `room_cap` VARCHAR(50),
    `class_id` INT,
    FOREIGN KEY (`class_id`) REFERENCES `class`(`class_id`) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS enroll(
    `stud_id` INT AUTO_INCREMENT,
    `class_id` INT,
    `grade` VARCHAR(3),
    FOREIGN KEY (`stud_id`) REFERENCES `student`(`stud_id`) ON UPDATE RESTRICT ON DELETE RESTRICT,
    FOREIGN KEY (`class_id`) REFERENCES `class`(`class_id`) ON UPDATE RESTRICT ON DELETE RESTRICT,
    PRIMARY KEY (`stud_id`, `class_id`) 
);

------------------------------------------ INSERT DATABASE --------------------------------------------------------
-- proffessor 
INSERT INTO `proffessor` (`prof_fname`, `prof_lname`) VALUES('Peter','John');
INSERT INTO `proffessor` (`prof_fname`, `prof_lname`) VALUES('Adam','Smith');
INSERT INTO `proffessor` (`prof_fname`, `prof_lname`) VALUES('Warrent','Bridge');
INSERT INTO `proffessor` (`prof_fname`, `prof_lname`) VALUES('Peterson','Wick');
INSERT INTO `proffessor` (`prof_fname`, `prof_lname`) VALUES('Hello','World');
INSERT INTO `proffessor` (`prof_fname`, `prof_lname`) VALUES('Professor','Wong');

-- proffessor
INSERT INTO `student` (`stud_fname`, `stud_lname`,`stud_street`,`stud_city`,`stud_zip`) VALUES ('Adam','John', 'street 1','city 1','zip 1');
INSERT INTO `student` (`stud_fname`, `stud_lname`,`stud_street`,`stud_city`,`stud_zip`) VALUES ('Peter','John','street 2','city 2','zip 2');
INSERT INTO `student` (`stud_fname`, `stud_lname`,`stud_street`,`stud_city`,`stud_zip`) VALUES ('Harry','Kane','street 3','city 3','zip 3');
INSERT INTO `student` (`stud_fname`, `stud_lname`,`stud_street`,`stud_city`,`stud_zip`) VALUES ('Ronie','Smith','street 4','city 4','zip 4');
INSERT INTO `student` (`stud_fname`, `stud_lname`,`stud_street`,`stud_city`,`stud_zip`) VALUES ('Luke','Shaw', 'street 5','city 5','zip 5');
INSERT INTO `student` (`stud_fname`, `stud_lname`,`stud_street`,`stud_city`,`stud_zip`) VALUES ('Helen','Dane','street 6','city 6','zip 6');
INSERT INTO `student` (`stud_fname`, `stud_lname`,`stud_street`,`stud_city`,`stud_zip`) VALUES ('Danie','John','street 7','city 7','zip 7');
INSERT INTO `student` (`stud_fname`, `stud_lname`,`stud_street`,`stud_city`,`stud_zip`) VALUES ('Mike','Gil', 'street 8','city 8','zip 8');
INSERT INTO `student` (`stud_fname`, `stud_lname`,`stud_street`,`stud_city`,`stud_zip`) VALUES ('Sauny','Curry','street 9','city 9','zip 9');
INSERT INTO `student` (`stud_fname`, `stud_lname`,`stud_street`,`stud_city`,`stud_zip`) VALUES ('Adama','Stone','street 10','city 10','zip 10');
-- course
INSERT INTO `course` (`course_name`) VALUES('PROGRAMING');
INSERT INTO `course` (`course_name`) VALUES('BIOLOGY');
INSERT INTO `course` (`course_name`) VALUES('MATH');
INSERT INTO `course` (`course_name`) VALUES('ENGLISH');
INSERT INTO `course` (`course_name`) VALUES('PHYSICS');
-- class
INSERT INTO `class` (`class_name`,`prof_id`,`course_id`) VALUES('class-A1',1,1);
INSERT INTO `class` (`class_name`,`prof_id`,`course_id`) VALUES('class-A2',2,3);
INSERT INTO `class` (`class_name`,`prof_id`,`course_id`) VALUES('class-A3',3,5);
INSERT INTO `class` (`class_name`,`prof_id`,`course_id`) VALUES('class-A4',5,4);
INSERT INTO `class` (`class_name`,`prof_id`,`course_id`) VALUES('class-A5',6,2);
INSERT INTO `class` (`class_name`,`prof_id`,`course_id`) VALUES('class-A6',1,1);
INSERT INTO `class` (`class_name`,`prof_id`,`course_id`) VALUES('class-A7',4,5);
INSERT INTO `class` (`class_name`,`prof_id`,`course_id`) VALUES('class-A8',6,3);
INSERT INTO `class` (`class_name`,`prof_id`,`course_id`) VALUES('class-A9',3,2);
INSERT INTO `class` (`class_name`,`prof_id`,`course_id`) VALUES('class-A10',4,4);
INSERT INTO `class` (`class_name`,`prof_id`,`course_id`) VALUES('class-A11',2,5);
INSERT INTO `class` (`class_name`,`prof_id`,`course_id`) VALUES('class-A12',2,3);
INSERT INTO `class` (`class_name`,`prof_id`,`course_id`) VALUES('class-A13',5,1);
-- ROOM
INSERT INTO `room` (`room_loc`, `room_cap`, `class_id`) VALUES('LOC-1',30,1);
INSERT INTO `room` (`room_loc`, `room_cap`, `class_id`) VALUES('LOC-2',30,2);
INSERT INTO `room` (`room_loc`, `room_cap`, `class_id`) VALUES('LOC-3',30,3);
INSERT INTO `room` (`room_loc`, `room_cap`, `class_id`) VALUES('LOC-4',30,4);
INSERT INTO `room` (`room_loc`, `room_cap`, `class_id`) VALUES('LOC-5',30,5);
INSERT INTO `room` (`room_loc`, `room_cap`, `class_id`) VALUES('LOC-6',30,6);
INSERT INTO `room` (`room_loc`, `room_cap`, `class_id`) VALUES('LOC-7',30,7);
INSERT INTO `room` (`room_loc`, `room_cap`, `class_id`) VALUES('LOC-8',30,8);
INSERT INTO `room` (`room_loc`, `room_cap`, `class_id`) VALUES('LOC-9',30,9);
INSERT INTO `room` (`room_loc`, `room_cap`, `class_id`) VALUES('LOC-10',30,10);
INSERT INTO `room` (`room_loc`, `room_cap`, `class_id`) VALUES('LOC-11',30,11);
INSERT INTO `room` (`room_loc`, `room_cap`, `class_id`) VALUES('LOC-12',30,12);
INSERT INTO `room` (`room_loc`, `room_cap`, `class_id`) VALUES('LOC-13',30,13);
-- enroll
INSERT INTO `enroll` (`stud_id`, `class_id`, `grade`) VALUES(1,1,'GR');
INSERT INTO `enroll` (`stud_id`, `class_id`, `grade`) VALUES(1,2,'GR');
INSERT INTO `enroll` (`stud_id`, `class_id`, `grade`) VALUES(1,3,'GR');
INSERT INTO `enroll` (`stud_id`, `class_id`, `grade`) VALUES(2,3,'GR');
INSERT INTO `enroll` (`stud_id`, `class_id`, `grade`) VALUES(2,4,'GR');
INSERT INTO `enroll` (`stud_id`, `class_id`, `grade`) VALUES(2,5,'GR');
INSERT INTO `enroll` (`stud_id`, `class_id`, `grade`) VALUES(2,6,'GR');
INSERT INTO `enroll` (`stud_id`, `class_id`, `grade`) VALUES(3,6,'GR');
INSERT INTO `enroll` (`stud_id`, `class_id`, `grade`) VALUES(3,7,'GR');
INSERT INTO `enroll` (`stud_id`, `class_id`, `grade`) VALUES(3,8,'GR');
INSERT INTO `enroll` (`stud_id`, `class_id`, `grade`) VALUES(4,8,'GR');
INSERT INTO `enroll` (`stud_id`, `class_id`, `grade`) VALUES(4,9,'GR');
INSERT INTO `enroll` (`stud_id`, `class_id`, `grade`) VALUES(4,10,'GR');
INSERT INTO `enroll` (`stud_id`, `class_id`, `grade`) VALUES(5,10,'GR');
INSERT INTO `enroll` (`stud_id`, `class_id`, `grade`) VALUES(5,11,'GR');
INSERT INTO `enroll` (`stud_id`, `class_id`, `grade`) VALUES(5,12,'GR');
INSERT INTO `enroll` (`stud_id`, `class_id`, `grade`) VALUES(6,11,'GR');
INSERT INTO `enroll` (`stud_id`, `class_id`, `grade`) VALUES(6,12,'GR');
INSERT INTO `enroll` (`stud_id`, `class_id`, `grade`) VALUES(6,13,'GR');
INSERT INTO `enroll` (`stud_id`, `class_id`, `grade`) VALUES(6,13,'GR');
INSERT INTO `enroll` (`stud_id`, `class_id`, `grade`) VALUES(7,12,'GR');
INSERT INTO `enroll` (`stud_id`, `class_id`, `grade`) VALUES(7,14,'GR');
INSERT INTO `enroll` (`stud_id`, `class_id`, `grade`) VALUES(8,15,'GR');
INSERT INTO `enroll` (`stud_id`, `class_id`, `grade`) VALUES(8,16,'GR');
INSERT INTO `enroll` (`stud_id`, `class_id`, `grade`) VALUES(9,16,'GR');
INSERT INTO `enroll` (`stud_id`, `class_id`, `grade`) VALUES(10,16,'GR');
INSERT INTO `enroll` (`stud_id`, `class_id`, `grade`) VALUES(8,16,'GR');
INSERT INTO `enroll` (`stud_id`, `class_id`, `grade`) VALUES(7,16,'GR');
INSERT INTO `enroll` (`stud_id`, `class_id`, `grade`) VALUES(10,15,'GR');
INSERT INTO `enroll` (`stud_id`, `class_id`, `grade`) VALUES(6,16,'GR');
INSERT INTO `enroll` (`stud_id`, `class_id`, `grade`) VALUES(4,13,'GR');

------------------------------------------ QUERY DATABASE --------------------------------------------------------

-- những cặp student-professor có dạy học nhau và số lớp mà họ có liên quan
SELECT CONCAT(P.prof_fname , " " , P.prof_lname) AS proffessor_NAME, 
CONCAT(S.stud_fname , " " , S.stud_lname) AS student_NAME,
COUNT(C.class_id) AS TIME_MEET
FROM proffessor AS P
INNER JOIN class AS C ON C.prof_id = P.prof_id
INNER JOIN enroll AS E ON E.class_id = C.class_id
INNER JOIN student AS S ON S.stud_id = E.stud_id
GROUP BY proffessor_NAME,student_NAME;

-- những course (distinct) mà 1 professor cụ thể đang dạy
SELECT course.course_name
FROM course 
INNER JOIN class ON class.course_id = course.course_id
INNER JOIN proffessor AS P ON P.prof_id = class.prof_id
WHERE P.prof_id = 2
GROUP BY course.course_name;

-- những course (distinct) mà 1 student cụ thể đang học
SELECT course.course_name
FROM course
INNER JOIN class ON class.course_id = course.course_id
INNER JOIN enroll AS E ON E.class_id = class.class_id
INNER JOIN student AS S ON S.stud_id = E.stud_id
WHERE S.stud_id = 1
GROUP BY course.course_name;

-- điểm số là A, B, C, D, E, F tương đương với 10, 8, 6, 4, 2, 0, điểm số trung bình của 1 học sinh cụ thể (quy ra lại theo chữ cái, và xếp loại học lực (weak nếu avg < 5, average nếu >=5 < 8, good nếu >=8 )
SELECT (
CASE
    WHEN AVG(E.grade) >= 8 THEN "good"
    WHEN AVG(E.grade) >= 5 THEN "average"
    ELSE "weak"
END) AS LEVEL, 
(CASE
    WHEN AVG(E.grade) = 10 THEN "A"
    WHEN AVG(E.grade) >= 8 THEN "B"
    WHEN AVG(E.grade) >= 6 THEN "C"
    WHEN AVG(E.grade) >= 4 THEN "D"
    WHEN AVG(E.grade) >= 2 THEN "E"
    ELSE "F"
END) AS MARK_LETTER,
CONCAT(S.stud_fname , " " , S.stud_lname) AS student_NAME
FROM student AS S
JOIN enroll AS E
GROUP BY S.stud_id, student_NAME;

-- điểm số trung bình của các class (quy ra lại theo chữ cái)

SELECT 
(CASE
    WHEN AVG(E.grade) = 10 THEN "A"
    WHEN AVG(E.grade) >= 8 THEN "B"
    WHEN AVG(E.grade) >= 6 THEN "C"
    WHEN AVG(E.grade) >= 4 THEN "D"
    WHEN AVG(E.grade) >= 2 THEN "E"
    ELSE "F"
END) AS MARK_LETTER, C.class_name
FROM class AS C
JOIN enroll AS E ON E.class_id = C.class_id
GROUP BY C.class_id;

-- điểm số trung bình của các course (quy ra lại theo chữ cái)

SELECT 
(CASE
    WHEN AVG(E.grade) = 10 THEN "A"
    WHEN AVG(E.grade) >= 8 THEN "B"
    WHEN AVG(E.grade) >= 6 THEN "C"
    WHEN AVG(E.grade) >= 4 THEN "D"
    WHEN AVG(E.grade) >= 2 THEN "E"
    ELSE "F"
END) AS MARK_LETTER, course.course_name
FROM class 
JOIN course ON course.course_id = class.course_id
JOIN enroll AS E ON E.class_id = class.class_id 
GROUP BY course.course_id;

