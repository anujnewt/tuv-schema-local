create or replace procedure fecxc."fecxp_llena_rep_ppto_soin"  ( v_periodo integer, v_mes integer ) as $body$
declare
flg0 text;
-- pgv moved types start
-- pgv moved types end
/*declare
v_periodo int:= to_number(to_char(sysdate::text, 'YYYY'));
v_mes int:= to_number(to_char(sysdate::text, 'MM'));*/
v_id_sesion varchar(25):= to_char(clock_timestamp(),'YYYYMMDD');
v_cla_fe_id fecxp_politicas_soin.cla_fe_id%type;
v_politica_soin_id fecxp_politicas_soin.politica_soin_id%type;
v_prioridad fecxp_politicas_soin.prioridad%type;
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
cursor_clasificacion_fe cursor for
select	 cla_fe_id, prioridad, politica_soin_id, ctam01_ini, ctam01_fin, ctam02_ini, ctam02_fin,
ctam03_ini, ctam03_fin, tipo_ini, tipo_fin, division_ini, division_fin, rubro_ini, rubro_fin
from	 fecxp_politicas_soin
where  	 activa_regla = 1
order by prioridad asc;
begin 

delete from fecxp_rep_ppto_soin;
insert	into fecxp_cuentas_soin_caratula(
e_codigo, ctam01, ctam02, ctam03, tipo, division, rubro, moneda)
select	ps.e_codigo, cs.ctam01, cs.ctam02, cs.ctam03, cs.ctatip, cs.cg13di, cs.cg13ru, ps.moneda
from	fecxp_ppto_conversion_soin ps,
fecxp_cat_cuentas_soin cs
where	ps.e_codigo = cs.e_codigo
and		ps.arsmap 	= cs.ctam01
and		ps.aejmap 	= cs.ctam02
and		ps.cncmap 	= cs.ctam03
and 	ps.periodo_extraccion = v_periodo
and		ps.mes_extraccion = v_mes
group by ps.e_codigo, cs.ctam01, cs.ctam02, cs.ctam03, cs.ctatip, cs.cg13di, cs.cg13ru, ps.moneda;
open  cursor_clasificacion_fe;
loop
----se clasifica de acuerdo a las clasificaciones de flujo de efectivo (al comparar contra el cursor)---
fetch cursor_clasificacion_fe
into  v_cla_fe_id, v_prioridad, v_politica_soin_id, v_ctam01_ini, v_ctam01_fin, v_ctam02_ini, v_ctam02_fin, v_ctam03_ini, v_ctam03_fin, v_tipo_ini, v_tipo_fin, v_division_ini, v_division_fin, v_rubro_ini, v_rubro_fin;
flg0 := found;
exit when (not flg0);/* apply on cursor_clasificacion_fe */
update	fecxp_cuentas_soin_caratula
set		cla_fe_id = v_cla_fe_id
where (ctam01 >= coalesce(v_ctam01_ini, '0'))
and (ctam01 <= coalesce(v_ctam01_fin, 'z'))
and (ctam02 >= coalesce(v_ctam02_ini, '0'))
and (ctam02 <= coalesce(v_ctam02_fin, 'z'))
and (ctam03 >= coalesce(v_ctam03_ini, '0'))
and (ctam03 <= coalesce(v_ctam03_fin, 'z'))
and (tipo >= coalesce(v_tipo_ini, '0'))
and (tipo <= coalesce(v_tipo_fin, 'z'))
and (division >= coalesce(v_division_ini, 0))
and (division <= coalesce(v_division_fin, 9999))
and (rubro >= coalesce(v_rubro_ini, 0))
and (rubro <= coalesce(v_rubro_fin, 9999))
and		coalesce(cla_fe_id, '|') = '|';
end loop;
close cursor_clasificacion_fe;
---- se inserta en la tabla q contiene el reporte propiamente ----
insert into fecxp_rep_ppto_soin(cod_empresa, des_empresa, cla_id_fe, cla_fe_des, rubro, orden_id, id_sesion, periodo, mes, moneda,
tipo_cambio, importe_linea, ctam01, ctam02, ctam03, cg13di, cg13ru, ctatip)
select   ps.e_codigo, e.des_empresa, c.cla_fe_id, cfe.cla_fe_des, cfe.cla_atributo2, cfe.cla_atributo1, v_id_sesion, ps.periodo, ps.mescod, m.mon_oracle, m.tipo_cambio, ps.importe_linea, c.ctam01, c.ctam02, c.ctam03, c.division, c.rubro, c.tipo
from   fecxc_empresas e,
fecxp_clasificacion_fe cfe,
fecxp_cuentas_soin_caratula c,
fecxp_ppto_conversion_soin ps,
fecxp_monedas m
where ps.periodo_extraccion = v_periodo
and ps.mes_extraccion = v_mes
and m.mes = ps.mescod
and	e.e_codigo = c.e_codigo
and	e.e_codigo = ps.e_codigo
and	cfe.cla_fe_id = c.cla_fe_id
and m.mon_sybase = ps.moneda
and	c.ctam01 = ps.arsmap
and c.ctam02 = ps.aejmap
and c.ctam03 = ps.cncmap;
end;
$body$
language plpgsql
;
