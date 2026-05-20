create or replace procedure feci."feci_modifica_recibo_pr"  ( p_cod_estado_recibo varchar, p_id_usuario numeric, p_folio_recibo varchar, p_tipo_recibo varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
case p_tipo_recibo
when 'BATCH' then
case p_cod_estado_recibo
when 'PEND' then
update feci_recibo_tab
set
id_usuario_clasificacion = p_id_usuario,
cod_estado_recibo = 'CLSF',
fec_clasificacion = clock_timestamp(),
fec_ult_modificacion = clock_timestamp()
where folio_recibo = p_folio_recibo;
when 'CLSF' then
update feci_recibo_tab
set
id_usuario_clasificacion = p_id_usuario,
fec_clasificacion = clock_timestamp(),
fec_ult_modificacion = clock_timestamp()
where folio_recibo = p_folio_recibo;
when 'APLC' then
update feci_recibo_tab
set
id_usuario_clasificacion = p_id_usuario,
fec_clasificacion = clock_timestamp(),
fec_ult_modificacion = clock_timestamp()
where folio_recibo = p_folio_recibo;
end case;
when 'MANUAL' then
case p_cod_estado_recibo
when 'PEND' then
update feci_recibo_manual_tab
set
id_usuario_clasificacion = p_id_usuario,
cod_estado_recibo = 'CLSF',
fec_clasificacion = clock_timestamp(),
fec_ult_modificacion = clock_timestamp()
where folio_recibo_manual = p_folio_recibo;
when 'CLSF' then
update feci_recibo_manual_tab
set
id_usuario_clasificacion = p_id_usuario,
fec_clasificacion = clock_timestamp(),
fec_ult_modificacion = clock_timestamp()
where folio_recibo_manual = p_folio_recibo;
when 'APLC' then
update feci_recibo_manual_tab
set
id_usuario_clasificacion = p_id_usuario,
fec_clasificacion = clock_timestamp(),
fec_ult_modificacion = clock_timestamp()
where folio_recibo_manual = p_folio_recibo;
end case;
end case;
update feci_clasificacion_tab
set ind_estado = 0,
fec_ult_modificacion = clock_timestamp(),
id_usuario_ult_modif = p_id_usuario
where folio_recibo = p_folio_recibo
and tipo_recibo = p_tipo_recibo
and ind_estado = 1;end;
$body$
language plpgsql
;
