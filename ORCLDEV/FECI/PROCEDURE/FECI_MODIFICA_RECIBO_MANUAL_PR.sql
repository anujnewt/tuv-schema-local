create or replace procedure feci."feci_modifica_recibo_manual_pr"  ( p_folio_recibo numeric, p_fecha timestamp(0), p_moneda varchar, p_empresa varchar, p_ref_cliente varchar, p_nom_cliente varchar, p_clase_cliente varchar, p_metodo_pago varchar, p_banco_emisor varchar, p_num_chequera varchar, p_num_cheque varchar, p_num_operacion varchar, p_usuario numeric, p_cod_cliente varchar, p_importe numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
update feci_recibo_manual_tab
set
fec_contabilidad =  to_timestamp(to_char(p_fecha, 'yyyy-MM-dd'),'yyyy-MM-dd'),
fec_operativa = to_timestamp(to_char(p_fecha, 'yyyy-MM-dd'),'yyyy-MM-dd'),
importe = p_importe,
cod_moneda = p_moneda,
cod_empresa = p_empresa,
ref_cliente = p_ref_cliente,
nom_cliente = p_nom_cliente,
clase_cliente = p_clase_cliente,
metodo_pago = p_metodo_pago,
nom_banco_emisor = p_banco_emisor,
num_chequera = p_num_chequera,
num_cheque = p_num_cheque,
num_operacion = p_num_operacion,
fec_ult_modificacion = clock_timestamp(),
id_usuario_ult_modif = p_usuario,
cod_cliente = p_cod_cliente
where folio_recibo_manual = p_folio_recibo;
call feci_modifica_tipo_cambio_recibo_pr (p_folio_recibo, 'MANUAL', p_usuario);end;
$body$
language plpgsql
;
