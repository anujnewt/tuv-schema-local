create or replace procedure feci."feci_obtener_acumulado_estimacion_pr"  ( p_anio numeric, p_mes numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
feci_cursor refcursor;
begin
open feci_cursor for
select sum(num_importe_mxn) as acumulado_mxn ,sum(num_importe_usd) as acumulado_usd
from feci_estimacion_tab
where num_anio = p_anio and num_mes = p_mes;
dbms_sql_return_result(feci_cursor);end;
$body$
language plpgsql
;
