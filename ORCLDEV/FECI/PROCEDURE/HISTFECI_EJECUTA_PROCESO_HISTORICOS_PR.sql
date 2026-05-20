create or replace procedure feci."histfeci_ejecuta_proceso_historicos_pr"  () as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- llamada a los procedimientos almacenados sin parametros de entrada
histfeci_procesa_catalogos_pr;
histfeci_procesa_segmento_gforecast_pr;
histfeci_procesa_concepto_region_pr;
histfeci_procesa_recibos_pr;
histfeci_procesa_clasificaciones_pr;end;
$body$
language plpgsql
;
