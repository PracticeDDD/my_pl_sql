FUNCTION get_region_cnt_emp(p_department_id NUMBER DEFAULT NULL) RETURN tab_region_emp PIPELINED IS
        out_rec tab_region_emp := tab_region_emp();
        l_cur SYS_REFCURSOR;
    BEGIN
        OPEN l_cur FOR
            SELECT 
                r.region_name, 
                COUNT(e.employee_id) AS count_employees
            FROM hr.regions r
            JOIN hr.countries c ON r.region_id = c.region_id
            JOIN hr.locations l ON c.country_id = l.country_id
            JOIN hr.departments d ON l.location_id = d.location_id
            LEFT JOIN employees e ON d.department_id = e.department_id
            WHERE (e.department_id = p_department_id OR p_department_id IS NULL)
            GROUP BY r.region_name;

        BEGIN
            LOOP
                EXIT WHEN l_cur%NOTFOUND;
                FETCH l_cur BULK COLLECT INTO out_rec;
                FOR i IN 1 .. out_rec.count LOOP
                    PIPE ROW(out_rec(i));
                END LOOP;
            END LOOP;
        CLOSE l_cur;
        
        EXCEPTION
            WHEN OTHERS THEN
                IF (l_cur%ISOPEN) THEN
                    CLOSE l_cur;
                    RAISE;
                ELSE
                    RAISE;
                END IF;
        END;
    END get_region_cnt_emp;


SELECT *
FROM TABLE(util.get_region_cnt_emp());

SELECT *
FROM TABLE(util.get_region_cnt_emp(p_department_id=>'110'));
