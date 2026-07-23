SELECT name, gpa
FROM Students
WHERE gpa = (
    SELECT MAX(gpa)
    FROM Students
);

SELECT MAX(gpa)
FROM Students
WHERE gpa < (
    SELECT MAX(gpa)
    FROM Students
);

SELECT name
FROM Students
WHERE department IN (
    SELECT department
    FROM Students
    WHERE department = 'CSE'
);

SELECT name, department
FROM Students
WHERE department IN (
    SELECT department
    FROM Alumni
);

SELECT name
FROM Students s
WHERE EXISTS (
    SELECT *
    FROM Alumni a
    WHERE s.department = a.department
);

SELECT *
FROM Students s
WHERE gpa = (
    SELECT MAX(gpa)
    FROM Students
    WHERE department = s.department
);


