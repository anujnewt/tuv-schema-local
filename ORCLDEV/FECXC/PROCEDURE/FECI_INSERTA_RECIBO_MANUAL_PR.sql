create or replace procedure fecxc."feci_inserta_recibo_manual_pr"  ( p_fecha timestamp(0), p_moneda varchar, p_empresa varchar, p_ref_cliente varchar, p_nom_cliente varchar, p_clase_cliente varchar, p_metodo_pago varchar, p_banco_emisor varchar, p_num_chequera varchar, p_num_cheque varchar, p_num_operacion varchar, p_usuario numeric, p_cod_cliente varchar, p_importe numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
id_registro numeric;
feci_cursors refcursor;
begin 

insert into fecxc.feci_recibo_manual_tab(
fec_contabilidad ,fec_operativa,importe,cod_moneda,cod_empresa,ref_cliente,nom_cliente,clase_cliente,
metodo_pago,nom_banco_emisor,num_chequera,num_cheque,num_operacion,tipo_cambio_origen,fec_tc_origen,
tipo_cambio_dolar,fec_tc_dolar,id_usuario_clasificacion,fec_clasificacion,id_usuario_aplicacion,
fec_aplicacion,cod_estado_recibo,fec_creacion,fec_ult_modificacion,id_usuario_creacion,
id_usuario_ult_modif,ind_estado,cod_cliente)
values (
to_timestamp(to_char(p_fecha, 'yyyy-MM-dd'),'yyyy-MM-dd') ,to_timestamp(to_char(p_fecha, 'yyyy-MM-dd'),'yyyy-MM-dd'),p_importe,p_moneda,p_empresa,p_ref_cliente,p_nom_cliente,p_clase_cliente,
p_metodo_pago,p_banco_emisor,p_num_chequera,p_num_cheque,p_num_operacion,null,null,
null,null,null,null,null,null,'CLSF',clock_timestamp(),clock_timestamp(),p_usuario,0,1,p_cod_cliente
)
returning folio_recibo_manual into id_registro;
call fecxc.feci_modifica_tipo_cambio_recibo_pr (id_registro, 'MANUAL', p_usuario);
open feci_cursors for
select folio_recibo_manual from fecxc.feci_recibo_manual_tab where folio_recibo_manual =  id_registro;
dbms_sql_return_result(feci_cursors);end;
$body$
language plpgsql
;
