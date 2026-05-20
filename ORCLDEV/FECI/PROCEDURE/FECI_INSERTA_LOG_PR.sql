create or replace procedure feci."feci_inserta_log_pr"  ( p_message text, p_messagetemplate text, p_level varchar, p_timestamp timestamp(0), p_exception text, p_logevent text ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
id_registro numeric;
feci_cursors refcursor;
begin
insert into feci_log_tab(clase, mensaje, nivel, fecha_hora, excepcion, clave_rastreo)
values ( p_message, p_messagetemplate, p_level, p_timestamp, p_exception, p_logevent)
returning id_log into id_registro;
open feci_cursors for
select clave_rastreo from feci_log_tab where id_log =  id_registro;
dbms_sql_return_result(feci_cursors);end;
$body$
language plpgsql
;
