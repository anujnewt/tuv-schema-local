create or replace procedure fecxc."feci_obtener_detalle_recibos_pr"  ( p_folio numeric , p_tipo varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
feci_cursor refcursor;
begin 

open feci_cursor for
select
a.folio_recibo,
a.tipo_recibo,
a.fec_contabilidad,
a.fec_operativa,
a.fec_operativa,
a.importe,
a.cod_moneda,
a.des_moneda,
a.cod_empresa,
a.cod_cliente,
a.des_empresa,
a.ref_cliente,
a.ref_cliente,
a.nom_cliente,
a.clase_cliente,
a.metodo_pago,
a.nom_banco_emisor,
a.num_chequera,
a.num_chequera,
a.num_cheque,
a.num_operacion,
a.tipo_cambio_origen,
a.fec_tc_origen,
a.tipo_cambio_dolar,
a.fec_tc_dolar,
a.id_usuario_clasificacion,
a.fec_clasificacion,
a.id_usuario_aplicacion,
a.fec_aplicacion,
a.cod_estado_recibo,
a.fec_creacion,
a.fec_ult_modificacion,
a.id_usuario_creacion,
a.id_usuario_ult_modif,
a.ind_estado,
a.ind_estado,
b.des_nombres,
b.des_apellidos,
c.des_nombres as des_nombres_apl,
c.des_apellidos as des_apellidos_apl
from fecxc.feci_recibos_vw a
left join fecxc.feci_usuario_tab b on a.id_usuario_clasificacion = b.id_usuario
left join fecxc.feci_usuario_tab c on a.id_usuario_aplicacion = c.id_usuario
where folio_recibo = p_folio and tipo_recibo = p_tipo;
dbms_sql_return_result(feci_cursor);end;
$body$
language plpgsql
;
