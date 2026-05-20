create or replace procedure fecxc."fecxp_llena_caratula_reald"  ( v_fecha_ini datedefault sysdate-12 ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
-- declare
-- v_fecha_ini date:= to_timestamp('20060101','YYYYMMDD');
v_e_codigo integer;
v_periodo integer:= (to_char(clock_timestamp(), 'YYYY'))::numeric;
v_id_sesion varchar(25) := to_char(clock_timestamp(), 'DD-MM-YYYY');
v_fecha_ene timestamp(0):= to_date(to_char(clock_timestamp(), 'YYYY') || '0101', 'YYYYMMDD');
v_fecha_fin timestamp(0):= clock_timestamp();
v_fecha_act timestamp(0);
v_cla_fe_id fecxp_politicas_erp.cla_fe_id%type;
v_prioridad fecxp_politicas_erp.prioridad%type;
v_tipo_operacion_ini fecxp_politicas_erp.tipo_operacion_ini%type;
v_tipo_operacion_fin fecxp_politicas_erp.tipo_operacion_fin%type;
v_id_banco_ini fecxp_politicas_erp.id_banco_ini%type;
v_id_banco_fin fecxp_politicas_erp.id_banco_fin%type;
v_id_chequera_ini fecxp_politicas_erp.id_chequera_ini%type;
v_id_chequera_fin fecxp_politicas_erp.id_chequera_fin%type;
v_politica_erp_id fecxp_politicas_erp.politica_erp_id%type;
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
cursor_clas_fe_oracle_ing cursor for
select	cla_fe_id, politica_erp_id, prioridad, tipo_operacion_ini, tipo_operacion_fin, id_banco_ini, id_banco_fin, id_chequera_ini, id_chequera_fin,
oracle_segmento1_ini, oracle_segmento1_fin, oracle_segmento2_ini, oracle_segmento2_fin, oracle_segmento3_ini, oracle_segmento3_fin, oracle_segmento4_ini, oracle_segmento4_fin, oracle_segmento5_ini, oracle_segmento5_fin, oracle_segmento6_ini, oracle_segmento6_fin, oracle_segmento7_ini, oracle_segmento7_fin
from	fecxp_politicas_erp
where	id_tipo_movto in ('A', 'I')
and		activa_regla = 1
order by prioridad asc;
cursor_clas_fe_soin_ing cursor for
select	cla_fe_id, politica_soin_id, prioridad, tipo_operacion_ini, tipo_operacion_fin, id_banco_ini, id_banco_fin, id_chequera_ini, id_chequera_fin,
e_codigo_ini, e_codigo_fin, ctam01_ini, ctam01_fin, ctam02_ini, ctam02_fin, ctam03_ini, ctam03_fin, tipo_ini, tipo_fin, division_ini, division_fin, rubro_ini, rubro_fin, ctacr1_ini, ctacr1_fin, ctacr2_ini, ctacr2_fin
from	fecxp_politicas_soin
where	id_tipo_movto in ('A', 'I')
and		activa_regla = 1
order by prioridad asc;
cursor_clas_fe_oracle_egr cursor for
select	cla_fe_id, politica_erp_id, prioridad, tipo_operacion_ini, tipo_operacion_fin, id_banco_ini, id_banco_fin, id_chequera_ini, id_chequera_fin,
oracle_segmento1_ini, oracle_segmento1_fin, oracle_segmento2_ini, oracle_segmento2_fin, oracle_segmento3_ini, oracle_segmento3_fin, oracle_segmento4_ini, oracle_segmento4_fin, oracle_segmento5_ini, oracle_segmento5_fin, oracle_segmento6_ini, oracle_segmento6_fin, oracle_segmento7_ini, oracle_segmento7_fin
from	fecxp_politicas_erp
where	id_tipo_movto in ('A', 'E')
and		activa_regla = 1
order by prioridad asc;
cursor_clas_fe_soin_egr cursor for
select	cla_fe_id, politica_soin_id, prioridad, tipo_operacion_ini, tipo_operacion_fin, id_banco_ini, id_banco_fin, id_chequera_ini, id_chequera_fin,
e_codigo_ini, e_codigo_fin, ctam01_ini, ctam01_fin, ctam02_ini, ctam02_fin, ctam03_ini, ctam03_fin, tipo_ini, tipo_fin, division_ini, division_fin, rubro_ini, rubro_fin, ctacr1_ini, ctacr1_fin, ctacr2_ini, ctacr2_fin
from	fecxp_politicas_soin
where activa_regla = 1
order by prioridad asc;
cursor_saldos_finales_set cursor for
select fecha
from fecxp_saldos_finales_setd
where fecha >= to_date(to_char(clock_timestamp(), 'YYYY') || '0101', 'YYYYMMDD')
group by fecha;
begin 

delete	from fecxp_real_caratulad
where	e_codigo = coalesce(v_e_codigo, e_codigo)
and		fecha >= v_fecha_ini;/* dmap converted statement start */
/* commit; */
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
-- ingresos
--== clasifica e inserta ingresos cobranza e icia ==--
insert	into fecxp_ingresos_caratula_tmp(cla_fe_id, e_codigo, folio_set, tipo_operacion, id_banco, id_chequera, fecha, moneda, importe_linea,referencia, tipo_clasificacion)
select	i.cod_valor,  i.no_empresa, i.no_folio_det, i.id_tipo_operacion_set, i.id_banco, i.id_chequera, i.fec_valor, i.moneda, i.importe_linea, i.referencia, case coalesce(i.cod_valor, '|') when '|' then null else 'MODULO FECXC' end
from	(
select	coalesce(b.cod_valor, '|') cod_valor,
a.no_empresa,
a.no_folio_det,
a.fec_valor,
m.mon_oracle moneda,
a.id_tipo_operacion_set,
a.id_banco,
a.id_chequera,
sum(case when nullif(b.importe_detalle::text, '') is null then a.importe else b.importe_detalle end) importe_linea,
a.referencia
from fecxp_monedas m, fecxc_empresas c, fecxc_dep_especiales a
left outer join (
select	base_inf.codfolio, base_inf.e_codigo, base_inf.segmento1, base_inf.codoperacion, base_inf.tipocambio, base_inf.importe, base_inf.importe_detalle,
base_inf.f_deposito,  base_inf.segmento2, base_inf.cod_sec_det,
base_inf.cod_sec_catclas, base_inf.secmoneda,
cod_flujo.cod_valor, cod_flujo.desc_valor
from (
select	a.codfolio, a.e_codigo, b.segmento1, a.codoperacion, a.tipocambio, a.importe, b.importe as importe_detalle,
a.f_deposito,  coalesce(b.segmento2, -1) as segmento2, b.cod_sec_det,
b.cod_sec_catclas, a.secmoneda
from	fecxc_enc_clasificados a,
fecxc_det_clasificados b,
fecxc_det_clasfecxc i
where	a.e_codigo = b.e_codigo
and		a.cod_sec_clasifica = b.cod_sec_clasifica
and		b.cod_sec_det = i.cod_sec_det
and		b.cod_sec_catclas = i.cod_sec_catclas
--and		i.excluir_enreportes = 'NO'
and		nullif(b.segmento1::text, '') is not null
) base_inf
left outer join (
select	g1.cod_sec_lin, g1.sec_flujo_detcat, h1.cod_valor,
h1.desc_valor
from	fecxc_mapeo_flujo g1, fecxc_det_catalogos h1
where	g1.sec_flujo_detcat = h1.cod_sec_lin
and		h1.tipo_cat = 'FLUJO'
union
select	-1, -1, 'NO MAPEADOS', 'NO MAPEADOS'
) cod_flujo on (base_inf.segmento2 = cod_flujo.cod_sec_lin) ) b on (a.no_empresa = b.e_codigo and a.no_folio_det = b.codfolio)
where a.fec_valor >= v_fecha_ini and a.fec_valor <= v_fecha_fin and a.no_empresa = c.e_codigo and m.mon_set = a.id_divisa and (to_char(a.fec_valor, 'MM'))::numeric  = m.mes and (to_char(a.fec_valor, 'YYYY'))::numeric  = m.periodo group by -- coalesce (case when id_tipo_operacion_set = 3101 and a.id_banco = 14  and id_chequera in ('51451001688') then 'ING01' else b.cod_valor end, '|'),
coalesce(b.cod_valor, '|'),
a.no_empresa,
a.no_folio_det,
fec_valor,
m.mon_oracle,
a.id_tipo_operacion_set,
a.id_banco,
a.id_chequera,
case when nullif(b.desc_valor::text, '') is null then 'INGRESOS' else b.desc_valor end,
a.referencia
) i
where	i.no_empresa = coalesce(v_e_codigo, i.no_empresa);/* dmap converted statement end */
--actualiza la cle_fe_id
update	fecxp_ingresos_caratula_tmp a
set(a.cla_fe_id, a.tipo_clasificacion) =
(
select	b.cla_fe_id, 'REFERENCIAS'
from	fecxp_cat_subcodigo b
where	b.no_empresa = a.e_codigo
and		b.id_codigo = oracle.substr(a.referencia, 1, 2)
and		b.id_subcodigo = oracle.substr(a.referencia, 4, 3)
and		b.estatus = 'ACTIVO'
and		nullif(b.cla_fe_id::text, '') is not null
)
where	oracle.substr(a.referencia, 3, 1) = '9'
and		coalesce(a.cla_fe_id, '|') = '|'
and		length(a.referencia) = 7
and		exists (
select	1
from	fecxp_cat_subcodigo b
where	b.no_empresa = a.e_codigo
and		b.id_codigo = oracle.substr(a.referencia, 1, 2)
and		b.id_subcodigo = oracle.substr(a.referencia, 4, 3)
and		b.estatus = 'ACTIVO'
and		nullif(b.cla_fe_id::text, '') is not null
);
insert	into fecxp_ingresos_caratula_d_tmp(
cla_fe_id, e_codigo, folio_set, tipo_operacion, fecha, moneda, importe, id_banco, id_chequera, referencia, importe_linea, ora_soin_segmento1, ora_soin_segmento2, ora_soin_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6, oracle_segmento7, cual_erp, tipo_clasificacion)
select	t.cla_fe_id, t.e_codigo, t.folio_set, t.tipo_operacion, t.fecha, t.moneda, t.importe_linea, t.id_banco, t.id_chequera, t.referencia, coalesce(d.importe_linea, 0) importe_linea, coalesce(d.ora_soin_segmento1, '000') ora_soin_segmento1, coalesce(d.ora_soin_segmento2, '00') ora_soin_segmento2, coalesce(d.ora_soin_segmento3, '000') ora_soin_segmento3, coalesce(d.oracle_segmento4, '000000') ora_soin_segmento4, coalesce(d.oracle_segmento5, '00000000') ora_soin_segmento5, coalesce(d.oracle_segmento6, '000') ora_soin_segmento6, coalesce(d.oracle_segmento7, '0') ora_soin_segmento7, c.cual_erp, t.tipo_clasificacion
from fecxp_ingresos_caratula_tmp t, fecxc_empresas c, fecxc_dep_especiales e
left outer join fecxc_dep_especiales_d d on (e.secuencia_dep_especiales = d.secuencia_dep_especiales)
where e.no_empresa = c.e_codigo and e.no_empresa = t.e_codigo and e.no_folio_det = t.folio_set;
--==  clasificacion de ingresos oracle segun politicas de clasificacion de fe ==--
open	cursor_clas_fe_oracle_ing;
loop
fetch	cursor_clas_fe_oracle_ing
into	v_cla_fe_id, v_politica_erp_id, v_prioridad, v_tipo_operacion_ini, v_tipo_operacion_fin, v_id_banco_ini, v_id_banco_fin, v_id_chequera_ini, v_id_chequera_fin,
v_ora_s1_ini, v_ora_s1_fin, v_ora_s2_ini, v_ora_s2_fin, v_ora_s3_ini, v_ora_s3_fin, v_ora_s4_ini, v_ora_s4_fin, v_ora_s5_ini, v_ora_s5_fin, v_ora_s6_ini, v_ora_s6_fin, v_ora_s7_ini, v_ora_s7_fin;
exit when not found; /* apply on cursor_clas_fe_oracle_ing */
--== clasificaci.n de cuentas contables erp ==--
update	fecxp_ingresos_caratula_d_tmp
set		cla_fe_id = v_cla_fe_id,
tipo_clasificacion = 'POLITICAS'
where (e_codigo >= coalesce(v_ora_s1_ini, 0))
and (e_codigo <= coalesce(v_ora_s1_fin, 9999))
and (tipo_operacion >= coalesce(v_tipo_operacion_ini, 0))
and (tipo_operacion <= coalesce(v_tipo_operacion_fin, 9999))
and (id_banco >= coalesce(v_id_banco_ini, 0))
and (id_banco <= coalesce(v_id_banco_fin, 9999))
and (lpad(id_chequera::text, 20, '0'::text) >= coalesce(lpad(v_id_chequera_ini::text, 20, '0'::text), '00000000000000000000'))
and (lpad(id_chequera::text, 20, '0'::text) <= coalesce(lpad(v_id_chequera_fin::text, 20, '0'::text), '99999999999999999999'))
and (ora_soin_segmento1 >= coalesce(v_ora_s1_ini, '0'))
and (ora_soin_segmento1 <= coalesce(v_ora_s1_fin, 'z'))
and (ora_soin_segmento2 >= coalesce(v_ora_s2_ini, '0'))
and (ora_soin_segmento2 <= coalesce(v_ora_s2_fin, 'z'))
and (ora_soin_segmento3 >= coalesce(v_ora_s3_ini, '0'))
and (ora_soin_segmento3 <= coalesce(v_ora_s3_fin, 'z'))
and (oracle_segmento4 >= coalesce(v_ora_s4_ini, '0'))
and (oracle_segmento4 <= coalesce(v_ora_s4_fin, 'z'))
and (oracle_segmento5 >= coalesce(v_ora_s5_ini, '0'))
and (oracle_segmento5 <= coalesce(v_ora_s5_fin, 'z'))
and (oracle_segmento6 >= coalesce(v_ora_s6_ini, '0'))
and (oracle_segmento6 <= coalesce(v_ora_s6_fin, 'z'))
and (oracle_segmento7 >= coalesce(v_ora_s7_ini, '0'))
and (oracle_segmento7 <= coalesce(v_ora_s7_fin, 'z'))
and		e_codigo = coalesce(v_e_codigo, e_codigo)
and		coalesce(cla_fe_id, '|') = '|'
and		cual_erp = 'O';
end loop;
close cursor_clas_fe_oracle_ing;
--==  clasificacion de ingresos soin segun politicas de clasificacion de fe ==--
open	cursor_clas_fe_soin_ing;
loop
fetch	cursor_clas_fe_soin_ing
into	v_cla_fe_id, v_politica_erp_id, v_prioridad, v_tipo_operacion_ini, v_tipo_operacion_fin, v_id_banco_ini, v_id_banco_fin, v_id_chequera_ini, v_id_chequera_fin,
v_e_codigo_ini, v_e_codigo_fin, v_ctam01_ini, v_ctam01_fin, v_ctam02_ini, v_ctam02_fin, v_ctam03_ini, v_ctam03_fin, v_tipo_ini, v_tipo_fin, v_division_ini, v_division_fin, v_rubro_ini, v_rubro_fin, v_ctacr1_ini, v_ctacr1_fin, v_ctacr2_ini, v_ctacr2_fin;
exit when not found; /* apply on cursor_clas_fe_soin_ing */
--== clasificaci.n de cuentas contables erp ==--
update	fecxp_ingresos_caratula_d_tmp
set		cla_fe_id = v_cla_fe_id,
tipo_clasificacion = 'POLITICAS'
where (e_codigo >= coalesce(v_ora_s1_ini, 0))
and (e_codigo <= coalesce(v_ora_s1_fin, 9999))
and (tipo_operacion >= coalesce(v_tipo_operacion_ini, 0))
and (tipo_operacion <= coalesce(v_tipo_operacion_fin, 9999))
and (id_banco >= coalesce(v_id_banco_ini, 0))
and (id_banco <= coalesce(v_id_banco_fin, 9999))
and (lpad(id_chequera::text, 20, '0'::text) >= coalesce(lpad(v_id_chequera_ini::text, 20, '0'::text), '00000000000000000000'))
and (lpad(id_chequera::text, 20, '0'::text) <= coalesce(lpad(v_id_chequera_fin::text, 20, '0'::text), '99999999999999999999'))
and (ora_soin_segmento1 >= coalesce(v_ctam01_ini, '0'))
and (ora_soin_segmento1 <= coalesce(v_ctam01_fin, 'z'))
and (ora_soin_segmento2 >= coalesce(v_ctam02_ini, '0'))
and (ora_soin_segmento2 <= coalesce(v_ctam02_fin, 'z'))
and (ora_soin_segmento3 >= coalesce(v_ctam03_ini, '0'))
and (ora_soin_segmento3 <= coalesce(v_ctam03_fin, 'z'))
and		e_codigo = coalesce(v_e_codigo, e_codigo)
and		coalesce(cla_fe_id, '|') = '|'
and		cual_erp = 'S';
end loop;
close cursor_clas_fe_soin_ing;
insert	into fecxp_real_caratulad(
e_codigo, des_empresa, id_sesion_rc, fecha, moneda, tipo_cambio, cla_fe_id, cla_fe_des, importe_linea)
select	t.e_codigo, e.des_empresa, v_id_sesion, t.fecha, t.moneda, m.tipo_cambio, t.cla_fe_id, cf.cla_fe_des, t.importe_linea
from	fecxp_clasificacion_fe cf,
fecxp_ingresos_caratula_d_tmp t,
fecxc_empresas e,
fecxp_monedas m
where	t.e_codigo = e.e_codigo
and		t.cla_fe_id = cf.cla_fe_id
and		m.mon_oracle = t.moneda
and		e.e_codigo = coalesce(v_e_codigo, e.e_codigo)
and		m.periodo = (to_char(t.fecha, 'YYYY'))::numeric
and		m.mes = (to_char(t.fecha, 'MM'))::numeric;
/* commit; */
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
-- egresos
--== cargamos las cuentas contables que generaron movimiento durante el mes  ==--
insert	into fecxp_ctas_erp_caratula_tmp(
cla_fe_id, e_codigo, tipo_operacion, id_banco, id_chequera, oracle_segmento1, oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6, oracle_segmento7)
select	distinct '|' as cla_fe_id,
d.e_codigo, e.tipo_operacion, e.id_banco, e.id_chequera, d.oracle_segmento1, d.oracle_segmento2, d.oracle_segmento3, d.oracle_segmento4, d.oracle_segmento5, d.oracle_segmento6, d.oracle_segmento7
from	fecxp_enc_pagos_erp e,
fecxp_det_pagos_procesados d
where	e.fecha_aplicacion >= v_fecha_ini
and		e.fecha_aplicacion <= v_fecha_fin
and		e.e_codigo = coalesce(v_e_codigo, e.e_codigo)
and		e.e_codigo = d.e_codigo
and		e.secuencia_pagos_erp = d.secuencia_pagos_erp;
insert	into fecxp_ctas_soin_caratula2_tmp(
cla_fe_id, e_codigo, tipo_operacion, id_banco, id_chequera, ctam01, ctam02, ctam03, division, rubro, ctacr1, ctacr2)
select	distinct '|' as cla_fe_id,
e.e_codigo, e.tipo_operacion, e.id_banco, e.id_chequera, d.ctam01, d.ctam02, d.ctam03, 0, 0, '0', '0'
from	fecxp_enc_pagos_soin e,
fecxp_det_pagos_soin d
where	e.fecha_aplicacion >= v_fecha_ini
and		e.fecha_aplicacion <= v_fecha_fin
and		e.e_codigo = coalesce(v_e_codigo, e.e_codigo)
and		e.e_codigo = d.e_codigo
and		e.secuencia_pagos_soin = d.secuencia_pagos_soin;
update	fecxp_ctas_soin_caratula2_tmp c1
set(division, rubro) =
(
select	c2.cg13di, c2.cg13ru
from	fecxp_cat_cuentas_soin c2
where	  c1.ctam01 = c2.ctam01
and		c1.ctam02 = c2.ctam02
and		c1.ctam03 = c2.ctam03
)
where	exists (
select	c2.cg13ru
from	fecxp_cat_cuentas_soin c2
where	c1.ctam01 = c2.ctam01
and		c1.ctam02 = c2.ctam02
and		c1.ctam03 = c2.ctam03
);
--==  clasificacion de cuentas sesgun politicas de clasificacion de fe ==--
open cursor_clas_fe_oracle_egr;
loop
fetch	cursor_clas_fe_oracle_egr
into	v_cla_fe_id, v_politica_erp_id, v_prioridad, v_tipo_operacion_ini, v_tipo_operacion_fin, v_id_banco_ini, v_id_banco_fin, v_id_chequera_ini, v_id_chequera_fin,
v_ora_s1_ini, v_ora_s1_fin, v_ora_s2_ini, v_ora_s2_fin, v_ora_s3_ini, v_ora_s3_fin, v_ora_s4_ini, v_ora_s4_fin, v_ora_s5_ini, v_ora_s5_fin, v_ora_s6_ini, v_ora_s6_fin, v_ora_s7_ini, v_ora_s7_fin;
exit when not found; /* apply on cursor_clas_fe_oracle_egr */
--== clasificacion de cuentas contables erp ==--
update	fecxp_ctas_erp_caratula_tmp
set		cla_fe_id = v_cla_fe_id
where (tipo_operacion >= coalesce(v_tipo_operacion_ini, 0))
and (tipo_operacion <= coalesce(v_tipo_operacion_fin, 9999))
and (id_banco >= coalesce(v_id_banco_ini, 0))
and (id_banco <= coalesce(v_id_banco_fin, 9999))
and (lpad(id_chequera::text, 20, '0'::text) >= coalesce(lpad(v_id_chequera_ini::text, 20, '0'::text), '00000000000000000000'))
and (lpad(id_chequera::text, 20, '0'::text) <= coalesce(lpad(v_id_chequera_fin::text, 20, '0'::text), '99999999999999999999'))
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
close cursor_clas_fe_oracle_egr;
--== clasificacion flujo de efectivo para soin ==--
open cursor_clas_fe_soin_egr;
loop
fetch cursor_clas_fe_soin_egr
into	v_cla_fe_id, v_politica_erp_id, v_prioridad, v_tipo_operacion_ini, v_tipo_operacion_fin, v_id_banco_ini, v_id_banco_fin, v_id_chequera_ini, v_id_chequera_fin,
v_e_codigo_ini, v_e_codigo_fin, v_ctam01_ini, v_ctam01_fin, v_ctam02_ini, v_ctam02_fin, v_ctam03_ini, v_ctam03_fin, v_tipo_ini, v_tipo_fin, v_division_ini, v_division_fin, v_rubro_ini, v_rubro_fin, v_ctacr1_ini, v_ctacr1_fin, v_ctacr2_ini, v_ctacr2_fin;
exit when not found; /* apply on cursor_clas_fe_soin_egr */
--== se clasifican las cuentas de soin ==--
update	fecxp_ctas_soin_caratula2_tmp
set		cla_fe_id = v_cla_fe_id
where (tipo_operacion >= coalesce(v_tipo_operacion_ini, 0))
and (tipo_operacion <= coalesce(v_tipo_operacion_fin, 9999))
and (id_banco >= coalesce(v_id_banco_ini, 0))
and (id_banco <= coalesce(v_id_banco_fin, 9999))
and (lpad(id_chequera::text, 20, '0'::text) >= coalesce(lpad(v_id_chequera_ini::text, 20, '0'::text), '00000000000000000000'))
and (lpad(id_chequera::text, 20, '0'::text) <= coalesce(lpad(v_id_chequera_fin::text, 20, '0'::text), '99999999999999999999'))
and (e_codigo >= coalesce(v_e_codigo_ini, 0))
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
and		e_codigo = coalesce(v_e_codigo, e_codigo)
and		coalesce(cla_fe_id, '|') = '|';
end loop;
close cursor_clas_fe_soin_egr;
--== inicia la inclusion de informacion del erp ==--
insert	into fecxp_erp_caratula_tmpd(
e_codigo, des_empresa, fecha,
mon_oracle, tipo_cambio, importe, oracle_segmento1, oracle_segmento2, oracle_segmento3,
oracle_segmento4, oracle_segmento5, oracle_segmento6, oracle_segmento7, tipo_operacion, id_banco, id_chequera)
select	pe.e_codigo, e.des_empresa, pe.fecha_aplicacion,
m.mon_oracle, m.tipo_cambio,  (pp.importe_linea) importe, pp.oracle_segmento1, pp.oracle_segmento2, pp.oracle_segmento3,
pp.oracle_segmento4, pp.oracle_segmento5, pp.oracle_segmento6, pp.oracle_segmento7, pe.tipo_operacion, pe.id_banco, pe.id_chequera
from	fecxp_enc_pagos_erp pe,
fecxp_det_pagos_procesados pp,
fecxc_empresas e,
fecxp_monedas m
where	pe.fecha_aplicacion >= v_fecha_ini
and		pe.fecha_aplicacion <= v_fecha_fin
and		m.mes = (to_char(pe.fecha_aplicacion, 'MM'))::numeric
and		m.periodo = (to_char(pe.fecha_aplicacion, 'YYYY'))::numeric
and		m.mon_set = pe.moneda
and		e.e_codigo = pe.e_codigo
and		e.e_codigo = coalesce(v_e_codigo, e.e_codigo)
and		pe.secuencia_pagos_erp = pp.secuencia_pagos_erp;
insert	into fecxp_real_caratulad(
e_codigo, des_empresa, id_sesion_rc, fecha, moneda, tipo_cambio, cla_fe_id, cla_fe_des, importe_linea)
select	a.e_codigo, a.des_empresa,  v_id_sesion, a.fecha, a.mon_oracle, a.tipo_cambio, b.cla_fe_id, b.cla_fe_des, sum(a.importe * (b.cla_atributo3::numeric)::numeric )
from	fecxp_erp_caratula_tmpd a,
(
select	 c.e_codigo, c.tipo_operacion, c.id_banco, c.id_chequera, b.cla_fe_id, b.cla_fe_des, b.cla_atributo3, c.oracle_segmento1, c.oracle_segmento2, c.oracle_segmento3, c.oracle_segmento4, c.oracle_segmento5, c.oracle_segmento6, c.oracle_segmento7
from	 fecxp_clasificacion_fe b,
fecxp_ctas_erp_caratula_tmp c
where	b.cla_fe_id = c.cla_fe_id
) b
where	a.e_codigo = b.e_codigo
and		a.tipo_operacion = b.tipo_operacion
and		a.id_banco = b.id_banco
and		a.id_chequera = b.id_chequera
and		a.oracle_segmento1 = b.oracle_segmento1
and		a.oracle_segmento2 = b.oracle_segmento2
and		a.oracle_segmento3 = b.oracle_segmento3
and		a.oracle_segmento4 = b.oracle_segmento4
and		a.oracle_segmento5 = b.oracle_segmento5
and		a.oracle_segmento6 = b.oracle_segmento6
and		a.oracle_segmento7 = b.oracle_segmento7
and		a.e_codigo = coalesce(v_e_codigo, a.e_codigo)
group by a.e_codigo, a.des_empresa, a.fecha, a.mon_oracle, a.tipo_cambio, b.cla_fe_id, b.cla_fe_des;
--== empieza la inclusion de registros caratula soin ==--
insert	into fecxp_soin_caratula_tmpd(
e_codigo, des_empresa, fecha, mon_oracle, tipo_cambio, importe, ctam01, ctam02, ctam03, tipo_operacion, id_banco, id_chequera)
select	ep.e_codigo, e.des_empresa, ep.fecha_aplicacion,
m.mon_oracle, m.tipo_cambio, ps.importe_linea as importe, ps.ctam01, ps.ctam02, ps.ctam03, ep.tipo_operacion, ep.id_banco, ep.id_chequera
from	fecxp_enc_pagos_soin ep,
fecxp_det_pagos_soin ps,
fecxc_empresas e,
fecxp_monedas m
where	ep.fecha_aplicacion >= v_fecha_ini
and		ep.fecha_aplicacion <= v_fecha_fin
and		m.mes    = (to_char(ep.fecha_aplicacion, 'MM'))::numeric
and		m.periodo  = (to_char(ep.fecha_aplicacion, 'YYYY'))::numeric
and		e.e_codigo = coalesce(v_e_codigo, e.e_codigo)
and		m.mon_set		= ep.moneda
and		e.e_codigo = ep.e_codigo
and		ep.secuencia_pagos_soin = ps.secuencia_pagos_soin
and		ep.e_codigo = ps.e_codigo
and		ps.ctam01 <> '000';
insert	into fecxp_real_caratulad(
e_codigo, des_empresa, id_sesion_rc, fecha, moneda, tipo_cambio, cla_fe_id, cla_fe_des, importe_linea)
select	a.e_codigo, a.des_empresa, v_id_sesion, a.fecha, a.mon_oracle, a.tipo_cambio, b.cla_fe_id, b.cla_fe_des, sum(importe*b.cla_atributo3)
from	fecxp_soin_caratula_tmpd a,
(
select	c.e_codigo, c.tipo_operacion, c.id_banco, c.id_chequera, b.cla_fe_id, b.cla_atributo3, b.cla_fe_des,  c.ctam01, c.ctam02, c.ctam03
from	fecxp_clasificacion_fe b,
fecxp_ctas_soin_caratula2_tmp c
where	b.cla_fe_id = c.cla_fe_id
) b
where	a.e_codigo = b.e_codigo
and		a.e_codigo = coalesce(v_e_codigo, a.e_codigo)
and		a.tipo_operacion = b.tipo_operacion
and		a.id_banco = b.id_banco
and		a.id_chequera = b.id_chequera
and		a.ctam01 = b.ctam01
and		a.ctam02 = b.ctam02
and		a.ctam03 = b.ctam03
group by a.e_codigo, a.des_empresa, 1, a.fecha, a.mon_oracle, a.tipo_cambio, b.cla_fe_id, b.cla_fe_des;
--== termina la inclusion de registros caratula soin ==--
delete	from fecxp_importacion_datos_hist d
where	to_char(d.fecha, 'YYYYMMDD') >= to_char(v_fecha_ini, 'YYYYMMDD')
and		to_char(d.fecha, 'YYYYMMDD') <= to_char(v_fecha_fin, 'YYYYMMDD')
and		d.tipo_importacion = 'R'
and		exists (
select	1
from	fecxp_saldos_finales_clasif c
where	c.cla_fe_id = d.cla_fe_id_imp
and		c.atributo_4 = d.atributo_4
);
/* commit; */
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
-- importados
--== inserta registros importados que afectan al saldo ==--
insert	into fecxp_real_caratulad(
e_codigo, des_empresa, id_sesion_rc,  fecha,   moneda, tipo_cambio, cla_fe_id, cla_fe_des, importe_linea, estatus)
select	e.e_codigo, e.des_empresa, v_id_sesion,  d.fecha, d.moneda_imp, m.tipo_cambio, c.cla_fe_id, c.cla_fe_des, (c.cla_atributo3)::numeric  * d.importe_linea, 'IMPORTADO'
from	fecxp_monedas m,
fecxc_empresas e,
fecxp_clasificacion_fe c,
fecxp_importacion_datos_hist d
where	d.estatus_origen = 'IMPORTADO'
and		d.fecha >= v_fecha_ini
and		d.fecha <= v_fecha_fin
and		d.tipo_importacion in ('R', 'S')
and		e.e_codigo = coalesce(v_e_codigo, e.e_codigo)
and		e.e_codigo = d.e_empresa_imp
and		m.mon_oracle = d.moneda_imp
and		m.mes = d.mes
and		m.periodo = (to_char(d.fecha, 'YYYY'))::numeric
and		c.cla_fe_id = d.cla_fe_id_imp;
/* commit; */
-----------leo
---------------->>>>>>>>>> aqui inicie<<<<<<<<<<---------------------
-----**********------------------
delete	from fecxp_ajustes_saldos_finalesd;
v_fecha_act:= v_fecha_ini;
open cursor_saldos_finales_set;
loop
fetch cursor_saldos_finales_set
into v_fecha_act;
exit when not found; /* apply on cursor_saldos_finales_set */
insert	into fecxp_ajustes_saldos_finalesd(
tipo_dato, e_codigo, importe, moneda, fecha)
select	'S', c.e_codigo, sum(c.importe_linea) importe_linea, c.moneda, v_fecha_act
from (
select	c.e_codigo,
c.moneda,
c.fecha,
c.cla_fe_id,
c.importe_linea
from	fecxp_real_caratulad c
where	c.fecha = v_fecha_ene
and		c.cla_fe_id = 'SI'
union all
select	c.e_codigo,
c.moneda,
c.fecha,
c.cla_fe_id,
c.importe_linea
from	fecxp_real_caratulad c
where	c.fecha >= v_fecha_ene
and		c.cla_fe_id <> 'SI'
) c,
fecxp_clasificacion_fe f
where	f.genera_saldo = 1
and		c.cla_fe_id = f.cla_fe_id
and		c.e_codigo = coalesce(v_e_codigo, c.e_codigo)
and		c.fecha >= v_fecha_ene
and		c.fecha <= v_fecha_act
group by c.e_codigo, c.moneda;
insert	into fecxp_ajustes_saldos_finalesd
select	'A', sa.e_codigo,
ss.importe_set - sa.importe_ajustado,
sa.moneda, sa.fecha
from ( -- hay q poner el saldo recien capturado mas el ajuste del fecha anterior
select	e_codigo, sum(importe) importe_ajustado, fecha, moneda
from	fecxp_ajustes_saldos_finalesd
where	fecha = v_fecha_act
group by e_codigo, fecha, moneda
) sa,
(
select	e_codigo, sum(importe) importe_set, fecha, moneda
from	fecxp_saldos_finales_setd
where	fecha = v_fecha_act
group by e_codigo, moneda, fecha
) ss
where	sa.e_codigo = ss.e_codigo
and		sa.fecha = ss.fecha
and		sa.moneda = ss.moneda
and		sa.e_codigo = coalesce(v_e_codigo, sa.e_codigo)
and		sa.importe_ajustado - ss.importe_set <> 0;
insert	into fecxp_ajustes_saldos_finalesd
select	'I', sa.e_codigo,
ss.importe_set - sa.importe_ajustado,
sa.moneda, sa.fecha + 1
from ( -- hay q poner el saldo recien capturado mas el ajuste del fecha anterior
select	e_codigo, sum(importe) importe_ajustado, fecha, moneda
from	fecxp_ajustes_saldos_finalesd
where	fecha = v_fecha_act
group by e_codigo, fecha, moneda
) sa,
(
select	e_codigo, sum(importe) importe_set, fecha, moneda
from	fecxp_saldos_finales_setd
where	fecha = v_fecha_act
group by e_codigo, moneda, fecha
) ss
where	sa.e_codigo = ss.e_codigo
and		sa.fecha = ss.fecha
and		sa.moneda = ss.moneda
and		sa.e_codigo = coalesce(v_e_codigo, sa.e_codigo)
and		sa.importe_ajustado - ss.importe_set <> 0;
exit when not found; /* apply on cursor_saldos_finales_set */
end loop;
close cursor_saldos_finales_set;
insert	into fecxp_ajustes_saldos_finalesd
select	'I', e_codigo, -1 * sum(importe) importe_ajustado, moneda, fecha + 1
from	fecxp_ajustes_saldos_finalesd
where	tipo_dato = 'A'
and		e_codigo = coalesce(v_e_codigo, e_codigo)
group by tipo_dato, e_codigo, moneda, fecha + 1;
insert	into fecxp_importacion_datos_hist(
tipo_empresa_imp, tipo_importacion, e_empresa_imp, cla_fe_id_imp, importe_linea, moneda_imp, mes, fecha, atributo_4, estatus_origen)
select	e.tipoempresa, 'R', e.e_codigo, c.cla_fe_id, -1 * sum(s.importe), s.moneda, ((to_char(fecha, 'MM'))::numeric ) mes, fecha, c.atributo_4, 'IMPORTADO'
from	fecxc_empresas e,
fecxp_ajustes_saldos_finalesd s,
fecxp_saldos_finales_clasif c
where	e.e_codigo = s.e_codigo
and		s.tipo_dato <> 'S'
and		s.fecha >= v_fecha_ene
and		s.fecha <= v_fecha_fin
and		e.e_codigo = coalesce(v_e_codigo, e.e_codigo)
group by e.tipoempresa, e.e_codigo, c.cla_fe_id, s.moneda, s.fecha, clock_timestamp(), c.atributo_4;
--== calcula e inserta saldos ==--
insert	into fecxp_real_caratulad(
e_codigo, des_empresa, id_sesion_rc, fecha, moneda, tipo_cambio, cla_fe_id, cla_fe_des, importe_linea, estatus)
select	e.e_codigo, e.des_empresa, 1 v_id_sesion, s.fecha, s.moneda, m.tipo_cambio, cf.cla_fe_id, cf.cla_fe_des, -1 * (cf.cla_atributo3::numeric)::numeric  * sum(s.importe), 'IMPORTADO'
from	fecxc_empresas e,
fecxp_monedas m,
fecxp_ajustes_saldos_finalesd s,
fecxp_saldos_finales_clasif c,
fecxp_clasificacion_fe cf
where	s.tipo_dato <> 'S'
and		cf.cla_fe_id = c.cla_fe_id
and		e.e_codigo = s.e_codigo
and		s.fecha >= v_fecha_ene
and		s.fecha <= v_fecha_fin
and		s.moneda = m.mon_oracle
and		(to_char(s.fecha, 'MM'))::numeric  = m.mes
and		(to_char(s.fecha, 'YYYY'))::numeric  = m.periodo
and		e.e_codigo = coalesce(v_e_codigo, e.e_codigo)
group by e.e_codigo, e.des_empresa, -- v_id_sesion,
s.fecha, s.moneda, m.tipo_cambio, cf.cla_fe_id, cf.cla_fe_des, (cf.cla_atributo3)::numeric;
/* commit; */
v_fecha_act:= v_fecha_ini;
------------------------------------------------------------------------------
--== c!lcula e inserta saldos ==--
loop
-- inserta el saldo inicial del siguiente mes
insert	into fecxp_real_caratulad(
e_codigo, des_empresa, id_sesion_rc, fecha, moneda, tipo_cambio, cla_fe_id, cla_fe_des, importe_linea, estatus)
select	c.e_codigo, c.des_empresa, c.id_sesion_rc, v_fecha_act, c.moneda, c.tipo_cambio, 'SI', 'SALDO INICIAL', sum(c.importe_linea), 'CALCULADO'
from	fecxp_real_caratulad c,
fecxp_clasificacion_fe f
where	c.cla_fe_id = f.cla_fe_id
and		c.e_codigo = coalesce(v_e_codigo, c.e_codigo)
and		c.fecha = v_fecha_act - 1
and		v_fecha_act <> v_fecha_ene
and		f.genera_saldo = 1
and		c.cla_fe_id = 'SF'
group by c.e_codigo, c.des_empresa, c.id_sesion_rc, c.moneda, c.tipo_cambio;
--== calcula de saldos finales para las empresas que hayan generado fe ==--
insert	into fecxp_real_caratulad(
e_codigo, des_empresa, id_sesion_rc, fecha, moneda, tipo_cambio, cla_fe_id, cla_fe_des, importe_linea, estatus)
select	c.e_codigo, c.des_empresa, c.id_sesion_rc, c.fecha, c.moneda, c.tipo_cambio, 'SF', 'SALDO FINAL SET', sum(c.importe_linea), 'CALCULADO'
from	fecxp_real_caratulad c,
fecxp_clasificacion_fe f
where	c.cla_fe_id = f.cla_fe_id
and		c.e_codigo = coalesce(v_e_codigo, c.e_codigo)
and		c.fecha = v_fecha_act
and		f.genera_saldo = 1
-- and		c.cla_fe_id <> 'SF'
group by c.e_codigo, c.des_empresa, c.id_sesion_rc, c.fecha, c.moneda, c.tipo_cambio;
exit when to_char(v_fecha_act, 'YYYYMMDD') >= to_char(v_fecha_fin, 'YYYYMMDD');
v_fecha_act:= v_fecha_act + 1;
end loop;
/* commit; */
-- end;
exception
when no_data_found then
raise exception '%', 'NO HAY DATOS NUEVOS.' using errcode = '45000';end;
$body$
language plpgsql
;
