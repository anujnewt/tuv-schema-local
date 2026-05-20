create or replace procedure feci."feci_inserta_estimacion_pr"  ( p_anio numeric, p_mes numeric, p_semana numeric, p_forecast varchar, p_segmento varchar, p_monto_mxn numeric , p_monto_usd numeric, p_usuario numeric, p_respuesta inout numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
id_est numeric;
contador numeric;
respuesta    numeric;
contador_est    numeric;
begin
select count(id_semanas_estimacion) into strict contador from feci_semanas_estimacion_tab where num_anio=p_anio and num_mes = p_mes;
if  contador > 0 then
select count(id_estimacion) into strict contador_est
from feci_estimacion_tab where
num_anio = p_anio and num_mes = p_mes and
num_semana = p_semana and
cod_grupo_forecast =   p_forecast and
cod_segmento = p_segmento;
if contador_est = 0 then
insert into feci_estimacion_tab(cod_grupo_forecast,cod_segmento,num_anio,num_mes,num_semana,num_importe_mxn,num_importe_usd
,fec_creacion,fec_ult_modificacion,id_usuario_creacion,id_usuario_ult_modif,ind_estado)
values (
p_forecast,
p_segmento,
p_anio,
p_mes,
p_semana,
p_monto_mxn,
p_monto_usd,
clock_timestamp(),
clock_timestamp(),
p_usuario,
0,
1
) returning id_estimacion into id_est;
respuesta := id_est;
else
respuesta := -4;
end if;
else
respuesta := -3;
end if;
p_respuesta := respuesta;end;
$body$
language plpgsql
;
