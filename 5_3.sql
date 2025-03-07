DECLARE
    v_recipient VARCHAR2(50);
    v_subject VARCHAR2(50) := 'test_subject';
    v_mes VARCHAR2(5000) := 'Р’С–С‚Р°СЋ С€Р°РЅРѕРІРЅРёР№! </br> РћСЃСЊ Р·РІС–С‚ Р· РЅР°С€РѕСЋ РєРѕРјРїР°РЅС–С—:</br></br>';
BEGIN
    SELECT v_mes || '<!DOCTYPE html>
    <html>
      <head>
        <title></title>
        <style>
          table, th, td { border: 1px solid; }
          .center { text-align: center; }
        </style>
      </head>
      <body>
        <table border="1" cellspacing="0" cellpadding="2" rules="GROUPS" frame="HSIDES">
          <thead>
            <tr align="left">
              <th>Р†Рґ РїРѕСЃР°РґРё</th>
              <th>РљС–Р»СЊРєС–СЃС‚СЊ СЃРїС–РІСЂРѕР±С–С‚РЅРёРєС–РІ</th>
            </tr>
          </thead>
          <tbody>' || list_html || '</tbody>
        </table>
      </body>
    </html>' 
    INTO v_mes
    FROM (
        SELECT LISTAGG('<tr align=left>
                            <td>'|| department_id || '</td>
                            <td class=''center''>'|| employee_count ||'</td>
                        </tr>', '') WITHIN GROUP (ORDER BY employee_count) AS list_html
        FROM (
            SELECT department_id, COUNT(*) AS employee_count
            FROM darina.employeesa
            WHERE department_id IS NOT NULL
            GROUP BY department_id
        )
    );
    
    SELECT em.email
    INTO v_recipient
    FROM darina.employeesa em
    where employee_id = 207;
    
    v_mes := v_mes || '</br></br></br>Р— РїРѕРІР°РіРѕСЋ, Р”Р°С€Р°Р”';

    dbms_output.put_line(v_mes);

    sys.sendmail(p_recipient => v_recipient,
                 p_subject => v_subject,
                 p_message => v_mes || ' ');
END;
/
