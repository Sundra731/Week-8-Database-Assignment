-- SCHOOL RECORD SYSTEM
-- CREATE DATABASE
CREATE DATABASE studentRecordsdb;
USE studentRecordsdb;

-- CREATE TABLES
-- Departments Table
CREATE TABLE departments(
	dept_id INT AUTO_INCREMENT PRIMARY KEY,
    dept_name VARCHAR(100) NOT NULL
);
-- Students Table
CREATE TABLE Students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    dob DATE NOT NULL,
    gender ENUM('Male','Female','Other') NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15),
    dept_id INT,
    enrollment_year YEAR NOT NULL,
    FOREIGN KEY (dept_id) REFERENCES Departments(dept_id) ON DELETE SET NULL
);
-- Instructors Table
CREATE TABLE Instructors (
    instructor_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15),
    dept_id INT,
    hire_date DATE,
    FOREIGN KEY (dept_id) REFERENCES Departments(dept_id) ON DELETE SET NULL
);
-- Courses Table
CREATE TABLE Courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_code VARCHAR(10) NOT NULL UNIQUE,
    course_name VARCHAR(100) NOT NULL,
    credits INT NOT NULL CHECK (credits > 0),
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES Departments(dept_id) ON DELETE SET NULL
);
-- Course Schedule Table
CREATE TABLE Course_Schedule (
    schedule_id INT AUTO_INCREMENT PRIMARY KEY,
    course_id INT NOT NULL,
    instructor_id INT NOT NULL,
    semester ENUM('Jan-Apr','May-Aug','Sep-Dec') NOT NULL,
    year YEAR NOT NULL,
    FOREIGN KEY (course_id) REFERENCES Courses(course_id) ON DELETE CASCADE,
    FOREIGN KEY (instructor_id) REFERENCES Instructors(instructor_id) ON DELETE CASCADE
);
-- Enrollments Table
CREATE TABLE Enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    enrollment_date DATE DEFAULT (CURRENT_DATE),
    UNIQUE KEY uq_student_course (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES Students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES Courses(course_id) ON DELETE CASCADE
);
-- Grades Table 
CREATE TABLE Grades (
    grade_id INT AUTO_INCREMENT PRIMARY KEY,
    enrollment_id INT UNIQUE NOT NULL,
    grade ENUM('A','B','C','D','E','F','Incomplete') NOT NULL,
    FOREIGN KEY (enrollment_id) REFERENCES Enrollments(enrollment_id) ON DELETE CASCADE
);

-- INSERT DATA
-- 1. Departments
INSERT INTO Departments (dept_name) VALUES
('Computer Science'),
('Business Administration'),
('Electrical Engineering'),
('Medicine and Surgery'),
('Architecture');

-- 2. Students
INSERT INTO Students (first_name, last_name, dob, gender, email, phone, dept_id, enrollment_year) VALUES
('Alice', 'Wanjiku', '2002-05-14', 'Female', 'alicewanjiku@uonbi.ac.ke', '0712345678', 1, 2021),
('Brian', 'Otieno', '2004-02-16', 'Male', 'brianotieno@uonbi.ac.ke', '0723456789', 2, 2020),
('Cynthia', 'Mwende', '2003-02-10', 'Female', 'cynthiamwende@uonbi.ac.ke', '0734567890', 4, 2022),
('David', 'Kamau', '2000-08-05', 'Male', 'davidkamau@uonbi.ac.ke', '0745678901', 3, 2019),
('Emily', 'Achieng', '2005-12-17', 'Female', 'emilyachieng@uonbi.ac.ke', '0756789012', 5, 2022);


-- 3. Instructors
INSERT INTO Instructors (first_name, last_name, email, phone, dept_id, hire_date) VALUES
('James', 'Mutua', 'j.mutua@uonbi.ac.ke', '0701112233', 1, '2015-09-01'),
('Sarah', 'Njoki', 's.njoki@uonbi.ac.ke', '0702223344', 2, '2017-01-15'),
('Peter', 'Mwangi', 'p.mwangi@uonbi.ac.ke', '0703334455', 3, '2018-06-12'),
('Lucy', 'Atieno', 'l.atieno@uonbi.ac.ke', '0704445566', 4, '2019-02-01'),
('John', 'Oduor', 'j.oduor@uonbi.ac.ke', '0705556677', 5, '2020-03-20');

-- 4. Courses
INSERT INTO Courses (course_code, course_name, credits, dept_id) VALUES
('CCS101', 'Introduction to Programming', 3, 1),
('CCS202', 'Database Systems', 3, 1),
('BUS101', 'Principles of Management', 2, 2),
('EEE201', 'Circuit Analysis', 4, 3),
('MBSBS301', 'Anatomy', 3, 4),
('ACS101', 'History of Architecture', 3, 5);

-- 5. Course Schedule
INSERT INTO Course_Schedule (course_id, instructor_id, semester, year) VALUES
(1, 1, 'Jan-Apr', 2023),
(2, 1, 'Sep-Dec', 2023),
(3, 2, 'May-Aug', 2023),
(4, 3, 'Jan-Apr', 2023),
(5, 4, 'Sep-Dec', 2023),
(5, 5, 'Jan-Apr', 2023);

-- 6. Enrollments
INSERT INTO Enrollments (student_id, course_id, enrollment_date) VALUES
(1, 1, '2023-01-15'),
(1, 2, '2023-09-05'),
(2, 3, '2023-05-10'),
(3, 1, '2023-01-16'),
(4, 4, '2023-01-20'),
(5, 5, '2023-09-07'),
(3, 6, '2023-01-18');

-- 7. Grades
INSERT INTO Grades (enrollment_id, grade) VALUES
(1, 'A'),
(2, 'B'),
(3, 'C'),
(4, 'A'),
(5, 'B'),
(6, 'A'),
(7, 'Incomplete');


-- ROLES
-- Create Users
CREATE USER 'admin_user'@'localhost' IDENTIFIED BY 'adminpass';
CREATE USER 'instructor_user'@'localhost' IDENTIFIED BY 'instructorpass';
CREATE USER 'student_user'@'localhost' IDENTIFIED BY 'studentpass';

-- Grant privileges
GRANT ALL PRIVILEGES ON studentrecordsdb.* TO 'admin_user'@'localhost';
GRANT SELECT, INSERT, UPDATE ON studentrecordsdb.Grades TO 'instructor_user'@'localhost';
GRANT SELECT ON studentrecordsdb.Students TO 'student_user'@'localhost';
FLUSH PRIVILEGES;

