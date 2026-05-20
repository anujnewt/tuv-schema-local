create or replace procedure fecxc."fecxp_recalcula_importacion"  ( v_mes_desde varchar, v_periodo varchar, v_version_fe_imp varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_e_codigo integer;
v_id_sesion varchar(25) := to_char(clock_timestamp(),'DD-MM-YYYY');
v_periodo_act integer:= (v_periodo)::numeric;
v_mes_act integer:= (v_mes_desde)::numeric;
begin 

/* dmap converted statement start */
----------------------------------------------------------------------------------------------------------------------------------------------
--== empieza real ==--
--== inicializa la tabla ==--
delete	from fecxp_real_caratula c
where	c.e_codigo = coalesce(v_e_codigo, c.e_codigo)
and		to_date( concat(to_char(c.periodo), lpad(c.mes::text, 2, '0'::text) , '01') , 'YYYYMMDD') >= to_date( concat(v_periodo, lpad(v_mes_desde::text, 2, '0'::text) , '01') , 'YYYYMMDD')
and		estatus = 'IMPORTADO';/* dmap converted statement end */
--== mete el saldo inicial ==--
insert	into fecxp_real_caratula(
e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des, importe_linea)
select	c.e_codigo, c.des_empresa, c.id_sesion_rc,
case when c.mes = 12 then c.periodo + 1 else c.periodo end,
case when c.mes = 12 then 1 else c.mes + 1 end, c.moneda, c.tipo_cambio,
'SI', 'SALDO INICIAL', c.importe_linea
from	fecxp_real_caratula c
where	c.e_codigo = coalesce(v_e_codigo, c.e_codigo)
and		c.periodo = case (v_mes_desde)::numeric  when 1 then (v_periodo)::numeric  - 1 else (v_periodo)::numeric  end
and		c.mes = case (v_mes_desde)::numeric  when 1 then 12 else (v_mes_desde)::numeric  - 1 end
and		c.cla_fe_id = 'SF'
and		c.estatus = 'IMPORTADO';/* dmap converted statement start */
--==  inicia la inclusion de registros importados ==--
insert	into fecxp_real_caratula(
e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des, importe_linea, estatus)
select	e.e_codigo, e.des_empresa, v_id_sesion, (to_char(d.fecha, 'YYYY'))::numeric , d.mes, d.moneda_imp, m.tipo_cambio, c.cla_fe_id, c.cla_fe_des, (c.cla_atributo3)::numeric  * d.importe_linea, 'IMPORTADO'
from	fecxp_monedas m,
fecxc_empresas e,
fecxp_clasificacion_fe c,
fecxp_importacion_datos_hist d
where	d.estatus_origen = 'IMPORTADO'
and		e.e_codigo = coalesce(v_e_codigo, e.e_codigo)
and		to_date( concat(to_char(d.fecha, 'YYYY'), lpad(d.mes::text, 2, '0'::text) , '01') , 'YYYYMMDD') >= to_date( concat(v_periodo, lpad(v_mes_desde::text, 2, '0'::text) , '01') , 'YYYYMMDD')
and 	d.tipo_importacion in ('R', 'S')
and		e.e_codigo = d.e_empresa_imp
and		m.mon_oracle = d.moneda_imp
and		m.mes = d.mes
and		m.periodo = (to_char(d.fecha, 'YYYY'))::numeric
and		c.cla_fe_id = d.cla_fe_id_imp;/* dmap converted statement end *//* dmap converted statement start */
----------------------------------------------------------------------------------------------------------------------------------------------
--== termina real ==--
----------------------------------------------------------------------------------------------------------------------------------------------
--== empieza ppto ==--
delete	from fecxp_ppto_caratula
where	to_date( concat(to_char(periodo), lpad(mes::text, 2, '0'::text) , '01') , 'YYYYMMDD') = to_date( concat(to_char(v_periodo), lpad(v_mes_desde::text, 2, '0'::text) , '01') , 'YYYYMMDD')
and		e_codigo = coalesce(v_e_codigo, e_codigo)
and		estatus = 'IMPORTADO';/* dmap converted statement end */
--== mete el saldo inicial de reales si v_mes_desde = 1 ==--
insert	into fecxp_ppto_caratula(
e_codigo, des_empresa, id_sesion_pc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des, importe_linea, estatus)
select	e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des, importe_linea, estatus
from	fecxp_real_caratula
where	cla_fe_id = 'SI'
and		periodo = v_periodo
and		mes = v_mes_desde
and		v_mes_desde = 1
and		e_codigo = coalesce(v_e_codigo, e_codigo)
and		estatus = 'IMPORTADO';
--== mete el saldo final del mes pasado de ppto si v_mes_desde <> 1 ==--
insert	into fecxp_ppto_caratula(
e_codigo, des_empresa, id_sesion_pc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des, importe_linea)
select	c.e_codigo, c.des_empresa, c.id_sesion_pc,
case when c.mes = 12 then c.periodo + 1 else c.periodo end,
case when c.mes = 12 then 1 else c.mes + 1 end, c.moneda, c.tipo_cambio,
'SI', 'SALDO INICIAL', c.importe_linea
from	fecxp_ppto_caratula c
where	c.e_codigo = coalesce(v_e_codigo, c.e_codigo)
and		c.periodo = case when v_mes_desde = '1' then (v_periodo)::numeric  - 1 else (v_periodo)::numeric  end
and		c.mes = case when v_mes_desde = '1' then 12 else (v_mes_desde)::numeric  - 1 end
and		v_mes_desde <> 1
and		c.cla_fe_id = 'SF'
and		c.estatus = 'IMPORTADO';
--== inserta los registros importados ==--
insert	into fecxp_ppto_caratula(
e_codigo, des_empresa, id_sesion_pc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des, importe_linea, estatus)
select	e.e_codigo, e.des_empresa, v_id_sesion, v_periodo, d.mes, d.moneda_imp, m.tipo_cambio, c.cla_fe_id, oracle.substr(c.cla_fe_des, 1, 25), (c.cla_atributo3)::numeric  * d.importe_linea, 'IMPORTADO'
from	fecxp_monedas m,
fecxc_empresas e,
fecxp_clasificacion_fe c,
fecxp_importacion_datos_hist d
where	d.mes >= v_mes_desde
and		d.tipo_importacion in ('S', 'P')
and		d.atributo_3 = v_version_fe_imp
and		e.e_codigo = d.e_empresa_imp
and		m.mon_oracle = d.moneda_imp
and		m.mes = d.mes
and		m.periodo = (to_char(d.fecha, 'YYYY'))::numeric
and		c.cla_fe_id = d.cla_fe_id_imp
and		e.e_codigo = coalesce(v_e_codigo, e.e_codigo);
--== cuadra el ppto interempresas ==--
insert	into fecxp_ppto_caratula(
e_codigo, des_empresa, id_sesion_pc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des, importe_linea, estatus)
select	p.e_codigo, e.des_empresa, v_id_sesion, p.periodo, p.mes, p.moneda, m.tipo_cambio, p.cla_fe_id, c.cla_fe_des, (c.cla_atributo3)::numeric  * (p.importe_ing01 + p.importe_egr01) diferencia, 'CALCULADO'
from	(
select	pi.e_codigo, 'EGR01' cla_fe_id, pi.periodo, pi.mes, pi.moneda,
pi.importe_linea importe_ing01,
pe.importe_linea importe_egr01
from (
select	pi.e_codigo, pi.periodo, pi.mes, pi.moneda, sum(pi.importe_linea) importe_linea
from	fecxp_ppto_caratula pi
where	pi.cla_fe_id = 'ING01'
group by pi.e_codigo, pi.periodo, pi.mes, pi.moneda
) pi,
(
select	pe.e_codigo, pe.periodo, pe.mes, pe.moneda, sum(pe.importe_linea) importe_linea
from	fecxp_ppto_caratula pe
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
from (
select	pi.e_codigo, pi.periodo, pi.mes, pi.moneda, pi.importe_linea
from	fecxp_ppto_caratula pi
where	pi.cla_fe_id = 'ING01'
and		not exists (
select	pe.e_codigo, pe.periodo, pe.mes, pe.moneda, sum(pe.importe_linea) importe_linea
from	fecxp_ppto_caratula pe
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
from (
select	pe.e_codigo, pe.periodo, pe.mes, pe.moneda, 0, pe.importe_linea
from	fecxp_ppto_caratula pe
where	pe.cla_fe_id = 'EGR01'
and		not exists (
select	pi.e_codigo, pi.periodo, pi.mes, pi.moneda, sum(pi.importe_linea) importe_linea
from	fecxp_ppto_caratula pi
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
where	m.periodo = (v_periodo)::numeric
and		m.mes >= (v_mes_desde)::numeric
and		p.e_codigo = e.e_codigo
and		m.mon_oracle = p.moneda
and		m.mes = p.mes
and		m.periodo = p.periodo
and		c.cla_fe_id = p.cla_fe_id
and		p.e_codigo = coalesce(v_e_codigo, p.e_codigo);
----------------------------------------------------------------------------------------------------------------------------------------------
--== termina ppto ==--
----------------------------------------------------------------------------------------------------------------------------------------------
--== empieza calculo saldos finales ==--
loop
-- comienza ppto
--== calcula de saldos finales para las empresas que hayan generado fe ==--
insert	into fecxp_real_caratula(
e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des, importe_linea)
select	c.e_codigo, c.des_empresa, c.id_sesion_rc, c.periodo, c.mes, c.moneda, c.tipo_cambio, 'SF', 'SALDO FINAL', sum(c.importe_linea)
from	fecxp_clasificacion_fe cf,
fecxp_real_caratula c
where	c.e_codigo = coalesce(v_e_codigo, c.e_codigo)
and		c.periodo = v_periodo_act
and		c.mes = v_mes_act
and		cf.genera_saldo = 1
and		cf.cla_fe_id = c.cla_fe_id
group by c.e_codigo, c.des_empresa, c.id_sesion_rc, c.periodo, c.mes, c.moneda, c.tipo_cambio;
-- inserta el saldo inicial del siguiente mes
insert	into fecxp_real_caratula(
e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des, importe_linea)
select	c.e_codigo, c.des_empresa, c.id_sesion_rc,
case when c.mes = 12 then c.periodo + 1 else c.periodo end,
case when c.mes = 12 then 1 else c.mes + 1 end, c.moneda, c.tipo_cambio,
'SI', 'SALDO INICIAL', c.importe_linea
from	fecxp_real_caratula c
where	c.e_codigo = coalesce(v_e_codigo, c.e_codigo)
and		periodo = v_periodo_act
and		mes = v_mes_act
and		cla_fe_id = 'SF';
exit when v_mes_act = (to_char(clock_timestamp(),'MM'))::numeric  and v_periodo_act = (to_char(clock_timestamp(),'YYYY'))::numeric;
-- termina real
-- comienza ppto
--== calcula de saldos finales para las empresas que hayan generado fe ==--
insert	into fecxp_ppto_caratula(
e_codigo, des_empresa, id_sesion_pc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des, importe_linea)
select	e_codigo, des_empresa, id_sesion_pc, periodo, mes, moneda, tipo_cambio, 'SF', 'SALDO FINAL', sum(importe_linea)
from	fecxp_clasificacion_fe cf,
fecxp_ppto_caratula c
where	c.periodo = v_periodo_act
and		c.mes = v_mes_act
and		cf.genera_saldo = 1
and		cf.cla_fe_id = c.cla_fe_id
and		cf.cla_fe_id <> 'SF'
and		c.e_codigo = coalesce(v_e_codigo, c.e_codigo)
group by c.e_codigo, c.des_empresa, c.id_sesion_pc, c.periodo, c.mes, c.moneda, c.tipo_cambio;
-- inserta el saldo inicial del siguiente mes
insert	into fecxp_ppto_caratula(
e_codigo, des_empresa, id_sesion_pc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des, importe_linea)
select	e_codigo, des_empresa, id_sesion_pc,
case when mes = 12 then periodo::numeric + 1 else periodo end,
case when mes = 12 then 1 else mes::numeric + 1 end, moneda, tipo_cambio,
'SI', 'SALDO INICIAL', importe_linea
from	fecxp_ppto_caratula
where	periodo = v_periodo_act
and		mes = v_mes_act
and		mes <> 1
and		e_codigo = coalesce(v_e_codigo, e_codigo)
and		cla_fe_id = 'SF';
-- termina ppto
v_mes_act:= v_mes_act + 1;
if v_mes_act > 12 then
v_mes_act:= '1';
v_periodo_act:= v_periodo_act + 1;
end if;
end loop;/* dmap converted statement start */
----------------------------------------------------------------------------------------------------------------------------------------------
--== termina calculo saldos finales ==--
----------------------------------------------------------------------------------------------------------------------------------------------
--== calcula saldo sf2 ==--
insert	into fecxp_real_caratula(
e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des, importe_linea, estatus)
select	c.e_codigo, c.des_empresa, c.id_sesion_rc,
c.periodo, c.mes, c.moneda, c.tipo_cambio, 'SF2', 'POSICION CON FACULTAD DECISION', sum(c.importe_linea), 'CALCULADO' estatus
from (
select	c.e_codigo, c.des_empresa, c.id_sesion_rc, c.periodo, c.mes, c.moneda, c.tipo_cambio, c.cla_fe_id, c.cla_fe_des, sum(c.importe_linea) importe_linea
from	fecxp_real_caratula c
where	c.cla_fe_id = 'SF'
group by c.e_codigo, c.des_empresa, c.id_sesion_rc, c.periodo, c.mes, c.moneda, c.tipo_cambio, c.cla_fe_id, c.cla_fe_des
union all
select	c.e_codigo, c.des_empresa, c.id_sesion_rc, c.periodo, c.mes, c.moneda, c.tipo_cambio, c.cla_fe_id, c.cla_fe_des, sum(c.importe_linea) importe_linea
from	fecxp_real_caratula c,
fecxp_clasificacion_fe cf
where	cf.genera_saldo = 0
and		cf.cla_fe_id not in ('ING02', 'EGR02')
and		c.cla_fe_id = cf.cla_fe_id
group by c.e_codigo, c.des_empresa, c.id_sesion_rc, c.periodo, c.mes, c.moneda, c.tipo_cambio, c.cla_fe_id, c.cla_fe_des
) c
where	c.e_codigo = coalesce(v_e_codigo, c.e_codigo)
and		to_date( concat(to_char(c.periodo), lpad(c.mes::text, 2, '0'::text) , '01') , 'YYYYMMDD') >= to_date( concat(v_periodo, lpad(v_mes_desde::text, 2, '0'::text) , '01') , 'YYYYMMDD')
group by c.e_codigo, c.des_empresa, c.id_sesion_rc, c.periodo, c.mes, c.moneda, c.tipo_cambio;/* dmap converted statement end */
/* commit; */
exception
when no_data_found then
raise exception '%', 'NO HAY DATOS NUEVOS.' using errcode = '45000';end;
$body$
language plpgsql
;
