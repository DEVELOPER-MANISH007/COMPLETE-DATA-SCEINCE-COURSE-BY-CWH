-- =========================================
-- SQL PRACTICE SCRIPT (RUNNABLE)
-- =========================================

-- 1️⃣ Create Database
CREATE DATABASE sql_practice;
USE sql_practice;

-- 2️⃣ Create Table
CREATE TABLE Students (
student_id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(50),
age INT,
gender VARCHAR(10),
department VARCHAR(50),
email VARCHAR(100),
phone VARCHAR(15),
city VARCHAR(50),
admission_year INT,
gpa DECIMAL(3,2),
scholarship BOOLEAN
);

-- 3️⃣ Insert Data (with NULL values)

INSERT INTO Students (name, age, gender, department, email, phone, city, admission_year, gpa, scholarship) VALUES
('Rahul Sharma',20,'Male','CSE','[rahul@gmail.com](mailto:rahul@gmail.com)','9000000001','Delhi',2022,8.5,TRUE),
('Priya Singh',21,'Female','IT','[priya@gmail.com](mailto:priya@gmail.com)',NULL,'Lucknow',2021,9.1,TRUE),
('Aman Verma',19,'Male','ECE',NULL,'9000000003','Kanpur',2023,7.8,FALSE),
('Neha Gupta',22,'Female','CSE','[neha@gmail.com](mailto:neha@gmail.com)','9000000004','Noida',2021,NULL,TRUE),
('Rohit Yadav',20,'Male','ME','[rohit@gmail.com](mailto:rohit@gmail.com)',NULL,'Agra',2022,7.2,FALSE),
('Anjali Mishra',21,'Female','IT','[anjali@gmail.com](mailto:anjali@gmail.com)','9000000006','Varanasi',2021,9.3,TRUE),
('Karan Patel',23,'Male','CSE',NULL,'9000000007','Ahmedabad',2020,6.9,FALSE),
('Sneha Kapoor',20,'Female','ECE','[sneha@gmail.com](mailto:sneha@gmail.com)',NULL,'Chandigarh',2022,8.0,TRUE),
('Arjun Mehta',22,'Male','CSE','[arjun@gmail.com](mailto:arjun@gmail.com)','9000000009','Mumbai',2021,8.7,NULL),
('Pooja Sharma',19,'Female','IT','[pooja@gmail.com](mailto:pooja@gmail.com)','9000000010','Jaipur',2023,NULL,TRUE);

-- =========================================
-- 4️⃣ BASIC SELECT
-- =========================================

SELECT * FROM Students;

-- Select specific columns
SELECT name, department FROM Students;

-- =========================================
-- 5️⃣ WHERE CONDITIONS
-- =========================================

-- GPA greater than 8
SELECT * FROM Students
WHERE gpa > 8;

-- Students in CSE department
SELECT * FROM Students
WHERE department = 'CSE';

-- =========================================
-- 6️⃣ ORDER BY
-- =========================================

SELECT name, gpa
FROM Students
ORDER BY gpa DESC;

-- =========================================
-- 7️⃣ GROUP BY + AGGREGATE FUNCTIONS
-- =========================================

-- Department wise student count
SELECT department, COUNT(*)
FROM Students
GROUP BY department;

-- Department average GPA
SELECT department, AVG(gpa)
FROM Students
GROUP BY department;

-- =========================================
-- 8️⃣ SECOND HIGHEST GPA
-- =========================================

SELECT MAX(gpa)
FROM Students
WHERE gpa < (SELECT MAX(gpa) FROM Students);

-- =========================================
-- 9️⃣ NULL HANDLING
-- =========================================

-- Find NULL emails
SELECT *
FROM Students
WHERE email IS NULL;

-- Replace NULL GPA with 5
SELECT name, IFNULL(gpa,5) AS updated_gpa
FROM Students;

-- =========================================
-- 🔟 CASE + AS (Condition based column)
-- =========================================

SELECT name, gpa,
CASE
WHEN gpa >= 9 THEN 'Excellent'
WHEN gpa >= 8 THEN 'Good'
WHEN gpa >= 7 THEN 'Average'
ELSE 'Poor'
END AS performance
FROM Students;

-- =========================================
-- 1️⃣1️⃣ UPDATE DATA
-- =========================================

UPDATE Students
SET gpa = 9.0
WHERE name = 'Rahul Sharma';

-- Update NULL GPA values
UPDATE Students
SET gpa = 6
WHERE gpa IS NULL;

-- =========================================
-- 1️⃣2️⃣ TRANSACTION EXAMPLE
-- =========================================

START TRANSACTION;

UPDATE Students
SET gpa = gpa + 0.5
WHERE department = 'CSE';

SAVEPOINT before_commit;

-- If needed
-- ROLLBACK TO before_commit;

COMMIT;

-- =========================================
-- END OF PRACTICE SCRIPT
-- =========================================
