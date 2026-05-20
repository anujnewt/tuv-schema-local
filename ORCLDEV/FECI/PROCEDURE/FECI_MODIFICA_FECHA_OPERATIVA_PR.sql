create or replace procedure feci."feci_modifica_fecha_operativa_pr"  ( p_recibo numeric, p_tipo varchar, p_nueva_fecha timestamp(0), p_usuario numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
if p_tipo = 'BATCH' then
update feci_recibo_tab
set
fec_operativa = to_timestamp(p_nueva_fecha,'YYYY-MM-DD'),
id_usuario_ult_modif = p_usuario,
fec_ult_modificacion = clock_timestamp()
where
folio_recibo = p_recibo;
else
update feci_recibo_manual_tab
set
fec_operativa = to_timestamp(p_nueva_fecha,'YYYY-MM-DD'),
id_usuario_ult_modif = p_usuario,
fec_ult_modificacion = clock_timestamp()
where
folio_recibo_manual = p_recibo;
end if;
call feci_modifica_tipo_cambio_recibo_pr (p_recibo, p_tipo, p_usuario);
call feci_calcula_montos_clasificacion_recibos_pr (p_recibo, p_usuario);end;
$body$
language plpgsql
;
