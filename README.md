# Student Records Database System

## Project Overview
This is a full-featured relational database designed to manage student records at a Kenyan university.  
The system stores information about students, instructors, departments, courses, enrollments, course schedules, and grades.  
It supports many-to-many relationships between students and courses and includes role-based access for users.

---

## Features
- Manage students, courses, and instructors
- Record enrollments and grades
- Track course schedules per semester
- Support many-to-many relationships between students and courses
- Role-based access control:
  - **Admin:** Full access to all tables
  - **Instructor:** Can view and update grades
  - **Student:** Can view own records
- Includes sample data for demonstration

---

## Tables and Relationships

| Table | Description |
|-------|-------------|
| **Departments** | List of university departments |
| **Students** | Student details linked to Departments |
| **Instructors** | Instructor details linked to Departments |
| **Courses** | Courses linked to Departments |
| **Course_Schedule** | Assigns instructors to courses by semester and year |
| **Enrollments** | Junction table linking Students and Courses (many-to-many, M:N) |
| **Grades** | Linked 1:1 with Enrollments for recording grades |

**Relationships:**
- Departments → 1:N → Students, Instructors, Courses  
- Students ↔ M:N ↔ Courses via Enrollments (junction table)  
- Enrollments → 1:1 → Grades  
- Courses → 1:N → Course_Schedule → 1:N → Instructors  

---

## Setup Instructions

1. Open MySQL Workbench or MySQL CLI.
2. Run the provided SQL file (`student_records.sql`) to create tables and insert data.
3. Optional: create roles and grant privileges.
4. Run example queries below to verify relationships.

---

## Sample Queries (inside README)

- List all students with their departments:
```sql
SELECT s.first_name, s.last_name, d.dept_name
FROM Students s
LEFT JOIN Departments d ON s.dept_id = d.dept_id;

-- This query shows each student, the courses they are enrolled in, and their corresponding grades
SELECT s.first_name, s.last_name, c.course_name, g.grade
FROM Enrollments e
JOIN Students s ON e.student_id = s.student_id
JOIN Courses c ON e.course_id = c.course_id
LEFT JOIN Grades g ON e.enrollment_id = g.enrollment_id;

-- List courses and assigned instructors:
SELECT c.course_name, i.first_name, i.last_name, cs.semester, cs.year
FROM Course_Schedule cs
JOIN Courses c ON cs.course_id = c.course_id
JOIN Instructors i ON cs.instructor_id = i.instructor_id;



