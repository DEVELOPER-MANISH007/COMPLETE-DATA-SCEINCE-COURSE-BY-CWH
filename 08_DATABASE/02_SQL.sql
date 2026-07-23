
-- CREATE TABLE classes (
--  class_id INT AUTO_INCREMENT PRIMARY KEY,
--  class_name VARCHAR(50) NOT NULL
-- );

-- CREATE TABLE students (
--  student_id INT AUTO_INCREMENT PRIMARY KEY,
--  student_name VARCHAR(100) NOT NULL,
--  class_id INT,
--  FOREIGN KEY (class_id) REFERENCES classes(class_id)
--  ON UPDATE CASCADE
--  ON DELETE SET NULL
-- );
-- INSERT INTO classes (class_name) VALUES ('Mathematics'), ('Science'), ('History');

-- INSERT INTO students (student_name, class_id) VALUES
-- ('Alice', 1),
-- ('Bob', 2),
-- ('Charlie', 1);

SELECT
 table_name,
 column_name,
 constraint_name,
 referenced_table_name,
 referenced_column_name
FROM
 information_schema.key_column_usage
WHERE
 referenced_table_name IS NOT NULL
 AND table_schema = 'school';

SELECT * FROM STUDENTS;
SELECT * FROM CLASSES;
SHOW CREATE  TABLE STUDENTS