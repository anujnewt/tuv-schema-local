create or replace procedure feci."feci_obtener_resultado_batch"  () as $body$
declare
-- pgv moved types start
-- pgv moved types end
--feci_cursor refcursor;
feci_cursor refcursor;
begin
open feci_cursor for
select id_resultado_batch, fec_inicio, fec_fin, tipo_ejecucion,tipo_resultado,observaciones,num_nuevos_recibos,
num_nuevas_empresas,num_nuevas_monedas,num_nuevos_tc from feci_resultado_batch_tab
where id_resultado_batch = (select max(id_resultado_batch) from feci_resultado_batch_tab);
dbms_sql.return_result(feci_cursor);end;
$body$
language plpgsql
;
