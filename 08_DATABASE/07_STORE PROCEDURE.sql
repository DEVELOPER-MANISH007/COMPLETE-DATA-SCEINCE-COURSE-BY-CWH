DELIMITER //

CREATE PROCEDURE ShowStudents()
BEGIN
    SELECT * FROM Students
    WHERE GENDER = 'MALE';
END //

DELIMITER ;


CALL ShowStudents(); 

