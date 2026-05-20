create or replace procedure fecxc."fecxp_llena_ppto_soin12mct"  () as $body$
declare
flg0 text;
-- pgv moved types end
begin 

-------------------------------------------------------------------------
-- consulta comparativa del ppto de soin operativo vs flujo
declare
-- pgv moved types start
v_cla_fe_id fecxp_politicas_soin.cla_fe_id%type;
v_politica_soin_id fecxp_politicas_soin.politica_soin_id%type;
v_prioridad fecxp_politicas_soin.prioridad%type;
v_ctam01_ini fecxp_politicas_soin.ctam01_ini%type;
v_ctam01_fin fecxp_politicas_soin.ctam01_fin%type;
v_ctam02_ini fecxp_politicas_soin.ctam02_ini%type;
v_ctam02_fin fecxp_politicas_soin.ctam02_fin%type;
v_ctam03_ini fecxp_politicas_soin.ctam03_ini%type;
v_ctam03_fin fecxp_politicas_soin.ctam03_fin%type;
v_division_ini fecxp_politicas_soin.division_ini%type;
v_division_fin fecxp_politicas_soin.division_fin%type;
v_rubro_ini fecxp_politicas_soin.rubro_ini%type;
v_rubro_fin fecxp_politicas_soin.rubro_fin%type;
v_ctacr1_ini fecxp_politicas_soin.ctacr1_ini%type;
v_ctacr1_fin fecxp_politicas_soin.ctacr1_fin%type;
v_ctacr2_ini fecxp_politicas_soin.ctacr2_ini%type;
v_ctacr2_fin fecxp_politicas_soin.ctacr2_fin%type;
v_tipo_operacion_ini fecxp_politicas_soin.tipo_operacion_ini%type;
v_tipo_operacion_fin fecxp_politicas_soin.tipo_operacion_fin%type;
cursor_clasificacion_fe_soin cursor  for
select	 cla_fe_id, politica_soin_id, prioridad, ctam01_ini, ctam01_fin, ctam02_ini, ctam02_fin, ctam03_ini, ctam03_fin, division_ini, division_fin, rubro_ini, rubro_fin, ctacr1_ini, ctacr1_fin, ctacr2_ini, ctacr2_fin, tipo_operacion_ini, tipo_operacion_fin
from	 fecxp_politicas_soin
where  	 activa_regla = 1
order by  prioridad asc;
begin
insert	 into fecxp_ctas_soin_caratula(cla_fe_id, e_codigo, ctam01, ctam02, ctam03, division, rubro, ctacr1, ctacr2)
select	distinct '|' as cla_id, ps.e_codigo, ps.arsmap, ps.aejmap, ps.cncmap, 0, 0, ctacr1, ctacr2
from	fecxp_ppto_conversion_soin ps;
-- and		ps.e_codigo = v_empresa_soin
-- and		ps.periodo = v_periodo
-- and		ps.mescod = v_mes;
update	fecxp_ctas_soin_caratula c1
set(division, rubro) = 	(
select	c2.cg13di, c2.cg13ru
from	fecxp_cat_cuentas_soin c2
where   c1.ctam01 = c2.ctam01
and		c1.ctam02 = c2.ctam02
and		c1.ctam03 = c2.ctam03
)
where	exists (
select	c2.cg13di, c2.cg13ru
from	fecxp_cat_cuentas_soin c2
where   c1.ctam01 = c2.ctam01
and		c1.ctam02 = c2.ctam02
and		c1.ctam03 = c2.ctam03
);
open  cursor_clasificacion_fe_soin;
loop
fetch cursor_clasificacion_fe_soin
into  v_cla_fe_id, v_politica_soin_id, v_prioridad, v_ctam01_ini, v_ctam01_fin, v_ctam02_ini, v_ctam02_fin, v_ctam03_ini, v_ctam03_fin, v_division_ini, v_division_fin, v_rubro_ini, v_rubro_fin, v_ctacr1_ini, v_ctacr1_fin, v_ctacr2_ini, v_ctacr2_fin, v_tipo_operacion_ini, v_tipo_operacion_fin;
flg0 := found;
exit when (not flg0);/* apply on cursor_clasificacion_fe_soin */
-- clasificacion de cuentas contables erp.
update	fecxp_ctas_soin_caratula
set		cla_fe_id = v_cla_fe_id
where (ctam01 >= coalesce(v_ctam01_ini, '0'))
and (ctam01 <= coalesce(v_ctam01_fin, 'z'))
and (ctam02 >= coalesce(v_ctam02_ini, '0'))
and (ctam02 <= coalesce(v_ctam02_fin, 'z'))
and (ctam03 >= coalesce(v_ctam03_ini, '0'))
and (ctam03 <= coalesce(v_ctam03_fin, 'z'))
and (division >= coalesce(v_division_ini, 0))
and (division <= coalesce(v_division_fin, 9999))
and (rubro >= coalesce(v_rubro_ini, 0))
and (rubro <= coalesce(v_rubro_fin, 9999))
and (lpad(ctacr1::text, 4, '0'::text) >= coalesce(lpad(v_ctacr1_ini::text, 4, '0'::text), '0000'))
and (lpad(ctacr1::text, 4, '0'::text) <= coalesce(lpad(v_ctacr1_fin::text, 4, '0'::text), 'zzzz'))
and (lpad(ctacr2::text, 4, '0'::text) >= coalesce(lpad(v_ctacr2_ini::text, 4, '0'::text), '0000'))
and (lpad(ctacr2::text, 4, '0'::text) <= coalesce(lpad(v_ctacr2_fin::text, 4, '0'::text), 'zzzz'))
and		coalesce(v_tipo_operacion_ini, 0) = 0
and		coalesce(v_tipo_operacion_fin, 0) = 0
and		coalesce(cla_fe_id, '|') = '|';
end loop;
close cursor_clasificacion_fe_soin;
end;
exception
when no_data_found then
raise exception '%', 'No hay datos nuevos.' using errcode = '45000';
end;
$body$
language plpgsql
;
