create or replace procedure feci."feci_obtener_estimaciones_pr"  ( p_anio numeric, p_mes numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
feci_cursor refcursor;
begin
open feci_cursor for
select
est.id_estimacion ,
est.num_importe_mxn as monto_mxn ,
est.num_importe_usd as monto_usd,
est.num_anio,
est.num_mes,
est.cod_grupo_forecast,
est.cod_segmento,num_semana,
fore.des_grupo_forecast,
seg.des_segmento
from feci_estimacion_tab  est
inner join feci_grupo_forecast_cat  fore on est.cod_grupo_forecast = fore.cod_grupo_forecast
inner join feci_segmento_cat  seg on est.cod_segmento = seg.cod_segmento
where num_anio = p_anio and num_mes = p_mes;
dbms_sql_return_result(feci_cursor);end;
$body$
language plpgsql
;
