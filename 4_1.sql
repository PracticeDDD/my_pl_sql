PROCEDURE check_work_time IS

BEGIN

    IF TO_CHAR(SYSDATE, 'DY', 'NLS_DATE_LANGUAGE = AMERICAN') IN ('SAT', 'SUN') THEN
        raise_application_error (-20205, 'Ви можете вносити зміни лише у робочі дні');
    END IF;

END check_work_time;
/


BEGIN
   util.check_work_time;
END;
/
