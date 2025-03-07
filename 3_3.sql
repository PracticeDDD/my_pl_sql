DECLARE
    v_po_result VARCHAR2(100); v_department darina.departments.department_name%TYPE;
BEGIN
    
    util.DEL_JOBS (p_job_id =>'IT_QA',
                   po_result => v_po_result);
    dbms_output.put_line(v_po_result);  
    
    
    dbms_output.put_line( darina.util.get_dep_name(p_employee_id => 101) );
      
END; 
/

