CREATE TABLE interbank_index_ua_history (
    dt      VARCHAR2(100),
    id_api  VARCHAR2(100),
    value   NUMBER ,
    special VARCHAR2(100));

--SET DEFINE OFF; -- один раз запустити

CREATE OR REPLACE FORCE EDITIONABLE VIEW "DARINA"."INTERBANK_INDEX_UA_V" ("DT", "ID_API", "VALUE", "SPECIAL") AS 
    SELECT TO_DATE(tt.dt, 'dd.mm.yyyy') AS date_index,
                   tt.id_api,
                   tt.value, 
                   tt.special
    FROM (SELECT sys.get_nbu(p_url => 'https://bank.gov.ua/NBU_uonia?id_api=UONIA_UnsecLoansDepo&json') AS json_value FROM dual)
    CROSS JOIN json_table
    (
    json_value, '$[*]'
    COLUMNS
    (
    dt      VARCHAR2(100) PATH '$.dt',
    id_api  VARCHAR2(100) PATH '$.id_api',
    value   NUMBER PATH '$.value',
    special VARCHAR2(100) PATH '$.special'
    )
) tt;


BEGIN
    download_ibank_index_ua;
END;

create or replace PROCEDURE download_ibank_index_ua AS
BEGIN
INSERT INTO interbank_index_ua_history (dt, id_api, value, special)
    SELECT dt, id_api, value, special
    FROM interbank_index_ua_v;

END download_ibank_index_ua;

BEGIN
    dbms_scheduler.create_job (job_name        => 'job_update_ibank_index_ua',
                               job_type        => 'PLSQL_BLOCK',
                               job_action      => 'begin download_ibank_index_ua; END;',
                               start_date      => SYSDATE,
                               repeat_interval => 'FREQ=DAILY;BYHOUR=9;BYMINUTE=00',
                               enabled         => TRUE,
                               auto_drop => FALSE,
                               comments => 'Оновлення Український індекс міжбанківських ставок овернайт');
END;
/

SELECT * FROM INTERBANK_INDEX_UA_HISTORY;
