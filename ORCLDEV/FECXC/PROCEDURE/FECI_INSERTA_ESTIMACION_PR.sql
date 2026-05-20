create or replace procedure fecxc."feci_inserta_estimacion_pr"  ( p_anio numeric, p_mes numeric, p_semana numeric, p_forecast varchar, p_segmento varchar, p_monto_mxn numeric , p_monto_usd numeric, p_usuario numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
id_est numeric;
feci_cursors refcursor;
begin 

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
open feci_cursors for
select id_estimacion from feci_estimacion_tab where id_estimacion =  id_est;
dbms_sql_return_result(feci_cursors);end;
$body$
language plpgsql
;
