create or replace procedure fecxc."fecxp_llena_caratula_real_h"  ( v_mes integer, v_periodo integer, v_version integer, v_nombre_version varchar, v_comentario varchar, v_usuario varchar, v_operacion integer               ----1 es para insertar la version, 0 es para borrar la version
) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin 

if v_operacion=1 then
--------para caraturas reales
insert    into fecxp_real_caratula_h(e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des, importe_linea, estatus, tipo_caratula, id_version)
select    e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des, importe_linea, estatus, tipo_caratula, v_version
from    fecxp_real_caratula
where   periodo=v_periodo
and     mes=v_mes;
/* commit; */
-------para det_real_soin_h
insert into fecxc.fecxp_pagos_soin_clasif_h(e_codigo, folio_set, tipo_operacion,estatus_movimiento, id_chequera, id_banco,
forma_pago, fecha_aplicacion, moneda, tipo_cambio, origen_movimiento, importe,
numero_de_partida_soin, ctam01, ctam02,ctam03, importe_linea, concepto,
beneficiario, no_cliente,secuencia_det_pagos_soin, referencia,
descripcion, id_version)
select                                        e_codigo, folio_set, tipo_operacion,estatus_movimiento, id_chequera, id_banco,
forma_pago, fecha_aplicacion, moneda, tipo_cambio, origen_movimiento, importe,
numero_de_partida_soin, ctam01, ctam02,ctam03, importe_linea, concepto,
beneficiario, no_cliente,secuencia_det_pagos_soin, referencia,
descripcion, v_version
from    fecxc.fecxp_pagos_soin_clasif
where   (to_char(fecha_aplicacion,'YYYY'))::numeric =v_periodo
and     (to_char(fecha_aplicacion,'MM'))::numeric =v_mes;
/* commit; */
insert into fecxc.fecxp_ctas_clasif_real_soin_h(cla_fe_id, e_codigo, tipo_operacion,ctam01, ctam02, ctam03,tipo, division, rubro,
ctacr1, ctacr2, id_banco,id_chequera,periodo,mes,id_version)
select                                           cla_fe_id, e_codigo, tipo_operacion,ctam01, ctam02, ctam03,tipo, division, rubro,
ctacr1, ctacr2, id_banco,id_chequera,v_periodo,v_mes, v_version
from  fecxc.fecxp_ctas_clasif_real_soin;
/* commit; */
insert into fecxc.fecxp_ingresos_clasif_h(cla_fe_id, e_codigo, folio_set,tipo_operacion, fecha, moneda,tipo_cambio, importe, concepto,
beneficiario, id_status_mov, id_chequera,id_banco, id_forma_pago, referencia,importe_linea,
ora_soin_segmento1, ora_soin_segmento2,ora_soin_segmento3, oracle_segmento4, oracle_segmento5,
oracle_segmento6, oracle_segmento7, cual_erp,tipo_clasificacion, no_cliente, descripcion,id_version)
select                                     cla_fe_id, e_codigo, folio_set,tipo_operacion, fecha, moneda,tipo_cambio, importe, concepto,
beneficiario, id_status_mov, id_chequera,id_banco, id_forma_pago, referencia,importe_linea,
ora_soin_segmento1, ora_soin_segmento2,ora_soin_segmento3, oracle_segmento4, oracle_segmento5,
oracle_segmento6, oracle_segmento7, cual_erp,tipo_clasificacion, no_cliente, descripcion, v_version
from fecxc.fecxp_ingresos_clasif
where   (to_char(fecha,'YYYY'))::numeric =v_periodo
and     (to_char(fecha,'MM'))::numeric =v_mes;
/* commit; */
insert into fecxc.fecxp_det_reales_coinversion_h(e_codigo, folio_set, tipo_operacion,estatus_movimiento, secuencia_id, cla_fe_id,
cla_fe_des, id_chequera, id_banco,forma_pago, fecha_aplicacion, moneda,tipo_cambio,
importe, numero_de_partida_erp,ora_soin_segmento1, ora_soin_segmento2, ora_soin_segmento3,
oracle_segmento4, oracle_segmento5, oracle_segmento6,oracle_segmento7, importe_linea,
concepto,beneficiario, no_cliente, referencia,descripcion, id_tipo_movto, tipo_erp,id_version)
select  e_codigo, folio_set, tipo_operacion,estatus_movimiento, secuencia_id, cla_fe_id,
cla_fe_des, id_chequera, id_banco,forma_pago, fecha_aplicacion, moneda,tipo_cambio,
importe, numero_de_partida_erp,ora_soin_segmento1, ora_soin_segmento2, ora_soin_segmento3,
oracle_segmento4, oracle_segmento5, oracle_segmento6,oracle_segmento7, importe_linea,
concepto,beneficiario, no_cliente, referencia,descripcion, id_tipo_movto, tipo_erp, v_version
from    fecxc.fecxp_det_reales_coinversion
where   (to_char(fecha_aplicacion,'YYYY'))::numeric =v_periodo
and     (to_char(fecha_aplicacion,'MM'))::numeric =v_mes;
/* commit; */
insert into fecxc.fecxp_det_reales_inversion_h(e_codigo, folio_set, tipo_operacion,estatus_movimiento, secuencia_id, cla_fe_id,cla_fe_des,
id_chequera, id_banco,forma_pago, fecha_aplicacion, moneda,tipo_cambio, importe, numero_de_partida_erp,
ora_soin_segmento1, ora_soin_segmento2, ora_soin_segmento3,oracle_segmento4, oracle_segmento5, oracle_segmento6,
oracle_segmento7, importe_linea, concepto,beneficiario, no_cliente, referencia,descripcion, id_tipo_movto, tipo_erp,
id_version)
select                                          e_codigo, folio_set, tipo_operacion,estatus_movimiento, secuencia_id, cla_fe_id,cla_fe_des,
id_chequera, id_banco,forma_pago, fecha_aplicacion, moneda,tipo_cambio, importe, numero_de_partida_erp,
ora_soin_segmento1, ora_soin_segmento2, ora_soin_segmento3,oracle_segmento4, oracle_segmento5, oracle_segmento6,
oracle_segmento7, importe_linea, concepto,beneficiario, no_cliente, referencia,descripcion, id_tipo_movto, tipo_erp,
v_version
from     fecxc.fecxp_det_reales_inversion
where    (to_char(fecha_aplicacion,'YYYY'))::numeric =v_periodo
and      (to_char(fecha_aplicacion,'MM'))::numeric =v_mes;
/* commit; */
insert into fecxc.fecxp_importacion_datos_hist_r( tipo_empresa_imp, tipo_importacion, e_empresa_imp, cla_fe_id_imp, importe_linea, moneda_imp,
mes, fecha, atributo_1, atributo_2, atributo_3, atributo_4, estatus_origen, id_version, e_empresa_des,
division, agrupamiento, rubro, folio_set, no_cliente, referencia, descripcion, tipo_operacion, id_banco,
forma_pago, id_chequera, estatus_movimiento, beneficiario, concepto, origen_movimiento,
numero_de_partida, cia, neg, cta, sct, cc, icia, top, estatus, fecha_aplicacion, cla_fe_des, code_combination)
select                                      tipo_empresa_imp, tipo_importacion, e_empresa_imp,cla_fe_id_imp, importe_linea, moneda_imp,
mes, fecha, atributo_1, atributo_2, atributo_3, atributo_4, estatus_origen, v_version, e_empresa_des,
division, agrupamiento,rubro, folio_set, no_cliente, referencia, descripcion, tipo_operacion, id_banco,
forma_pago, id_chequera,estatus_movimiento, beneficiario, concepto,  origen_movimiento,
numero_de_partida, cia, neg, cta, sct,cc, icia, top,estatus, fecha_aplicacion, cla_fe_des, code_combination
from fecxc.fecxp_importacion_datos_hist
where   (to_char(fecha,'YYYY'))::numeric  = v_periodo
and     mes                              = v_mes;
----------para detalle de reales oracle----------
insert into fecxc.fecxp_pagos_erp_clasif_h(e_codigo, folio_set, tipo_operacion,  estatus_movimiento, id_chequera, id_banco,   forma_pago, fecha_aplicacion, moneda,
tipo_cambio, origen_movimiento, importe,    numero_de_partida_erp, oracle_segmento1, oracle_segmento2,oracle_segmento3,
oracle_segmento4, oracle_segmento5, oracle_segmento6, oracle_segmento7, importe_linea,concepto, beneficiario, no_cliente,
sec_det_pag_proc,referencia, descripcion, id_version)
select                                     e_codigo, folio_set, tipo_operacion,estatus_movimiento, id_chequera, id_banco, forma_pago, fecha_aplicacion, moneda,
tipo_cambio, origen_movimiento, importe,numero_de_partida_erp, oracle_segmento1, oracle_segmento2,oracle_segmento3,
oracle_segmento4, oracle_segmento5,oracle_segmento6, oracle_segmento7, importe_linea,concepto, beneficiario, no_cliente,
sec_det_pag_proc, referencia, descripcion, v_version
from fecxc.fecxp_pagos_erp_clasif
where   (to_char(fecha_aplicacion,'YYYY'))::numeric =v_periodo
and     (to_char(fecha_aplicacion,'MM'))::numeric =v_mes;
/* commit; */
---se le agrego a la tabla periodo y mes
insert into fecxc.fecxp_ctas_clasif_real_erp_h(cla_fe_id, e_codigo, tipo_operacion,oracle_segmento1, oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6,
oracle_segmento7, id_banco, id_chequera,periodo,mes,id_version)
select                                          cla_fe_id, e_codigo, tipo_operacion, oracle_segmento1, oracle_segmento2, oracle_segmento3,oracle_segmento4, oracle_segmento5, oracle_segmento6,
oracle_segmento7, id_banco, id_chequera, v_periodo,v_mes,v_version
from fecxc.fecxp_ctas_clasif_real_erp;
/* commit; */
end if;
if v_operacion=0 then
---para caraturas reales
delete from  fecxp_real_caratula_h
where   periodo=v_periodo
and     mes=v_mes
and     id_version=v_version;
-------para det_real_soin_h
delete
from    fecxc.fecxp_pagos_soin_clasif_h
where   (to_char(fecha_aplicacion,'YYYY'))::numeric =v_periodo
and     (to_char(fecha_aplicacion,'MM'))::numeric =v_mes
and     id_version=v_version;
delete
from    fecxc.fecxp_ctas_clasif_real_soin_h
where   periodo=v_periodo
and     mes=v_mes
and     id_version=v_version;
delete
from    fecxc.fecxp_ingresos_clasif_h
where   (to_char(fecha,'YYYY'))::numeric =v_periodo
and     (to_char(fecha,'MM'))::numeric =v_mes
and     id_version=v_version;
delete
from    fecxc.fecxp_det_reales_coinversion_h
where   (to_char(fecha_aplicacion,'YYYY'))::numeric =v_periodo
and     (to_char(fecha_aplicacion,'MM'))::numeric =v_mes
and     id_version=v_version;
delete
from    fecxc.fecxp_det_reales_inversion_h
where   (to_char(fecha_aplicacion,'YYYY'))::numeric =v_periodo
and     (to_char(fecha_aplicacion,'MM'))::numeric =v_mes
and     id_version=v_version;
delete
from    fecxc.fecxp_importacion_datos_hist_r
where   (to_char(fecha,'YYYY'))::numeric  = v_periodo
and     mes                              = v_mes;
----------para detalle de reales oracle----------
delete
from    fecxc.fecxp_pagos_erp_clasif_h
where   (to_char(fecha_aplicacion,'YYYY'))::numeric =v_periodo
and     (to_char(fecha_aplicacion,'MM'))::numeric =v_mes
and     id_version=v_version;
delete
from    fecxc.fecxp_ctas_clasif_real_erp_h
where   periodo=v_periodo
and     mes=v_mes
and     id_version=v_version;
end if;
insert into fecxp_bitacora_historicos(proceso_id, proceso_nombre, created_by, date_created, id_version, desc_version, periodo, mes, comentario, tipo_operacion)
select 17, 'HISTORICO DE REALES', v_usuario, clock_timestamp(), v_version, v_nombre_version, v_periodo, v_mes, v_comentario, case when v_operacion=1 then 'REGISTRA VERSION' else 'ELIMINA VERSION' end;
update fecxp_ppto_extraccion_params
set estatus_proceso = 'INACTIVO',estatus_ext_ult_ejecucion= 'EXITOSO'
where proceso_id =17;
/* commit; */
exception
when others then
update fecxp_ppto_extraccion_params
set estatus_proceso = 'INACTIVO',estatus_ext_ult_ejecucion= 'ERROR'
where proceso_id =17;/* dmap converted statement start */
raise exception '%',  concat('An error was encountered - ', sqlstate, ' -ERROR- ', sqlerrm)  using errcode = '45001';/* dmap converted statement end */
rollback;end;
$body$
language plpgsql
;
