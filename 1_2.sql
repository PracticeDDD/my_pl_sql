DECLARE
    v_date DATE := TO_DATE('09-10-2024', 'DD-MM-YYYY');
    v_day NUMBER;
BEGIN

    v_day := to_number(to_char(v_date, 'dd'));
    IF v_date = (last_day(trunc(SYSDATE))) THEN
        DBMS_OUTPUT.PUT_LINE('Виплата зарплати');
    ELSIF  v_day = 15 THEN
        DBMS_OUTPUT.PUT_LINE('Виплата авансу');
    ELSIF  v_day < 15 THEN
        DBMS_OUTPUT.PUT_LINE('Чекаємо на аванс');
    ELSIF  v_day > 15 THEN
        DBMS_OUTPUT.PUT_LINE('Чекаємо на зарплату');
    END IF;

END;
/
