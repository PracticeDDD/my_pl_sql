FUNCTION get_sum_price_sales (p_table IN VARCHAR2) return NUMBER IS
    v_sum NUMBER;
    v_dynamic_sql VARCHAR2(100);
    p_message     logs.message%TYPE;
  

BEGIN

    IF p_table not IN ('products', 'products_old') THEN
    to_log(p_appl_proc => 'get_sum_price_sales', p_message =>'Неприпустиме значення! Очікується products або products_oldі');
    raise_application_error (-20001, 'Неприпустиме значення! Очікується products або products_oldі');
    END IF;
    
    v_dynamic_sql :=  'SELECT SUM(p.price_sales)
    FROM hr.'|| p_table||' p'; 

    dbms_output.put_line(v_dynamic_sql);
    EXECUTE IMMEDIATE v_dynamic_sql INTO v_sum;
    dbms_output.put_line(v_sum);
END get_sum_price_sales;


DECLARE
v_sum NUMBER;
BEGIN
v_sum :=  util.get_sum_price_sales('products');
dbms_output.put_line(v_sum);
END;
/
