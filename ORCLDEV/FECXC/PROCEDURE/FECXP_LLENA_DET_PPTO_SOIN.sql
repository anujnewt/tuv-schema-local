create or replace procedure fecxc."fecxp_llena_det_ppto_soin"  ( v_version_fe numeric, v_mes_desde numeric, v_mes_hasta numeric, v_ecodigo_desde numeric, v_ecodigo_hasta numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_e_codigo integer;
v_periodo integer:= (to_char(clock_timestamp(), 'YYYY'))::numeric;
v_mes_act integer := (to_char(clock_timestamp(), 'MM'))::numeric;
v_cla_fe_id fecxp_politicas_soin.cla_fe_id%type;
v_prioridad fecxp_politicas_soin.prioridad%type;
v_tipo_operacion_ini fecxp_politicas_soin.tipo_operacion_ini%type;
v_tipo_operacion_fin fecxp_politicas_soin.tipo_operacion_fin%type;
v_id_banco_ini fecxp_politicas_soin.id_banco_ini%type;
v_id_banco_fin fecxp_politicas_soin.id_banco_fin%type;
v_id_chequera_ini fecxp_politicas_soin.id_chequera_ini%type;
v_id_chequera_fin fecxp_politicas_soin.id_chequera_fin%type;
v_politica_soin_id fecxp_politicas_soin.politica_soin_id%type;
v_e_codigo_ini fecxp_politicas_soin.e_codigo_ini%type;
v_e_codigo_fin fecxp_politicas_soin.e_codigo_fin%type;
v_ctam01_ini fecxp_politicas_soin.ctam01_ini%type;
v_ctam01_fin fecxp_politicas_soin.ctam01_fin%type;
v_ctam02_ini fecxp_politicas_soin.ctam02_ini%type;
v_ctam02_fin fecxp_politicas_soin.ctam02_fin%type;
v_ctam03_ini fecxp_politicas_soin.ctam03_ini%type;
v_ctam03_fin fecxp_politicas_soin.ctam03_fin%type;
v_tipo_ini fecxp_politicas_soin.tipo_ini%type;
v_tipo_fin fecxp_politicas_soin.tipo_fin%type;
v_division_ini fecxp_politicas_soin.division_ini%type;
v_division_fin fecxp_politicas_soin.division_fin%type;
v_rubro_ini fecxp_politicas_soin.rubro_ini%type;
v_rubro_fin fecxp_politicas_soin.rubro_fin%type;
v_ctacr1_ini fecxp_politicas_soin.ctacr1_ini%type;
v_ctacr1_fin fecxp_politicas_soin.ctacr1_fin%type;
v_ctacr2_ini fecxp_politicas_soin.ctacr2_ini%type;
v_ctacr2_fin fecxp_politicas_soin.ctacr2_fin%type;
cursor_clasificacion_fe_soin cursor for
select cla_fe_id, politica_soin_id, prioridad, tipo_operacion_ini, tipo_operacion_fin, id_banco_ini, id_banco_fin, id_chequera_ini, id_chequera_fin,
e_codigo_ini, e_codigo_fin, ctam01_ini, ctam01_fin, ctam02_ini, ctam02_fin, ctam03_ini, ctam03_fin, tipo_ini, tipo_fin, division_ini, division_fin, rubro_ini, rubro_fin, ctacr1_ini, ctacr1_fin, ctacr2_ini, ctacr2_fin
from fecxp_politicas_soin
where activa_regla = 1
and  id_tipo_movto in ('A', 'E')
order by prioridad asc;
cursor_clasificacion_fe_ing cursor for
select cla_fe_id, politica_soin_id, prioridad, tipo_operacion_ini, tipo_operacion_fin, id_banco_ini, id_banco_fin, id_chequera_ini, id_chequera_fin,
e_codigo_ini, e_codigo_fin, ctam01_ini, ctam01_fin, ctam02_ini, ctam02_fin, ctam03_ini, ctam03_fin
from fecxp_politicas_soin
where id_tipo_movto in ('A', 'I')
and  activa_regla = 1
order by prioridad asc;
begin 

/*modificacion may 09 v4.  referencia, descripcion y cliente*/
/*proviene de fecxp_llena_det_cont_soin*/
/*modificacion abr 09 v3.  crear detalles de inversion y coinversion*/
/*modificado dic 08*/
--===============================================================================================--
--== ppto soin ==--
--== limpia tabla de enlace  ==--
delete from fecxp_del_soin_caratula
;
insert into fecxp_del_soin_caratula
select distinct ps.e_codigo, ps.arsmap, ps.aejmap, ps.cncmap, ctacr1, ctacr2
from fecxp_ppto_conversion_soin ps
where ps.version_fe = v_version_fe
and  ps.e_codigo >= v_ecodigo_desde
and  ps.e_codigo <= v_ecodigo_hasta
and  ps.mescod >= v_mes_desde
and  ps.mescod <= v_mes_hasta;
/* commit; */
delete from fecxp_ctas_soin_caratula a
where exists (
select 1
from fecxp_del_soin_caratula d
where 	a.e_codigo = d.e_codigo
and		coalesce(a.ctam01,'0') = coalesce(d.ctam01,'0')
and 	coalesce(a.ctam02,'0') = coalesce(d.ctam02,'0')
and 	coalesce(a.ctam03,'0') = coalesce(d.ctam03,'0')
and 	coalesce(a.ctacr1,'0') = coalesce(d.ctacr1,'0')
and		coalesce(a.ctacr2,'0') = coalesce(d.ctacr2,'0')
);
/* commit; */
--== se cargan las cuentas contables del presupuesto  ==--
insert into fecxp_ctas_soin_caratula(cla_fe_id, e_codigo, ctam01, ctam02, ctam03, division, rubro, ctacr1, ctacr2)
select distinct '|' as cla_fe_id, ps.e_codigo, ps.ctam01, ps.ctam02, ps.ctam03, 0, 0, ps.ctacr1, ps.ctacr2
from fecxp_del_soin_caratula ps
;
/* commit; */
/*
insert into fecxp_ctas_soin_caratula (cla_fe_id, e_codigo, ctam01, ctam02, ctam03, division, rubro, ctacr1, ctacr2)
select distinct '|' as cla_fe_id, ps.e_codigo, ps.arsmap, ps.aejmap, ps.cncmap, 0, 0, ctacr1, ctacr2
from fecxp_ppto_conversion_soin ps
where ps.version_fe = v_version_fe
and  ps.e_codigo >= v_ecodigo_desde
and  ps.e_codigo <= v_ecodigo_hasta
and  ps.mescod >= v_mes_desde
and  ps.mescod <= v_mes_hasta;
*/
--== actualiza divisi?n y rubro  ==--
update fecxp_ctas_soin_caratula c1
set(division, rubro) = (
select c2.cg13di, c2.cg13ru
from fecxp_cat_cuentas_soin c2
where c1.ctam01 = c2.ctam01
and  c1.ctam02 = c2.ctam02
and  c1.ctam03 = c2.ctam03
)
where exists (
select c2.cg13di, c2.cg13ru
from fecxp_cat_cuentas_soin c2
where c1.ctam01 = c2.ctam01
and  c1.ctam02 = c2.ctam02
and  c1.ctam03 = c2.ctam03
);
/* commit; */
--==  clasificacion de cuentas sesgun politicas de clasificacion de fe ==--
open cursor_clasificacion_fe_soin;
loop
fetch cursor_clasificacion_fe_soin
into v_cla_fe_id, v_politica_soin_id, v_prioridad, v_tipo_operacion_ini, v_tipo_operacion_fin, v_id_banco_ini, v_id_banco_fin, v_id_chequera_ini, v_id_chequera_fin,
v_e_codigo_ini, v_e_codigo_fin, v_ctam01_ini, v_ctam01_fin, v_ctam02_ini, v_ctam02_fin, v_ctam03_ini, v_ctam03_fin, v_tipo_ini, v_tipo_fin, v_division_ini, v_division_fin, v_rubro_ini, v_rubro_fin, v_ctacr1_ini, v_ctacr1_fin, v_ctacr2_ini, v_ctacr2_fin;
exit when not found; /* apply on cursor_clasificacion_fe_soin */
update fecxp_ctas_soin_caratula
set  cla_fe_id = v_cla_fe_id
where (e_codigo >= coalesce(v_e_codigo_ini, 0))
and (e_codigo <= coalesce(v_e_codigo_fin, 9999))
and (ctam01 >= coalesce(v_ctam01_ini, '0'))
and (ctam01 <= coalesce(v_ctam01_fin, 'z'))
and (ctam02 >= coalesce(v_ctam02_ini, '0'))
and (ctam02 <= coalesce(v_ctam02_fin, 'z'))
and (ctam03 >= coalesce(v_ctam03_ini, '0'))
and (ctam03 <= coalesce(v_ctam03_fin, 'z'))
and (coalesce(division, 0) >= coalesce(v_division_ini, 0))
and (coalesce(division, 0) <= coalesce(v_division_fin, 9999))
and (coalesce(rubro, 0) >= coalesce(v_rubro_ini, 0))
and (coalesce(rubro, 0) <= coalesce(v_rubro_fin, 9999))
and (lpad(ctacr1::text, 4, '0'::text) >= coalesce(lpad(v_ctacr1_ini::text, 4, '0'::text), '0000'))
and (lpad(ctacr1::text, 4, '0'::text) <= coalesce(lpad(v_ctacr1_fin::text, 4, '0'::text), 'zzzz'))
and (lpad(ctacr2::text, 4, '0'::text) >= coalesce(lpad(v_ctacr2_ini::text, 4, '0'::text), '0000'))
and (lpad(ctacr2::text, 4, '0'::text) <= coalesce(lpad(v_ctacr2_fin::text, 4, '0'::text), 'zzzz'))
and  coalesce(v_tipo_operacion_ini, 0) = 0
and  coalesce(v_tipo_operacion_fin, 0) = 0
and  coalesce(v_id_banco_ini, 0) = 0
and  coalesce(v_id_banco_fin, 0) = 0
and  coalesce(lpad(v_id_chequera_ini::text, 20, '0'::text), '00000000000000000000') = '00000000000000000000'
and  coalesce(lpad(v_id_chequera_fin::text, 20, '0'::text), '00000000000000000000') = '00000000000000000000'
and  coalesce(cla_fe_id, '|') = '|';
/* commit; */
end loop;
close cursor_clasificacion_fe_soin;
delete from fecxp_det_cont_version_fe
where proceso = 'FECXP_LLENA_DET_PPTO_SOIN';
insert into fecxp_det_cont_version_fe(
proceso, version_fe)
values (
'FECXP_LLENA_DET_PPTO_SOIN', v_version_fe);
/* commit; */
--===============================================================================================--
--== termina ppto ==--
exception
when no_data_found then
raise exception '%', 'NO HAY DATOS NUEVOS.' using errcode = '45000';
when others then
rollback;/* dmap converted statement start */
raise exception '%',  concat('Error:', sqlstate , ' - ' , sqlerrm)  using errcode = '45000';/* dmap converted statement end */end;
$body$
language plpgsql
;
