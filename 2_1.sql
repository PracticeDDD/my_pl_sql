DECLARE
    v_employee_id hr.employees.employee_id%TYPE := 110;
    v_job_id hr.employees.job_id%TYPE;
    v_job_title hr.jobs.job_title%TYPE;
    v_first_name VARCHAR2(30);
    
BEGIN

    SELECT em.employee_id, em.job_id, em.first_name
    INTO v_employee_id, v_job_id, v_first_name
    FROM hr.employees em
    WHERE em.employee_id = v_employee_id;
    
    SELECT j.job_title, j.job_id
    INTO v_job_title, v_job_id
    FROM hr.jobs j
    WHERE j.job_id = 'AD_PRES';
    
    dbms_output.put_line('Співробітник з id = '||v_employee_id || ' займає посаду '|| v_job_title||'.');
    
END;
/
