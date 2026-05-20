create or replace procedure fecxc."fecxp_ppto_op_a_ppto_fe_soin"  ( v_version_fe integer, v_usuario_id varchar, v_comentario varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_periodo_extraccion integer;
v_version_extraccion integer;
v_e_codigo integer;
begin 

select	periodo_origen, version_origen
into strict	v_periodo_extraccion, v_version_extraccion
from	fecxp_ppto_operativo_soin_enc
where   version_fe = v_version_fe
group by periodo_origen, version_origen;
delete  from fecxp_ppto_conversion_soin
where   version_fe = v_version_fe and e_codigo = coalesce(v_e_codigo, e_codigo);
/* commit; */
delete  from fecxc.fecxp_ppto_conversion_soin_enc
where   version_fe = v_version_fe;
/* commit; */
insert  into fecxp_ppto_conversion_soin(
e_codigo,secuencia_ppto_operativo_soin, periodo, mescod, arsmap, aejmap,
cncmap, ctacr1, ctacr2, moneda, tipo_cambio, importe_linea, periodo_extraccion,
mes_extraccion, presupuesto_estatus, version_fe)
select  e_codigo,nextval('secuencia_ppto_operativo_soin'), periodo, mescod, arsmap, aejmap,
cncmap, ctacr1, ctacr2, moneda, tipo_cambio, importe_linea, periodo_extraccion,
mes_extraccion, 'EXTRAIDO', version_fe
from    fecxp_ppto_operativo_soin
where   version_fe = v_version_fe and e_codigo = coalesce(v_e_codigo, e_codigo);
/* commit; */
insert	into fecxc.fecxp_ppto_conversion_soin_enc(
version_fe, comentario, usuario_id, fecha_extraccion, version_reglas, fecha_version_reglas, periodo_origen, version_origen, estatus_origen, version_fe_origen)
select	version_fe, v_comentario, v_usuario_id, clock_timestamp(), 0, to_timestamp('19000101','YYYYMMDD'), periodo, 0, 0, 0
from	fecxp_ppto_conversion_soin
where	version_fe = v_version_fe and e_codigo = coalesce(v_e_codigo, e_codigo)
group by version_fe, periodo;
/* commit; */
--actualiza presupuesto (de operativo a "convertido" )  .
update  fecxp_ppto_conversion_soin pfe
set             importe_linea = 0,
presupuesto_estatus = 'CONVERTIDO'
where   exists (
select	1
from	fecxp_reglas_conversion_ppto rc
where (pfe.e_codigo >= rc.reg_segmento1_ini or nullif(rc.reg_segmento1_ini::text, '') is null)
and (pfe.e_codigo <= rc.reg_segmento1_fin or nullif(rc.reg_segmento1_fin::text, '') is null)
and (pfe.arsmap >= rc.reg_segmento2_ini or nullif(rc.reg_segmento2_ini::text, '') is null)
and (pfe.arsmap <= rc.reg_segmento2_fin or nullif(rc.reg_segmento2_fin::text, '') is null)
and (pfe.aejmap >= rc.reg_segmento3_ini or nullif(rc.reg_segmento3_ini::text, '') is null)
and (pfe.aejmap <= rc.reg_segmento3_fin or nullif(rc.reg_segmento3_fin::text, '') is null)
and (pfe.cncmap >= rc.reg_segmento4_ini or nullif(rc.reg_segmento4_ini::text, '') is null)
and (pfe.cncmap <= rc.reg_segmento4_fin or nullif(rc.reg_segmento4_fin::text, '') is null)
and (pfe.ctacr1 >= rc.reg_segmento5_ini or nullif(rc.reg_segmento5_ini::text, '') is null)
and (pfe.ctacr1 <= rc.reg_segmento5_fin or nullif(rc.reg_segmento5_fin::text, '') is null)
and (pfe.ctacr2 >= rc.reg_segmento6_ini or nullif(rc.reg_segmento6_ini::text, '') is null)
and (pfe.ctacr2 <= rc.reg_segmento6_fin or nullif(rc.reg_segmento6_fin::text, '') is null)
and (pfe.periodo = rc.periodo or nullif(rc.periodo::text, '') is null)
and (pfe.mescod >= rc.mes_ini or nullif(rc.mes_ini::text, '') is null)
and (pfe.mescod <= rc.mes_fin or nullif(rc.mes_fin::text, '') is null)
and		rc.plataforma = 'SOIN'
and		rc.mes_acumulacion = 0)
and		version_fe = v_version_fe and e_codigo = coalesce(v_e_codigo, e_codigo);
/* commit; */
update  fecxp_ppto_conversion_soin pfe
set             importe_linea = (
select	sum(pa.importe_linea)
from	fecxp_ppto_conversion_soin pa
where	pa.e_codigo = pfe.e_codigo
and		pa.arsmap = pfe.arsmap
and		pa.aejmap = pfe.aejmap
and		pa.cncmap = pfe.cncmap
and		pa.ctacr1 = pfe.ctacr1
and		pa.ctacr2 = pfe.ctacr2
and		pa.moneda = pfe.moneda
and		pa.version_fe = pfe.version_fe
group by pfe.e_codigo, pfe.arsmap, pfe.aejmap, pfe.cncmap, pfe.ctacr1, pfe.ctacr2, pfe.moneda, pfe.periodo_extraccion, pfe.mes_extraccion
),
presupuesto_estatus = 'CONVERTIDO'
where   exists (
select	1
from	fecxp_reglas_conversion_ppto rc
where (pfe.e_codigo >= rc.reg_segmento1_ini or nullif(rc.reg_segmento1_ini::text, '') is null)
and (pfe.e_codigo <= rc.reg_segmento1_fin or nullif(rc.reg_segmento1_fin::text, '') is null)
and (pfe.arsmap >= rc.reg_segmento2_ini or nullif(rc.reg_segmento2_ini::text, '') is null)
and (pfe.arsmap <= rc.reg_segmento2_fin or nullif(rc.reg_segmento2_fin::text, '') is null)
and (pfe.aejmap >= rc.reg_segmento3_ini or nullif(rc.reg_segmento3_ini::text, '') is null)
and (pfe.aejmap <= rc.reg_segmento3_fin or nullif(rc.reg_segmento3_fin::text, '') is null)
and (pfe.cncmap >= rc.reg_segmento4_ini or nullif(rc.reg_segmento4_ini::text, '') is null)
and (pfe.cncmap <= rc.reg_segmento4_fin or nullif(rc.reg_segmento4_fin::text, '') is null)
and (pfe.ctacr1 >= rc.reg_segmento5_ini or nullif(rc.reg_segmento5_ini::text, '') is null)
and (pfe.ctacr1 <= rc.reg_segmento5_fin or nullif(rc.reg_segmento5_fin::text, '') is null)
and (pfe.ctacr2 >= rc.reg_segmento6_ini or nullif(rc.reg_segmento6_ini::text, '') is null)
and (pfe.ctacr2 <= rc.reg_segmento6_fin or nullif(rc.reg_segmento6_fin::text, '') is null)
and (pfe.periodo = rc.periodo or nullif(rc.periodo::text, '') is null)
and (pfe.mescod >= rc.mes_ini or nullif(rc.mes_ini::text, '') is null)
and (pfe.mescod <= rc.mes_fin or nullif(rc.mes_fin::text, '') is null)
and		rc.plataforma = 'SOIN'
and		rc.mes_acumulacion = pfe.mescod)
and		version_fe = v_version_fe and e_codigo = coalesce(v_e_codigo, e_codigo);
/* commit; */
update  fecxp_ppto_conversion_soin pfe
set             importe_linea = 0,
presupuesto_estatus = 'CONVERTIDO'
where   exists (
select	1
from	fecxp_reglas_conversion_ppto rc
where (pfe.e_codigo >= rc.reg_segmento1_ini or nullif(rc.reg_segmento1_ini::text, '') is null)
and (pfe.e_codigo <= rc.reg_segmento1_fin or nullif(rc.reg_segmento1_fin::text, '') is null)
and (pfe.arsmap >= rc.reg_segmento2_ini or nullif(rc.reg_segmento2_ini::text, '') is null)
and (pfe.arsmap <= rc.reg_segmento2_fin or nullif(rc.reg_segmento2_fin::text, '') is null)
and (pfe.aejmap >= rc.reg_segmento3_ini or nullif(rc.reg_segmento3_ini::text, '') is null)
and (pfe.aejmap <= rc.reg_segmento3_fin or nullif(rc.reg_segmento3_fin::text, '') is null)
and (pfe.cncmap >= rc.reg_segmento4_ini or nullif(rc.reg_segmento4_ini::text, '') is null)
and (pfe.cncmap <= rc.reg_segmento4_fin or nullif(rc.reg_segmento4_fin::text, '') is null)
and (pfe.ctacr1 >= rc.reg_segmento5_ini or nullif(rc.reg_segmento5_ini::text, '') is null)
and (pfe.ctacr1 <= rc.reg_segmento5_fin or nullif(rc.reg_segmento5_fin::text, '') is null)
and (pfe.ctacr2 >= rc.reg_segmento6_ini or nullif(rc.reg_segmento6_ini::text, '') is null)
and (pfe.ctacr2 <= rc.reg_segmento6_fin or nullif(rc.reg_segmento6_fin::text, '') is null)
and (pfe.periodo = rc.periodo or nullif(rc.periodo::text, '') is null)
and (pfe.mescod >= rc.mes_ini or nullif(rc.mes_ini::text, '') is null)
and (pfe.mescod <= rc.mes_fin or nullif(rc.mes_fin::text, '') is null)
and		rc.plataforma = 'SOIN'
and		rc.mes_acumulacion <> pfe.mescod)
and		version_fe = v_version_fe and e_codigo = coalesce(v_e_codigo, e_codigo);
/* commit; */
insert	into fecxp_ppto_bitacora_procesos(
sec_ext_bitacora, proceso_id, fecha_ext_ult_ejecucion, estatus_ext_ult_ejecucion, periodo_ppto_ult_ejecucion, version_ppto_ult_ejecucion, estatus_ppto_ult_ejecucion, version_ppto_generado)
values (nextval('sec_ext_bitacora'), 2,  clock_timestamp(), 'CONVERSION EXITOSA', v_periodo_extraccion, v_version_extraccion, 'V', v_version_fe);
/* commit; */
exception
when no_data_found then
raise exception '%', 'No hay datos nuevos.' using errcode = '45000';end;
$body$
language plpgsql
;
