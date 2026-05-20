create or replace procedure feci."feci_valida_semanas_pr"  ( p_mes numeric, p_anio numeric, p_respuesta inout numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
contador        numeric;
respuesta    numeric;
begin
select count(id_estimacion) into strict contador  from feci_estimacion_tab where num_anio = p_anio and num_mes=p_mes;
if contador > 0 then
respuesta :=-1;
else
respuesta := contador;
end if;
p_respuesta := respuesta;end;
$body$
language plpgsql
;
