-- Assume the following tables are used in a university database.
CREATE DATABASE university;

-- Student <StID, name, lastname, department>
CREATE TABLE Student
(
  stid              INT unsigned NOT NULL AUTO_INCREMENT,  -- unique student id
  name              VARCHAR(150) NOT NULL,                 -- Students first name
  lastname          VARCHAR(150) NOT NULL,                 -- Students last name
  department        VARCHAR(150) NOT NULL,                 -- Department of major
  PRIMARY KEY       (stid)                                 -- Make the id the primary key
);

--Course <code, name, credit>
CREATE TABLE Course
(
  code              SMALLINT unsigned NOT NULL,            -- unique course code
  name              VARCHAR(150) NOT NULL,                 -- course name
  credit            TINYINT unsigned NOT NULL,             -- total credit hours
  PRIMARY KEY       (code)                                 -- Make the code the primary key
);

-- Grades <StId, code, year, semester, score>
CREATE TABLE Grades
(
  stid              INT unsigned NOT NULL,                 -- unique student id
  code              SMALLINT unsigned NOT NULL,            -- Students first name
  year              SMALLINT unsigned NOT NULL,            -- Students last name
  semester          TINYINT unsigned NOT NULL,             -- Department of major
  score             TINYINT unsigned,                      -- Final score for the course
  PRIMARY KEY       (stid, code, year, semester),          -- one unique class per student
  FOREIGN KEY       (stid) REFERENCES Student(stid) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY       (code) REFERENCES Course(code) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Write necessary SQL commands to create the tables. Make valid assumptions about the domains of the attributes,
-- and constraints. Choose appropriate primary and foreign keys. Write queries to add a few records to each
-- table (at least 2 students, 4 courses, and 3 grades for each student
INSERT INTO Student
    (name, lastname, department)
    VALUES
    ('Jason', 'Watson', 'Computer Science'),
    ('Ada', 'Lovelace', 'Mathematics'),
    ('Vint', 'Cerf', 'Mathematics'),
    ('Alan', 'Turing', 'Mathematics'),
    ('Linus', 'Torvalds', 'Computer Science')
;

INSERT INTO Course
    (code, name, credit)
    VALUES
    ('1001','Underwater Baket Weaving','3'),
    ('6399','Advanced Computer Networks','3'),
    ('6488','Cybersecurity Bandits','3'),
    ('2040','Discrete Mathematics','3')
;


INSERT INTO Grades
    (stid, code, year, semester, score)
    VALUES
    ('1', '1001', '2021', '20', '0'),
    ('1', '6399', '2223', '10', '100'),
    ('1', '6488', '2223', '10', '95'),
    ('1', '2040', '2223', '20', NULL),
    ('2', '2040', '2122', '20', '100'),
    ('2', '6399', '2223', '10', '100'),
    ('2', '6488', '2021', '20', '23'),
    ('3', '1001', '2021', '20', '57'),
    ('3', '6399', '2223', '10', '100'),
    ('3', '6488', '2223', '10', '85'),
    ('4', '1001', '2021', '20', '0'),
    ('4', '6399', '2223', '10', '100'),
    ('4', '6488', '2223', '10', '99'),
    ('5', '1001', '2021', '20', '47'),
    ('5', '6399', '2223', '10', '100'),
    ('5', '6488', '2223', '10', '100')
;

-- Write a query to find all students that failed a specific course (choose a course form your list) in 2021- spring
SELECT 
    s.stid student_id,
    s.name first_name,
    s.lastname last_name,
    g.code course_code,
    g.year year,
    g.semester semester,
    g.score score
FROM
    university.Student s
    left join university.grades g on g.stid = s.stid
WHERE
    g.year = '2021'
    AND g.semester = '20' -- 10 = fall, 20 = spring
    AND g.score < 70
;

-- Given the student ID of a student, print his/her transcript
SELECT
    s.stid ID,
    CONCAT(s.name, ' ', s.lastname) name,
    g.code 'Course Code',
    c.name 'Course Name',
    g.year Year,
    g.semester Semester,
    g.score Score,
    (
        CASE
            WHEN g.score >= 70 THEN c.credit
            WHEN g.score is NULL THEN 'IP'
            ELSE 0
        END
    ) Credit
FROM
    university.Student s
    left join university.Grades g on g.stid = s.stid
    left join university.Course c on c.code = g.code
where s.stid = 1 -- Change ID to lookup new transcript
order by g.year desc, g.semester asc
;