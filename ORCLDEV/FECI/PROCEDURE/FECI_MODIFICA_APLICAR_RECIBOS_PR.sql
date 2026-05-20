create or replace procedure feci."feci_modifica_aplicar_recibos_pr"  ( p_id_usuario numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
update feci_recibo_manual_tab
set cod_estado_recibo ='APLC' ,
id_usuario_aplicacion = p_id_usuario,
fec_aplicacion = clock_timestamp(),
fec_ult_modificacion =  clock_timestamp(),
id_usuario_ult_modif = p_id_usuario
where
folio_recibo_manual in (select folio_recibo from feci_recibos_vw where tipo_recibo='MANUAL'
and cod_estado_recibo='CLSF');
update feci_recibo_tab
set cod_estado_recibo ='APLC' ,
id_usuario_aplicacion = p_id_usuario,
fec_aplicacion = clock_timestamp(),
fec_ult_modificacion =  clock_timestamp(),
id_usuario_ult_modif = p_id_usuario
where
folio_recibo in (select folio_recibo from feci_recibos_vw
where tipo_recibo='BATCH' and cod_estado_recibo='CLSF');end;
$body$
language plpgsql
;
