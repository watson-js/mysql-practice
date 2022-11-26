CREATE database university;
USE university;

--Student <StID, name, department>
CREATE TABLE Student
(
  stid              INT unsigned NOT NULL AUTO_INCREMENT,  # unique student id
  name              VARCHAR(150) NOT NULL,                 # Students first name
  department        VARCHAR(150) NOT NULL,                 # Department of major
  PRIMARY KEY       (stid)                                 # Make the id the primary key
);

--Course <code, cname, credit>
CREATE TABLE Course
(
  cid               VARCHAR(12) NOT NULL,                  # unique course code
  cname             VARCHAR(150) NOT NULL,                 # course name
  credit            TINYINT unsigned NOT NULL,             # total credit hours
  PRIMARY KEY       (cid)                                  # Make the code the primary key
);

-- Grading <stid, cid, year, grade>
CREATE TABLE Grading
(
  stid              INT unsigned NOT NULL,                 # unique student id
  cid               VARCHAR(12) NOT NULL,                  # unique course code
  year              SMALLINT unsigned NOT NULL,            # Students last name
  grade             TINYINT unsigned,                      # Final grade for the course
  PRIMARY KEY       (stid, cid, year),                     # one unique class per student
  FOREIGN KEY       (stid) REFERENCES Student(stid) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY       (cid) REFERENCES Course(cid) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO Student
    (name, department)
    VALUES
    ('Jason', 'Computer Science'),
    ('Ada', 'Mathematics'),
    ('Vint', 'Mathematics'),
    ('Alan', 'Mathematics'),
    ('Linus', 'Computer Science'),
    ('John', 'Computer Science')
;

INSERT INTO Course
    (cid, cname, credit)
    VALUES
    ('CENG356','Advanced Software Engineering','3'),
    ('CS6399','Advanced Computer Networks','3'),
    ('CY6488','Cybersecurity Bandits','3'),
    ('MT2040','Discrete Mathematics','3')
;

INSERT INTO
    Grading (stid, cid, year, grade)
VALUES
    ('1',   'CENG356',  '2020',     '95'    ),
    ('1',   'CENG356',  '2010',     '42'    ),
    ('1',   'CS6399',   '2018',     '100'   ),
    ('1',   'CY6488',   '2018',     '95'    ),
    ('1',   'MT2040',   '2018',     NULL    ),
    ('2',   'CS6399',   '2022',     '100'   ),
    ('2',   'MT2040',   '2018',     '100'   ),
    ('2',   'CY6488',   '2021',     '23'    ),
    ('3',   'CENG356',  '2020',     '75'    ),
    ('3',   'CENG356',  '2010',     '57'    ),
    ('3',   'MT2040',   '2018',     '100'   ),
    ('3',   'CY6488',   '2018',     '85'    ),
    ('4',   'MT2040',   '2021',     '0'     ),
    ('4',   'CS6399',   '2018',     '100'   ),
    ('4',   'CY6488',   '2018',     '99'    ),
    ('5',   'MT2040',   '2021',     '47'    ),
    ('5',   'CS6399',   '2018',     '100'   ),
    ('5',   'CY6488',   '2018',     '100'   ),
    ('6',   'CENG356',  '2020',     '86'    ),
    ('6',   'CENG356',  '2000',     '47'    ),
    ('6',   'CS6399',   '2018',     '100'   ),
    ('6',   'CY6488',   '2018',     '100'   )
    ;

-- Find the number of students taking course CENG356 in 2020
SELECT
    count(stid)
FROM
    Grading
WHERE
    cid = 'CENG356'
    and year = '2020'
;

-- Find the average grade for CENG356 in 2020
SELECT
    AVG(grade)
FROM
    Grading
WHERE
    cid = 'CENG356'
    and year = '2020'
;

-- Find the average grade for CENG356 during years 2000 and 2010
SELECT
    AVG(grade)
FROM
    Grading
WHERE
    cid = 'CENG356'
    and year IN ('2000','2010')
;

-- How many courses did a student named ‘John’ take in 2018? 
SELECT
    count(g.stid)
FROM
    Grading g
    left join Student s on s.stid = g.stid
WHERE
    year = '2018'
    and lower(s.name) = 'john'
;

-- What is the average grade of students in each course in 2018?
SELECT
    AVG(grade),
    cid
FROM
    Grading
WHERE
    year = '2018'
GROUP BY cid
;
