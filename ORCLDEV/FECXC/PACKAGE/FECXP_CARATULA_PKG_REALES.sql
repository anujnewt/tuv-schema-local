create or replace procedure fecxc.fecxp_caratula_pkg_reales () as $body$
declare
-- pgv moved types start
-- pgv moved types end
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
v_ctacr1_ini fecxp_politicas_soin.ctacr1_ini%type;
v_ctacr1_fin fecxp_politicas_soin.ctacr1_fin%type;
v_ctacr2_ini fecxp_politicas_soin.ctacr2_ini%type;
v_ctacr2_fin fecxp_politicas_soin.ctacr2_fin%type;
v_errores integer;
cursor_clasificacion_fe_oracle cursor for
select	 cla_fe_id, politica_erp_id, prioridad, oracle_segmento1_ini, oracle_segmento1_fin, oracle_segmento2_ini, oracle_segmento2_fin, oracle_segmento3_ini, oracle_segmento3_fin, oracle_segmento4_ini, oracle_segmento4_fin, oracle_segmento5_ini, oracle_segmento5_fin, oracle_segmento6_ini, oracle_segmento6_fin, oracle_segmento7_ini, oracle_segmento7_fin
from	 fecxp_politicas_erp
order by prioridad asc;
cursor_clasificacion_fe_soin cursor for
select	 cla_fe_id, politica_soin_id, prioridad, e_codigo_ini, e_codigo_fin, ctam01_ini, ctam01_fin, ctam02_ini, ctam02_fin, ctam03_ini, ctam03_fin, tipo_ini, tipo_fin, division_ini, division_fin, rubro_ini, rubro_fin, ctacr1_ini, ctacr1_fin, ctacr2_ini, ctacr2_fin
from	 fecxp_politicas_soin
order by prioridad asc;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
begin
delete	from fecxp_real_caratula;
exception
when no_data_found then
v_errores :=1;
end;
begin
--== cargamos las cuentas contables que generaron movimiento durante el mes  ==--
insert	into fecxp_cuentas_erp_caratula(cla_fe_id, e_codigo, oracle_segmento1, oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6, oracle_segmento7)
select distinct '|'as cla_id, d.e_codigo, d.oracle_segmento1, d.oracle_segmento2, d.oracle_segmento3, d.oracle_segmento4, d.oracle_segmento5, d.oracle_segmento6, d.oracle_segmento7
from	fecxp_enc_pagos_erp e,
fecxp_det_pagos_procesados d
where	(to_char(e.fecha_aplicacion, 'YYYY'))::numeric  = v_periodo
and		(to_char(e.fecha_aplicacion, 'MM'))::numeric  < v_mes_act
and		e.secuencia_pagos_erp = d.secuencia_pagos_erp;
exception
when no_data_found then
v_errores :=1;
end;
begin
insert	into fecxp_ctas_soin_caratula_tmp(cla_fe_id, e_codigo, ctam01, ctam02, ctam03, division, rubro, ctacr1, ctacr2)
select	distinct '|' as cla_id, e.e_codigo, d.ctam01, d.ctam02, d.ctam03, 0, 0, '0', '0'
from	fecxp_enc_pagos_soin e,
fecxp_det_pagos_soin d
where   (to_char(e.fecha_aplicacion, 'YYYY'))::numeric  =v_periodo
and		(to_char(e.fecha_aplicacion, 'MM'))::numeric  < v_mes_act
and		e.secuencia_pagos_soin = d.secuencia_pagos_soin;
exception
when no_data_found then
v_errores :=1;
end;
begin
update	fecxp_ctas_soin_caratula_tmp c1
set		division = 	(
select	distinct c2.cg13di
from	fecxp_cat_cuentas_soin c2
where   c1.ctam01 = c2.ctam01
and		c1.ctam02 = c2.ctam02
and		c1.ctam03 = c2.ctam03
),
rubro = (
select	distinct c2.cg13ru
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
into  v_cla_fe_id, v_politica_soin_id, v_prioridad, v_e_codigo_ini, v_e_codigo_fin, v_ctam01_ini, v_ctam01_fin, v_ctam02_ini, v_ctam02_fin, v_ctam03_ini, v_ctam03_fin, v_tipo_ini, v_tipo_fin, v_division_ini, v_division_fin, v_rubro_ini, v_rubro_fin, v_ctacr1_ini, v_ctacr1_fin, v_ctacr2_ini, v_ctacr2_fin;
exit when not found; /* apply on cursor_clasificacion_fe_soin */
begin
--== se clasifican las cuentas de soin ==--
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
and (ctacr1 >= coalesce(v_ctacr1_ini, '000'))
and (ctacr1 <= coalesce(v_ctacr1_fin, 'zzz'))
and (ctacr2 >= coalesce(v_ctacr2_ini, '0000'))
and (ctacr2 <= coalesce(v_ctacr2_fin, 'zzzz'))
and		coalesce(cla_fe_id, '|') = '|';
exception
when no_data_found then
v_errores :=1;
end;
end loop;
close cursor_clasificacion_fe_soin;
/******************************************************************************************************/
begin
--== inserta ingresos cobranza e icia ==--
insert	into fecxp_real_caratula(e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des, importe_linea)
select	i.no_empresa, i.des_empresa, v_id_sesion, i.periodo, i.mes, i.moneda, i.tipo_cambio, i.cla_fe_id, cf.cla_fe_des, i.importe_linea
from	fecxp_clasificacion_fe cf,
(
select	a.no_empresa,
c.des_empresa,
(to_char(a.fec_valor, 'YYYY'))::numeric  as periodo,
(to_char(a.fec_valor, 'MM'))::numeric  as mes,
m.mon_oracle moneda,
m.tipo_cambio,
case when nullif(b.cod_valor::text, '') is null then
case when id_tipo_operacion_set = 3100 then 'A7'
when id_tipo_operacion_set = 3101 and a.id_banco <> 14  and id_chequera <> '51451001688' then 'B1'
when id_tipo_operacion_set = 3102 then 'A7'
when id_tipo_operacion_set = 3103 then 'B1'
when id_tipo_operacion_set = 3107 then 'A7'
when id_tipo_operacion_set = 3109 then 'A7'
when id_tipo_operacion_set = 3111 then 'B1'
when id_tipo_operacion_set = 3500 then 'B1'
when id_tipo_operacion_set = 3706 then 'ING02' --interempresas
when id_tipo_operacion_set = 4102 then 'ING02' --interempresas
when id_tipo_operacion_set = 3112 then 'B1'
else 'ING01' end
else b.cod_valor end cla_fe_id,
sum(case when nullif(b.importe_detalle::text, '') is null then a.importe else b.importe_detalle end) importe_linea
from fecxp_monedas m, fecxc_empresas c, fecxc_dep_especiales a
left outer join (select base_inf.codfolio, base_inf.e_codigo, base_inf.segmento1, base_inf.codoperacion, base_inf.tipocambio, base_inf.importe, base_inf.importe_detalle,
base_inf.f_deposito,  base_inf.segmento2, base_inf.cod_sec_det,
base_inf.cod_sec_catclas, base_inf.secmoneda,
cod_flujo.cod_valor, cod_flujo.desc_valor
from (select	a.codfolio, a.e_codigo, b.segmento1, a.codoperacion, a.tipocambio, a.importe, b.importe as importe_detalle,
a.f_deposito,  coalesce(b.segmento2, -1) as segmento2, b.cod_sec_det,
b.cod_sec_catclas, a.secmoneda
from	fecxc_enc_clasificados a,
fecxc_det_clasificados b,
fecxc_det_clasfecxc i
where	a.e_codigo = b.e_codigo
and		a.cod_sec_clasifica = b.cod_sec_clasifica
and		b.cod_sec_det = i.cod_sec_det
and		b.cod_sec_catclas = i.cod_sec_catclas
--and		i.excluir_enreportes = no
and		nullif(b.segmento1::text, '') is not null) base_inf
left outer join (select	g1.cod_sec_lin, g1.sec_flujo_detcat, h1.cod_valor,
h1.desc_valor
from	fecxc_mapeo_flujo g1, fecxc_det_catalogos h1
where	g1.sec_flujo_detcat = h1.cod_sec_lin
and		h1.tipo_cat = 'FLUJO'
union
select	-1, -1, 'NO MAPEADOS', 'NO MAPEADOS'
) cod_flujo on (base_inf.segmento2 = cod_flujo.cod_sec_lin) ) b on (a.no_empresa = b.e_codigo and a.no_folio_det = b.codfolio)
where (to_char(a.fec_valor, 'YYYY'))::numeric  = v_periodo and (to_char(a.fec_valor, 'MM'))::numeric   < v_mes_act and a.no_empresa = c.e_codigo and m.mon_set = a.id_divisa and (to_char(a.fec_valor, 'MM'))::numeric  = m.mes group by a.no_empresa,
c.des_empresa,
(to_char(a.fec_valor, 'YYYY'))::numeric ,
(to_char(a.fec_valor, 'MM'))::numeric ,
m.mon_oracle,
m.tipo_cambio,
case when nullif(b.cod_valor::text, '') is null then
case when id_tipo_operacion_set = 3100 then 'A7'
when id_tipo_operacion_set = 3101 and a.id_banco <> 14  and id_chequera <> '51451001688' then 'B1'
when id_tipo_operacion_set = 3102 then 'A7'
when id_tipo_operacion_set = 3103 then 'B1'
when id_tipo_operacion_set = 3107 then 'A7'
when id_tipo_operacion_set = 3109 then 'A7'
when id_tipo_operacion_set = 3111 then 'B1'
when id_tipo_operacion_set = 3500 then 'B1'
when id_tipo_operacion_set = 3706 then 'ING02' --interempresas
when id_tipo_operacion_set = 4102 then 'ING02' --interempresas
when id_tipo_operacion_set = 3112 then 'B1'
else 'ING01' end
else b.cod_valor end,
case when nullif(b.desc_valor::text, '') is null then 'INGRESOS' else b.desc_valor end) i
where	i.cla_fe_id = cf.cla_fe_id;
exception
when no_data_found then
v_errores :=1;
end;
begin
/*  inicia la inclusion de informacion del erp*/
insert into fecxp_erp_caratula_tmp
select	pe.e_codigo, e.des_empresa, (to_char(pe.fecha_aplicacion,'YYYY')) as periodo, (to_char(pe.fecha_aplicacion,'MM')) as mes,
m.mon_oracle, m.tipo_cambio,  (pp.importe_linea) importe, pp.oracle_segmento1, pp.oracle_segmento2, pp.oracle_segmento3,
pp.oracle_segmento4, pp.oracle_segmento5, pp.oracle_segmento6, pp.oracle_segmento7
from	fecxp_enc_pagos_erp pe,
fecxp_det_pagos_procesados pp,
fecxc_empresas e,
fecxp_monedas m
where  	(to_char(pe.fecha_aplicacion, 'YYYY'))::numeric  = v_periodo
and		(to_char(pe.fecha_aplicacion, 'MM'))::numeric  <  v_mes_act
and		m.mes = (to_char(pe.fecha_aplicacion,'MM'))::numeric
and		m.mon_set = pe.moneda
and		e.e_codigo = pe.e_codigo
and		pe.secuencia_pagos_erp = pp.secuencia_pagos_erp
and		pe.e_codigo 	   = pp.e_codigo;
exception
when no_data_found then
v_errores :=1;
end;
begin
insert	into fecxp_real_caratula(e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio,
cla_fe_id, cla_fe_des, importe_linea)
select	a.e_codigo, a.des_empresa,  v_id_sesion, a.periodo, a.mes,
a.mon_oracle, a.tipo_cambio, b.cla_fe_id, b.cla_fe_des, sum(a.importe * (b.cla_atributo3::numeric)::numeric )
from fecxp_erp_caratula_tmp a, (select c.e_codigo, b.cla_fe_id, b.cla_fe_des, b.cla_atributo3 , c.oracle_segmento1, c.oracle_segmento2, c.oracle_segmento3,
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
group by a.e_codigo, a.des_empresa, 1,  a.periodo,  a.mes,
a.mon_oracle, a.tipo_cambio, b.cla_fe_id, b.cla_fe_des;
/*  termina la inclusion de registros caratula erp*/
exception
when no_data_found then
v_errores :=1;
end;
begin
/*  inicia la inclusion de registros caratula soin*/
insert into fecxp_soin_caratula_tmp
select	ep.e_codigo, e.des_empresa, (to_char(ep.fecha_aplicacion,'YYYY')) as periodo, (to_char(ep.fecha_aplicacion,'MM')) as mes,
m.mon_oracle, m.tipo_cambio, ps.importe_linea  as importe, ps.ctam01, ps.ctam02, ps.ctam03
from	fecxp_enc_pagos_soin ep,
fecxp_det_pagos_soin ps,
fecxc_empresas e,
fecxp_monedas m
where	(to_char(ep.fecha_aplicacion, 'YYYY'))::numeric  = v_periodo
and		(to_char(ep.fecha_aplicacion, 'MM'))::numeric  < v_mes_act
and		m.mes = (to_char(ep.fecha_aplicacion, 'MM'))::numeric
and		m.mon_set = ep.moneda
and		e.e_codigo = ep.e_codigo
and		ep.secuencia_pagos_soin = ps.secuencia_pagos_soin
and		ep.e_codigo 			= ps.e_codigo
and		ps.ctam01 <> '000';
exception
when no_data_found then
v_errores :=1;
end;
begin
insert	into fecxp_real_caratula(
e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des, importe_linea)
select a.e_codigo, a.des_empresa, v_id_sesion,  a.periodo,  a.mes,
a.mon_oracle, a.tipo_cambio, b.cla_fe_id, b.cla_fe_des, sum(importe*b.cla_atributo3)
from fecxp_soin_caratula_tmp a, (select c.e_codigo, b.cla_fe_id, b.cla_atributo3,b.cla_fe_des,  c.ctam01, c.ctam02, c.ctam03
from fecxp_clasificacion_fe b, fecxp_ctas_soin_caratula_tmp c
where b.cla_fe_id = c.cla_fe_id) b
where a.e_codigo = b.e_codigo
and a.ctam01 = b.ctam01
and a.ctam02  = b.ctam02
and a.ctam03  = b.ctam03
group by a.e_codigo, a.des_empresa, 1,  a.periodo,  a.mes,
a.mon_oracle, a.tipo_cambio, b.cla_fe_id, b.cla_fe_des;
exception
when no_data_found then
v_errores :=1;
end;
/*  termina la inclusion de registros caratula soin*/
begin
--== inserta registros importados que afectan al saldo ==--
insert	into fecxp_real_caratula(
e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des, importe_linea, estatus)
select	e.e_codigo, e.des_empresa, v_id_sesion, (to_char(d.fecha, 'YYYY'))::numeric , d.mes, d.moneda_imp, m.tipo_cambio, c.cla_fe_id, c.cla_fe_des, (c.cla_atributo3)::numeric  * d.importe_linea, 'IMPORTADO'
from	fecxp_monedas m,
fecxc_empresas e,
fecxp_clasificacion_fe c,
fecxp_importacion_datos_hist d
where	d.estatus_origen = 'IMPORTADO'
and		(to_char(d.fecha, 'YYYY'))::numeric  = v_periodo
and		d.mes < v_mes_act
and		d.tipo_importacion in ('R', 'S')
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
--== calcula e inserta saldos ==--
v_mes_act:= 1;
loop
begin
--== calcula de saldos finales para las empresas que hayan generado fe ==--
insert	into fecxp_real_caratula(
e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des, importe_linea)
select	e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, 'SF', 'SALDO FINAL', sum(importe_linea)
from	fecxp_clasificacion_fe cf,
fecxp_real_caratula c
where	c.periodo = v_periodo
and		c.mes = v_mes_act
and		cf.genera_saldo = 1
and		cf.cla_fe_id = c.cla_fe_id
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
and		mes = v_mes_act
and		cla_fe_id = 'SF';
exception
when no_data_found then
v_errores :=1;
end;
v_mes_act := v_mes_act + 1;
exit when v_mes_act = 11;
end loop;
/*
--  insertamos en la tabla de reporte real fluctuacion cambiaria para datos erp
insert into fecxp_real_caratula (
e_codigo, des_empresa, id_sesion_rc, periodo, mes,
moneda, tipo_cambio, cla_fe_id, cla_fe_des, importe_linea)
select	cm.e_codigo,
cm.des_empresa,
v_id_sesion,
cm.periodo,
cm.mes,
mxp moneda,
1 tipo_cambio,
dic01 cla_fe_id,
diferencial cambiario cla_fe_des,
cd.importe_linea - cm.importe_linea importe_linea
from	(
select	pe.e_codigo,
e.des_empresa,
(to_char(pe.fecha_aplicacion,yyyy)) as periodo,
(to_char(pe.fecha_aplicacion,mm)) as mes,
sum (m.tipo_cambio * pp.importe_linea * cf.cla_atributo3) importe_linea
from	fecxp_cuentas_erp_caratula c,
fecxp_enc_pagos_erp pe,
fecxp_det_pagos_procesados pp,
fecxc_empresas e,
fecxp_clasificacion_fe cf,
fecxp_monedas m
where	to_number (to_char (pe.fecha_aplicacion, yyyy)) =v_periodo
and		to_number (to_char (pe.fecha_aplicacion, mm)) < v_mes_act
and		m.mes = to_number(to_char(pe.fecha_aplicacion,mm))
and		m.mon_set = pe.moneda
and		e.e_codigo = pe.e_codigo
and		cf.cla_fe_id = c.cla_fe_id
and		pe.secuencia_pagos_erp = pp.secuencia_pagos_erp
and		c.oracle_segmento1 = pp.oracle_segmento1
and		c.oracle_segmento2 = pp.oracle_segmento2
and		c.oracle_segmento3 = pp.oracle_segmento3
and		c.oracle_segmento4 = pp.oracle_segmento4
and		c.oracle_segmento5 = pp.oracle_segmento5
and		c.oracle_segmento6 = pp.oracle_segmento6
and		c.oracle_segmento7 = pp.oracle_segmento7
group by pe.e_codigo, e.des_empresa, (to_char(pe.fecha_aplicacion,yyyy)), (to_char(pe.fecha_aplicacion,mm))
) cm,
(
select	pe.e_codigo,
(to_char(pe.fecha_aplicacion,yyyy)) as periodo,
(to_char(pe.fecha_aplicacion,mm)) as mes,
sum (pe.tipo_cambio * pp.importe_linea * cf.cla_atributo3) importe_linea
from	fecxp_cuentas_erp_caratula c,
fecxp_enc_pagos_erp pe,
fecxp_det_pagos_procesados pp,
fecxp_clasificacion_fe cf
where	to_number (to_char (pe.fecha_aplicacion, yyyy)) =v_periodo
and		to_number (to_char (pe.fecha_aplicacion, mm)) < v_mes_act
and		cf.cla_fe_id = c.cla_fe_id
and		pe.secuencia_pagos_erp = pp.secuencia_pagos_erp
and		c.oracle_segmento1 = pp.oracle_segmento1
and		c.oracle_segmento2 = pp.oracle_segmento2
and		c.oracle_segmento3 = pp.oracle_segmento3
and		c.oracle_segmento4 = pp.oracle_segmento4
and		c.oracle_segmento5 = pp.oracle_segmento5
and		c.oracle_segmento6 = pp.oracle_segmento6
and		c.oracle_segmento7 = pp.oracle_segmento7
group by pe.e_codigo, (to_char(pe.fecha_aplicacion,yyyy)), (to_char(pe.fecha_aplicacion,mm))
) cd
where	cd.e_codigo = cm.e_codigo
and		cd.periodo = cm.periodo
and		cd.mes = cm.mes;
--  insertamos en la tabla de reporte real fluctuacion cambiaria para datos soin
insert into fecxp_real_caratula (
e_codigo, des_empresa, id_sesion_rc, periodo, mes,
moneda, tipo_cambio, cla_fe_id, cla_fe_des, importe_linea)
select	cm.e_codigo,
cm.des_empresa,
v_id_sesion,
cm.periodo,
cm.mes,
mxp moneda,
1 tipo_cambio,
dic01 cla_fe_id,
diferencial cambiario cla_fe_des,
cd.importe_linea - cm.importe_linea importe_linea
from	(
select	ep.e_codigo,
e.des_empresa,
(to_char(ep.fecha_aplicacion,yyyy)) as periodo,
(to_char(ep.fecha_aplicacion,mm)) as mes,
sum (m.tipo_cambio * ps.importe_linea * cf.cla_atributo3) importe_linea
from	fecxp_ctas_soin_caratula_tmp c,
fecxp_enc_pagos_soin ep,
fecxp_det_pagos_soin ps,
fecxc_empresas e,
fecxp_clasificacion_fe cf,
fecxp_monedas m
where	to_number (to_char (ep.fecha_aplicacion, yyyy)) =v_periodo
and		to_number (to_char (ep.fecha_aplicacion, mm)) < v_mes_act
and		m.mes = to_number (to_char (ep.fecha_aplicacion, mm))
and		m.mon_set = ep.moneda
and		cf.cla_fe_id = c.cla_fe_id
and		e.e_codigo = ep.e_codigo
and		ep.secuencia_pagos_soin = ps.secuencia_pagos_soin
and		ps.ctam01 <> 000
and		c.ctam01 = ps.ctam01
and		c.ctam02 = ps.ctam02
and		c.ctam03 = ps.ctam03
group by ep.e_codigo, e.des_empresa, (to_char(ep.fecha_aplicacion,yyyy)), (to_char(ep.fecha_aplicacion,mm))
) cm,
(
select	ep.e_codigo,
(to_char(ep.fecha_aplicacion,yyyy)) as periodo,
(to_char(ep.fecha_aplicacion,mm)) as mes,
sum (ep.tipo_cambio * ps.importe_linea * cf.cla_atributo3) importe_linea
from	fecxp_ctas_soin_caratula_tmp c,
fecxp_enc_pagos_soin ep,
fecxp_det_pagos_soin ps,
fecxp_clasificacion_fe cf
where	to_number (to_char (ep.fecha_aplicacion, yyyy)) =v_periodo
and		to_number (to_char (ep.fecha_aplicacion, mm)) < v_mes_act
and		cf.cla_fe_id = c.cla_fe_id
and		ep.secuencia_pagos_soin = ps.secuencia_pagos_soin
and		ps.ctam01 <> 000
and		c.ctam01 = ps.ctam01
and		c.ctam02 = ps.ctam02
and		c.ctam03 = ps.ctam03
group by ep.e_codigo, (to_char(ep.fecha_aplicacion,yyyy)), (to_char(ep.fecha_aplicacion,mm))
) cd;
-- 4commit;
*/
end;
$body$
language plpgsql
;
