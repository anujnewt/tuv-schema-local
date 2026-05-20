create or replace procedure fecxc."fecxp_copia_ppto_soin"  ( v_version_fe_ini integer, v_version_fe_fin integer, v_usuario_id varchar, v_comentario varchar ) as $body$
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
from	fecxp_ppto_operativo_soin_enc
where	version_fe = v_version_fe_ini
group by periodo_origen;
-----------------------------------------------------------------------------------------------------------
-- borra encabezado y detalle de ppto operativo
delete	from fecxp_ppto_operativo_soin_enc
where	version_fe = v_version_fe_fin;
delete	from fecxp_ppto_operativo_soin
where	version_fe = v_version_fe_fin;
/* commit; */
-----------------------------------------------------------------------------------------------------------
-- inserta encabezado y detalle de ppto operativo
insert	into fecxp_ppto_operativo_soin(
secuencia_ppto_operativo_soin, e_codigo, periodo, mescod, arsmap,
aejmap, cncmap, ctacr1, ctacr2, importe_linea,
moneda, periodo_extraccion, mes_extraccion, tipo_cambio, version_fe)
select  nextval('secuencia_ppto_operativo_soin'), e_codigo,periodo, mescod, arsmap,
aejmap, cncmap, ctacr1, ctacr2, importe_linea,
moneda, periodo_extraccion, mes_extraccion, tipo_cambio, v_version_fe_fin
from	fecxp_ppto_operativo_soin
where	version_fe = v_version_fe_ini;
/* commit; */
insert	into fecxp_ppto_operativo_soin_enc(
version_fe, comentario, usuario_id, fecha_extraccion, version_reglas, fecha_version_reglas, periodo_origen, version_origen, estatus_origen, version_fe_origen)
select	version_fe, v_comentario, v_usuario_id, clock_timestamp(), 0, to_timestamp('19000101','YYYYMMDD'), periodo_extraccion, v_version, 'V', v_version_fe_ini
from	fecxp_ppto_operativo_soin
where	version_fe = v_version_fe_fin
group by version_fe, periodo_extraccion;
/* commit; */
-----------------------------------------------------------------------------------------------------------
-- borra encabezado y detalle de ppto convertido
delete	from fecxp_ppto_conversion_soin_enc
where	version_fe = v_version_fe_fin;
delete	from fecxp_ppto_conversion_soin
where	version_fe = v_version_fe_fin;
/* commit; */
-----------------------------------------------------------------------------------------------------------
-- inserta encabezado y detalle de ppto convertido
insert	into fecxp_ppto_conversion_soin(
e_codigo, secuencia_ppto_operativo_soin, periodo, mescod, arsmap, aejmap,
cncmap, ctacr1, ctacr2, moneda, tipo_cambio, importe_linea, periodo_extraccion,
mes_extraccion, presupuesto_estatus, version_fe)
select	e_codigo, nextval('secuencia_ppto_operativo_soin'), periodo, mescod, arsmap, aejmap,
cncmap, ctacr1, ctacr2, moneda, tipo_cambio, importe_linea, periodo_extraccion,
mes_extraccion, presupuesto_estatus, v_version_fe_fin
from	fecxp_ppto_conversion_soin
where	version_fe = v_version_fe_ini;
/* commit; */
insert	into fecxp_ppto_conversion_soin_enc(
version_fe, comentario, usuario_id, fecha_extraccion, version_reglas, fecha_version_reglas, periodo_origen, version_origen, estatus_origen, version_fe_origen)
select	v_version_fe_fin, v_comentario, v_usuario_id, clock_timestamp(), 0, to_timestamp('19000101','YYYYMMDD'), periodo_extraccion, v_version, 'V', 0
from	fecxp_ppto_conversion_soin
where	version_fe = v_version_fe_ini
group by version_fe, periodo_extraccion;/* dmap converted statement start */
/* commit; */
-----------------------------------------------------------------------------------------------------------
-- inserta bitacora
insert	into fecxp_ppto_bitacora_procesos(
sec_ext_bitacora, proceso_id, fecha_ext_ult_ejecucion, estatus_ext_ult_ejecucion, periodo_ppto_ult_ejecucion, version_ppto_ult_ejecucion, estatus_ppto_ult_ejecucion, version_ppto_generado)
values (nextval('sec_ext_bitacora'), 4,  clock_timestamp(),  concat('EXITOSA VI: ', to_char(v_version_fe_ini) , ' VF: ' , to_char(v_version_fe_fin)) , v_periodo, v_version, 'V', v_version_fe_fin);/* dmap converted statement end */
exception
when no_data_found then
raise exception '%', 'No hay datos nuevos.' using errcode = '45000';end;
$body$
language plpgsql
;
