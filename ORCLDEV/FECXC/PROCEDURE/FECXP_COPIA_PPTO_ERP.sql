create or replace procedure fecxc."fecxp_copia_ppto_erp"  ( v_version_fe_ini integer, v_version_fe_fin integer, v_usuario_id varchar, v_comentario varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_periodo integer;
v_version integer;
begin 

-----------------------------------------------------------------------------------------------------------
-- obtiene periodo y version del ppto
select	periodo_origen, v_version_fe_ini
into strict	v_periodo, v_version
from	fecxp_ppto_opera_erp_enc
where	version_fe = v_version_fe_ini
group by periodo_origen;
-----------------------------------------------------------------------------------------------------------
-- borra encabezado y detalle de ppto operativo
delete	from fecxp_ppto_opera_erp_enc
where	version_fe = v_version_fe_fin;
delete	from fecxp_ppto_opera_erp
where	version_fe = v_version_fe_fin;
/* commit; */
-----------------------------------------------------------------------------------------------------------
-- inserta encabezado y detalle de ppto operativo
insert	into fecxp_ppto_opera_erp(
e_codigo,
secuencia_ptto_oracle,
periodo_extraccion,
mes_de_extraccion,
periodo_ppto,
libro_id,
version_id,
moneda,
code_combination_id,
oracle_segmento1, oracle_segmento2, oracle_segmento3,
oracle_segmento4, oracle_segmento5, oracle_segmento6, oracle_segmento7,
ppto_01, pss_01, usd_01, eur_01,
ppto_02, pss_02, usd_02, eur_02,
ppto_03, pss_03, usd_03, eur_03,
ppto_04, pss_04, usd_04, eur_04,
ppto_05, pss_05, usd_05, eur_05,
ppto_06, pss_06, usd_06, eur_06,
ppto_07, pss_07, usd_07, eur_07,
ppto_08, pss_08, usd_08, eur_08,
ppto_09, pss_09, usd_09, eur_09,
ppto_10, pss_10, usd_10, eur_10,
ppto_11, pss_11, usd_11, eur_11,
ppto_12, pss_12, usd_12, eur_12,
version_fe)
select  e_codigo,
nextval('secuencia_ptto_oracle'),
periodo_extraccion,
mes_de_extraccion,
periodo_ppto,
libro_id,
version_id,
moneda,
code_combination_id,
oracle_segmento1, oracle_segmento2, oracle_segmento3,
oracle_segmento4, oracle_segmento5, oracle_segmento6, oracle_segmento7,
ppto_01, pss_01, usd_01, eur_01,
ppto_02, pss_02, usd_02, eur_02,
ppto_03, pss_03, usd_03, eur_03,
ppto_04, pss_04, usd_04, eur_04,
ppto_05, pss_05, usd_05, eur_05,
ppto_06, pss_06, usd_06, eur_06,
ppto_07, pss_07, usd_07, eur_07,
ppto_08, pss_08, usd_08, eur_08,
ppto_09, pss_09, usd_09, eur_09,
ppto_10, pss_10, usd_10, eur_10,
ppto_11, pss_11, usd_11, eur_11,
ppto_12, pss_12, usd_12, eur_12,
v_version_fe_fin
from	fecxp_ppto_opera_erp
where	version_fe = v_version_fe_ini;
/* commit; */
insert	into fecxp_ppto_opera_erp_enc(
version_fe, comentario, usuario_id, fecha_extraccion, version_reglas, fecha_version_reglas, periodo_origen, version_origen, estatus_origen, version_fe_origen)
select	version_fe, v_comentario, v_usuario_id, clock_timestamp(), 0, to_timestamp('19000101','YYYYMMDD'), periodo_extraccion, version_id, 'V', v_version_fe_ini
from	fecxp_ppto_opera_erp
where	version_fe = v_version_fe_fin
group by version_fe, periodo_extraccion, version_id;
/* commit; */
-----------------------------------------------------------------------------------------------------------
-- borra encabezado y detalle de ppto convertido
delete	from fecxp_ppto_conversion_erp_enc
where	version_fe = v_version_fe_fin;
delete	from fecxp_ppto_conversion_erp
where	version_fe = v_version_fe_fin;
/* commit; */
-----------------------------------------------------------------------------------------------------------
-- inserta encabezado y detalle de ppto convertido
insert	into fecxp_ppto_conversion_erp(
e_codigo, secuencia_ptto_conversion, periodo, mes, libro_id, version_id,
moneda, tipo_cambio, code_combination, importe_linea, oracle_segmento1,
oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6,
oracle_segmento7, periodo_extraccion, mes_extraccion, presupuesto_estatus, version_fe)
select	e_codigo, secuencia_ptto_conversion, periodo, mes, libro_id, version_id,
moneda, tipo_cambio, code_combination, importe_linea, oracle_segmento1,
oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6,
oracle_segmento7, periodo_extraccion, mes_extraccion, presupuesto_estatus, v_version_fe_fin
from	fecxp_ppto_conversion_erp
where	version_fe = v_version_fe_ini;
/* commit; */
insert	into fecxp_ppto_conversion_erp_enc(
version_fe, comentario, usuario_id, fecha_extraccion, version_reglas, fecha_version_reglas, periodo_origen, version_origen, estatus_origen, version_fe_origen)
select	v_version_fe_fin, v_comentario, v_usuario_id, clock_timestamp(), 0, to_timestamp('19000101','YYYYMMDD'), periodo_extraccion, version_id, 'V', v_version_fe_ini
from	fecxp_ppto_conversion_erp
where	version_fe = v_version_fe_ini
group by version_fe, periodo_extraccion, version_id;/* dmap converted statement start */
/* commit; */
-----------------------------------------------------------------------------------------------------------
-- inserta bitacora
insert	into fecxp_ppto_bitacora_procesos(
sec_ext_bitacora, proceso_id, fecha_ext_ult_ejecucion, estatus_ext_ult_ejecucion, periodo_ppto_ult_ejecucion, version_ppto_ult_ejecucion, estatus_ppto_ult_ejecucion, version_ppto_generado)
values (nextval('sec_ext_bitacora'), 3,  clock_timestamp(),  concat('COPIA EXITOSA VI: ', to_char(v_version_fe_ini) , ' VF: ' , to_char(v_version_fe_fin)) , v_periodo, v_version, 'V', v_version_fe_fin);/* dmap converted statement end */
exception
when no_data_found then
raise exception '%', 'No hay datos nuevos.' using errcode = '45000';end;
$body$
language plpgsql
;
