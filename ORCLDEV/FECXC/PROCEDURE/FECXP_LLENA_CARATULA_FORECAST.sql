create or replace procedure fecxc."fecxp_llena_caratula_forecast"  ( v_mes_desde integer, v_periodo integer, v_version_fe_erp integer, v_version_fe_soin integer, v_version_fe_imp varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_e_codigo integer;
v_id_sesion varchar(25) := to_char(clock_timestamp(),'DD-MM-YYYY');
v_mes_act integer:= v_mes_desde;
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
v_ctacr1_ini fecxp_politicas_soin.ctacr1_ini%type;
v_ctacr1_fin fecxp_politicas_soin.ctacr1_fin%type;
v_ctacr2_ini fecxp_politicas_soin.ctacr2_ini%type;
v_ctacr2_fin fecxp_politicas_soin.ctacr2_fin%type;
v_tipo_operacion_ini fecxp_politicas_erp.tipo_operacion_ini%type;
v_tipo_operacion_fin fecxp_politicas_erp.tipo_operacion_fin%type;
cursor_clasificacion_fe_oracle cursor for
select	 cla_fe_id, politica_erp_id, prioridad, oracle_segmento1_ini, oracle_segmento1_fin, oracle_segmento2_ini, oracle_segmento2_fin, oracle_segmento3_ini, oracle_segmento3_fin, oracle_segmento4_ini, oracle_segmento4_fin, oracle_segmento5_ini, oracle_segmento5_fin, oracle_segmento6_ini, oracle_segmento6_fin, oracle_segmento7_ini, oracle_segmento7_fin
from	 fecxp_politicas_erp
where	id_tipo_movto in ('A', 'E')
and		activa_regla = 1
and		coalesce(tipo_operacion_ini, 0) = 0
and		coalesce(tipo_operacion_fin, 0) = 0
and		coalesce(id_banco_ini, 0) = 0
and		coalesce(id_banco_fin, 0) = 0
and		coalesce(lpad(id_chequera_ini::text, 20, '0'::text), '00000000000000000000') = '00000000000000000000'
and		coalesce(lpad(id_chequera_fin::text, 20, '0'::text), '00000000000000000000') = '00000000000000000000'
order by prioridad asc;
cursor_clasificacion_fe_soin cursor for
select	cla_fe_id, politica_soin_id, prioridad, e_codigo_ini, e_codigo_fin, ctam01_ini, ctam01_fin, ctam02_ini, ctam02_fin, ctam03_ini, ctam03_fin, division_ini, division_fin, rubro_ini, rubro_fin, ctacr1_ini, ctacr1_fin, ctacr2_ini, ctacr2_fin
from	fecxp_politicas_soin
where	id_tipo_movto in ('A', 'E')
and		activa_regla = 1
and		coalesce(tipo_operacion_ini, 0) = 0
and		coalesce(tipo_operacion_fin, 0) = 0
and		coalesce(id_banco_ini, 0) = 0
and		coalesce(id_banco_fin, 0) = 0
and		coalesce(lpad(id_chequera_ini::text, 20, '0'::text), '00000000000000000000') = '00000000000000000000'
and		coalesce(lpad(id_chequera_fin::text, 20, '0'::text), '00000000000000000000') = '00000000000000000000'
order by prioridad asc;
begin 

/* dmap converted statement start */
/*modif. mayo 2009 excluir las claves de intereses, iva e isr de los saldos finales de coinversion e inversion*/
/*modif. abril 2009 debido a carat coinv e inversion*/
/******************************************************************************************************************************
*
*    ojo este proceso depende que se haya ejecutado el proceso de calculo de reales.
una vez ejecutado, se puede correr cuantas veces se quiera
*
*******************************************************************************************************************************/
delete	from fecxp_real_caratula c
where	c.e_codigo = coalesce(v_e_codigo, c.e_codigo)
and		to_date( concat(to_char(c.periodo), lpad(c.mes::text, 2, '0'::text) , '01') , 'YYYYMMDD') >= to_date( concat(v_periodo, lpad(v_mes_desde::text, 2, '0'::text) , '01') , 'YYYYMMDD')
;/* dmap converted statement end */
--== mete el saldo inicial ==--
insert	into fecxp_real_caratula(
e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des, importe_linea, tipo_caratula)
select	c.e_codigo, c.des_empresa, c.id_sesion_rc,
c.periodo,
c.mes + 1,
c.moneda, c.tipo_cambio,
'SI', 'SALDO INICIAL', c.importe_linea, c.tipo_caratula
from	fecxp_real_caratula c
where	c.e_codigo = coalesce(v_e_codigo, c.e_codigo)
and		c.periodo = v_periodo
and		c.mes = v_mes_desde - 1
and		v_mes_desde <> 1
and		c.cla_fe_id = 'SF'
;
--== cargamos las cuentas contables que generaron movimiento durante el mes  ==--
insert	into fecxp_cuentas_erp_caratula(
cla_fe_id, e_codigo, oracle_segmento1, oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6, oracle_segmento7)
select	distinct '|'as cla_fe_id, p.e_codigo, p.oracle_segmento1, p.oracle_segmento2, p.oracle_segmento3, p.oracle_segmento4, p.oracle_segmento5, p.oracle_segmento6, p.oracle_segmento7
from	fecxp_ppto_conversion_erp p,
fecxc_empresas e
where	p.version_fe = v_version_fe_erp
and		p.mes >= v_mes_desde
and		e.e_codigo = p.e_codigo
and		e.cual_erp = 'O'
and		p.e_codigo = coalesce(v_e_codigo, p.e_codigo);
insert	into fecxp_ctas_soin_caratula_tmp(cla_fe_id, e_codigo, ctam01, ctam02, ctam03, division, rubro, ctacr1, ctacr2)
select	distinct '|' as cla_fe_id, ps.e_codigo, ps.arsmap, ps.aejmap, ps.cncmap, 0, 0, ps.ctacr1, ps.ctacr2
from	fecxp_ppto_conversion_soin ps,
fecxc_empresas e
where	ps.version_fe = v_version_fe_soin
and		ps.mescod >= v_mes_desde
and		e.e_codigo = ps.e_codigo
and		e.cual_erp = 'S'
and		ps.e_codigo = coalesce(v_e_codigo, ps.e_codigo);
update	fecxp_ctas_soin_caratula_tmp c1
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
--==  clasificacion de cuentas sesgun politicas de clasificacion de fe ==--
open  cursor_clasificacion_fe_oracle;
loop
fetch	cursor_clasificacion_fe_oracle
into	v_cla_fe_id, v_politica_erp_id, v_prioridad, v_ora_s1_ini, v_ora_s1_fin, v_ora_s2_ini, v_ora_s2_fin, v_ora_s3_ini, v_ora_s3_fin, v_ora_s4_ini, v_ora_s4_fin, v_ora_s5_ini, v_ora_s5_fin, v_ora_s6_ini, v_ora_s6_fin, v_ora_s7_ini, v_ora_s7_fin;
exit when not found; /* apply on cursor_clasificacion_fe_oracle */
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
end loop;
close cursor_clasificacion_fe_oracle;
--== clasificacion flujo de efectivo para soin ==--
open  cursor_clasificacion_fe_soin;
loop
fetch cursor_clasificacion_fe_soin
into  v_cla_fe_id, v_politica_soin_id, v_prioridad, v_e_codigo_ini, v_e_codigo_fin, v_ctam01_ini, v_ctam01_fin, v_ctam02_ini, v_ctam02_fin, v_ctam03_ini, v_ctam03_fin, v_division_ini, v_division_fin, v_rubro_ini, v_rubro_fin, v_ctacr1_ini, v_ctacr1_fin, v_ctacr2_ini, v_ctacr2_fin;
exit when not found; /* apply on cursor_clasificacion_fe_soin */
-- clasificacion de cuentas contables erp.
update	fecxp_ctas_soin_caratula_tmp
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
and (lpad(ctacr1::text, 4, '0'::text) >= coalesce(lpad(v_ctacr1_ini::text, 4, '0'::text), '0000'))
and (lpad(ctacr1::text, 4, '0'::text) <= coalesce(lpad(v_ctacr1_fin::text, 4, '0'::text), 'zzzz'))
and (lpad(ctacr2::text, 4, '0'::text) >= coalesce(lpad(v_ctacr2_ini::text, 4, '0'::text), '0000'))
and (lpad(ctacr2::text, 4, '0'::text) <= coalesce(lpad(v_ctacr2_fin::text, 4, '0'::text), 'zzzz'))
and		coalesce(cla_fe_id, '|') = '|';
end loop;
close cursor_clasificacion_fe_soin;
-- ******************************************************************************************************
--== forecast ==--
-------------------------------------------oracle---------------------------------
--== se insertan los movimientos de las cuentas contables erp ==--
insert into fecxp_ppto_conv_erp_tmp
select	e.e_codigo, e.des_empresa, v_periodo, pp.mes, pp.moneda, m.tipo_cambio,
pp.oracle_segmento1, pp.oracle_segmento2, pp.oracle_segmento3, pp.oracle_segmento4, pp.oracle_segmento5
,pp.oracle_segmento6,pp.oracle_segmento7,
sum(pp.importe_linea)
from	fecxp_ppto_conversion_erp pp,
fecxc_empresas e,
fecxp_monedas m
where	pp.version_fe = v_version_fe_erp
and		pp.mes >= v_mes_desde
and		m.mes = pp.mes
and		m.periodo = pp.periodo
and		m.mon_oracle = pp.moneda
and		e.e_codigo = pp.e_codigo
and		e.cual_erp = 'O'
and		e.e_codigo = coalesce(v_e_codigo, e.e_codigo)
group by e.e_codigo, e.des_empresa, pp.mes, pp.moneda, m.tipo_cambio,
pp.oracle_segmento1, pp.oracle_segmento2, pp.oracle_segmento3, pp.oracle_segmento4, pp.oracle_segmento5
,pp.oracle_segmento6,pp.oracle_segmento7;
insert	into fecxp_real_caratula(e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des, importe_linea, tipo_caratula)
select	a.e_codigo, a.des_empresa,  v_id_sesion, v_periodo, a.mes,
a.moneda, a.tipo_cambio, b.cla_fe_id, oracle.substr(b.cla_fe_des, 1, 25) cla_fe_des, sum(a.importe_linea * (b.cla_atributo5::numeric)::numeric ), 'CH'
from	fecxp_ppto_conv_erp_tmp a,
(
select	c.e_codigo, b.cla_fe_id, b.cla_fe_des, b.cla_atributo5 , c.oracle_segmento1, c.oracle_segmento2, c.oracle_segmento3,
c.oracle_segmento4, c.oracle_segmento5, c.oracle_segmento6, c.oracle_segmento7
from	fecxp_clasificacion_fe b, fecxp_cuentas_erp_caratula c
where	b.cla_fe_id = c.cla_fe_id
and		c.e_codigo = coalesce(v_e_codigo, c.e_codigo)
) b
where	a.e_codigo = b.e_codigo
and		a.oracle_segmento1 = b.oracle_segmento1
and		a.oracle_segmento2 = b.oracle_segmento2
and		a.oracle_segmento3 = b.oracle_segmento3
and		a.oracle_segmento4 = b.oracle_segmento4
and		a.oracle_segmento5 = b.oracle_segmento5
and		a.oracle_segmento6 = b.oracle_segmento6
and		a.oracle_segmento7 = b.oracle_segmento7
group by a.e_codigo, a.des_empresa, a.mes,
a.moneda, a.tipo_cambio, b.cla_fe_id, oracle.substr(b.cla_fe_des, 1, 25);
insert	into fecxp_real_caratula(e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des, importe_linea,tipo_caratula)
select	ps.e_codigo, e.des_empresa, v_id_sesion, v_periodo, ps.mescod, m.mon_oracle, m.tipo_cambio, c.cla_fe_id, oracle.substr(cf.cla_fe_des, 1, 25), sum(ps.importe_linea * (cf.cla_atributo5::numeric)::numeric ), 'CH'
from	fecxp_ctas_soin_caratula_tmp c,
fecxp_ppto_conversion_soin ps,
fecxc_empresas e,
fecxp_monedas m,
fecxp_clasificacion_fe cf
where	ps.version_fe = v_version_fe_soin
and		ps.mescod >= v_mes_desde
and		cf.cla_fe_id = c.cla_fe_id
and		e.e_codigo = ps.e_codigo
and		m.mes = ps.mescod
and		m.periodo = ps.periodo
and		m.mon_sybase = ps.moneda
and		ps.e_codigo = c.e_codigo
and		ps.arsmap = c.ctam01
and		ps.aejmap  = c.ctam02
and		ps.cncmap  = c.ctam03
and		ps.ctacr1 = c.ctacr1
and		ps.ctacr2 = c.ctacr2
and		e.cual_erp = 'S'
and		ps.e_codigo = coalesce(v_e_codigo, ps.e_codigo)
group by ps.e_codigo, e.des_empresa, ps.mescod, m.mon_oracle, m.tipo_cambio, c.cla_fe_id, oracle.substr(cf.cla_fe_des, 1, 25);
--== inserta los registros importados ==--
insert	into fecxp_real_caratula(
e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des, importe_linea, estatus, tipo_caratula)
select	e.e_codigo, e.des_empresa, v_id_sesion, v_periodo, d.mes, d.moneda_imp, m.tipo_cambio, c.cla_fe_id, oracle.substr(c.cla_fe_des, 1, 25), (c.cla_atributo5)::numeric  * d.importe_linea, 'IMPORTADO',
case when c.cla_fe_id in ('SI COIN','SF COIN','INGCOIN','EGRCOIN') then 'CO'
when c.cla_fe_id in ('SI INV','SF INV','INGINV','EGRINV') then 'IN'
else 'CH'
end tipo_caratula
from	fecxp_monedas m,
fecxc_empresas e,
fecxp_clasificacion_fe c,
fecxp_importacion_datos_hist d
where	d.mes >= v_mes_desde
and		d.tipo_importacion in ('P')
and		d.atributo_3 = v_version_fe_imp
and		e.e_codigo = d.e_empresa_imp
and		m.mon_oracle = d.moneda_imp
and		m.mes = d.mes
and		m.periodo = (to_char(d.fecha, 'YYYY'))::numeric
and		c.cla_fe_id = d.cla_fe_id_imp
and		d.e_empresa_imp = coalesce(v_e_codigo, d.e_empresa_imp);
--== inserta los saldos iniciales ==--
------------------------------------------------------------------------------
------------------------------------------------------------------------------
---coinversion e inversion
insert	into fecxp_real_caratula(
e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des, importe_linea, tipo_caratula)
select	c.e_codigo, c.des_empresa, c.id_sesion_rc,
c.periodo,
c.mes + 1,
c.moneda, c.tipo_cambio,
'SI COIN', 'SDO INICIAL COINVERSION', c.importe_linea, 'CO'
from	fecxp_real_caratula c
where	c.e_codigo = coalesce(v_e_codigo, c.e_codigo)
and		c.periodo = v_periodo
and		c.mes = v_mes_desde - 1
and		v_mes_desde <> 1
and		c.cla_fe_id = 'SF COIN'
;
insert	into fecxp_real_caratula(
e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des, importe_linea, tipo_caratula)
select	c.e_codigo, c.des_empresa, c.id_sesion_rc,
c.periodo,
c.mes + 1,
c.moneda, c.tipo_cambio,
'SI INV', 'SDO INICIAL INVERSION', c.importe_linea, 'IN'
from	fecxp_real_caratula c
where	c.e_codigo = coalesce(v_e_codigo, c.e_codigo)
and		c.periodo = v_periodo
and		c.mes = v_mes_desde - 1
and		v_mes_desde <> 1
and		c.cla_fe_id = 'SF INV'
;
--== calcula e inserta saldos ==--
v_mes_act:= v_mes_desde;
/*
insert into fecxp_real_caratula (
e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des, importe_linea, estatus)
select	p.e_codigo, e.des_empresa, v_id_sesion, p.periodo, p.mes, p.moneda, m.tipo_cambio, p.cla_fe_id, c.cla_fe_des, to_number (c.cla_atributo5) * (p.importe_ing01 + p.importe_egr01) diferencia, 'CALCULADO'
from	(
select	pi.e_codigo, 'EGR01' cla_fe_id, pi.periodo, pi.mes, pi.moneda,
pi.importe_linea importe_ing01,
pe.importe_linea importe_egr01
from
(
select	pi.e_codigo, pi.periodo, pi.mes, pi.moneda, sum (pi.importe_linea) importe_linea
from	fecxp_real_caratula pi
where	pi.cla_fe_id = 'ING01'
group by pi.e_codigo, pi.periodo, pi.mes, pi.moneda
) pi,
(
select	pe.e_codigo, pe.periodo, pe.mes, pe.moneda, sum (pe.importe_linea) importe_linea
from	fecxp_real_caratula pe
where	pe.cla_fe_id = 'EGR01'
group by pe.e_codigo, pe.periodo, pe.mes, pe.moneda
) pe
where	pi.e_codigo = pe.e_codigo
and		pi.periodo = pe.periodo
and		pi.mes = pe.mes
and		pi.moneda = pe.moneda
union all
select	pi.e_codigo, 'EGR01' cla_fe_id, pi.periodo, pi.mes, pi.moneda,
pi.importe_linea importe_ing01, 0
from	(
select	pi.e_codigo, pi.periodo, pi.mes, pi.moneda, pi.importe_linea
from	fecxp_real_caratula pi
where	pi.cla_fe_id = 'ING01'
and		not exists (
select	pe.e_codigo, pe.periodo, pe.mes, pe.moneda, sum (pe.importe_linea) importe_linea
from	fecxp_real_caratula pe
where	pe.cla_fe_id = 'EGR01'
and		pi.e_codigo = pe.e_codigo
and		pi.periodo = pe.periodo
and		pi.mes = pe.mes
and		pi.moneda = pe.moneda
group by pe.e_codigo, pe.periodo, pe.mes, pe.moneda
)
) pi
union all
select	pe.e_codigo, 'ING01' cla_fe_id, pe.periodo, pe.mes, pe.moneda,
0, -1 * pe.importe_linea importe_egr01
from
(
select	pe.e_codigo, pe.periodo, pe.mes, pe.moneda, 0, pe.importe_linea
from	fecxp_real_caratula pe
where	pe.cla_fe_id = 'EGR01'
and		not exists (
select	pi.e_codigo, pi.periodo, pi.mes, pi.moneda, sum (pi.importe_linea) importe_linea
from	fecxp_real_caratula pi
where	pi.cla_fe_id = 'ING01'
and		pi.e_codigo = pe.e_codigo
and		pi.periodo = pe.periodo
and		pi.mes = pe.mes
and		pi.moneda = pe.moneda
group by pi.e_codigo, pi.periodo, pi.mes, pi.moneda
)
) pe
) p,
fecxp_monedas m,
fecxc_empresas e,
fecxp_clasificacion_fe c
where	m.periodo = v_periodo
and		m.mes >= v_mes_desde
and		p.e_codigo = e.e_codigo
and		m.mon_oracle = p.moneda
and		m.mes = p.mes
and		m.periodo = p.periodo
and		c.cla_fe_id = p.cla_fe_id
and		e.e_codigo = nvl (v_e_codigo, e.e_codigo);
*/
loop
--== calcula de saldos finales para las empresas que hayan generado fe ==--
insert	into fecxp_real_caratula(
e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des, importe_linea, tipo_caratula)
select	e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, 'SF', 'SALDO FINAL', sum(importe_linea), 'CH'
from	fecxp_clasificacion_fe cf,
fecxp_real_caratula c
where	c.periodo = v_periodo
and		c.mes = v_mes_act
and		cf.genera_saldo = 1
and		cf.cla_fe_id = c.cla_fe_id
and		cf.cla_fe_id not in ('SF', 'SF INV', 'SF COIN','SI COIN', 'SI INV','INGCOIN','EGRCOIN','INGINV','EGRINV')
and		c.tipo_caratula ='CH'
and		c.e_codigo = coalesce(v_e_codigo, c.e_codigo)
group by c.e_codigo, c.des_empresa, c.id_sesion_rc, c.periodo, c.mes, c.moneda, c.tipo_cambio;
---coinversion e inversion
insert	into fecxp_real_caratula(
e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des, importe_linea, tipo_caratula)
select	e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, 'SF COIN', 'SDO FINAL COINVERSION', sum(coalesce(importe_linea,0)), 'CO'
from	fecxp_clasificacion_fe cf,
fecxp_real_caratula c
where	c.periodo = v_periodo
and		c.mes = v_mes_act
and		cf.cla_fe_id = c.cla_fe_id
and		cf.cla_fe_id in ('SI COIN','INGCOIN','EGRCOIN')
and		c.e_codigo = coalesce(v_e_codigo, c.e_codigo)
group by c.e_codigo, c.des_empresa, c.id_sesion_rc, c.periodo, c.mes, c.moneda, c.tipo_cambio;
insert	into fecxp_real_caratula(
e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des, importe_linea, tipo_caratula)
select	e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, 'SF INV', 'SDO FINAL INVERSION', sum(coalesce(importe_linea,0)), 'IN'
from	fecxp_clasificacion_fe cf,
fecxp_real_caratula c
where	c.periodo = v_periodo
and		c.mes = v_mes_act
and		cf.cla_fe_id = c.cla_fe_id
and		cf.cla_fe_id in ('SI INV','INGINV','EGRINV')
and		c.e_codigo = coalesce(v_e_codigo, c.e_codigo)
group by c.e_codigo, c.des_empresa, c.id_sesion_rc, c.periodo, c.mes, c.moneda, c.tipo_cambio;
-- inserta el saldo inicial del siguiente mes
insert	into fecxp_real_caratula(
e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des, importe_linea, tipo_caratula)
select	e_codigo, des_empresa, id_sesion_rc,
case when mes = 12 then periodo::numeric + 1 else periodo end,
case when mes = 12 then 1 else mes::numeric + 1 end, moneda, tipo_cambio,
'SI', 'SALDO INICIAL', importe_linea, tipo_caratula
from	fecxp_real_caratula
where	periodo = v_periodo
and		mes = v_mes_act
and		cla_fe_id = 'SF'
and		tipo_caratula = 'CH'
and		e_codigo = coalesce(v_e_codigo, e_codigo);
--coinversion e inversion
insert	into fecxp_real_caratula(
e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des, importe_linea, tipo_caratula)
select	e_codigo, des_empresa, id_sesion_rc,
case when mes = 12 then periodo::numeric + 1 else periodo end,
case when mes = 12 then 1 else mes::numeric + 1 end, moneda, tipo_cambio,
'SI COIN', 'SDO INICIAL COINVERSION', coalesce(importe_linea,0) importe_linea, 'CO'
from	fecxp_real_caratula
where	periodo = v_periodo
and		mes = v_mes_act
and		cla_fe_id = 'SF COIN'
and		tipo_caratula = 'CO'
and		e_codigo = coalesce(v_e_codigo, e_codigo);
insert	into fecxp_real_caratula(
e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des, importe_linea, tipo_caratula)
select	e_codigo, des_empresa, id_sesion_rc,
case when mes = 12 then periodo::numeric + 1 else periodo end,
case when mes = 12 then 1 else mes::numeric + 1 end, moneda, tipo_cambio,
'SI INV', 'SDO INICIAL INVERSION', coalesce(importe_linea,0) importe_linea, 'IN'
from	fecxp_real_caratula
where	periodo = v_periodo
and		mes = v_mes_act
and		cla_fe_id = 'SF INV'
and		tipo_caratula = 'IN'
and		e_codigo = coalesce(v_e_codigo, e_codigo);
exit when v_mes_act = 12;
v_mes_act := v_mes_act + 1;
end loop;
/* commit; */
exception
when no_data_found then
raise exception '%', 'NO HAY DATOS NUEVOS.' using errcode = '45000';end;
$body$
language plpgsql
;
