create or replace procedure fecxc.fecxp_caratula_pkg_forecast () as $body$
declare
-- pgv moved types start
-- pgv moved types end
/******************************************************************************************************************************
*
*    ojo este proceso depende que se haya ejecutado el proceso de calculo de reales, esto en este proceso no se controla
*	la elminacion de registros de la estructura fecxp_real_caratula
*
*******************************************************************************************************************************/
v_periodo integer:= (to_char(clock_timestamp(), 'YYYY'))::numeric;
v_mes	integer:= 1;
v_mes_saldo integer;
v_id_sesion varchar(25) := to_char(clock_timestamp(),'DD-MM-YYYY');
v_fec_ant timestamp(0);
v_fin integer;
v_mes_act integer := (to_char(clock_timestamp(), 'MM'))::numeric;
v_cla_fe_id fecxp_politicas_erp.cla_fe_id%type;
v_politica_erp_id fecxp_politicas_erp.politica_erp_id%type;
v_prioridad fecxp_politicas_erp.prioridad%type;
v_ora_s1_ini fecxp_politicas_erp.oracle_segmento1_ini%type;
v_ora_s1_fin fecxp_politicas_erp.oracle_segmento1_fin%type;
v_ora_s2_ini fecxp_politicas_erp.oracle_segmento2_ini%type;
v_ora_s2_fin fecxp_politicas_erp.oracle_segmento2_fin%type;
v_ora_s3_ini fecxp_politicas_erp.oracle_segmento3_ini%type;
v_ora_s3_fin fecxp_politicas_erp.oracle_segmento3_fin%type;
v_ora_s4_ini fecxp_politicas_erp.oracle_segmento4_ini%type;
v_ora_s4_fin fecxp_politicas_erp.oracle_segmento4_fin%type;
v_ora_s5_ini fecxp_politicas_erp.oracle_segmento5_ini%type;
v_ora_s5_fin fecxp_politicas_erp.oracle_segmento5_fin%type;
v_ora_s6_ini fecxp_politicas_erp.oracle_segmento6_ini%type;
v_ora_s6_fin fecxp_politicas_erp.oracle_segmento6_fin%type;
v_ora_s7_ini fecxp_politicas_erp.oracle_segmento7_ini%type;
v_ora_s7_fin fecxp_politicas_erp.oracle_segmento7_fin%type;
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
v_errores integer;
cursor_clasificacion_fe_oracle cursor for
select	 cla_fe_id, politica_erp_id, prioridad, oracle_segmento1_ini, oracle_segmento1_fin, oracle_segmento2_ini, oracle_segmento2_fin, oracle_segmento3_ini, oracle_segmento3_fin, oracle_segmento4_ini, oracle_segmento4_fin, oracle_segmento5_ini, oracle_segmento5_fin, oracle_segmento6_ini, oracle_segmento6_fin, oracle_segmento7_ini, oracle_segmento7_fin
from	 fecxp_politicas_erp
order by prioridad asc;
cursor_clasificacion_fe_soin cursor for
select	 cla_fe_id, politica_soin_id, prioridad, e_codigo_ini, e_codigo_fin, ctam01_ini, ctam01_fin, ctam02_ini, ctam02_fin, ctam03_ini, ctam03_fin, tipo_ini, tipo_fin, division_ini, division_fin, rubro_ini, rubro_fin
from	 fecxp_politicas_soin
order by prioridad asc;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
begin
--== cargamos las cuentas contables que generaron movimiento durante el mes  ==--
insert	into fecxp_cuentas_erp_caratula(cla_fe_id, e_codigo, oracle_segmento1, oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6, oracle_segmento7)
select	distinct '|'as cla_id, e_codigo, oracle_segmento1, oracle_segmento2, oracle_segmento3,oracle_segmento4, oracle_segmento5, oracle_segmento6, oracle_segmento7
from	fecxp_ppto_conversion_erp
where	periodo_extraccion = v_periodo
and		mes_extraccion = v_mes_act
and		periodo = v_periodo;
exception
when no_data_found then
v_errores :=1;
end;
begin
insert	into fecxp_cuentas_soin_caratula(cla_fe_id, e_codigo, ctam01, ctam02, ctam03, division, rubro)
select	distinct '|' as cla_id, ps.e_codigo, ps.arsmap, ps.aejmap, ps.cncmap, 0, 0
from	fecxp_ppto_conversion_soin ps
where	ps.periodo_extraccion = v_periodo
and 	ps.mes_extraccion = v_mes_act;
exception
when no_data_found then
v_errores :=1;
end;
begin
update	fecxp_cuentas_soin_caratula c1
set		division = 	(
select	c2.cg13di
from	fecxp_cat_cuentas_soin c2
where   c1.ctam01 = c2.ctam01
and		c1.ctam02 = c2.ctam02
and		c1.ctam03 = c2.ctam03
),
rubro = (
select	c2.cg13ru
from	fecxp_cat_cuentas_soin c2
where   c1.ctam01 = c2.ctam01
and		c1.ctam02 = c2.ctam02
and		c1.ctam03 = c2.ctam03
)
where	exists (
select	c2.cg13ru
from	fecxp_cat_cuentas_soin c2
where   c1.ctam01 = c2.ctam01
and		c1.ctam02 = c2.ctam02
and		c1.ctam03 = c2.ctam03
);
exception
when no_data_found then
v_errores :=1;
end;
--==  clasificacion de cuentas sesgun politicas de clasificacion de fe ==--
open  cursor_clasificacion_fe_oracle;
loop
fetch cursor_clasificacion_fe_oracle
into  v_cla_fe_id, v_prioridad, v_politica_erp_id, v_ora_s1_ini, v_ora_s1_fin, v_ora_s2_ini, v_ora_s2_fin, v_ora_s3_ini, v_ora_s3_fin, v_ora_s4_ini, v_ora_s4_fin, v_ora_s5_ini, v_ora_s5_fin, v_ora_s6_ini, v_ora_s6_fin, v_ora_s7_ini, v_ora_s7_fin;
exit when not found; /* apply on cursor_clasificacion_fe_oracle */
begin
--== clasificacion de cuentas contables erp ==--
update	fecxp_cuentas_erp_caratula
set		cla_fe_id = v_cla_fe_id
where (oracle_segmento1 >= coalesce(v_ora_s1_ini, '0'))
and (oracle_segmento1 <= coalesce(v_ora_s1_fin, 'z'))
and (oracle_segmento2 >= coalesce(v_ora_s2_ini, '0'))
and (oracle_segmento2 <= coalesce(v_ora_s2_fin, 'z'))
and (oracle_segmento3 >= coalesce(v_ora_s3_ini, '0'))
and (oracle_segmento3 <= coalesce(v_ora_s3_fin, 'z'))
and (oracle_segmento4 >= coalesce(v_ora_s4_ini, '0'))
and (oracle_segmento4 <= coalesce(v_ora_s4_fin, 'z'))
and (oracle_segmento5 >= coalesce(v_ora_s5_ini, '0'))
and (oracle_segmento5 <= coalesce(v_ora_s5_fin, 'z'))
and (oracle_segmento6 >= coalesce(v_ora_s6_ini, '0'))
and (oracle_segmento6 <= coalesce(v_ora_s6_fin, 'z'))
and (oracle_segmento7 >= coalesce(v_ora_s7_ini, '0'))
and (oracle_segmento7 <= coalesce(v_ora_s7_fin, 'z'))
and		coalesce(cla_fe_id, '|') = '|';
exception
when no_data_found then
v_errores :=1;
end;
end loop;
close cursor_clasificacion_fe_oracle;
--== clasificacion flujo de efectivo para soin ==--
open  cursor_clasificacion_fe_soin;
loop
fetch cursor_clasificacion_fe_soin
into  v_cla_fe_id, v_politica_soin_id, v_prioridad, v_e_codigo_ini, v_e_codigo_fin, v_ctam01_ini, v_ctam01_fin, v_ctam02_ini, v_ctam02_fin, v_ctam03_ini, v_ctam03_fin, v_tipo_ini, v_tipo_fin, v_division_ini, v_division_fin, v_rubro_ini, v_rubro_fin;
exit when not found; /* apply on cursor_clasificacion_fe_soin */
begin
--== se clasifican las cuentas de soin ==--
update	fecxp_cuentas_soin_caratula
set		cla_fe_id = v_cla_fe_id
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
and		coalesce(cla_fe_id, '|') = '|';
exception
when no_data_found then
v_errores :=1;
end;
end loop;
close cursor_clasificacion_fe_soin;
/******************************************************************************************************/
--== forecast ==--
-------------------------------------------oracle---------------------------------
begin
--== se insertan los movimientos de las cuentas contables erp ==--
insert into fecxp_ppto_conv_erp_tmp
select	e.e_codigo, e.des_empresa, pp.periodo, pp.mes, pp.moneda, m.tipo_cambio,
pp.oracle_segmento1, pp.oracle_segmento2, pp.oracle_segmento3, pp.oracle_segmento4, pp.oracle_segmento5
,pp.oracle_segmento6,pp.oracle_segmento7,
sum(pp.importe_linea)
from	fecxp_ppto_conversion_erp pp,
fecxc_empresas e,
fecxp_monedas m
where	pp.periodo_extraccion = v_periodo
and		pp.mes_extraccion = v_mes_act
and		pp.mes >= v_mes_act
and		m.mes = pp.mes
and		m.mon_oracle = pp.moneda
and		e.e_codigo = pp.e_codigo
group by e.e_codigo, e.des_empresa, pp.periodo, pp.mes, pp.moneda, m.tipo_cambio,
pp.oracle_segmento1, pp.oracle_segmento2, pp.oracle_segmento3, pp.oracle_segmento4, pp.oracle_segmento5
,pp.oracle_segmento6,pp.oracle_segmento7;
exception
when no_data_found then
v_errores :=1;
end;
begin
insert into fecxp_real_caratula(e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des, importe_linea)
select	a.e_codigo, a.des_empresa,  v_id_sesion, a.periodo, a.mes,
a.moneda, a.tipo_cambio, b.cla_fe_id, oracle.substr(b.cla_fe_des, 1, 25) cla_fe_des, sum(a.importe_linea)
from fecxp_ppto_conv_erp_tmp a, (select c.e_codigo, b.cla_fe_id, b.cla_fe_des, b.cla_atributo3 , c.oracle_segmento1, c.oracle_segmento2, c.oracle_segmento3,
c.oracle_segmento4, c.oracle_segmento5, c.oracle_segmento6, c.oracle_segmento7
from fecxp_clasificacion_fe b, fecxp_cuentas_erp_caratula c
where b.cla_fe_id = c.cla_fe_id) b
where a.e_codigo = b.e_codigo
and a.oracle_segmento1 = b.oracle_segmento1
and a.oracle_segmento2 = b.oracle_segmento2
and a.oracle_segmento3 = b.oracle_segmento3
and a.oracle_segmento4 = b.oracle_segmento4
and a.oracle_segmento5 = b.oracle_segmento5
and a.oracle_segmento6 = b.oracle_segmento6
and a.oracle_segmento7 = b.oracle_segmento7
group by a.e_codigo, a.des_empresa,   a.periodo, a.mes,
a.moneda, a.tipo_cambio, b.cla_fe_id, oracle.substr(b.cla_fe_des, 1, 25);
exception
when no_data_found then
v_errores :=1;
end;
-------------------------------------------soin---------------------------------
begin
--== se insertan los registros de las cuentas q generaron fe ==--
insert into fecxp_ppto_conv_soin_tmp
select	ps.e_codigo, e.des_empresa, ps.periodo, ps.mescod, m.mon_oracle, m.tipo_cambio, sum(ps.importe_linea),
arsmap, aejmap, cncmap, ctacr1, ctacr2
from	fecxp_ppto_conversion_soin ps,
fecxc_empresas e,
fecxp_monedas m
where	ps.periodo_extraccion = v_periodo
and		ps.mes_extraccion = v_mes_act
and		ps.mescod >= v_mes_act
and		e.e_codigo = ps.e_codigo
and		m.mes = ps.mescod
and		m.mon_sybase = ps.moneda
group by ps.e_codigo, e.des_empresa, ps.periodo, ps.mescod, m.mon_oracle, m.tipo_cambio, arsmap, aejmap, cncmap, ctacr1, ctacr2;
exception
when no_data_found then
v_errores :=1;
end;
begin
insert	into fecxp_real_caratula(e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des, importe_linea)
select	a.e_codigo, a.des_empresa, v_id_sesion, a.periodo, a.mescod, a.mon_oracle, a.tipo_cambio, b.cla_fe_id, oracle.substr(b.cla_fe_des, 1, 25), sum(a.importe_linea)
from fecxp_ppto_conv_soin_tmp a, (select c.e_codigo, b.cla_fe_id, b.cla_atributo3,b.cla_fe_des,  c.ctam01, c.ctam02, c.ctam03
from fecxp_clasificacion_fe b, fecxp_cuentas_soin_caratula c
where b.cla_fe_id = c.cla_fe_id) b
where a.e_codigo = b.e_codigo
and a.ctam01 = b.ctam01
and a.ctam02  = b.ctam02
and a.ctam03  = b.ctam03
group by a.e_codigo, a.des_empresa, a.periodo, a.mescod, a.mon_oracle, a.tipo_cambio, b.cla_fe_id, oracle.substr(b.cla_fe_des, 1, 25);
exception
when no_data_found then
v_errores :=1;
end;
begin
--== inserta los registros importados ==--
insert	into fecxp_real_caratula(
e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des, importe_linea, estatus)
select	e.e_codigo, e.des_empresa, v_id_sesion, (to_char(d.fecha, 'YYYY'))::numeric , d.mes, d.moneda_imp, m.tipo_cambio, c.cla_fe_id, oracle.substr(c.cla_fe_des, 1, 25), (c.cla_atributo3)::numeric  * d.importe_linea, 'IMPORTADO'
from	fecxp_monedas m,
fecxc_empresas e,
fecxp_clasificacion_fe c,
fecxp_importacion_datos_hist d
where	(to_char(d.fecha, 'YYYY'))::numeric  = v_periodo
and		d.mes >= v_mes_act
and		d.estatus_origen = 'IMPORTADO'
and		d.tipo_importacion in ('P')
and		e.e_codigo = d.e_empresa_imp
and		m.mon_oracle = d.moneda_imp
and		m.mes = d.mes
and		c.cla_fe_id = d.cla_fe_id_imp;
exception
when no_data_found then
v_errores :=1;
end;
--== inserta los saldos iniciales ==--
------------------------------------------------------------------------------
------------------------------------------------------------------------------
loop
--== calcula e inserta saldos ==--
begin
--== calcula de saldos finales para las empresas que hayan generado fe ==--
insert	into fecxp_real_caratula(
e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des, importe_linea)
select	e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, 'SF', 'SALDO FINAL', sum(importe_linea)
from	fecxp_clasificacion_fe cf,
fecxp_real_caratula c
where	c.periodo = v_periodo
and		cf.genera_saldo = 1
and		cf.cla_fe_id = c.cla_fe_id
and		mes = v_mes_act
group by c.e_codigo, c.des_empresa, c.id_sesion_rc, c.periodo, c.mes, c.moneda, c.tipo_cambio;
exception
when no_data_found then
v_errores :=1;
end;
begin
-- inserta el saldo inicial del siguiente mes
insert	into fecxp_real_caratula(
e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des, importe_linea)
select	e_codigo, des_empresa, id_sesion_rc,
case when mes = 12 then periodo::numeric + 1 else periodo end,
case when mes = 12 then 1 else mes::numeric + 1 end, moneda, tipo_cambio,
'SI', 'SALDO INICIAL', importe_linea
from	fecxp_real_caratula
where	periodo = v_periodo
and		cla_fe_id = 'SF'
and		mes = v_mes_act;
exception
when no_data_found then
v_errores :=1;
end;
v_mes_act := v_mes_act + 1;
exit when v_mes_act = 11;
end loop;end;
$body$
language plpgsql
;
