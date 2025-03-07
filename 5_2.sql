CREATE TABLE projects_ext (project_id      NUMBER,
                           project_name    VARCHAR2(100),
                           department_id   NUMBER)
ORGANIZATION EXTERNAL (
    TYPE ORACLE_LOADER
    DEFAULT DIRECTORY FILES_FROM_SERVER
    ACCESS PARAMETERS (
        RECORDS DELIMITED BY NEWLINE
        FIELDS TERMINATED BY ',' 
        OPTIONALLY ENCLOSED BY '"'
        MISSING FIELD VALUES ARE NULL)
    LOCATION ('PROJECTS.csv')
    )
REJECT LIMIT UNLIMITED;




CREATE OR REPLACE VIEW rep_project_dep_v AS
SELECT 
    d.department_name,
    COUNT(e.employee_id) AS employee_count,
    COUNT(DISTINCT e.employee_id) AS unique_employee_count,
    SUM(e.salary) AS total_salary
FROM projects_ext p
JOIN departments d ON p.department_id = d.department_id
JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_name;


DECLARE
    v_file UTL_FILE.FILE_TYPE;
    v_line VARCHAR2(1000);
    
BEGIN

    v_file := UTL_FILE.FOPEN('FILES_FROM_SERVER', 'TOTAL_PROJ_INDEX_DY.csv', 'W');
    UTL_FILE.PUT_LINE(v_file, 'Department Name,Employee Count,Unique Employee Count,Total Salary');
    FOR cc IN (SELECT * FROM rep_project_dep_v)
    LOOP
        v_line := cc.department_name  ||','||  cc.employee_count ||','||  cc.unique_employee_count ||','|| cc.total_salary;
        UTL_FILE.PUT_LINE(v_file, v_line);
    END LOOP;  
    UTL_FILE.FCLOSE(v_file);
    DBMS_OUTPUT.PUT_LINE('CSV файл успішно створено.');
EXCEPTION
    WHEN OTHERS THEN
    RAISE;
END WRITE_FILE_TO_DISK;
/



    FOR cc IN (SELECT job_id ||','|| job_title ||','|| min_salary ||','|| max_salary AS file_content
               FROM darina.jobs) 
    LOOP
        file_content := file_content || cc.file_content||CHR(10);
END LOOP;

    file_handle:= UTL_FILE.FOPEN(file_location, file_name, 'W');
    UTL_FILE.PUT_RAW(file_handle, UTL_RAW.CAST_TO_RAW(file_content));
    UTL_FILE.FCLOSE(file_handle);
EXCEPTION
    WHEN OTHERS THEN
    RAISE;
END WRITE_FILE_TO_DISK;
