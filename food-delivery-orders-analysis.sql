-- =========================================
-- MINI PROJECT 001 : STUDENT MANAGEMENT SYSTEM
-- =========================================

-- =========================================
-- STEP 1 : CREATE DATABASE
-- =========================================

CREATE DATABASE student_management;


-- =========================================
-- STEP 2 : CREATE TABLE
-- =========================================

CREATE TABLE students (

    student_id SERIAL PRIMARY KEY,
    
    first_name VARCHAR(50),
    
    last_name VARCHAR(50),
    
    age INT,
    
    course VARCHAR(50),
    
    city VARCHAR(50),
    
    marks INT,
    
    admission_date DATE,
    
    passed BOOLEAN

);


-- =========================================
-- STEP 3 : INSERT DATA
-- =========================================

INSERT INTO students 
(first_name, last_name, age, course, city, marks, admission_date, passed)

VALUES

('Hari', 'Prasad', 22, 'MBA', 'Vizag', 85, '2025-05-10', TRUE),

('Rahul', 'Kumar', 21, 'BCom', 'Hyderabad', 45, '2025-04-11', FALSE),

('Sneha', 'Reddy', 23, 'MBA', 'Bangalore', 91, '2025-03-15', TRUE),

('Kiran', 'Sai', 20, 'BBA', 'Chennai', 67, '2025-01-21', TRUE),

('Divya', 'Sharma', 24, 'MBA', 'Mumbai', 39, '2025-02-18', FALSE);


-- =========================================
-- STEP 4 : DISPLAY ALL STUDENTS
-- =========================================

SELECT * 
FROM students;


-- =========================================
-- STEP 5 : STUDENTS WITH MARKS ABOVE 80
-- =========================================

SELECT *
FROM students
WHERE marks > 80;


-- =========================================
-- STEP 6 : ONLY MBA STUDENTS
-- =========================================

SELECT *
FROM students
WHERE course = 'MBA';


-- =========================================
-- STEP 7 : STUDENTS WHOSE NAME STARTS WITH 'S'
-- =========================================

SELECT *
FROM students
WHERE first_name LIKE 'S%';


-- =========================================
-- STEP 8 : STUDENTS WITH MARKS BETWEEN 60 AND 90
-- =========================================

SELECT *
FROM students
WHERE marks BETWEEN 60 AND 90;


-- =========================================
-- STEP 9 : DISPLAY FULL NAME USING CONCAT
-- =========================================

SELECT 
CONCAT(first_name, ' ', last_name) AS full_name
FROM students;


-- =========================================
-- STEP 10 : UPDATE RAHUL MARKS
-- =========================================

UPDATE students

SET 
    marks = 55,
    passed = TRUE

WHERE first_name = 'Rahul';


-- =========================================
-- STEP 11 : CHECK UPDATED DATA
-- =========================================

SELECT *
FROM students;


-- =========================================
-- STEP 12 : DELETE FAILED STUDENTS
-- =========================================

DELETE FROM students
WHERE passed = FALSE;


-- =========================================
-- STEP 13 : FINAL TABLE
-- =========================================

SELECT *
FROM students;


-- =========================================
-- MINI PROJECT COMPLETED
-- =========================================
