create or replace FUNCTION get_dep_name(p_employee_id IN NUMBER)
    RETURN VARCHAR IS
    v_department darina.departments.department_name%TYPE;

BEGIN
    SELECT d.department_name
    INTO v_department
    FROM darina.departments d
    JOIN darina.employees em
    ON d.department_id = em.department_id
    WHERE em.employee_id = p_employee_id;
    RETURN v_department;
END get_dep_name;



--
SELECT get_dep_name(101)
FROM dual;  


SELECT em.*, get_job_title(em.employee_id) as job_title, get_dep_name (em.employee_id) as department_name
FROM darina.employees em;
