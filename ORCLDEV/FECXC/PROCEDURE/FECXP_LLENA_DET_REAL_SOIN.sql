create or replace procedure fecxc."fecxp_llena_det_real_soin"  ( v_fecha_ini datedefault sysdate-12, v_fecha_fin datedefault sysdate-1, v_ecodigo_desde numeric, v_ecodigo_hasta numeric, v_tipo_ejecucion numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_e_codigo integer;
v_v_fecha_fin timestamp(0);
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
folios_repetidos cursor for select folio_set,importe,importe_linea from fecxc.fecxp_ingresos_clasif
where fecha > to_timestamp('01012010','DDMMYYYY')
and   id_status_mov='X'
and   tipo_operacion in (3102,3103,3108,3110,3112)
and   fecha between to_date('0101'||to_char(clock_timestamp(),'YYYY'),'DDMMYYYY') and to_date('3112'||to_char(clock_timestamp(),'YYYY'),'DDMMYYYY');
begin 

/*modificaci?n agosto 18 09, incluye par?metro del tipo de ejecuci?n [ autom?tica 1, manual 0]*/
/*modificaci?n may 09 v4.  referencia, descripci?n y cliente*/
/*proviene de fecxp_llena_det_cont_soin*/
/*modificaci?n abr 09 v3.  crear detalles de inversi?n y coinversi?n*/
/*modificado dic 08*/
/*modificacion jun 29 09 eliminacion de folios duplicados y cambio de signo a los folios cancelados*/
--===============================================================================================--
--== empieza real ==--
if v_tipo_ejecucion = 1 then
--autom?tica usar como fecha final el d?a anterior
--v_v_fecha_fin := sysdate -1;
v_v_fecha_fin := clock_timestamp();
else
v_v_fecha_fin := v_fecha_fin;
end if;/* dmap converted statement start */
-----------------------------------------------borrar folios repetidos  ambas plataformas
delete from fecxc.fecxc_dep_especiales where no_folio_det in (
select no_folio_det from fecxc.fecxc_dep_especiales
where fec_valor between to_date( concat('01/JAN/', to_char(clock_timestamp(),'YYYY')) ) and  to_date( concat('31/DEC/', to_char(clock_timestamp(),'YYYY'))
) and concepto ='DEP S B COBRO'
group by
no_empresa, no_folio_det ,
id_divisa, tipo_cambio, importe, concepto,
plataforma
having count(*) > 1)
and  id_status_mov='P';/* dmap converted statement end */
-----------------------------------------------
delete from fecxp_del_clasif_real_soin;
insert into fecxp_del_clasif_real_soin
select distinct e.e_codigo, e.tipo_operacion, e.id_banco, e.id_chequera, d.ctam01, d.ctam02, d.ctam03, '0', '0'
from fecxp_enc_pagos_soin e,
fecxp_det_pagos_soin d
where e.e_codigo >= v_ecodigo_desde
and     e.e_codigo <= v_ecodigo_hasta
and  e.fecha_aplicacion >= v_fecha_ini
and  e.fecha_aplicacion <= v_v_fecha_fin
and  e.e_codigo = d.e_codigo
and  e.secuencia_pagos_soin = d.secuencia_pagos_soin
;
/* commit; */
delete from fecxp_ctas_clasif_real_soin a
where  exists (
select 1
from fecxp_del_clasif_real_soin d
where  a.e_codigo = d.e_codigo
and a.tipo_operacion = d.tipo_operacion
and coalesce(a.id_banco,0) = coalesce(d.id_banco,0)
and coalesce(a.id_chequera,'0') = coalesce(d.id_chequera,'0')
and coalesce(a.ctam01,'0') = coalesce(d.ctam01,'0')
and coalesce(a.ctam02,'0') = coalesce(d.ctam02,'0')
and coalesce(a.ctam03,'0') = coalesce(d.ctam03,'0')
and a.ctacr1 = '0'
and a.ctacr2 = '0'
);
/* commit; */
delete from fecxp_ingresos_clasif
where e_codigo >= v_ecodigo_desde
and     e_codigo <= v_ecodigo_hasta
and     fecha >= v_fecha_ini
and        fecha <= v_v_fecha_fin
and        e_codigo in (
select e_codigo
from fecxc_empresas
where cual_erp = 'S'
);
/* commit; */
delete from fecxp_pagos_soin_clasif
where e_codigo >= v_ecodigo_desde
and     e_codigo <= v_ecodigo_hasta
and     fecha_aplicacion >= v_fecha_ini
and        fecha_aplicacion <= v_v_fecha_fin;
/* commit; */
delete from fecxp_det_reales_coinversion
where    e_codigo >= v_ecodigo_desde
and     e_codigo <= v_ecodigo_hasta
and     fecha_aplicacion >= v_fecha_ini
and        fecha_aplicacion <= v_v_fecha_fin
and        e_codigo in (
select e_codigo
from fecxc_empresas
where cual_erp = 'S'
);
/* commit; */
delete from fecxp_det_reales_inversion
where    e_codigo >= v_ecodigo_desde
and     e_codigo <= v_ecodigo_hasta
and     fecha_aplicacion >= v_fecha_ini
and        fecha_aplicacion <= v_v_fecha_fin
and        e_codigo in (
select e_codigo
from fecxc_empresas
where cual_erp = 'S'
);
insert into fecxp_ctas_clasif_real_soin(
cla_fe_id, e_codigo, tipo_operacion, id_banco, id_chequera, ctam01, ctam02, ctam03, division, rubro, ctacr1, ctacr2)
select distinct '|' as cla_id, e.e_codigo, e.tipo_operacion, e.id_banco, e.id_chequera, e.ctam01, e.ctam02, e.ctam03, 0, 0, '0', '0'
from fecxp_del_clasif_real_soin e
;
/*insert into fecxp_ctas_clasif_real_soin (
cla_fe_id, e_codigo, tipo_operacion, id_banco, id_chequera, ctam01, ctam02, ctam03, division, rubro, ctacr1, ctacr2)
select distinct '|' as cla_id, e.e_codigo, e.tipo_operacion, e.id_banco, e.id_chequera, d.ctam01, d.ctam02, d.ctam03, 0, 0, '0', '0'
from fecxp_enc_pagos_soin e,
fecxp_det_pagos_soin d
where e.e_codigo >= v_ecodigo_desde
and     e.e_codigo <= v_ecodigo_hasta
and  e.fecha_aplicacion >= v_fecha_ini
and  e.fecha_aplicacion <= v_v_fecha_fin
and  e.e_codigo = d.e_codigo
and  e.secuencia_pagos_soin = d.secuencia_pagos_soin
;*/
/* commit; */
update fecxp_ctas_clasif_real_soin c1
set(division, rubro) =
(
select c2.cg13di, c2.cg13ru
from fecxp_cat_cuentas_soin c2
where c1.ctam01 = c2.ctam01
and  c1.ctam02 = c2.ctam02
and  c1.ctam03 = c2.ctam03
)
where exists (
select 1
from fecxp_cat_cuentas_soin c2
where   c1.ctam01 = c2.ctam01
and  c1.ctam02 = c2.ctam02
and  c1.ctam03 = c2.ctam03
);
/* commit; */
open cursor_clasificacion_fe_soin;
loop
fetch cursor_clasificacion_fe_soin
into v_cla_fe_id, v_politica_soin_id, v_prioridad, v_tipo_operacion_ini, v_tipo_operacion_fin, v_id_banco_ini, v_id_banco_fin, v_id_chequera_ini, v_id_chequera_fin,
v_e_codigo_ini, v_e_codigo_fin, v_ctam01_ini, v_ctam01_fin, v_ctam02_ini, v_ctam02_fin, v_ctam03_ini, v_ctam03_fin, v_tipo_ini, v_tipo_fin, v_division_ini, v_division_fin, v_rubro_ini, v_rubro_fin, v_ctacr1_ini, v_ctacr1_fin, v_ctacr2_ini, v_ctacr2_fin;
exit when not found; /* apply on cursor_clasificacion_fe_soin */
-- se clasifican las cuentas de soin   ---
update fecxp_ctas_clasif_real_soin
set  cla_fe_id = v_cla_fe_id
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
and  coalesce(cla_fe_id, '|') = '|';
/* commit; */
end loop;
close cursor_clasificacion_fe_soin;
-- may 09 referencia descripci?n
-- abr 09 evitar duplicados se agrega distinct
insert into fecxp_pagos_soin_clasif(
e_codigo, folio_set, tipo_operacion, estatus_movimiento, id_chequera, id_banco, no_cliente,
forma_pago, fecha_aplicacion, moneda, tipo_cambio, origen_movimiento,
importe,
numero_de_partida_soin, ctam01, ctam02, ctam03,
importe_linea, concepto, beneficiario, secuencia_det_pagos_soin, referencia, descripcion)
select distinct e.e_codigo, e.folio_set, e.tipo_operacion, e.estatus_movimiento, e.id_chequera, e.id_banco, e.no_cliente,
e.forma_pago, e.fecha_aplicacion, e.moneda, e.tipo_cambio, e.origen_movimiento,
case when e.estatus_movimiento in ('X', 'Y', 'Z') then -1 else 1 end * e.importe importe,
d.numero_de_partida, d.ctam01, d.ctam02, d.ctam03,
d.importe_linea, e.concepto, e.beneficiario, d.secuencia_det_pagos_soin,
coalesce(e.referencia,'<SIN REFERENCIA>') referencia, coalesce(e.descripcion,'<SIN DESCRIPCION>') descripcion
from fecxp_enc_pagos_soin e,
fecxp_det_pagos_soin d
where e.e_codigo >= v_ecodigo_desde
and     e.e_codigo <= v_ecodigo_hasta
and  e.fecha_aplicacion >= v_fecha_ini
and  e.fecha_aplicacion <= v_v_fecha_fin
and  e.e_codigo = d.e_codigo
and  e.secuencia_pagos_soin = d.secuencia_pagos_soin;
------------------------------------------------------------------------------------------------
--== clasifica e inserta ingresos cobranza e icia ==--
insert into fecxp_ingresos_clasif(
cla_fe_id, e_codigo, folio_set, tipo_operacion, fecha, moneda, tipo_cambio, importe, concepto, beneficiario, id_status_mov, id_chequera, id_banco, id_forma_pago, referencia, tipo_clasificacion, no_cliente,
importe_linea, ora_soin_segmento1, ora_soin_segmento2, ora_soin_segmento3, cual_erp, descripcion)
select i.cod_valor, i.no_empresa, i.no_folio_det, i.id_tipo_operacion_set, i.fec_valor, i.moneda, i.tipo_cambio, i.importe, i.concepto, i.beneficiario, i.id_status_mov, i.id_chequera, i.id_banco, i.id_forma_pago, i.referencia, case coalesce(i.cod_valor, '|') when '|' then '' else 'MODULO FECXC' end, i.no_cliente,
i.importe_linea, '000', '000', '000', i.cual_erp, i.descripcion
from (
select coalesce(b.cod_valor, '|') cod_valor,
a.no_empresa,
a.no_folio_det,
a.fec_valor,
a.importe,
m.mon_oracle moneda,
a.id_tipo_operacion_set,
a.id_banco,
a.id_chequera,
coalesce(b.importe_detalle, a.importe) importe_linea,
coalesce(a.referencia,'<SIN REFERENCIA>') referencia,
a.tipo_cambio, a.concepto, a.beneficiario, a.id_status_mov, a.id_forma_pago,
c.cual_erp,
a.no_cliente,
coalesce(a.descripcion,'<SIN DESCRIPCION>') descripcion
from fecxc_dep_especiales a,
fecxp_monedas m,
(
select base_inf.codfolio, base_inf.e_codigo, base_inf.segmento1, base_inf.codoperacion, base_inf.tipocambio, base_inf.importe, base_inf.importe_detalle,
base_inf.f_deposito,  base_inf.segmento2, base_inf.cod_sec_det,
base_inf.cod_sec_catclas, base_inf.secmoneda,cod_flujo.cod_valor, cod_flujo.desc_valor
from (
select a.codfolio, a.e_codigo, b.segmento1, a.codoperacion, a.tipocambio, a.importe, b.importe as importe_detalle,
a.f_deposito,  coalesce(b.segmento2, -1) as segmento2, b.cod_sec_det,
b.cod_sec_catclas, a.secmoneda
from fecxc_enc_clasificados a,
fecxc_det_clasificados b,
fecxc_det_clasfecxc i
where a.e_codigo = b.e_codigo
and  a.cod_sec_clasifica = b.cod_sec_clasifica
and  b.cod_sec_det = i.cod_sec_det
and  b.cod_sec_catclas = i.cod_sec_catclas
--and  i.excluir_enreportes = 'NO'
and  nullif(b.segmento1::text, '') is not null
) base_inf
left outer join (
select g1.cod_sec_lin, g1.sec_flujo_detcat, h1.cod_valor,
h1.desc_valor, g1.sec_concepto_detcat, g1.cod_sec_det, g1.cod_sec_catclas
from fecxc_mapeo_flujo g1, fecxc_det_catalogos h1
where g1.sec_flujo_detcat = h1.cod_sec_lin
and  h1.tipo_cat = 'FLUJO'
union
select -1, -1, 'NO MAPEADOS', 'NO MAPEADOS', -1,-1,-1
) cod_flujo on (base_inf.segmento1 = cod_flujo.cod_sec_lin and base_inf.segmento2 = cod_flujo.sec_concepto_detcat and base_inf.cod_sec_catclas = cod_flujo.cod_sec_catclas and base_inf.cod_sec_det = cod_flujo.cod_sec_det) ) b,
fecxc_empresas c
where a.no_empresa = b.e_codigo
and  a.no_folio_det = b.codfolio
and  a.fec_valor >= v_fecha_ini
and  a.fec_valor <= v_v_fecha_fin
and        a.no_empresa >= v_ecodigo_desde
and        a.no_empresa <= v_ecodigo_hasta
and  c.cual_erp = 'S'
and  a.no_empresa = c.e_codigo
and  m.mon_set = a.id_divisa
and  (to_char(a.fec_valor, 'MM'))::numeric  = m.mes
and  (to_char(a.fec_valor, 'YYYY'))::numeric  = m.periodo
) i
where i.no_empresa = coalesce(v_e_codigo, i.no_empresa);
/* commit; */
------------------------------------------------------------------------------------------------
--== toma el resto de los ingresos con y sin detalle contable ==--
--abr 09 se agrega distinct para evitar duplicados
insert into fecxp_ingresos_clasif(
cla_fe_id, e_codigo, folio_set, tipo_operacion, fecha, moneda, tipo_cambio, importe, concepto, beneficiario, id_status_mov, id_chequera, id_banco, id_forma_pago, referencia, tipo_clasificacion, no_cliente,
importe_linea, ora_soin_segmento1, ora_soin_segmento2, ora_soin_segmento3, cual_erp, descripcion)
select  '|',  e.no_empresa, e.no_folio_det, e.id_tipo_operacion_set, e.fec_valor, m.mon_oracle, e.tipo_cambio, e.importe, e.concepto, e.beneficiario, e.id_status_mov, e.id_chequera, e.id_banco, e.id_forma_pago,
coalesce(e.referencia,'<SIN REFERENCIA>') referencia,
null, e.no_cliente,
coalesce(d.importe_linea, e.importe) importe_linea,
coalesce(d.ora_soin_segmento1, '000') ora_soin_segmento1,
coalesce(d.ora_soin_segmento2, '000') ora_soin_segmento2,--car?tula da 000 a esta cuenta
coalesce(d.ora_soin_segmento3, '000') ora_soin_segmento3,
c.cual_erp,
coalesce(e.descripcion,'<SIN DESCRIPCION>') descripcion
from fecxp_monedas m, fecxc_empresas c, fecxc_dep_especiales e
left outer join fecxc_dep_especiales_d d on (e.secuencia_dep_especiales = d.secuencia_dep_especiales)
where e.fec_valor >= v_fecha_ini and e.fec_valor <= v_v_fecha_fin and e.no_empresa >= v_ecodigo_desde and e.no_empresa <= v_ecodigo_hasta  and e.no_empresa = c.e_codigo and c.cual_erp = 'S' and m.mon_set = e.id_divisa and (to_char(e.fec_valor, 'MM'))::numeric  = m.mes and (to_char(e.fec_valor, 'YYYY'))::numeric  = m.periodo and not exists (
select 1
from fecxp_ingresos_clasif i
where e.no_empresa = i.e_codigo
and  e.no_folio_det = i.folio_set
and    e.id_status_mov = i.id_status_mov --para cancelados
);
/* commit; */
--actualiza la cle_fe_id
update fecxp_ingresos_clasif a
set(a.cla_fe_id, a.tipo_clasificacion) =
(
select b.cla_fe_id, 'REFERENCIAS'
from fecxp_cat_subcodigo b
where b.no_empresa = a.e_codigo
and  b.id_codigo = oracle.substr(a.referencia, 1, 2)
and  b.id_subcodigo = oracle.substr(a.referencia, 4, 3)
and  b.estatus = 'ACTIVO'
and  nullif(b.cla_fe_id::text, '') is not null
)
where a.ora_soin_segmento1 = '000'   --condici?n existente en car?tula
and oracle.substr(a.referencia, 3, 1) = '9'
and  coalesce(a.cla_fe_id, '|') = '|'
and  length(a.referencia) = 7
and  exists (
select 1
from fecxp_cat_subcodigo b
where b.no_empresa = a.e_codigo
and  b.id_codigo = oracle.substr(a.referencia, 1, 2)
and  b.id_subcodigo = oracle.substr(a.referencia, 4, 3)
and  b.estatus = 'ACTIVO'
and  nullif(b.cla_fe_id::text, '') is not null
);
--==  clasificacion de cuentas sesgun politicas de clasificacion de fe ==--
open cursor_clasificacion_fe_ing;
loop
fetch cursor_clasificacion_fe_ing
into v_cla_fe_id, v_politica_soin_id, v_prioridad, v_tipo_operacion_ini, v_tipo_operacion_fin, v_id_banco_ini, v_id_banco_fin, v_id_chequera_ini, v_id_chequera_fin,
v_e_codigo_ini, v_e_codigo_fin, v_ctam01_ini, v_ctam01_fin, v_ctam02_ini, v_ctam02_fin, v_ctam03_ini, v_ctam03_fin;
exit when not found; /* dmap converted statement start *//* apply on cursor_clasificacion_fe_ing */
--== clasificaci.n de cuentas contables erp ==--
update fecxp_ingresos_clasif
set  cla_fe_id = v_cla_fe_id,
tipo_clasificacion = 'POL?TICAS'
where (e_codigo >= coalesce(v_e_codigo_ini, 0))
and (e_codigo <= coalesce(v_e_codigo_fin, 9999))
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
and  e_codigo = coalesce(v_e_codigo, e_codigo)
and  coalesce(cla_fe_id, '|') = '|'
and  cual_erp = 'S'
and  fecha>=to_date( concat('0101', to_char(clock_timestamp(),'YYYY')) ,'DDMMYYYY');/* dmap converted statement end */
/* commit; */
end loop;
close cursor_clasificacion_fe_ing;
--== detalle coinversi?n ==--
---1) se insertan los egresos de coinversi?n
insert    into fecxp_det_reales_coinversion(
e_codigo, folio_set, tipo_operacion,estatus_movimiento, secuencia_id, cla_fe_id, cla_fe_des,
id_chequera,id_banco,forma_pago,fecha_aplicacion,moneda,tipo_cambio,importe,
numero_de_partida_erp,ora_soin_segmento1, ora_soin_segmento2, ora_soin_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6, oracle_segmento7,
importe_linea,concepto,beneficiario,no_cliente,referencia,descripcion,id_tipo_movto,tipo_erp)
select  e.no_cuenta, e.folio_set, e.tipo_operacion,e.estatus_movimiento, e.secuencia_pagos_erp,p.cla_fe_id,p.cla_fe_des,
e.id_chequera, e.id_banco,e.forma_pago, e.fecha_aplicacion, e.moneda, e.tipo_cambio,
case when e.estatus_movimiento in ('X', 'Y', 'Z') then -1 else 1 end * e.importe importe,
d.numero_de_partida_erp, d.oracle_segmento1, d.oracle_segmento2, d.oracle_segmento3, d.oracle_segmento4, d.oracle_segmento5, d.oracle_segmento6, d.oracle_segmento7,
d.importe_linea ,e.concepto, e.beneficiario,e.no_cliente,coalesce(e.referencia,'<SIN REFERENCIA>') referencia, coalesce(e.descripcion,'<SIN DESCRIPCION>') descripcion,
'E','S'
from     fecxp_enc_pagos_erp e,
fecxp_det_pagos_procesados d,
fecxp_cla_fe_nochequera p,
fecxc_empresas c,
fecxp_monedas m
where    e.e_codigo = 999
and     e.tipo_operacion in (3706,7001,7002,7003)
and        e.fecha_aplicacion >= v_fecha_ini
and        e.fecha_aplicacion <= v_v_fecha_fin
and        e.no_cuenta >= v_ecodigo_desde
and        e.no_cuenta <= v_ecodigo_hasta
and        e.e_codigo = d.e_codigo
and        e.secuencia_pagos_erp = d.secuencia_pagos_erp
and        p.tipo_operacion = e.tipo_operacion
and        p.id_tipo_movto = 'E'
and        p.tipo_clave = 'CO'
and        e.no_cuenta = c.e_codigo
and        c.cual_erp = 'S'
and        m.mon_set = e.moneda
and        (to_char(e.fecha_aplicacion, 'MM'))::numeric  = m.mes
and        (to_char(e.fecha_aplicacion, 'YYYY'))::numeric  = m.periodo
;
---2) se insertan los ingresos de coinversi?n oracle
insert    into fecxp_det_reales_coinversion(
e_codigo, folio_set, tipo_operacion,estatus_movimiento, secuencia_id, cla_fe_id, cla_fe_des,
id_chequera,id_banco,forma_pago,fecha_aplicacion,moneda,tipo_cambio,importe,
numero_de_partida_erp,ora_soin_segmento1, ora_soin_segmento2, ora_soin_segmento3,
importe_linea,concepto,beneficiario,no_cliente,referencia,descripcion,id_tipo_movto,tipo_erp)
select  e.no_cuenta, e.no_folio_det, e.id_tipo_operacion_set,e.id_status_mov, e.secuencia_dep_especiales,p.cla_fe_id,p.cla_fe_des,
e.id_chequera, e.id_banco,e.id_forma_pago, e.fec_valor, e.id_divisa, e.tipo_cambio,e.importe,
0,
coalesce(d.ora_soin_segmento1, '000') ora_soin_segmento1,  --segmento 1
coalesce(d.ora_soin_segmento2, '00') ora_soin_segmento2,
coalesce(d.ora_soin_segmento3, '000') ora_soin_segmento3,
coalesce(d.importe_linea, e.importe)  importe_linea,
e.concepto, e.beneficiario,e.no_cliente,coalesce(e.referencia,'<SIN REFERENCIA>') referencia, coalesce(e.descripcion,'<SIN DESCRIPCION>') descripcion,
'I',e.plataforma
from fecxp_cla_fe_nochequera p, fecxp_monedas m, fecxc_empresas c, fecxc_dep_especiales e
left outer join fecxc_dep_especiales_d d on (e.secuencia_dep_especiales = d.secuencia_dep_especiales)
where e.no_empresa = 999 and e.id_tipo_operacion_set in (3705,7000,7005) and e.fec_valor >= v_fecha_ini and e.fec_valor <= v_v_fecha_fin and e.no_cuenta >= v_ecodigo_desde and e.no_cuenta <= v_ecodigo_hasta  and p.tipo_operacion = e.id_tipo_operacion_set and p.id_tipo_movto = 'I' and p.tipo_clave = 'CO' and e.no_cuenta = c.e_codigo and c.cual_erp = 'S' and m.mon_set = e.id_divisa and (to_char(e.fec_valor, 'MM'))::numeric  = m.mes and (to_char(e.fec_valor, 'YYYY'))::numeric  = m.periodo
;
--== detalle inversi?n ==--
--1obtener los ingresos de inversi?n y darles clave de flujo, se abre por detalle de pago
--1.1 obtener inversiones oracle y regrso de isr
insert    into fecxp_det_reales_inversion(
e_codigo, folio_set, tipo_operacion,estatus_movimiento, secuencia_id, cla_fe_id, cla_fe_des,
id_chequera,id_banco,forma_pago,fecha_aplicacion,moneda,tipo_cambio,importe,
numero_de_partida_erp,ora_soin_segmento1, ora_soin_segmento2, ora_soin_segmento3,
importe_linea,concepto,beneficiario,no_cliente,referencia,descripcion,id_tipo_movto,tipo_erp)
select  e.e_codigo, e.folio_set, e.tipo_operacion,e.estatus_movimiento, e.secuencia_pagos_soin,p.cla_fe_id,p.cla_fe_des,
e.id_chequera, e.id_banco,e.forma_pago, e.fecha_aplicacion, e.moneda, e.tipo_cambio,
case when e.estatus_movimiento in ('X', 'Y', 'Z') then -1 else 1 end * e.importe importe,
d.numero_de_partida, d.ctam01, d.ctam02, d.ctam03,
d.importe_linea ,e.concepto, e.beneficiario,e.no_cliente,coalesce(e.referencia,'<SIN REFERENCIA>') referencia, coalesce(e.descripcion,'<SIN DESCRIPCION>') descripcion,
'I','S'
from     fecxp_enc_pagos_soin e,
fecxp_det_pagos_soin d,
fecxp_cla_fe_nochequera p,
fecxc_empresas c,
fecxp_monedas m
where    e.e_codigo = coalesce(v_e_codigo, e.e_codigo)
and     e.tipo_operacion in (4001,4104)
and        e.fecha_aplicacion >= v_fecha_ini
and        e.fecha_aplicacion <= v_v_fecha_fin
and        e.e_codigo >= v_ecodigo_desde
and        e.e_codigo <= v_ecodigo_hasta
and        e.e_codigo = d.e_codigo
and        e.secuencia_pagos_soin = d.secuencia_pagos_soin
and        p.tipo_operacion = e.tipo_operacion
and        p.id_tipo_movto = 'I'
and        p.tipo_clave = 'IN'
and        c.e_codigo = e.e_codigo
and        m.mon_set = e.moneda
and        (to_char(e.fecha_aplicacion, 'MM'))::numeric  = m.mes
and        (to_char(e.fecha_aplicacion, 'YYYY'))::numeric  = m.periodo
and        c.cual_erp = 'S'
;
---1.3 obtener la 4103  como ingreso
insert    into fecxp_det_reales_inversion(
e_codigo, folio_set, tipo_operacion,estatus_movimiento, secuencia_id, cla_fe_id, cla_fe_des,
id_chequera,id_banco,forma_pago,fecha_aplicacion,moneda,tipo_cambio,importe,
numero_de_partida_erp,ora_soin_segmento1, ora_soin_segmento2, ora_soin_segmento3,
importe_linea,concepto,beneficiario,no_cliente,referencia,descripcion,id_tipo_movto,tipo_erp)
select  e.no_empresa, e.no_folio_det, e.id_tipo_operacion_set,e.id_status_mov, e.secuencia_dep_especiales,p.cla_fe_id,p.cla_fe_des,
e.id_chequera, e.id_banco,e.id_forma_pago, e.fec_valor, e.id_divisa, e.tipo_cambio,e.importe,
0,
coalesce(d.ora_soin_segmento1, '000') ora_soin_segmento1,  --segmento 1
coalesce(d.ora_soin_segmento2, '00') ora_soin_segmento2,
coalesce(d.ora_soin_segmento3, '000') ora_soin_segmento3,
coalesce(d.importe_linea, e.importe)  importe_linea,
e.concepto, e.beneficiario,e.no_cliente,coalesce(e.referencia,'<SIN REFERENCIA>') referencia, coalesce(e.descripcion,'<SIN DESCRIPCION>') descripcion,
'I',e.plataforma
from fecxp_cla_fe_nochequera p, fecxp_monedas m, fecxc_empresas c, fecxc_dep_especiales e
left outer join fecxc_dep_especiales_d d on (e.secuencia_dep_especiales = d.secuencia_dep_especiales)
where e.id_tipo_operacion_set =4103 and e.fec_valor >= v_fecha_ini and e.fec_valor <= v_v_fecha_fin and e.no_empresa >= v_ecodigo_desde and e.no_empresa <= v_ecodigo_hasta  and p.tipo_operacion = e.id_tipo_operacion_set and p.id_tipo_movto = 'I' and p.tipo_clave = 'IN' and e.no_empresa = c.e_codigo and c.cual_erp = 'S' and m.mon_set = e.id_divisa and (to_char(e.fec_valor, 'MM'))::numeric  = m.mes and (to_char(e.fec_valor, 'YYYY'))::numeric  = m.periodo
;
---- clasificar los egresos
--- 2.1 obtener el regreso de inversi?n 4102 y el inter?s ganado
insert    into fecxp_det_reales_inversion(
e_codigo, folio_set, tipo_operacion,estatus_movimiento, secuencia_id, cla_fe_id, cla_fe_des,
id_chequera,id_banco,forma_pago,fecha_aplicacion,moneda,tipo_cambio,importe,
numero_de_partida_erp,ora_soin_segmento1, ora_soin_segmento2, ora_soin_segmento3,
importe_linea,concepto,beneficiario,no_cliente,referencia,descripcion,id_tipo_movto,tipo_erp)
select  e.no_empresa, e.no_folio_det, e.id_tipo_operacion_set,e.id_status_mov, e.secuencia_dep_especiales,p.cla_fe_id,p.cla_fe_des,
e.id_chequera, e.id_banco,e.id_forma_pago, e.fec_valor, e.id_divisa, e.tipo_cambio,e.importe,
0,
coalesce(d.ora_soin_segmento1, '000') ora_soin_segmento1,  --segmento 1
coalesce(d.ora_soin_segmento2, '00') ora_soin_segmento2,
coalesce(d.ora_soin_segmento3, '000') ora_soin_segmento3,
case when e.id_tipo_operacion_set=4103 then (p.cla_atributo3)::numeric  else 1 end * coalesce(d.importe_linea, e.importe) importe_linea,
e.concepto, e.beneficiario,e.no_cliente,coalesce(e.referencia,'<SIN REFERENCIA>') referencia, coalesce(e.descripcion,'<SIN DESCRIPCION>') descripcion,
'E',e.plataforma
from fecxp_cla_fe_nochequera p, fecxp_monedas m, fecxc_empresas c, fecxc_dep_especiales e
left outer join fecxc_dep_especiales_d d on (e.secuencia_dep_especiales = d.secuencia_dep_especiales)
where e.id_tipo_operacion_set in (4102,4103) and e.fec_valor >= v_fecha_ini and e.fec_valor <= v_v_fecha_fin and e.no_empresa >= v_ecodigo_desde and e.no_empresa <= v_ecodigo_hasta  and p.tipo_operacion = e.id_tipo_operacion_set and p.id_tipo_movto = 'E' and p.tipo_clave = 'IN' and e.no_empresa = c.e_codigo and c.cual_erp = 'S' and m.mon_set = e.id_divisa and (to_char(e.fec_valor, 'MM'))::numeric  = m.mes and (to_char(e.fec_valor, 'YYYY'))::numeric  = m.periodo
;
--2.2 obtener el isr oracle como egreso
insert    into fecxp_det_reales_inversion(
e_codigo, folio_set, tipo_operacion,estatus_movimiento, secuencia_id, cla_fe_id, cla_fe_des,
id_chequera,id_banco,forma_pago,fecha_aplicacion,moneda,tipo_cambio,importe,
numero_de_partida_erp,ora_soin_segmento1, ora_soin_segmento2, ora_soin_segmento3,
importe_linea,concepto,beneficiario,no_cliente,referencia,descripcion,id_tipo_movto,tipo_erp)
select  e.e_codigo, e.folio_set, e.tipo_operacion,e.estatus_movimiento, e.secuencia_pagos_soin,p.cla_fe_id,p.cla_fe_des,
e.id_chequera, e.id_banco,e.forma_pago, e.fecha_aplicacion, e.moneda, e.tipo_cambio,
case when e.estatus_movimiento in ('X', 'Y', 'Z') then -1 else 1 end * e.importe importe,
d.numero_de_partida , d.ctam01, d.ctam02, d.ctam03,
d.importe_linea * (p.cla_atributo3::numeric)::numeric  importe_linea,e.concepto, e.beneficiario,e.no_cliente,coalesce(e.referencia,'<SIN REFERENCIA>') referencia, coalesce(e.descripcion,'<SIN DESCRIPCION>') descripcion,
'E','S'
from     fecxp_enc_pagos_soin e,
fecxp_det_pagos_soin d,
fecxp_cla_fe_nochequera p,
fecxc_empresas c,
fecxp_monedas m
where    e.e_codigo = coalesce(v_e_codigo, e.e_codigo)
and     e.tipo_operacion =4104
and        e.fecha_aplicacion >= v_fecha_ini
and        e.fecha_aplicacion <= v_v_fecha_fin
and        e.e_codigo >= v_ecodigo_desde
and        e.e_codigo <= v_ecodigo_hasta
and        e.e_codigo = d.e_codigo
and        e.secuencia_pagos_soin = d.secuencia_pagos_soin
and        p.tipo_operacion = e.tipo_operacion
and        p.id_tipo_movto = 'E'
and        p.tipo_clave = 'IN'
and        c.e_codigo = e.e_codigo
and        m.mon_set = e.moneda
and        (to_char(e.fecha_aplicacion, 'MM'))::numeric  = m.mes
and        (to_char(e.fecha_aplicacion, 'YYYY'))::numeric  = m.periodo
and        c.cual_erp = 'S'
;/* dmap converted statement start */
--===============================================================================================--
--== termina real ==--
---/* se agrega codigo para eliminar los duplicados salvo buen cobro  de oracle */-------
delete from fecxc.fecxp_ingresos_clasif where folio_set in (
select folio_set from fecxc.fecxp_ingresos_clasif
where fecha between to_date( concat('01/JAN/', to_char(clock_timestamp(),'YYYY')) ) and  to_date( concat('31/DEC/', to_char(clock_timestamp(),'YYYY'))
) and concepto ='DEP S B COBRO'
and cual_erp='S'
group by
/*cla_fe_id,*/
e_codigo, folio_set,
/*tipo_operacion, fecha,*/
moneda,
tipo_cambio, importe, concepto,
/*beneficiario, /*id_status_mov, id_chequera,*/
/*id_banco,id_forma_pago, referencia,*/
importe_linea, /*ora_soin_segmento1, ora_soin_segmento2,
ora_soin_segmento3, oracle_segmento4, oracle_segmento5,
oracle_segmento6, oracle_segmento7,*/
cual_erp
/*tipo_clasificacion, no_cliente/*, descripcion*/
having count(*) > 1)
and  id_status_mov='P';/* dmap converted statement end */
-------------se agregra codigo para cambiar de signo los folios cancelados ---------------------
for c1 in folios_repetidos loop
if c1.importe >=0 and c1.importe_linea <0 then
update fecxc.fecxp_ingresos_clasif
set importe_linea=(c1.importe_linea*-1)
where folio_set= c1.folio_set
and   importe_linea  = c1.importe_linea
and   id_status_mov='X';
--dbms_output.put_line('IMPORTE POSITIVO -> '||c1.importe||' IMPORTE LINEA -> '||c1.importe_linea);
end if;
if c1.importe <0 and c1.importe_linea >=0 then
update fecxc.fecxp_ingresos_clasif
set importe_linea=(c1.importe_linea*-1)
where folio_set= c1.folio_set
and   importe_linea  = c1.importe_linea
and   id_status_mov='X';
---dbms_output.put_line('IMPORTE NEGATIVO -> '||c1.importe||' IMPORTE LINEA -> '||c1.importe_linea);
end if;
end loop;
/* commit; */
exception
when no_data_found then
raise exception '%', 'NO HAY DATOS NUEVOS.' using errcode = '45000';
when others then
rollback;/* dmap converted statement start */
raise exception '%',  concat('Error:', sqlstate , ' - ' , sqlerrm)  using errcode = '45000';/* dmap converted statement end */end;
$body$
language plpgsql
;
