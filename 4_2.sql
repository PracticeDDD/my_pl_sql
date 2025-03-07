util.check_work_time;

PROCEDURE DEL_JOBS (p_job_id  IN VARCHAR2,
                    po_result OUT VARCHAR2) IS                    
   v_delete_no_data_found EXCEPTION;

BEGIN

    DELETE from darina.jobs j
    WHERE j.job_id = p_job_id;
     
    IF SQL%ROWCOUNT = 0 THEN 
        RAISE v_delete_no_data_found;
    ELSE
        po_result := 'Посада '||p_job_id||' успішно видалена';
        --COMMIT;
    END IF;
    
    EXCEPTION
    WHEN v_delete_no_data_found THEN
         raise_application_erroR(-20004, 'Посада <p_job_id> не існує');
    
END;

END DEL_JOBS;



DECLARE
    v_po_result VARCHAR2(100); v_department darina.departments.department_name%TYPE;
BEGIN
    
    util.DEL_JOBS (p_job_id =>'IT_AN',
                   po_result => v_po_result);
    dbms_output.put_line(v_po_result);  
      
END; 
/
