create or replace PROCEDURE DEL_JOBS (p_job_id  IN VARCHAR2,
                                      po_result OUT VARCHAR2) IS                    
    v_not_exist_job number;

BEGIN

    SELECT COUNT(j.job_id)
    INTO v_not_exist_job
    FROM darina.jobs j
    WHERE j.job_id = p_job_id;

    IF (v_not_exist_job = 0 ) THEN
         po_result := 'Посада '||p_job_id||' не існує';
    
    ELSE
        DELETE from darina.jobs j
        WHERE j.job_id = p_job_id;
        COMMIT;
        po_result := 'Посада '||p_job_id||' успішно видалена';
        END IF; 
 
END DEL_JOBS;

select *
from darina.jobs


Declare
    v_po_result VARCHAR2(100);
BEGIN
    DEL_JOBS (p_job_id =>'IT_AA',
              po_result => v_po_result);
    dbms_output.put_line(v_po_result);
END;
/
