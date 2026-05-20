create or replace procedure fecxc."fecxp_llena_caratula_ptto_h"  ( /*v_mes                   in integer,*/
v_periodo integer, v_version integer, v_nombre_version varchar, v_comentario varchar, v_usuario varchar, v_operacion integer               ----1 es para insertar la version, 0 es para borrar la version
) as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_meses integer:=1;
v_contador integer;
begin 

if v_operacion=1 then
for v_contador in 1..12
loop
----------para caratula de prespuesto----------
insert into fecxc.fecxp_ppto_caratula_h(e_codigo, des_empresa, id_sesion_pc,periodo, mes, moneda,tipo_cambio,
cla_fe_id, cla_fe_des,importe_linea, estatus, id_version)
select                                    e_codigo, des_empresa, id_sesion_pc,periodo, mes, moneda,tipo_cambio,
cla_fe_id, cla_fe_des,importe_linea, estatus, v_version
from fecxc.fecxp_ppto_caratula
where periodo = v_periodo
and   mes     = v_meses;
/* commit; */
-------------para detalle contable de prespuesto erp---------------
insert into fecxc.fecxp_ppto_opera_erp_h(e_codigo, secuencia_ptto_oracle, periodo_extraccion,mes_de_extraccion, periodo_ppto, libro_id,version_id, moneda, code_combination_id,
oracle_segmento1, oracle_segmento2, oracle_segmento3,oracle_segmento4, oracle_segmento5, oracle_segmento6,oracle_segmento7, ppto_01, pss_01,
usd_01, eur_01, ppto_02,pss_02, usd_02, eur_02,ppto_03, pss_03, usd_03,eur_03, ppto_04, pss_04,usd_04, eur_04, ppto_05,pss_05, usd_05, eur_05,
ppto_06, pss_06, usd_06,eur_06, ppto_07, pss_07,usd_07, eur_07, ppto_08,pss_08, usd_08, eur_08,ppto_09, pss_09, usd_09,eur_09, ppto_10, pss_10,
usd_10, eur_10, ppto_11,pss_11, usd_11, eur_11,ppto_12, pss_12, usd_12,eur_12, version_fe, tc_01,tc_02, tc_03, tc_04,tc_05, tc_06, tc_07,tc_08, tc_09, tc_10,
tc_11, tc_12, mon_func,mon_orig, id_version)
select                                  e_codigo, secuencia_ptto_oracle, periodo_extraccion,mes_de_extraccion, periodo_ppto, libro_id,version_id, moneda, code_combination_id,
oracle_segmento1, oracle_segmento2, oracle_segmento3,oracle_segmento4, oracle_segmento5, oracle_segmento6,oracle_segmento7, ppto_01, pss_01,
usd_01, eur_01, ppto_02,pss_02, usd_02, eur_02,ppto_03, pss_03, usd_03,eur_03, ppto_04, pss_04,usd_04, eur_04, ppto_05,pss_05, usd_05, eur_05,
ppto_06, pss_06, usd_06,eur_06, ppto_07, pss_07,usd_07, eur_07, ppto_08,pss_08, usd_08, eur_08,ppto_09, pss_09, usd_09,eur_09, ppto_10, pss_10,
usd_10, eur_10, ppto_11,pss_11, usd_11, eur_11,ppto_12, pss_12, usd_12,eur_12, version_fe, tc_01,tc_02, tc_03, tc_04,tc_05, tc_06, tc_07,tc_08, tc_09, tc_10,
tc_11, tc_12, mon_func,mon_orig, v_version
from fecxc.fecxp_ppto_opera_erp
where  periodo_extraccion    = v_periodo
and    mes_de_extraccion     = v_meses;
--and mes_de_extraccion = v_mes
/* commit; */
insert into fecxc.fecxp_ppto_conversion_erp_h(e_codigo, secuencia_ptto_conversion, periodo,mes, libro_id, version_id,moneda, tipo_cambio, code_combination,importe_linea, oracle_segmento1, oracle_segmento2,
oracle_segmento3, oracle_segmento4, oracle_segmento5,oracle_segmento6, oracle_segmento7, periodo_extraccion,mes_extraccion, presupuesto_estatus, version_fe,
mon_func, mon_orig, id_version)
select                                         e_codigo, secuencia_ptto_conversion, periodo,mes, libro_id, version_id,moneda, tipo_cambio, code_combination,importe_linea, oracle_segmento1, oracle_segmento2,
oracle_segmento3, oracle_segmento4, oracle_segmento5,oracle_segmento6, oracle_segmento7, periodo_extraccion,mes_extraccion, presupuesto_estatus, version_fe,
mon_func, mon_orig,v_version
from fecxc.fecxp_ppto_conversion_erp
where   periodo = v_periodo
and     mes     = v_meses;
--and     mes=v_mes;
/* commit; */
insert into fecxc.fecxp_importacion_datos_hist_h(tipo_empresa_imp, tipo_importacion, e_empresa_imp,cla_fe_id_imp, importe_linea, moneda_imp,
mes, fecha, atributo_1, atributo_2, atributo_3, atributo_4, estatus_origen, id_version, division,
agrupamiento, rubro, folio_set, no_cliente, referencia, descripcion,tipo_operacion, id_banco, forma_pago,
id_chequera, estatus_movimiento, beneficiario, concepto, origen_movimiento, numero_de_partida,
cia, neg, cta, sct, cc, icia,top, estatus, fecha_aplicacion,e_empresa_des, cla_fe_des, code_combination)
select
tipo_empresa_imp, tipo_importacion, e_empresa_imp, cla_fe_id_imp, importe_linea, moneda_imp,
mes, fecha, atributo_1,atributo_2, atributo_3, atributo_4, estatus_origen,v_version, division,
agrupamiento, rubro, folio_set, no_cliente, referencia, descripcion, tipo_operacion, id_banco, forma_pago,
id_chequera, estatus_movimiento, beneficiario, concepto, origen_movimiento, numero_de_partida,
cia, neg, cta, sct, cc, icia, top, estatus, fecha_aplicacion, e_empresa_des, cla_fe_des, code_combination
from fecxc.fecxp_importacion_datos_hist
where   (to_char(fecha,'YYYY'))::numeric  = v_periodo
and                                 mes  = v_meses;
--and     mes                              = v_mes;
/* commit; */
-------------para detalle contable de prespuesto soin---------------
insert into fecxc.fecxp_ppto_conversion_soin_h(e_codigo, secuencia_ppto_operativo_soin, periodo,mescod, arsmap, aejmap,cncmap, ctacr1, ctacr2,
importe_linea, moneda, tipo_cambio,periodo_extraccion, mes_extraccion, presupuesto_estatus,version_fe,id_version)
select                                          e_codigo, secuencia_ppto_operativo_soin, periodo,mescod, arsmap, aejmap,cncmap, ctacr1, ctacr2,
importe_linea, moneda, tipo_cambio,periodo_extraccion, mes_extraccion, presupuesto_estatus,version_fe,v_version
from fecxc.fecxp_ppto_conversion_soin
where  periodo =  v_periodo
and    mes_extraccion      =  v_meses;
--and    mes_extraccion     =  v_mes;
/* commit; */
insert into fecxc.fecxp_ppto_operativo_soin_h(secuencia_ppto_operativo_soin, e_codigo, periodo,mescod, arsmap, aejmap,cncmap, ctacr1, ctacr2,importe_linea, moneda, periodo_extraccion,
mes_extraccion, tipo_cambio, version_fe,id_version)
select                                         secuencia_ppto_operativo_soin, e_codigo, periodo,mescod, arsmap, aejmap,cncmap, ctacr1, ctacr2,importe_linea, moneda, periodo_extraccion,
mes_extraccion, tipo_cambio, version_fe,v_version
from fecxc.fecxp_ppto_operativo_soin
where  periodo =  v_periodo
and    mes_extraccion      = v_meses;/* dmap converted statement start */
--and    mes_extraccion     =  v_mes;
/* commit; */
perform dbms_output.put_line( concat('TERMINO CORRECTAMENTE el mes :', v_meses)) ;/* dmap converted statement end */
v_meses:=v_meses+1;
end loop;
end if;
if v_operacion=0 then
----------para caratula de prespuesto----------
delete
from fecxc.fecxp_ppto_caratula_h
where periodo = v_periodo
--and   mes     = v_mes
and   id_version=v_version;
/* commit; */
-------------para detalle contable de prespuesto erp---------------
delete
from  fecxc.fecxp_ppto_opera_erp_h
where periodo_extraccion = v_periodo
--and   mes_de_extraccion  = v_mes
and   id_version=v_version;
/* commit; */
delete
from  fecxp_ppto_conversion_erp_h
where periodo = v_periodo
--and   mes     = v_mes
and   id_version=v_version;
/* commit; */
delete
from  fecxp_importacion_datos_hist_h
where  (to_char(fecha,'YYYY'))::numeric =v_periodo
--and     mes   = v_mes
and    id_version=v_version;
/* commit; */
-------------para detalle contable de prespuesto soin---------------
delete from
fecxp_ppto_conversion_soin_h
where periodo_extraccion = v_periodo
--and   mes_extraccion    = v_mes
and   id_version=v_version;
/* commit; */
delete from
fecxp_ppto_operativo_soin_h
where periodo_extraccion = v_periodo
--and   mes_extraccion    = v_mes
and   id_version=v_version;
/* commit; */
end if;
insert into fecxp_bitacora_historicos(proceso_id, proceso_nombre     , created_by, date_created, id_version, desc_version, periodo, mes, comentario, tipo_operacion)
select                                        18, 'HISTORICO DE PTTO', v_usuario , clock_timestamp(),      v_version, v_nombre_version, v_periodo,  0, v_comentario, case when v_operacion=1 then 'REGISTRA VERSION' else 'ELIMINA VERSION' end;
update fecxp_ppto_extraccion_params
set estatus_proceso = 'INACTIVO',estatus_ext_ult_ejecucion= 'EXITOSO'
where proceso_id =18;
/* commit; */
exception
when others then
update fecxp_ppto_extraccion_params
set estatus_proceso = 'INACTIVO',estatus_ext_ult_ejecucion= 'ERROR'
where proceso_id =18;/* dmap converted statement start */
raise exception '%',  concat('An error was encountered - ', sqlstate, ' -ERROR- ', sqlerrm)  using errcode = '45001';/* dmap converted statement end */
rollback;end;
$body$
language plpgsql
;
