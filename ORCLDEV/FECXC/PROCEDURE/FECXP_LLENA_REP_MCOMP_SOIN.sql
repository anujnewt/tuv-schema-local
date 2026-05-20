create or replace procedure fecxc."fecxp_llena_rep_mcomp_soin"  ( v_periodo integer, v_mes integer ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
/*declare
v_periodo      int:= 2005;
v_mes 	       int:= 01;   */
v_id_sesion    varchar(25):= to_char(clock_timestamp(),'YYYYMMDD');
v_cla_fe_id    fecxp_politicas_soin.cla_fe_id%type;
v_politica_soin_id fecxp_politicas_soin.politica_soin_id%type;
v_prioridad    fecxp_politicas_soin.prioridad%type;
v_ctam01_ini   fecxp_politicas_soin.ctam01_ini%type;
v_ctam01_fin   fecxp_politicas_soin.ctam01_fin%type;
v_ctam02_ini   fecxp_politicas_soin.ctam02_ini%type;
v_ctam02_fin   fecxp_politicas_soin.ctam02_fin%type;
v_ctam03_ini   fecxp_politicas_soin.ctam03_ini%type;
v_ctam03_fin   fecxp_politicas_soin.ctam03_fin%type;
v_tipo_ini     fecxp_politicas_soin.tipo_ini%type;
v_tipo_fin     fecxp_politicas_soin.tipo_fin%type;
v_division_ini fecxp_politicas_soin.division_ini%type;
v_division_fin fecxp_politicas_soin.division_fin%type;
v_rubro_ini	   fecxp_politicas_soin.rubro_ini%type;
v_rubro_fin    fecxp_politicas_soin.rubro_fin%type;
cursor_clasificacion_fe cursor for
select	 cla_fe_id, prioridad, politica_soin_id, ctam01_ini, ctam01_fin, ctam02_ini, ctam02_fin,
ctam03_ini, ctam03_fin, tipo_ini, tipo_fin, division_ini, division_fin, rubro_ini, rubro_fin
from	 fecxp_politicas_soin
where  	 activa_regla = 1
order by prioridad asc;
begin 

delete from fecxp_rep_mvcomp_soin
where (to_char(fecha_aplicacion, 'YYYY'))::numeric  = v_periodo
and (to_char(fecha_aplicacion, 'MM'))::numeric  = v_mes;
--== se insertan las cuentas q generaron flujo de efectivo ==--
insert	into fecxp_cuentas_soin_caratula(e_codigo, ctam01, ctam02, ctam03)
select	distinct e_codigo, cs.ctam01, cs.ctam02, cs.ctam03
from	fecxp_mov_comple_soin cs
where   (to_char(cs.cgbfec,'YYYY'))::numeric  = v_periodo
and		(to_char(cs.cgbfec,'MM'))::numeric  = v_mes;
--==  se clasifican  ==--
open  cursor_clasificacion_fe;
loop
--***** debug *****-- v_existe:= null;
fetch cursor_clasificacion_fe
into  v_cla_fe_id, v_prioridad, v_politica_soin_id, v_ctam01_ini, v_ctam01_fin, v_ctam02_ini, v_ctam02_fin, v_ctam03_ini, v_ctam03_fin, v_tipo_ini, v_tipo_fin, v_division_ini, v_division_fin, v_rubro_ini, v_rubro_fin;
exit when not found; /* apply on cursor_clasificacion_fe */
update	fecxp_cuentas_soin_caratula
set		cla_fe_id = v_cla_fe_id
where (ctam01 >= coalesce(v_ctam01_ini, '0'))
and (ctam01 <= coalesce(v_ctam01_fin, 'z'))
and (ctam02 >= coalesce(v_ctam02_ini, '0'))
and (ctam02 <= coalesce(v_ctam02_fin, 'z'))
and (ctam03 >= coalesce(v_ctam03_ini, '0'))
and (ctam03 <= coalesce(v_ctam03_fin, 'z'))
and		coalesce(cla_fe_id, '|') = '|';
end loop;
close cursor_clasificacion_fe;
insert into fecxp_rep_mvcomp_soin(cod_empresa, des_empresa, cla_id_fe, cla_fe_des, rubro, orden_id, fecha_aplicacion,
moneda, tipo_cambio, importe_debito, importe_credito, ctam01, ctam02, ctam03)
select  e.e_codigo, e.des_empresa,c.cla_fe_id, cfe.cla_fe_des, cfe.cla_atributo2, cfe.cla_atributo1,
mc.cgbfec, m.mon_oracle, m.tipo_cambio, case when mc.cgttip = 'D' then mc.cgtmon else 0 end as debito,
case when mc.cgttip = 'C' then cgtmon else 0 end as credito, mc.ctam01, mc.ctam02, mc.ctam03
from  fecxc_empresas e,
fecxp_clasificacion_fe cfe,
fecxp_cuentas_soin_caratula c,
fecxp_mov_comple_soin mc,
fecxp_monedas m
where e.e_codigo = mc.e_codigo
and e.e_codigo = c.e_codigo
and cfe.cla_fe_id = c.cla_fe_id
and m.mon_sybase = mc.moneda
and m.mes = mc.mescod
and	c.ctam01 = mc.ctam01
and c.ctam02 = mc.ctam02
and c.ctam03 = mc.ctam03;
/* commit; */
end;
$body$
language plpgsql
;
