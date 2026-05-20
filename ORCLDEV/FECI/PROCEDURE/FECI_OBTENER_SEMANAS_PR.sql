create or replace procedure feci."feci_obtener_semanas_pr"  ( p_anio numeric, p_mes numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
feci_cursor refcursor;
begin
open feci_cursor for
select
id_semanas_estimacion ,
num_anio ,
num_mes,
fec_inicio_semana_1,
fec_fin_semana_1,
fec_inicio_semana_2,
fec_fin_semana_2,
fec_inicio_semana_3,
fec_fin_semana_3,
fec_inicio_semana_4,
fec_fin_semana_4,
fec_inicio_semana_5,
fec_fin_semana_5
from feci_semanas_estimacion_tab
where num_anio = p_anio and num_mes = p_mes;
dbms_sql_return_result(feci_cursor);end;
$body$
language plpgsql
;
