create or replace procedure fecxc."fecxp_llena_det_cont_erp"  ( v_fecha_ini datedefault sysdate-12, v_version_fe numeric, v_mes_desde numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_e_codigo integer;
v_periodo integer:= (to_char(clock_timestamp(), 'YYYY'))::numeric;
v_fecha_fin timestamp(0):= clock_timestamp();
v_mes_act integer := (to_char(clock_timestamp(), 'MM'))::numeric;
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
cursor_clasificacion_fe_ing cursor for
select	cla_fe_id, politica_erp_id, prioridad, tipo_operacion_ini, tipo_operacion_fin, id_banco_ini, id_banco_fin, id_chequera_ini, id_chequera_fin,
oracle_segmento1_ini, oracle_segmento1_fin, oracle_segmento2_ini, oracle_segmento2_fin, oracle_segmento3_ini, oracle_segmento3_fin, oracle_segmento4_ini, oracle_segmento4_fin, oracle_segmento5_ini, oracle_segmento5_fin, oracle_segmento6_ini, oracle_segmento6_fin, oracle_segmento7_ini, oracle_segmento7_fin
from	fecxp_politicas_erp
where	id_tipo_movto in ('A', 'I')
and		activa_regla = 1
order by prioridad asc;
cursor_clasificacion_fe_egr cursor for
select	cla_fe_id, politica_erp_id, prioridad, tipo_operacion_ini, tipo_operacion_fin, id_banco_ini, id_banco_fin, id_chequera_ini, id_chequera_fin,
oracle_segmento1_ini, oracle_segmento1_fin, oracle_segmento2_ini, oracle_segmento2_fin, oracle_segmento3_ini, oracle_segmento3_fin, oracle_segmento4_ini, oracle_segmento4_fin, oracle_segmento5_ini, oracle_segmento5_fin, oracle_segmento6_ini, oracle_segmento6_fin, oracle_segmento7_ini, oracle_segmento7_fin
from	fecxp_politicas_erp
where	id_tipo_movto in ('A', 'E')
and		activa_regla = 1
order by prioridad asc;
begin 

/*modificacion mayo 09 v4  referencia,desc y nocte */
/*modificacion abr 09 v3.  crear detalles de inversion y coinversion*/
/*modificacion dic 08 v2.*/
--===============================================================================================--
--== empieza real ==--
delete	from fecxp_ingresos_clasif
where	e_codigo = coalesce(v_e_codigo, e_codigo)
and		e_codigo in (
select e_codigo
from fecxc_empresas
where cual_erp = 'O'
);
/* commit; */
delete	from fecxp_ctas_clasif_real_erp
where	e_codigo = coalesce(v_e_codigo, e_codigo);
/* commit; */
delete	from fecxp_pagos_erp_clasif
where	e_codigo = coalesce(v_e_codigo, e_codigo);
/* commit; */
delete from fecxp_det_reales_coinversion
where	e_codigo = coalesce(v_e_codigo, e_codigo)
and		e_codigo in (
select e_codigo
from fecxc_empresas
where cual_erp = 'O'
);
/* commit; */
delete from fecxp_det_reales_inversion
where	e_codigo = coalesce(v_e_codigo, e_codigo)
and		e_codigo in (
select e_codigo
from fecxc_empresas
where cual_erp = 'O'
);
/* commit; */
insert	into fecxp_ctas_clasif_real_erp(
cla_fe_id, e_codigo, tipo_operacion, id_banco, id_chequera, oracle_segmento1, oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6, oracle_segmento7)
select	distinct '|'as cla_id, d.e_codigo, e.tipo_operacion, e.id_banco, e.id_chequera, d.oracle_segmento1, d.oracle_segmento2, d.oracle_segmento3, d.oracle_segmento4, d.oracle_segmento5, d.oracle_segmento6, d.oracle_segmento7
from	fecxp_enc_pagos_erp e,
fecxp_det_pagos_procesados d
where	e.e_codigo = coalesce(v_e_codigo, e.e_codigo)
and		e.fecha_aplicacion >= v_fecha_ini
and		e.fecha_aplicacion <= v_fecha_fin
and		e.e_codigo = d.e_codigo
and		e.secuencia_pagos_erp = d.secuencia_pagos_erp;
/* commit; */
open cursor_clasificacion_fe_egr;
loop
fetch	cursor_clasificacion_fe_egr
into	v_cla_fe_id, v_politica_erp_id, v_prioridad, v_tipo_operacion_ini, v_tipo_operacion_fin, v_id_banco_ini, v_id_banco_fin, v_id_chequera_ini, v_id_chequera_fin,
v_ora_s1_ini, v_ora_s1_fin, v_ora_s2_ini, v_ora_s2_fin, v_ora_s3_ini, v_ora_s3_fin, v_ora_s4_ini, v_ora_s4_fin, v_ora_s5_ini, v_ora_s5_fin, v_ora_s6_ini, v_ora_s6_fin, v_ora_s7_ini, v_ora_s7_fin;
exit when not found; /* apply on cursor_clasificacion_fe_egr */
--== clasificaci?n de cuentas contables erp ==--
update	fecxp_ctas_clasif_real_erp
set		cla_fe_id = v_cla_fe_id
where (tipo_operacion >= coalesce(v_tipo_operacion_ini, 0))
and (tipo_operacion <= coalesce(v_tipo_operacion_fin, 9999))
and (id_banco >= coalesce(v_id_banco_ini, 0))
and (id_banco <= coalesce(v_id_banco_fin, 9999))
and (lpad(id_chequera::text, 20, '0'::text) >= coalesce(lpad(v_id_chequera_ini::text, 20, '0'::text), '00000000000000000000'))
and (lpad(id_chequera::text, 20, '0'::text) <= coalesce(lpad(v_id_chequera_fin::text, 20, '0'::text), '99999999999999999999'))
and (oracle_segmento1 >= coalesce(v_ora_s1_ini, '0'))
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
and		e_codigo = coalesce(v_e_codigo, e_codigo)
and		coalesce(cla_fe_id, '|') = '|';
/* commit; */
end loop;
close cursor_clasificacion_fe_egr;
--abr 09  se agrega distinct para evitar duplicados
--may 09 agregar descripcion y referencia
insert into fecxp_pagos_erp_clasif(
e_codigo, folio_set, tipo_operacion, estatus_movimiento, id_chequera, id_banco, no_cliente,
forma_pago, fecha_aplicacion, moneda, tipo_cambio, origen_movimiento, importe,
numero_de_partida_erp, oracle_segmento1, oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6, oracle_segmento7, importe_linea,
concepto, beneficiario, sec_det_pag_proc,referencia, descripcion)
select	distinct e.e_codigo, e.folio_set, e.tipo_operacion, e.estatus_movimiento, e.id_chequera, e.id_banco, e.no_cliente,
e.forma_pago, e.fecha_aplicacion, e.moneda, e.tipo_cambio, e.origen_movimiento, case when e.estatus_movimiento in ('X', 'Y', 'Z') then -1 else 1 end * e.importe importe,
d.numero_de_partida_erp, d.oracle_segmento1, d.oracle_segmento2, d.oracle_segmento3, d.oracle_segmento4, d.oracle_segmento5, d.oracle_segmento6, d.oracle_segmento7, d.importe_linea,
e.concepto, e.beneficiario, d.sec_det_pag_proc,coalesce(e.referencia, '<SIN REFERENCIA>') referencia , coalesce(e.descripcion, '<SIN DESCRIPCION>') descripcion
from	fecxp_enc_pagos_erp e,
fecxp_det_pagos_procesados d
where	e.e_codigo = coalesce(v_e_codigo, e.e_codigo)
and		e.fecha_aplicacion >= v_fecha_ini
and		e.fecha_aplicacion <= v_fecha_fin
and		e.e_codigo = d.e_codigo
and		e.secuencia_pagos_erp = d.secuencia_pagos_erp;
------------------------------------------------------------------------------------------------
--== inserta y clasifica ingresos cobranza e icia ==--
------------------------------------------------------------------------------------------------
--== toma ingresos del m?dulo fecxc ?nicamente ==--
--may 09 agregar descripcion y referencia
insert	into fecxp_ingresos_clasif(
cla_fe_id, e_codigo, folio_set, tipo_operacion, fecha, moneda, tipo_cambio, importe, concepto, beneficiario, id_status_mov, id_chequera, id_banco, id_forma_pago, referencia, tipo_clasificacion, no_cliente,
importe_linea, ora_soin_segmento1, ora_soin_segmento2, ora_soin_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6, oracle_segmento7, cual_erp, descripcion)
select	i.cod_valor,  i.no_empresa, i.no_folio_det, i.id_tipo_operacion_set, i.fec_valor, i.moneda, i.tipo_cambio, i.importe, i.concepto, i.beneficiario, i.id_status_mov, i.id_chequera, i.id_banco, i.id_forma_pago, i.referencia, case coalesce(i.cod_valor, '|') when '|' then null else 'MODULO FECXC' end, i.no_cliente,
i.importe_linea, '000', '00', '000', '000000', '00000000', '000', '0', i.cual_erp, i.descripcion
from	(
select	coalesce(b.cod_valor, '|') cod_valor,
a.no_empresa,
a.no_folio_det,
a.fec_valor,
a.importe,
m.mon_oracle moneda,
a.id_tipo_operacion_set,
a.id_banco,
a.id_chequera,
coalesce(b.importe_detalle, a.importe) importe_linea,
coalesce(a.referencia, '<SIN REFERENCIA>') referencia,
a.tipo_cambio, a.concepto, a.beneficiario, a.id_status_mov, a.id_forma_pago,
c.cual_erp,
a.no_cliente,
coalesce(a.descripcion,'<SIN DESCRIPCION>') descripcion
from	fecxc_dep_especiales a,
fecxp_monedas m,
(
select	base_inf.codfolio, base_inf.e_codigo, base_inf.segmento1, base_inf.codoperacion, base_inf.tipocambio, base_inf.importe, base_inf.importe_detalle,
base_inf.f_deposito,  base_inf.segmento2, base_inf.cod_sec_det,
base_inf.cod_sec_catclas, base_inf.secmoneda,cod_flujo.cod_valor, cod_flujo.desc_valor
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
h1.desc_valor, g1.sec_concepto_detcat, g1.cod_sec_det, g1.cod_sec_catclas
from	fecxc_mapeo_flujo g1, fecxc_det_catalogos h1
where	g1.sec_flujo_detcat = h1.cod_sec_lin
and		h1.tipo_cat = 'FLUJO'
union
select	-1, -1, 'NO MAPEADOS', 'NO MAPEADOS', -1,-1,-1
) cod_flujo on (base_inf.segmento1 = cod_flujo.cod_sec_lin and base_inf.segmento2 = cod_flujo.sec_concepto_detcat and base_inf.cod_sec_catclas = cod_flujo.cod_sec_catclas and base_inf.cod_sec_det = cod_flujo.cod_sec_det) ) b,
fecxc_empresas c
where	a.no_empresa = b.e_codigo
and		a.no_folio_det = b.codfolio
and		a.fec_valor >= v_fecha_ini
and		a.fec_valor <= v_fecha_fin
and 	c.cual_erp = 'O'
and 	a.no_empresa = c.e_codigo
and		m.mon_set = a.id_divisa
and		(to_char(a.fec_valor, 'MM'))::numeric  = m.mes
and		(to_char(a.fec_valor, 'YYYY'))::numeric  = m.periodo
) i
where	i.no_empresa = coalesce(v_e_codigo, i.no_empresa);
------------------------------------------------------------------------------------------------
--== toma el resto de los ingresos con y sin detalle contable ==--
--may 09 se agrega referencia y descripcion
insert	into fecxp_ingresos_clasif(
cla_fe_id, e_codigo, folio_set, tipo_operacion, fecha, moneda, tipo_cambio, importe, concepto, beneficiario, id_status_mov, id_chequera, id_banco, id_forma_pago, referencia, tipo_clasificacion, no_cliente,
importe_linea, ora_soin_segmento1, ora_soin_segmento2, ora_soin_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6, oracle_segmento7, cual_erp,descripcion)
select	'|',  e.no_empresa, e.no_folio_det, e.id_tipo_operacion_set, e.fec_valor, m.mon_oracle, e.tipo_cambio, e.importe, e.concepto, e.beneficiario, e.id_status_mov, e.id_chequera, e.id_banco, e.id_forma_pago,
coalesce(e.referencia, '<SIN REFERENCIA>') referencia, null, e.no_cliente,
coalesce(d.importe_linea, e.importe) importe_linea,
coalesce(d.ora_soin_segmento1, '000') ora_soin_segmento1,  --segmento 1
coalesce(d.ora_soin_segmento2, '00') ora_soin_segmento2,
coalesce(d.ora_soin_segmento3, '000') ora_soin_segmento3,
coalesce(d.oracle_segmento4, '000000') ora_soin_segmento4,
coalesce(d.oracle_segmento5, '00000000') ora_soin_segmento5,
coalesce(d.oracle_segmento6, '000') ora_soin_segmento6,
coalesce(d.oracle_segmento7, '0') ora_soin_segmento7,
c.cual_erp,
coalesce(e.descripcion, '<SIN DESCRIPCION>') descripcion
from fecxp_monedas m, fecxc_empresas c, fecxc_dep_especiales e
left outer join fecxc_dep_especiales_d d on (e.secuencia_dep_especiales = d.secuencia_dep_especiales)
where e.fec_valor >= v_fecha_ini and e.fec_valor <= v_fecha_fin and e.no_empresa = coalesce(v_e_codigo, e.no_empresa)  and e.no_empresa = c.e_codigo and c.cual_erp = 'O' and m.mon_set = e.id_divisa and (to_char(e.fec_valor, 'MM'))::numeric  = m.mes and (to_char(e.fec_valor, 'YYYY'))::numeric  = m.periodo and not exists (
select	1
from	fecxp_ingresos_clasif i
where	e.no_empresa = i.e_codigo
and		e.no_folio_det = i.folio_set
and	e.id_status_mov = i.id_status_mov --para cancelados
);
/* commit; */
-- clasifica por referencias
update	fecxp_ingresos_clasif a
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
where	a.ora_soin_segmento1 = '000'
and		oracle.substr(a.referencia, 3, 1) = '9'
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
--==  clasificacion de cuentas sesgun politicas de clasificacion de fe ==--
open	cursor_clasificacion_fe_ing;
loop
fetch	cursor_clasificacion_fe_ing
into	v_cla_fe_id, v_politica_erp_id, v_prioridad, v_tipo_operacion_ini, v_tipo_operacion_fin, v_id_banco_ini, v_id_banco_fin, v_id_chequera_ini, v_id_chequera_fin,
v_ora_s1_ini, v_ora_s1_fin, v_ora_s2_ini, v_ora_s2_fin, v_ora_s3_ini, v_ora_s3_fin, v_ora_s4_ini, v_ora_s4_fin, v_ora_s5_ini, v_ora_s5_fin, v_ora_s6_ini, v_ora_s6_fin, v_ora_s7_ini, v_ora_s7_fin;
exit when not found; /* apply on cursor_clasificacion_fe_ing */
--== clasificaci.n de cuentas contables erp ==--
update	fecxp_ingresos_clasif
set		cla_fe_id = v_cla_fe_id,
tipo_clasificacion = 'POL?TICAS'
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
/* commit; */
end loop;
close cursor_clasificacion_fe_ing;
/* commit; */
--== detalle coinversion ==--
---1) se insertan los egresos de coinversion
insert	into fecxp_det_reales_coinversion(
e_codigo, folio_set, tipo_operacion,estatus_movimiento, secuencia_id, cla_fe_id, cla_fe_des,
id_chequera,id_banco,forma_pago,fecha_aplicacion,moneda,tipo_cambio,importe,
numero_de_partida_erp,ora_soin_segmento1, ora_soin_segmento2, ora_soin_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6, oracle_segmento7,
importe_linea,concepto,beneficiario,no_cliente,referencia,descripcion,id_tipo_movto,tipo_erp)
select  e.no_cuenta, e.folio_set, e.tipo_operacion,e.estatus_movimiento, e.secuencia_pagos_erp,p.cla_fe_id,p.cla_fe_des,
e.id_chequera, e.id_banco,e.forma_pago, e.fecha_aplicacion, e.moneda, e.tipo_cambio,
case when e.estatus_movimiento in ('X', 'Y', 'Z') then -1 else 1 end * e.importe importe,
d.numero_de_partida_erp, d.oracle_segmento1, d.oracle_segmento2, d.oracle_segmento3, d.oracle_segmento4, d.oracle_segmento5, d.oracle_segmento6, d.oracle_segmento7,
d.importe_linea,e.concepto, e.beneficiario,e.no_cliente,coalesce(e.referencia,'<SIN REFERENCIA>') referencia, coalesce(e.descripcion,'<SIN DESCRIPCION>') descripcion,
'E','O'
from 	fecxp_enc_pagos_erp e,
fecxp_det_pagos_procesados d,
fecxp_cla_fe_nochequera p,
fecxc_empresas c,
fecxp_monedas m
where	e.e_codigo = 999
and 	e.tipo_operacion in (3706,7001,7002,7003)
and		e.fecha_aplicacion >= v_fecha_ini
and		e.fecha_aplicacion <= v_fecha_fin
and 	c.e_codigo = e.no_cuenta
and		c.cual_erp = 'O'
and		e.e_codigo = d.e_codigo
and		e.secuencia_pagos_erp = d.secuencia_pagos_erp
and		p.tipo_operacion = e.tipo_operacion
and		p.id_tipo_movto = 'E'
and		p.tipo_clave = 'CO'
and		m.mon_set = e.moneda
and		(to_char(e.fecha_aplicacion, 'MM'))::numeric  = m.mes
and		(to_char(e.fecha_aplicacion, 'YYYY'))::numeric  = m.periodo
;
---2) se insertan los ingresos de coinversion oracle
insert	into fecxp_det_reales_coinversion(
e_codigo, folio_set, tipo_operacion,estatus_movimiento, secuencia_id, cla_fe_id, cla_fe_des,
id_chequera,id_banco,forma_pago,fecha_aplicacion,moneda,tipo_cambio,importe,
numero_de_partida_erp,ora_soin_segmento1, ora_soin_segmento2, ora_soin_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6, oracle_segmento7,
importe_linea,concepto,beneficiario,no_cliente,referencia,descripcion,id_tipo_movto,tipo_erp)
select  e.no_cuenta, e.no_folio_det, e.id_tipo_operacion_set,e.id_status_mov, e.secuencia_dep_especiales,p.cla_fe_id,p.cla_fe_des,
e.id_chequera, e.id_banco,e.id_forma_pago, e.fec_valor, e.id_divisa, e.tipo_cambio,e.importe,
0,
coalesce(d.ora_soin_segmento1, '000') ora_soin_segmento1,  --segmento 1
coalesce(d.ora_soin_segmento2, '00') ora_soin_segmento2,
coalesce(d.ora_soin_segmento3, '000') ora_soin_segmento3,
coalesce(d.oracle_segmento4, '000000') ora_soin_segmento4,
coalesce(d.oracle_segmento5, '00000000') ora_soin_segmento5,
coalesce(d.oracle_segmento6, '000') ora_soin_segmento6,
coalesce(d.oracle_segmento7, '0') ora_soin_segmento7,
coalesce(d.importe_linea, e.importe) importe_linea,
e.concepto, e.beneficiario,e.no_cliente,
coalesce(e.referencia, '<SIN REFERENCIA>') referencia,
coalesce(e.descripcion,'<SIN DESCRIPCION>') descripcion,
'I',e.plataforma
from fecxp_cla_fe_nochequera p, fecxp_monedas m, fecxc_empresas c, fecxc_dep_especiales e
left outer join fecxc_dep_especiales_d d on (e.secuencia_dep_especiales = d.secuencia_dep_especiales)
where e.no_empresa = 999 and e.id_tipo_operacion_set in (3705,7000,7005) and e.fec_valor >= v_fecha_ini and e.fec_valor <= v_fecha_fin  and p.tipo_operacion = e.id_tipo_operacion_set and p.id_tipo_movto = 'I' and p.tipo_clave = 'CO' and e.no_cuenta = c.e_codigo and c.cual_erp = 'O' and m.mon_set = e.id_divisa and (to_char(e.fec_valor, 'MM'))::numeric  = m.mes and (to_char(e.fec_valor, 'YYYY'))::numeric  = m.periodo
;
--== detalle inversion ==--
--1obtener los ingresos de inversion y darles clave de flujo, se abre por detalle de pago
--1.1 obtener inversiones oracle y regrso de isr
insert	into fecxp_det_reales_inversion(
e_codigo, folio_set, tipo_operacion,estatus_movimiento, secuencia_id, cla_fe_id, cla_fe_des,
id_chequera,id_banco,forma_pago,fecha_aplicacion,moneda,tipo_cambio,importe,
numero_de_partida_erp,ora_soin_segmento1, ora_soin_segmento2, ora_soin_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6, oracle_segmento7,
importe_linea,concepto,beneficiario,no_cliente,referencia,descripcion,id_tipo_movto,tipo_erp)
select  e.e_codigo, e.folio_set, e.tipo_operacion,e.estatus_movimiento, e.secuencia_pagos_erp,p.cla_fe_id,p.cla_fe_des,
e.id_chequera, e.id_banco,e.forma_pago, e.fecha_aplicacion, e.moneda, e.tipo_cambio,
case when e.estatus_movimiento in ('X', 'Y', 'Z') then -1 else 1 end * e.importe importe,
d.numero_de_partida_erp, d.oracle_segmento1, d.oracle_segmento2, d.oracle_segmento3, d.oracle_segmento4, d.oracle_segmento5, d.oracle_segmento6, d.oracle_segmento7,
d.importe_linea ,e.concepto, e.beneficiario,e.no_cliente,coalesce(e.referencia,'<SIN REFERENCIA>') referencia, coalesce(e.descripcion,'<SIN DESCRIPCION>') descripcion,
'I','O'
from 	fecxp_enc_pagos_erp e,
fecxp_det_pagos_procesados d,
fecxp_cla_fe_nochequera p,
fecxc_empresas c,
fecxp_monedas m
where	e.e_codigo = coalesce(v_e_codigo, e.e_codigo)
and 	e.tipo_operacion in (4001,4104)
and		e.fecha_aplicacion >= v_fecha_ini
and		e.fecha_aplicacion <= v_fecha_fin
and		e.e_codigo = d.e_codigo
and		e.secuencia_pagos_erp = d.secuencia_pagos_erp
and		p.tipo_operacion = e.tipo_operacion
and		p.id_tipo_movto = 'I'
and		p.tipo_clave = 'IN'
and		c.e_codigo = e.e_codigo
and		m.mon_set = e.moneda
and		(to_char(e.fecha_aplicacion, 'MM'))::numeric  = m.mes
and		(to_char(e.fecha_aplicacion, 'YYYY'))::numeric  = m.periodo
and		c.cual_erp = 'O'
;
---1.3 obtener la 4103  como ingreso
insert	into fecxp_det_reales_inversion(
e_codigo, folio_set, tipo_operacion,estatus_movimiento, secuencia_id, cla_fe_id, cla_fe_des,
id_chequera,id_banco,forma_pago,fecha_aplicacion,moneda,tipo_cambio,importe,
numero_de_partida_erp,ora_soin_segmento1, ora_soin_segmento2, ora_soin_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6, oracle_segmento7,
importe_linea,concepto,beneficiario,no_cliente,referencia,descripcion,id_tipo_movto,tipo_erp)
select  e.no_empresa, e.no_folio_det, e.id_tipo_operacion_set,e.id_status_mov, e.secuencia_dep_especiales,p.cla_fe_id,p.cla_fe_des,
e.id_chequera, e.id_banco,e.id_forma_pago, e.fec_valor, e.id_divisa, e.tipo_cambio,e.importe,
0,
coalesce(d.ora_soin_segmento1, '000') ora_soin_segmento1,  --segmento 1
coalesce(d.ora_soin_segmento2, '00') ora_soin_segmento2,
coalesce(d.ora_soin_segmento3, '000') ora_soin_segmento3,
coalesce(d.oracle_segmento4, '000000') ora_soin_segmento4,
coalesce(d.oracle_segmento5, '00000000') ora_soin_segmento5,
coalesce(d.oracle_segmento6, '000') ora_soin_segmento6,
coalesce(d.oracle_segmento7, '0') ora_soin_segmento7,
coalesce(d.importe_linea, e.importe) importe_linea,
e.concepto, e.beneficiario,e.no_cliente,
coalesce(e.referencia,'<SIN REFERENCIA>') referencia,
coalesce(e.descripcion,'<SIN DESCRIPCION>') descripcion,
'I',e.plataforma
from fecxp_cla_fe_nochequera p, fecxp_monedas m, fecxc_empresas c, fecxc_dep_especiales e
left outer join fecxc_dep_especiales_d d on (e.secuencia_dep_especiales = d.secuencia_dep_especiales)
where e.id_tipo_operacion_set =4103 and e.fec_valor >= v_fecha_ini and e.fec_valor <= v_fecha_fin  and p.tipo_operacion = e.id_tipo_operacion_set and p.id_tipo_movto = 'I' and p.tipo_clave = 'IN' and e.no_empresa = c.e_codigo and c.cual_erp = 'O' and m.mon_set = e.id_divisa and (to_char(e.fec_valor, 'MM'))::numeric  = m.mes and (to_char(e.fec_valor, 'YYYY'))::numeric  = m.periodo
;
---- clasificar los egresos
--- 2.1 obtener el regreso de inversion 4102 y el interes ganado
insert	into fecxp_det_reales_inversion(
e_codigo, folio_set, tipo_operacion,estatus_movimiento, secuencia_id, cla_fe_id, cla_fe_des,
id_chequera,id_banco,forma_pago,fecha_aplicacion,moneda,tipo_cambio,importe,
numero_de_partida_erp,ora_soin_segmento1, ora_soin_segmento2, ora_soin_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6, oracle_segmento7,
importe_linea,concepto,beneficiario,no_cliente,referencia,descripcion,id_tipo_movto,tipo_erp)
select  e.no_empresa, e.no_folio_det, e.id_tipo_operacion_set,e.id_status_mov, e.secuencia_dep_especiales,p.cla_fe_id,p.cla_fe_des,
e.id_chequera, e.id_banco,e.id_forma_pago, e.fec_valor, e.id_divisa, e.tipo_cambio,e.importe,
0,
coalesce(d.ora_soin_segmento1, '000') ora_soin_segmento1,  --segmento 1
coalesce(d.ora_soin_segmento2, '00') ora_soin_segmento2,
coalesce(d.ora_soin_segmento3, '000') ora_soin_segmento3,
coalesce(d.oracle_segmento4, '000000') ora_soin_segmento4,
coalesce(d.oracle_segmento5, '00000000') ora_soin_segmento5,
coalesce(d.oracle_segmento6, '000') ora_soin_segmento6,
coalesce(d.oracle_segmento7, '0') ora_soin_segmento7,
case when e.id_tipo_operacion_set=4103 then (p.cla_atributo3)::numeric  else 1 end * coalesce(d.importe_linea, e.importe) importe_linea,
e.concepto, e.beneficiario,e.no_cliente,
coalesce(e.referencia, '<SIN REFERENCIA>') referencia,
coalesce(e.descripcion,'<SIN DESCRIPCION>') descripcion,
'E',e.plataforma
from fecxp_cla_fe_nochequera p, fecxp_monedas m, fecxc_empresas c, fecxc_dep_especiales e
left outer join fecxc_dep_especiales_d d on (e.secuencia_dep_especiales = d.secuencia_dep_especiales)
where e.id_tipo_operacion_set in (4102,4103) and e.fec_valor >= v_fecha_ini and e.fec_valor <= v_fecha_fin  and p.tipo_operacion = e.id_tipo_operacion_set and p.id_tipo_movto = 'E' and p.tipo_clave = 'IN' and e.no_empresa = c.e_codigo and c.cual_erp = 'O' and m.mon_set = e.id_divisa and (to_char(e.fec_valor, 'MM'))::numeric  = m.mes and (to_char(e.fec_valor, 'YYYY'))::numeric  = m.periodo and c.cual_erp = 'O'
;
--2.2 obtener el isr oracle como egreso
insert	into fecxp_det_reales_inversion(
e_codigo, folio_set, tipo_operacion,estatus_movimiento, secuencia_id, cla_fe_id, cla_fe_des,
id_chequera,id_banco,forma_pago,fecha_aplicacion,moneda,tipo_cambio,importe,
numero_de_partida_erp,ora_soin_segmento1, ora_soin_segmento2, ora_soin_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6, oracle_segmento7,
importe_linea,concepto,beneficiario,no_cliente,referencia,descripcion,id_tipo_movto,tipo_erp)
select  e.e_codigo, e.folio_set, e.tipo_operacion,e.estatus_movimiento, e.secuencia_pagos_erp,p.cla_fe_id,p.cla_fe_des,
e.id_chequera, e.id_banco,e.forma_pago, e.fecha_aplicacion, e.moneda, e.tipo_cambio,
case when e.estatus_movimiento in ('X', 'Y', 'Z') then -1 else 1 end * e.importe importe,
d.numero_de_partida_erp, d.oracle_segmento1, d.oracle_segmento2, d.oracle_segmento3, d.oracle_segmento4, d.oracle_segmento5, d.oracle_segmento6, d.oracle_segmento7,
d.importe_linea * (p.cla_atributo3::numeric)::numeric  importe_linea ,e.concepto, e.beneficiario,e.no_cliente,coalesce(e.referencia,'<SIN REFERENCIA>') referencia, coalesce(e.descripcion,'<SIN DESCRIPCION>') descripcion,
'E','O'
from 	fecxp_enc_pagos_erp e,
fecxp_det_pagos_procesados d,
fecxp_cla_fe_nochequera p,
fecxc_empresas c,
fecxp_monedas m
where	e.e_codigo = coalesce(v_e_codigo, e.e_codigo)
and 	e.tipo_operacion =4104
and		e.fecha_aplicacion >= v_fecha_ini
and		e.fecha_aplicacion <= v_fecha_fin
and		e.e_codigo = d.e_codigo
and		e.secuencia_pagos_erp = d.secuencia_pagos_erp
and		p.tipo_operacion = e.tipo_operacion
and		p.id_tipo_movto = 'E'
and		p.tipo_clave = 'IN'
and		c.e_codigo = e.e_codigo
and		m.mon_set = e.moneda
and		(to_char(e.fecha_aplicacion, 'MM'))::numeric  = m.mes
and		(to_char(e.fecha_aplicacion, 'YYYY'))::numeric  = m.periodo
and		c.cual_erp = 'O'
;
--===============================================================================================--
--== termina real ==--
--===============================================================================================--
--== empieza ppto ==--
--== limpia tabla de enlace  ==--
delete	from fecxp_rep_ppto_com_cta_erp
where	e_codigo = coalesce(v_e_codigo, e_codigo)
and		code_combination_id > 0;
/* commit; */
--== se cargan las cuentas contables del presupuesto  ==--
insert	into fecxp_rep_ppto_com_cta_erp(cla_fe_id, e_codigo, code_combination_id, oracle_segmento1, oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6, oracle_segmento7)
select	distinct '|'as cla_fe_id, e_codigo, code_combination, oracle_segmento1, oracle_segmento2, oracle_segmento3,oracle_segmento4, oracle_segmento5, oracle_segmento6, oracle_segmento7
from	fecxp_ppto_conversion_erp
where	e_codigo = coalesce(v_e_codigo, e_codigo)
and		version_fe = v_version_fe
and		mes >= v_mes_desde;
/* commit; */
--==  clasificacion de cuentas sesgun politicas de clasificacion de fe ==--
open	cursor_clasificacion_fe_egr;
loop
fetch	cursor_clasificacion_fe_egr
into	v_cla_fe_id, v_politica_erp_id, v_prioridad, v_tipo_operacion_ini, v_tipo_operacion_fin, v_id_banco_ini, v_id_banco_fin, v_id_chequera_ini, v_id_chequera_fin,
v_ora_s1_ini, v_ora_s1_fin, v_ora_s2_ini, v_ora_s2_fin, v_ora_s3_ini, v_ora_s3_fin, v_ora_s4_ini, v_ora_s4_fin, v_ora_s5_ini, v_ora_s5_fin, v_ora_s6_ini, v_ora_s6_fin, v_ora_s7_ini, v_ora_s7_fin;
exit when not found; /* apply on cursor_clasificacion_fe_egr */
update	fecxp_rep_ppto_com_cta_erp
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
and		coalesce(v_tipo_operacion_ini, 0) = 0
and		coalesce(v_tipo_operacion_fin, 0) = 0
and		coalesce(v_id_banco_ini, 0) = 0
and		coalesce(v_id_banco_fin, 0) = 0
and		coalesce(lpad(v_id_chequera_ini::text, 20, '0'::text), '00000000000000000000') = '00000000000000000000'
and		coalesce(lpad(v_id_chequera_fin::text, 20, '0'::text), '00000000000000000000') = '00000000000000000000'
and		e_codigo = coalesce(v_e_codigo, e_codigo)
and		coalesce(cla_fe_id, '|') = '|';
/* commit; */
end loop;
close	cursor_clasificacion_fe_egr;
delete	from fecxp_det_cont_version_fe
where	proceso = 'FECXP_LLENA_DET_CONT_ERP';
insert	into fecxp_det_cont_version_fe(
proceso, version_fe)
values (
'FECXP_LLENA_DET_CONT_ERP', v_version_fe);
/* commit; */
--===============================================================================================--
--== termina ppto ==--
exception
when no_data_found then
raise exception '%', 'NO HAY DATOS NUEVOS.' using errcode = '45000';end;
$body$
language plpgsql
;
