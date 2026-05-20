create or replace procedure feci."feci_modifica_estimacion_pr"  ( p_id numeric, p_id_usuario numeric, p_importe_mxn numeric, p_importe_usd numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
update feci_estimacion_tab
set num_importe_mxn = p_importe_mxn,
num_importe_usd = p_importe_usd,
fec_ult_modificacion = clock_timestamp(),
id_usuario_ult_modif = p_id_usuario
where id_estimacion = p_id;end;
$body$
language plpgsql
;
