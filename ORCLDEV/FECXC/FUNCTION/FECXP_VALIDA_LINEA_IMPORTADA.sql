create or replace  function  fecxc."fecxp_valida_linea_importada"  (tipo_importacion varchar, folio_set varchar,e_codigo varchar, numero_de_partida integer, estatus_movimiento varchar, code_combination integer, division varchar, agrupamiento varchar, rubro varchar, des_empresa varchar, moneda varchar,sct varchar,cta varchar, cc varchar, icia varchar, v_id_sesion fecxp_importacion_datos.atributo_1%type) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_division              varchar(50);
v_agrupamiento          varchar(50);
v_rubro                 varchar(50);
v_cla_fe_id             varchar(25);
v_cla_fe_des            varchar(50);
v_e_codigo              varchar(25);
v_e_empresa_des         varchar(100);
v_folio_set             varchar(150);
v_no_cliente            varchar(15);
v_referencia            varchar(30);
v_descripcion           varchar(30);
v_tipo_operacion        integer;
v_id_banco              integer;
v_forma_pago            integer;
v_id_chequera           varchar(20);
v_estatus_movimiento    varchar(1);
v_beneficiario          varchar(60);
v_concepto              varchar(100);
v_origen_movimiento     varchar(3);
v_numero_de_partida     integer;
v_cia                   varchar(25);
v_neg                   varchar(25);
v_cta                   varchar(25);
v_sct                   varchar(25);
v_cc                    varchar(25);
v_icia                    varchar(25);
v_top                    varchar(25);
v_estatus                varchar(50);
v_fecha_aplicacion        timestamp(0);
v_moneda_imp            varchar(25);
v_importe_linea            decimal(20,4);
v_contador_c            integer:=0;
v_mensaje               varchar(4000);
v_code_combination integer;
-- ************* cursor para reales oracle ********************
c_folios_oracle_real cursor(v_folio_set_c varchar,v_numero_de_partida_c integer, v_e_codigo_c varchar) for select distinct
e_codigo,des_empresa,folio_set,tipo_operacion,concepto,beneficiario,
estatus_movimiento,id_chequera,id_banco,no_cliente,forma_pago,fecha_aplicacion,
moneda,tc_original,tc_flujo,origen_movimiento,division,agrupamiento,
rubro,cla_fe_id,cla_fe_des,numero_de_partida,oracle_segmento1,oracle_segmento2,
oracle_segmento3,oracle_segmento4,oracle_segmento5,oracle_segmento6,oracle_segmento7,
importe_linea,estatus,met_clasificacion,referencia,descripcion
from (
select    sf.id_segmento, sf.des_segmento, r.e_codigo, e.des_empresa, r.folio_set, to_char(r.tipo_operacion) tipo_operacion, r.concepto, r.beneficiario, r.estatus_movimiento, r.id_chequera, to_char(r.id_banco) id_banco, coalesce(r.no_cliente ,'0') no_cliente,
to_char(r.forma_pago) forma_pago, r.fecha_aplicacion, r.moneda, 'TC_ORIGINAL: ' || to_char(r.tc_original) tc_original, 'TC_FLUJO: ' || to_char(r.tc_flujo) tc_flujo, r.origen_movimiento,
r.division, r.agrupamiento, r.rubro, r.cla_fe_id, r.cla_fe_des,
to_char(r.numero_de_partida_erp) numero_de_partida, r.oracle_segmento1, r.oracle_segmento2, r.oracle_segmento3, r.oracle_segmento4, r.oracle_segmento5, trim(both r.oracle_segmento6) oracle_segmento6, r.oracle_segmento7,
r.importe_linea,
r.importe_linea * tc_original importe_linea_tc_o,
r.importe_linea * tc_flujo importe_linea_tc_f,
r.estatus, r.met_clasificacion,
r.referencia, r.descripcion
from (
select    p.e_codigo, p.folio_set, p.tipo_operacion, p.concepto, p.beneficiario, p.estatus_movimiento, p.id_chequera, p.id_banco, p.no_cliente,
p.forma_pago, p.fecha_aplicacion, m.mon_oracle moneda, p.tipo_cambio tc_original,
m.tipo_cambio tc_flujo,
p.origen_movimiento, p.importe,
coalesce(cf.cla_atributo6,'') division,  --v7
coalesce(cf.cla_atributo4,'') agrupamiento,
coalesce(cf.cla_atributo2,'') rubro,
cf.cla_fe_id,
cf.cla_fe_des,
p.numero_de_partida_erp, p.oracle_segmento1, p.oracle_segmento2, p.oracle_segmento3, p.oracle_segmento4, p.oracle_segmento5, p.oracle_segmento6, p.oracle_segmento7, p.importe_linea, 'EGRESO EXTRAIDO' estatus, 'POL?TICAS' met_clasificacion,
p.referencia, p.descripcion
from    fecxc.fecxp_clasificacion_fe cf,
fecxc.fecxp_pagos_erp_clasif p,
fecxc.fecxp_ctas_clasif_real_erp c,
fecxc.fecxp_monedas m
where    p.e_codigo = c.e_codigo
and        p.tipo_operacion = c.tipo_operacion
and        p.id_banco = c.id_banco
and        p.id_chequera = c.id_chequera
and        p.oracle_segmento1 = c.oracle_segmento1
and        p.oracle_segmento2 = c.oracle_segmento2
and        p.oracle_segmento3 = c.oracle_segmento3
and        p.oracle_segmento4 = c.oracle_segmento4
and        p.oracle_segmento5 = c.oracle_segmento5
and        p.oracle_segmento6 = c.oracle_segmento6
and        p.oracle_segmento7 = c.oracle_segmento7
and        m.mon_set = p.moneda
and        m.periodo = (to_char(p.fecha_aplicacion, 'YYYY'))::numeric
and        m.mes = (to_char(p.fecha_aplicacion, 'MM'))::numeric
and        cf.cla_fe_id = c.cla_fe_id
union all
select    i.e_codigo, to_char(i.folio_set), i.tipo_operacion, i.concepto, i.beneficiario, i.id_status_mov, i.id_chequera, i.id_banco, i.no_cliente,
i.id_forma_pago, i.fecha, m.mon_oracle moneda, i.tipo_cambio, m.tipo_cambio, '',
i.importe,
coalesce(cf.cla_atributo6,'') division,  --v7
coalesce(cf.cla_atributo4,'') agrupamiento,
coalesce(cf.cla_atributo2,'') rubro,
cf.cla_fe_id, cf.cla_fe_des,
0, i.ora_soin_segmento1, i.ora_soin_segmento2, i.ora_soin_segmento3, i.oracle_segmento4, i.oracle_segmento5, i.oracle_segmento6, i.oracle_segmento7, case i.ora_soin_segmento1 when 'X' then i.importe else i.importe_linea end, 'INGRESO EXTRAIDO', i.tipo_clasificacion,
i.referencia, i.descripcion
from    fecxc.fecxp_ingresos_clasif i,
fecxc.fecxc_dep_especiales r,
fecxc.fecxp_monedas m,
fecxp_clasificacion_fe cf
where    i.id_status_mov not in ('Q')
and        i.cla_fe_id = cf.cla_fe_id
and        m.mon_oracle = i.moneda
and        m.periodo = (to_char(i.fecha, 'YYYY'))::numeric
and        m.mes = (to_char(i.fecha, 'MM'))::numeric
and        r.no_empresa = i.e_codigo
and        r.no_folio_det = i.folio_set
and        r.id_status_mov = i.id_status_mov
union all
select    (h.e_empresa_imp)::numeric , '0', 0, '', '', '', '', 0, '',
0, to_date(to_char(h.fecha,'YYYY') || lpad(to_char(h.mes)::text, 2, '0'::text) || '01', 'YYYYMMDD') fecha, h.moneda_imp moneda, m.tipo_cambio, m.tipo_cambio, '', h.importe_linea,
coalesce(c.cla_atributo6,'') division,  --v7
coalesce(c.cla_atributo4,'') agrupamiento,
coalesce(c.cla_atributo2,'') rubro,
c.cla_fe_id, c.cla_fe_des,
0, 'X' oracle_segmento1, 'X' oracle_segmento2, 'X' oracle_segmento3, 'X' oracle_segmento4, 'X' oracle_segmento5, 'X' oracle_segmento6, 'X' oracle_segmento7, h.importe_linea, 'IMPORTADO', 'NA',
'<SIN REFERENCIA>' referencia, '<SIN DESCRIPCION>' descripcion
from    fecxc.fecxp_importacion_datos_hist h,
fecxc.fecxp_clasificacion_fe c,
fecxc.fecxp_monedas m
where    h.tipo_importacion = 'R'
and        m.mon_oracle = h.moneda_imp
and        m.mes = h.mes
and        m.periodo = (to_char(fecha, 'YYYY'))::numeric
and        c.cla_fe_id = h.cla_fe_id_imp
) r,
fecxc.fecxc_emp_x_segmento es,
fecxc.fecxc_segmentos_flujo sf,
fecxc.fecxc_empresas e
where        es.id_segmento not in (11,15, 17, 18, 20, 26, 6, 13, 25)
and        e.cual_erp = 'O'
and        e.e_codigo = r.e_codigo
and        es.e_codigo = r.e_codigo
and        es.id_segmento = sf.id_segmento
union all
select    sf.id_segmento, sf.des_segmento, r.e_codigo, e.des_empresa, r.folio_set, to_char(r.tipo_operacion) tipo_operacion, r.concepto, r.beneficiario, r.estatus_movimiento, r.id_chequera, to_char(r.id_banco) id_banco, coalesce(r.no_cliente ,'0') no_cliente,
to_char(r.forma_pago) forma_pago, r.fecha_aplicacion, r.moneda, 'TC_ORIGINAL: ' || to_char(r.tc_original) tc_original, 'TC_FLUJO: ' || to_char(r.tc_flujo) tc_flujo, r.origen_movimiento,
r.division, r.agrupamiento, r.rubro, r.cla_fe_id, r.cla_fe_des,
to_char(r.numero_de_partida_erp) numero_de_partida, r.oracle_segmento1, r.oracle_segmento2, r.oracle_segmento3, r.oracle_segmento4, r.oracle_segmento5, trim(both r.oracle_segmento6) oracle_segmento6, r.oracle_segmento7,
r.importe_linea,
r.importe_linea * tc_original importe_linea_tc_o,
r.importe_linea * tc_flujo importe_linea_tc_f,
r.estatus, r.met_clasificacion,
r.referencia, r.descripcion
from (
select    p.e_codigo, p.folio_set, p.tipo_operacion, p.concepto, p.beneficiario, p.estatus_movimiento, p.id_chequera, p.id_banco, p.no_cliente,
p.forma_pago, p.fecha_aplicacion, m.mon_oracle moneda, p.tipo_cambio tc_original,
m.tipo_cambio tc_flujo,
'SET' as origen_movimiento, p.importe,
coalesce(cf.cla_atributo6,'') division,  --v7
coalesce(cf.cla_atributo4,'') agrupamiento,
coalesce(cf.cla_atributo2,'') rubro,
p.cla_fe_id,
cf.cla_fe_des,
p.numero_de_partida_erp, p.ora_soin_segmento1 as oracle_segmento1, p.ora_soin_segmento2 as oracle_segmento2, p.ora_soin_segmento3 as oracle_segmento3, p.oracle_segmento4, p.oracle_segmento5, p.oracle_segmento6, p.oracle_segmento7, p.importe_linea,
'COINV EGR' estatus, 'COINVERSION' met_clasificacion,
p.referencia, p.descripcion
from    fecxc.fecxp_clasificacion_fe cf,
fecxc.fecxp_det_reales_coinversion p,
fecxc.fecxp_monedas m
where    m.mon_set = p.moneda
and        m.periodo = (to_char(p.fecha_aplicacion, 'YYYY'))::numeric
and        m.mes = (to_char(p.fecha_aplicacion, 'MM'))::numeric
and        cf.cla_fe_id = p.cla_fe_id
and        p.id_tipo_movto ='E'
union all
select    p.e_codigo, p.folio_set, p.tipo_operacion, p.concepto, p.beneficiario, p.estatus_movimiento, p.id_chequera, p.id_banco, p.no_cliente,
p.forma_pago, p.fecha_aplicacion, m.mon_oracle moneda, p.tipo_cambio tc_original,
m.tipo_cambio tc_flujo,
'SET' as origen_movimiento, p.importe,
coalesce(cf.cla_atributo6,'') division,  --v7
coalesce(cf.cla_atributo4,'') agrupamiento,
coalesce(cf.cla_atributo2,'') rubro,
p.cla_fe_id,
cf.cla_fe_des,
p.numero_de_partida_erp, p.ora_soin_segmento1 as oracle_segmento1, p.ora_soin_segmento2 as oracle_segmento2, p.ora_soin_segmento3 as oracle_segmento3, p.oracle_segmento4, p.oracle_segmento5, p.oracle_segmento6, p.oracle_segmento7,
case p.ora_soin_segmento1 when 'X' then p.importe else p.importe_linea end,
'COINV ING' estatus, 'COINVERSION' met_clasificacion,
p.referencia, p.descripcion
from    fecxc.fecxp_clasificacion_fe cf,
fecxc.fecxp_det_reales_coinversion p,
fecxc.fecxp_monedas m
where    m.mon_set = p.moneda
and        m.periodo = (to_char(p.fecha_aplicacion, 'YYYY'))::numeric
and        m.mes = (to_char(p.fecha_aplicacion, 'MM'))::numeric
and        cf.cla_fe_id = p.cla_fe_id
and        p.id_tipo_movto ='I'
union all
select    p.e_codigo, p.folio_set, p.tipo_operacion, p.concepto, p.beneficiario, p.estatus_movimiento, p.id_chequera, p.id_banco, p.no_cliente,
p.forma_pago, p.fecha_aplicacion, m.mon_oracle moneda, p.tipo_cambio tc_original,
m.tipo_cambio tc_flujo,
'SET' as origen_movimiento, p.importe,
coalesce(cf.cla_atributo6,'') division,  --v7
coalesce(cf.cla_atributo4,'') agrupamiento,
coalesce(cf.cla_atributo2,'') rubro,
p.cla_fe_id,
cf.cla_fe_des,
p.numero_de_partida_erp, p.ora_soin_segmento1 as oracle_segmento1, p.ora_soin_segmento2 as oracle_segmento2, p.ora_soin_segmento3 as oracle_segmento3, p.oracle_segmento4, p.oracle_segmento5, p.oracle_segmento6, p.oracle_segmento7, p.importe_linea,
case p.id_tipo_movto when 'I' then 'INV INGR' else 'INV EGR' end estatus, 'INVERSION' met_clasificacion,
p.referencia, p.descripcion
from    fecxc.fecxp_clasificacion_fe cf,
fecxc.fecxp_det_reales_inversion p,
fecxc.fecxp_monedas m
where    m.mon_set = p.moneda
and        m.periodo = (to_char(p.fecha_aplicacion, 'YYYY'))::numeric
and        m.mes = (to_char(p.fecha_aplicacion, 'MM'))::numeric
and        cf.cla_fe_id = p.cla_fe_id
and        p.id_tipo_movto ='E'
union all
select    p.e_codigo, p.folio_set, p.tipo_operacion, p.concepto, p.beneficiario, p.estatus_movimiento, p.id_chequera, p.id_banco, p.no_cliente,
p.forma_pago, p.fecha_aplicacion, m.mon_oracle moneda, p.tipo_cambio tc_original,
m.tipo_cambio tc_flujo,
'SET'as origen_movimiento, p.importe,
coalesce(cf.cla_atributo6,'') division,  --v7
coalesce(cf.cla_atributo4,'') agrupamiento,
coalesce(cf.cla_atributo2,'') rubro,
p.cla_fe_id,
cf.cla_fe_des,
p.numero_de_partida_erp, p.ora_soin_segmento1 as oracle_segmento1, p.ora_soin_segmento2 as oracle_segmento2, p.ora_soin_segmento3 as oracle_segmento3, p.oracle_segmento4, p.oracle_segmento5, p.oracle_segmento6, p.oracle_segmento7,
case p.ora_soin_segmento1 when 'X' then p.importe else p.importe_linea end,
case p.id_tipo_movto when 'I' then 'INV ING' else 'INV EGR' end estatus, 'INVERSION' met_clasificacion,
p.referencia, p.descripcion
from    fecxc.fecxp_clasificacion_fe cf,
fecxc.fecxp_det_reales_inversion p,
fecxc.fecxp_monedas m
where    m.mon_set = p.moneda
and        m.periodo = (to_char(p.fecha_aplicacion, 'YYYY'))::numeric
and        m.mes = (to_char(p.fecha_aplicacion, 'MM'))::numeric
and        cf.cla_fe_id = p.cla_fe_id
and        p.id_tipo_movto ='I'
) r,
fecxc.fecxc_emp_x_segmento es,
fecxc.fecxc_segmentos_flujo sf,
fecxc.fecxc_empresas e
where    es.id_segmento not in (11,15, 17, 18, 20, 26, 6, 13, 25)
and     e.cual_erp = 'O'
and        e.e_codigo = r.e_codigo
and        es.e_codigo = r.e_codigo
and        es.id_segmento = sf.id_segmento) alias75 where folio_set = v_folio_set_c
and   numero_de_partida=v_numero_de_partida_c
and e_codigo = v_e_codigo_c;
--------------++++++++cursor para reales soin++++-----
c_folios_soin_real cursor(v_folio_set_c varchar,v_estatus_movimiento varchar) for select distinct
id_segmento,des_segmento,e_codigo,des_empresa,
folio_set,tipo_operacion,concepto,beneficiario,
estatus_movimiento,id_chequera,id_banco,no_cliente,
forma_pago,fecha_aplicacion,mes,moneda,tc_original,
tc_flujo,origen_movimiento,division,agrupamiento,rubro,
cla_fe_id,cla_fe_des,numero_de_partida_soin,ctam01,ctam02,ctam03,
importe_linea,estatus,met_clasificacion,importe_linea_tc_o,
importe_linea_tc_f,referencia,descripcion
from (
select sf.id_segmento, sf.des_segmento, r.e_codigo, e.des_empresa, r.folio_set,
to_char(r.tipo_operacion) tipo_operacion, r.concepto, r.beneficiario,
r.estatus_movimiento, r.id_chequera, to_char(r.id_banco) id_banco, coalesce(r.no_cliente ,'0') no_cliente,
to_char(r.forma_pago) forma_pago, r.fecha_aplicacion,
to_char(to_timestamp(r.fecha_aplicacion,'DD-MM-YYYY'),'MONTH','NLS_DATE_LANGUAGE=SPANISH') mes
, r.moneda, 'TC_ORIGINAL: ' || to_char(r.tc_original) tc_original, 'TC_FLUJO: ' || to_char(r.tc_flujo) tc_flujo, r.origen_movimiento,
r.division, r.agrupamiento, r.rubro,r.cla_fe_id, r.cla_fe_des,
to_char(r.numero_de_partida_soin) numero_de_partida_soin, r.ctam01, r.ctam02, r.ctam03,
r.importe_linea, r.estatus, r.met_clasificacion,
r.importe_linea * tc_original importe_linea_tc_o,
r.importe_linea * tc_flujo importe_linea_tc_f,
r.referencia, r.descripcion
from (
select  p.e_codigo, p.folio_set, p.tipo_operacion, p.concepto, p.beneficiario, p.estatus_movimiento, p.id_chequera, p.id_banco, p.no_cliente,
p.forma_pago, p.fecha_aplicacion, m.mon_oracle moneda, p.tipo_cambio tc_original, m.tipo_cambio tc_flujo, p.origen_movimiento,
p.importe,
coalesce(cf.cla_atributo6,'') division,  --v7
coalesce(cf.cla_atributo4,'') agrupamiento,
coalesce(cf.cla_atributo2,'') rubro,
cf.cla_fe_id,
cf.cla_fe_des,
p.numero_de_partida_soin, p.ctam01, p.ctam02, p.ctam03, p.importe_linea, 'EGRESO EXTRAIDO' estatus, 'POL?TICAS' met_clasificacion,
p.referencia, p.descripcion
from    fecxc.fecxp_clasificacion_fe cf,
fecxc.fecxp_pagos_soin_clasif p,
fecxc.fecxp_ctas_clasif_real_soin c,
fecxc.fecxp_monedas m
where    p.e_codigo = c.e_codigo
and        p.tipo_operacion = c.tipo_operacion
and        p.id_banco = c.id_banco
and        p.id_chequera = c.id_chequera
and        p.ctam01 = c.ctam01
and        p.ctam02 = c.ctam02
and        p.ctam03 = c.ctam03
and        cf.cla_fe_id = c.cla_fe_id
and        m.mon_set = p.moneda
and        m.periodo = (to_char(p.fecha_aplicacion, 'YYYY'))::numeric
and        m.mes = (to_char(p.fecha_aplicacion, 'MM'))::numeric
union all
select    i.e_codigo, to_char(i.folio_set), i.tipo_operacion, i.concepto, i.beneficiario, i.id_status_mov, i.id_chequera, i.id_banco, i.no_cliente,
i.id_forma_pago, i.fecha, m.mon_oracle moneda, i.tipo_cambio, m.tipo_cambio, '',
i.importe,
coalesce(cf.cla_atributo6,'') division,  --v7
coalesce(cf.cla_atributo4,'') agrupamiento,
coalesce(cf.cla_atributo2,'') rubro,
cf.cla_fe_id, cf.cla_fe_des,
0, i.ora_soin_segmento1, i.ora_soin_segmento2, i.ora_soin_segmento3, case i.ora_soin_segmento1 when 'X' then i.importe else i.importe_linea end, 'INGRESO EXTRAIDO', i.tipo_clasificacion,
i.referencia, i.descripcion
from    fecxc.fecxp_ingresos_clasif i,
fecxc.fecxc_dep_especiales r,
fecxc.fecxp_clasificacion_fe cf,
fecxc.fecxp_monedas m
where    i.cla_fe_id = cf.cla_fe_id
and        m.mon_oracle = i.moneda
and        m.periodo = (to_char(i.fecha, 'YYYY'))::numeric
and        m.mes = (to_char(i.fecha, 'MM'))::numeric
and        i.id_status_mov not in ('Q')
and        r.no_empresa = i.e_codigo
and        r.no_folio_det = i.folio_set
and        r.id_status_mov = i.id_status_mov
union all
select    (h.e_empresa_imp)::numeric , '0', 0, '', '', '', '', 0, '',
0, to_date(to_char(h.fecha,'YYYY') || lpad(to_char(h.mes)::text, 2, '0'::text) || '01', 'YYYYMMDD') fecha, h.moneda_imp, m.tipo_cambio, m.tipo_cambio, '',
h.importe_linea,
coalesce(c.cla_atributo6,'') division,  --v7
coalesce(c.cla_atributo4,'') agrupamiento,
coalesce(c.cla_atributo2,'') rubro,
c.cla_fe_id, c.cla_fe_des,
0, 'X' arsmap, 'X' aejmap, 'X' cncmap, h.importe_linea, 'IMPORTADO', 'NA',
'<SIN REFERENCIA>' referencia, '<SIN DESCRIPCION>' descripcion
from    fecxc.fecxp_importacion_datos_hist h,
fecxc.fecxp_clasificacion_fe c,
fecxc.fecxp_monedas m
where    h.tipo_importacion = 'R'
and        c.cla_fe_id = h.cla_fe_id_imp
and        m.mon_oracle = h.moneda_imp
and        m.mes = h.mes
and        m.periodo = (to_char(clock_timestamp(), 'YYYY'))::numeric
) r,
fecxc.fecxc_emp_x_segmento es,
fecxc.fecxc_segmentos_flujo sf,
fecxc.fecxc_empresas e
where    es.id_segmento not in (11, 15, 17, 18 , 20, 26, 6, 13, 25)
and        e.cual_erp = 'S'
and        es.e_codigo = r.e_codigo
and        e.e_codigo = r.e_codigo
and        es.id_segmento = sf.id_segmento
union all
select    sf.id_segmento, sf.des_segmento, r.e_codigo, e.des_empresa, r.folio_set, to_char(r.tipo_operacion) tipo_operacion, r.concepto, r.beneficiario, r.estatus_movimiento, r.id_chequera, to_char(r.id_banco) id_banco, coalesce(r.no_cliente ,'0') no_cliente,
to_char(r.forma_pago) forma_pago, r.fecha_aplicacion, to_char(to_timestamp(r.fecha_aplicacion,'DD-MM-YYYY'),'MONTH','NLS_DATE_LANGUAGE=SPANISH') mes
, r.moneda, 'TC_ORIGINAL: ' || to_char(r.tc_original) tc_original, 'TC_FLUJO: ' || to_char(r.tc_flujo) tc_flujo, r.origen_movimiento,
r.division, r.agrupamiento, r.rubro,r.cla_fe_id, r.cla_fe_des,
to_char(r.numero_de_partida_soin) numero_de_partida_soin, r.ctam01, r.ctam02, r.ctam03,
r.importe_linea, r.estatus, r.met_clasificacion,
r.importe_linea * tc_original importe_linea_tc_o,
r.importe_linea * tc_flujo importe_linea_tc_f,
r.referencia, r.descripcion
from (
select    p.e_codigo, p.folio_set, p.tipo_operacion, p.concepto, p.beneficiario, p.estatus_movimiento, p.id_chequera, p.id_banco, p.no_cliente,
p.forma_pago, p.fecha_aplicacion, m.mon_oracle moneda, p.tipo_cambio tc_original,
m.tipo_cambio tc_flujo,
'SET' as origen_movimiento, p.importe,
coalesce(cf.cla_atributo6,'') division,  --v7
coalesce(cf.cla_atributo4,'') agrupamiento,
coalesce(cf.cla_atributo2,'') rubro,
p.cla_fe_id,
cf.cla_fe_des,
p.numero_de_partida_erp as numero_de_partida_soin, p.ora_soin_segmento1 as ctam01, p.ora_soin_segmento2 as ctam02, p.ora_soin_segmento3 as ctam03,
p.importe_linea,
'COINV EGR' estatus, 'COINVERSION' met_clasificacion,
p.referencia, p.descripcion
from    fecxc.fecxp_clasificacion_fe cf,
fecxc.fecxp_det_reales_coinversion p,
fecxc.fecxp_monedas m
where    m.mon_set = p.moneda
and        m.periodo = (to_char(p.fecha_aplicacion, 'YYYY'))::numeric
and        m.mes = (to_char(p.fecha_aplicacion, 'MM'))::numeric
and        cf.cla_fe_id = p.cla_fe_id
and        p.id_tipo_movto ='E'
union all
select    p.e_codigo, p.folio_set, p.tipo_operacion, p.concepto, p.beneficiario, p.estatus_movimiento, p.id_chequera, p.id_banco, p.no_cliente,
p.forma_pago, p.fecha_aplicacion, m.mon_oracle moneda, p.tipo_cambio tc_original,
m.tipo_cambio tc_flujo,
'SET' as origen_movimiento, p.importe,
coalesce(cf.cla_atributo6,'') division,  --v7
coalesce(cf.cla_atributo4,'') agrupamiento,
coalesce(cf.cla_atributo2,'') rubro,
p.cla_fe_id,
cf.cla_fe_des,
p.numero_de_partida_erp as numero_de_partida_soin, p.ora_soin_segmento1 as ctam01, p.ora_soin_segmento2 as ctam02, p.ora_soin_segmento3 as ctam03,
case p.ora_soin_segmento1 when 'X' then p.importe else p.importe_linea end,
'COINV ING' estatus, 'COINVERSION' met_clasificacion,
p.referencia, p.descripcion
from    fecxc.fecxp_clasificacion_fe cf,
fecxc.fecxp_det_reales_coinversion p,
fecxc.fecxp_monedas m
where    m.mon_set = p.moneda
and        m.periodo = (to_char(p.fecha_aplicacion, 'YYYY'))::numeric
and        m.mes = (to_char(p.fecha_aplicacion, 'MM'))::numeric
and        cf.cla_fe_id = p.cla_fe_id
and        p.id_tipo_movto ='I'
union all
select    p.e_codigo, p.folio_set, p.tipo_operacion, p.concepto, p.beneficiario, p.estatus_movimiento, p.id_chequera, p.id_banco, p.no_cliente,
p.forma_pago, p.fecha_aplicacion, m.mon_oracle moneda, p.tipo_cambio tc_original,
m.tipo_cambio tc_flujo,
'SET' as origen_movimiento, p.importe,
coalesce(cf.cla_atributo6,'') division,  --v7
coalesce(cf.cla_atributo4,'') agrupamiento,
coalesce(cf.cla_atributo2,'') rubro,
p.cla_fe_id,
cf.cla_fe_des,
p.numero_de_partida_erp as numero_de_partida_soin, p.ora_soin_segmento1 as ctam01, p.ora_soin_segmento2 as ctam02, p.ora_soin_segmento3 as ctam03,
p.importe_linea,
case p.id_tipo_movto when 'I' then 'INV ING' else 'INV EGR' end estatus, 'INVERSION' met_clasificacion,
p.referencia, p.descripcion
from    fecxc.fecxp_clasificacion_fe cf,
fecxc.fecxp_det_reales_inversion p,
fecxc.fecxp_monedas m
where    m.mon_set = p.moneda
and        m.periodo = (to_char(p.fecha_aplicacion, 'YYYY'))::numeric
and        m.mes = (to_char(p.fecha_aplicacion, 'MM'))::numeric
and        cf.cla_fe_id = p.cla_fe_id
and        p.id_tipo_movto ='E'
union all
select    p.e_codigo, p.folio_set, p.tipo_operacion, p.concepto, p.beneficiario, p.estatus_movimiento, p.id_chequera, p.id_banco, p.no_cliente,
p.forma_pago, p.fecha_aplicacion, m.mon_oracle moneda, p.tipo_cambio tc_original,
m.tipo_cambio tc_flujo,
'SET'as origen_movimiento, p.importe,
coalesce(cf.cla_atributo6,'') division,  --v7
coalesce(cf.cla_atributo4,'') agrupamiento,
coalesce(cf.cla_atributo2,'') rubro,
p.cla_fe_id,
cf.cla_fe_des,
p.numero_de_partida_erp as numero_de_partida_soin, p.ora_soin_segmento1 as ctam01, p.ora_soin_segmento2 as ctam02, p.ora_soin_segmento3 as ctam03,
case p.ora_soin_segmento1 when 'X' then p.importe else p.importe_linea end,
case p.id_tipo_movto when 'I' then 'INV ING' else 'INV EGR' end estatus, 'INVERSION' met_clasificacion,
p.referencia, p.descripcion
from    fecxc.fecxp_clasificacion_fe cf,
fecxc.fecxp_det_reales_inversion p,
fecxc.fecxp_monedas m
where    m.mon_set = p.moneda
and        m.periodo = (to_char(p.fecha_aplicacion, 'YYYY'))::numeric
and        m.mes = (to_char(p.fecha_aplicacion, 'MM'))::numeric
and        cf.cla_fe_id = p.cla_fe_id
and        p.id_tipo_movto ='I'
) r,
fecxc.fecxc_emp_x_segmento es,
fecxc.fecxc_segmentos_flujo sf,
fecxc.fecxc_empresas e
where    es.id_segmento not in (11, 15, 17, 18 , 20, 26, 6, 13, 25)
and        e.cual_erp = 'S'
and        es.e_codigo = r.e_codigo
and        e.e_codigo = r.e_codigo
and        es.id_segmento = sf.id_segmento) alias78 where folio_set = v_folio_set and estatus_movimiento = v_estatus_movimiento;
--termina
--*******************cursor para presupuesto oracle *****************
c_folios_oracle_ppto cursor(v_code_combination integer, v_sct varchar) for select distinct
id_segmento,des_segmento,e_codigo,des_empresa,cla_fe_id,cla_fe_des,
division,agrupamiento,rubro,libro_id,version_id,moneda,mes,mes_num,
code_combination,oracle_segmento1,oracle_segmento2,oracle_segmento3,
oracle_segmento4,oracle_segmento5,oracle_segmento6,oracle_segmento7,
tc_original_str,tc_flujo_str,ppto_operativo_mo,ppto_operativo_mf_original,
ppto_operativo_mf_flujo,ppto_flujo_mo,ppto_flujo_mf_original,ppto_flujo_mf_flujo,
presupuesto_estatus,version_extraidos,version_importados
from (
select    sf.id_segmento, sf.des_segmento, p.e_codigo, p.des_empresa, p.cla_fe_id, p.cla_fe_des,
p.division, p.agrupamiento, p.rubro,to_char(p.libro_id) libro_id, to_char(p.version_id) version_id,
p.moneda, p.mes, p.mes_num,    to_char(p.code_combination) code_combination,
p.oracle_segmento1, p.oracle_segmento2, p.oracle_segmento3, p.oracle_segmento4, p.oracle_segmento5,
p.oracle_segmento6, p.oracle_segmento7,
'TC ORIGINAL ' || p.moneda || ': ' || to_char(p.tc_original) tc_original_str,
'TC FLUJO ' || p.moneda || ': ' || to_char(p.tc_flujo) tc_flujo_str,
p.ppto_operativo ppto_operativo_mo,
p.ppto_operativo * p.tc_original ppto_operativo_mf_original,
p.ppto_operativo * p.tc_flujo ppto_operativo_mf_flujo,
p.ppto_flujo ppto_flujo_mo,
p.ppto_flujo * p.tc_original ppto_flujo_mf_original,
p.ppto_flujo * p.tc_flujo ppto_flujo_mf_flujo,
p.presupuesto_estatus,
p.version_extraidos, p.version_importados
from (
select    pp.e_codigo, pp.version_fe, pp.des_empresa, cf.cla_fe_id, cf.cla_fe_des,
coalesce(cf.cla_atributo6,'') division,
coalesce(cf.cla_atributo4,'') agrupamiento,
coalesce(cf.cla_atributo2,'') rubro,
pp.libro_id, pp.version_id, pp.moneda,
pp.mes,
pp.mes_num,
pp.code_combination,
pp.oracle_segmento1, pp.oracle_segmento2, pp.oracle_segmento3, pp.oracle_segmento4, pp.oracle_segmento5, pp.oracle_segmento6, pp.oracle_segmento7,
pp.ppto_operativo * (cf.cla_atributo5::numeric)::numeric  ppto_operativo, pp.ppto_flujo * (cf.cla_atributo5::numeric)::numeric  ppto_flujo, pp.tc_original, pp.tc_flujo, pp.presupuesto_estatus,
pp.version_extraidos, null as version_importados
from (
select    e.e_codigo, po.version_fe, e.des_empresa,
pc.libro_id, pc.version_id,
pc.moneda, to_char(to_timestamp(po.mes,'MM'), 'MONTH', 'NLS_DATE_LANGUAGE=SPANISH') as mes,
po.mes mes_num,
pc.code_combination,
pc.oracle_segmento1, pc.oracle_segmento2, pc.oracle_segmento3, pc.oracle_segmento4, pc.oracle_segmento5, pc.oracle_segmento6, pc.oracle_segmento7,
po.ppto ppto_operativo, pc.importe_linea ppto_flujo, pc.tipo_cambio tc_original, m.tipo_cambio tc_flujo, pc.presupuesto_estatus,
po.version_fe  as version_extraidos
from (
select    e_codigo, version_fe, periodo_ppto, libro_id, version_id, moneda, code_combination_id, 1 mes, ppto_01 ppto
from    fecxc.fecxp_ppto_opera_erp
union all
select    e_codigo, version_fe, periodo_ppto, libro_id, version_id, moneda, code_combination_id, 2 mes, ppto_02 ppto
from    fecxc.fecxp_ppto_opera_erp
union all
select    e_codigo, version_fe, periodo_ppto, libro_id, version_id, moneda, code_combination_id, 3 mes, ppto_03 ppto
from    fecxc.fecxp_ppto_opera_erp
union all
select    e_codigo, version_fe, periodo_ppto, libro_id, version_id, moneda, code_combination_id, 4 mes, ppto_04 ppto
from    fecxc.fecxp_ppto_opera_erp
union all
select    e_codigo, version_fe, periodo_ppto, libro_id, version_id, moneda, code_combination_id, 5 mes, ppto_05 ppto
from    fecxc.fecxp_ppto_opera_erp
union all
select    e_codigo, version_fe, periodo_ppto, libro_id, version_id, moneda, code_combination_id, 6 mes, ppto_06 ppto
from    fecxc.fecxp_ppto_opera_erp
union all
select    e_codigo, version_fe, periodo_ppto, libro_id, version_id, moneda, code_combination_id, 7 mes, ppto_07 ppto
from    fecxc.fecxp_ppto_opera_erp
union all
select    e_codigo, version_fe, periodo_ppto, libro_id, version_id, moneda, code_combination_id, 8 mes, ppto_08 ppto
from    fecxc.fecxp_ppto_opera_erp
union all
select    e_codigo, version_fe, periodo_ppto, libro_id, version_id, moneda, code_combination_id, 9 mes, ppto_09 ppto
from    fecxc.fecxp_ppto_opera_erp
union all
select    e_codigo, version_fe, periodo_ppto, libro_id, version_id, moneda, code_combination_id, 10 mes, ppto_10 ppto
from    fecxc.fecxp_ppto_opera_erp
union all
select    e_codigo, version_fe, periodo_ppto, libro_id, version_id, moneda, code_combination_id, 11 mes, ppto_11 ppto
from    fecxc.fecxp_ppto_opera_erp
union all
select    e_codigo, version_fe, periodo_ppto, libro_id, version_id, moneda, code_combination_id, 12 mes, ppto_12 ppto
from    fecxc.fecxp_ppto_opera_erp
) po,
fecxc.fecxp_ppto_conversion_erp pc,
fecxc_empresas e,
fecxc.fecxp_monedas m
where    po.e_codigo = pc.e_codigo
and        po.version_fe = pc.version_fe
and        po.periodo_ppto = pc.periodo
and        po.libro_id = pc.libro_id
and        po.version_id = pc.version_id
and        po.moneda = pc.moneda
and        po.code_combination_id = pc.code_combination
and        po.mes = pc.mes
and        e.e_codigo = po.e_codigo
and        m.mon_oracle = po.moneda
and        m.periodo = po.periodo_ppto
and        m.mes = po.mes
) pp,
fecxc.fecxp_rep_ppto_com_cta_erp c,
fecxc.fecxp_clasificacion_fe cf
where    c.cla_fe_id = cf.cla_fe_id
and        c.code_combination_id = pp.code_combination
and                    c.e_codigo=pp.e_codigo
-- and        p.code_combination = 580865
union all
select    e.e_codigo, (atributo_3)::numeric , e.des_empresa, c.cla_fe_id, c.cla_fe_des,
coalesce(c.cla_atributo6,'') division,
coalesce(c.cla_atributo4,'') agrupamiento,
coalesce(c.cla_atributo2,'') rubro,
0 libro_id, 0 version_id, h.moneda_imp moneda,
to_char(to_timestamp(h.mes,'MM'), 'MONTH', 'NLS_DATE_LANGUAGE=SPANISH') as mes,
h.mes mes_num,
0,
e.e_codigo_soin oracle_segmento1, 'X' oracle_segmento2, 'X' oracle_segmento3, 'X' oracle_segmento4, 'X' oracle_segmento5, h.atributo_2 oracle_segmento6, 'X' oracle_segmento7,
0 ppto_operativo, sum(h.importe_linea * (c.cla_atributo5::numeric)::numeric ) ppto_flujo,
m.tipo_cambio, m.tipo_cambio, 'IMPORTADO',
null as version_extraidos, h.atributo_3 as version_importados
from    fecxc.fecxp_importacion_datos_hist h,
fecxc_empresas e,
fecxc.fecxp_clasificacion_fe c,
fecxc.fecxp_monedas m
where    h.tipo_importacion = 'P'
and        e.e_codigo = h.e_empresa_imp
and        e.cual_erp = 'O'
and        m.mon_oracle = h.moneda_imp
and        m.mes = h.mes
and        m.periodo = (to_char(clock_timestamp(), 'YYYY'))::numeric
and        c.cla_fe_id = h.cla_fe_id_imp
-- and        e.e_codigo = 19
-- and        c.cla_fe_id = 'A6'
group by e.e_codigo, (atributo_3)::numeric , e.des_empresa, c.cla_fe_id, c.cla_fe_des,
coalesce(c.cla_atributo6,''),
coalesce(c.cla_atributo4,''),
coalesce(c.cla_atributo2,''),
to_char(to_timestamp(h.mes,'MM'), 'MONTH', 'NLS_DATE_LANGUAGE=SPANISH'),
h.mes,
e.e_codigo_soin,
h.atributo_2,
h.moneda_imp, m.tipo_cambio, h.atributo_3
) p,
fecxc.fecxc_emp_x_segmento es,
fecxc.fecxc_segmentos_flujo sf
where    es.id_segmento not in (11, 15,  17, 18, 20,  26, 6, 13, 25)
and        es.id_segmento = sf.id_segmento
and        es.e_codigo = p.e_codigo) alias34 where code_combination = v_code_combination and sct = v_sct;
--termina
--********* cursor para ppto soin ********
c_folios_soin_ppto cursor(v_division varchar,v_agrupamiento varchar,v_rubro varchar,v_e_empresa_des varchar,v_moneda_imp varchar,v_cia varchar,v_neg varchar,v_cta varchar, v_sct varchar)
for select distinct
id_segmento,des_segmento,e_codigo,des_empresa,
cla_fe_id,cla_fe_des,division,agrupamiento,rubro,
arsmap,aejmap,cncmap,ctacr1,ctacr2,mes,moneda,
tc_original_str,tc_flujo_str,ppto_operativo_mo,
ppto_operativo_mf_original,ppto_operativo_mf_flujo,
ppto_flujo_mo,ppto_flujo_mf_original,ppto_flujo_mf_flujo,
presupuesto_estatus,version_importados,version_extraidos
from (
select    sf.id_segmento, sf.des_segmento, p.e_codigo, p.des_empresa, p.cla_fe_id, p.cla_fe_des,
p.division, p.agrupamiento, p.rubro,
p.arsmap, p.aejmap, p.cncmap, p.ctacr1, p.ctacr2, p.mes, p.moneda, 'TC ORIGINAL ' || p.moneda || ':' || to_char(p.tc_original) tc_original_str, 'TC FLUJO ' || p.moneda || ':' || to_char(p.tc_flujo) tc_flujo_str,
p.ppto_operativo * 1.0 ppto_operativo_mo,
p.ppto_operativo * p.tc_original ppto_operativo_mf_original,
p.ppto_operativo * p.tc_flujo ppto_operativo_mf_flujo,
p.ppto_flujo * 1.0 ppto_flujo_mo,
p.ppto_flujo * p.tc_original ppto_flujo_mf_original,
p.ppto_flujo * p.tc_flujo ppto_flujo_mf_flujo,
p.presupuesto_estatus,
p.version_importados, p.version_extraidos
from (
select    pp.e_codigo, pp.des_empresa, cf.cla_fe_id, cf.cla_fe_des,
coalesce(cf.cla_atributo6,'') division,
coalesce(cf.cla_atributo4,'') agrupamiento,
coalesce(cf.cla_atributo2,'') rubro,
pp.arsmap, pp.aejmap, pp.cncmap, pp.ctacr1, pp.ctacr2, pp.mes, pp.mon_oracle moneda,
pp.ppto_operativo * (cf.cla_atributo5::numeric)::numeric  ppto_operativo, pp.ppto_flujo * (cf.cla_atributo5::numeric)::numeric  ppto_flujo,
pp.tc_original, pp.tc_flujo,
pp.presupuesto_estatus,
pp.version_importados, pp.version_extraidos
from (
select    e.e_codigo, e.des_empresa, po.arsmap, po.aejmap, po.cncmap, po.ctacr1, po.ctacr2,
to_char(to_timestamp(po.mescod,'MM'), 'MONTH', 'NLS_DATE_LANGUAGE=SPANISH') as mes,
m.mon_oracle, po.importe_linea ppto_operativo, pc.importe_linea ppto_flujo,
po.tipo_cambio tc_original, m.tipo_cambio tc_flujo, pc.presupuesto_estatus,
null as version_importados, pc.version_fe as version_extraidos
from    fecxc.fecxc_empresas e,
fecxc.fecxp_ppto_conversion_soin pc,
fecxc.fecxp_ppto_operativo_soin po,
fecxc.fecxp_monedas m
where    e.e_codigo = po.e_codigo
and        po.e_codigo = pc.e_codigo
and        po.periodo  = pc.periodo
and     po.moneda = pc.moneda
and        po.mescod = pc.mescod
and        po.arsmap = pc.arsmap
and        po.aejmap = pc.aejmap
and        po.cncmap = pc.cncmap
and        po.ctacr1 = pc.ctacr1
and        po.ctacr2 = pc.ctacr2
and        po.version_fe = pc.version_fe
and        m.mon_sybase = po.moneda
and        m.periodo = po.periodo
and        m.mes = po.mescod
) pp,
fecxp_clasificacion_fe cf,
fecxp_ctas_soin_caratula c
where    cf.cla_fe_id = c.cla_fe_id
and        pp.e_codigo = c.e_codigo
and        pp.e_codigo = c.e_codigo
and        pp.arsmap = c.ctam01
and        pp.aejmap = c.ctam02
and        pp.cncmap = c.ctam03
and        pp.ctacr1 = c.ctacr1
and        pp.ctacr2 = c.ctacr2
union all
select    e.e_codigo, e.des_empresa, c.cla_fe_id, c.cla_fe_des,
coalesce(c.cla_atributo6,'') division,
coalesce(c.cla_atributo4,'') agrupamiento,
coalesce(c.cla_atributo2,'') rubro,
'X' arsmap, 'X' aejmap, 'X' cncmap, 'X' ctacr1, h.atributo_2 ctacr2,
to_char(to_timestamp(h.mes,'MM'), 'MONTH', 'NLS_DATE_LANGUAGE=SPANISH') as mes,
h.moneda_imp, 0 ppto_operativo  , h.importe_linea * (cfu.cla_atributo5::numeric)::numeric   ppto_flujo ,
m.tipo_cambio tc_original, m.tipo_cambio tc_flujo, 'IMPORTADO',
h.atributo_3 as version_importados, null as version_extraidos
from    fecxc.fecxp_importacion_datos_hist h,
fecxc.fecxc_empresas e,
fecxc.fecxp_clasificacion_fe c,
fecxc.fecxp_monedas m,
fecxp_clasificacion_fe cfu
where    h.tipo_importacion = 'P'
and        e.cual_erp = 'S'
and        e.e_codigo = h.e_empresa_imp
and        c.cla_fe_id = h.cla_fe_id_imp
and        m.mon_oracle = h.moneda_imp
and        m.mes = h.mes
and        m.periodo = (to_char(h.fecha, 'YYYY'))::numeric
and                         cfu.cla_fe_id=h.cla_fe_id_imp
) p,
fecxc.fecxc_emp_x_segmento es,
fecxc.fecxc_segmentos_flujo sf
where    es.id_segmento not in (11,15, 17, 18, 20, 26, 6, 13, 25)
and        es.id_segmento = sf.id_segmento
and        es.e_codigo = p.e_codigo) alias21 where division  = v_division
and agrupamiento = v_agrupamiento
and rubro = v_rubro
and des_empresa = v_e_empresa_des
and moneda = v_moneda_imp
and arsmap = v_cta
and aejmap = v_sct
and cncmap = v_cc
and ctacr1 = v_icia;
begin
if tipo_importacion = 'R' then
select division,agrupamiento,rubro,cla_fe_id_imp,cla_fe_des,e_empresa_imp,e_empresa_des,folio_set,no_cliente,referencia,descripcion,tipo_operacion,
id_banco,forma_pago,id_chequera,estatus_movimiento,beneficiario,concepto,origen_movimiento,numero_de_partida,cia,neg,cta,sct,cc,icia,
top,estatus,fecha_aplicacion,moneda_imp,importe_linea
into strict v_division,v_agrupamiento,v_rubro,v_cla_fe_id,v_cla_fe_des,v_e_codigo,v_e_empresa_des,v_folio_set,v_no_cliente,v_referencia,v_descripcion,v_tipo_operacion,
v_id_banco,v_forma_pago,v_id_chequera, v_estatus_movimiento,v_beneficiario,v_concepto,v_origen_movimiento,v_numero_de_partida,v_cia,
v_neg,v_cta,v_sct,v_cc,v_icia,v_top,v_estatus,v_fecha_aplicacion,v_moneda_imp,v_importe_linea
from  fecxp_importacion_datos where folio_set=folio_set
and atributo_1 = v_id_sesion;
for i in select * from c_folios_oracle_real(folio_set,numero_de_partida,e_codigo ) loop
if (v_division=i.division) or (nullif(v_division::text, '') is null and nullif(i.division::text, '') is null) then
if (v_agrupamiento = i.agrupamiento) or (nullif(v_agrupamiento::text, '') is null and nullif(i.agrupamiento::text, '') is null)       then
if (v_rubro = i.rubro)  or (nullif(v_rubro::text, '') is null and nullif(i.rubro::text, '') is null)              then
if (v_e_empresa_des=i.des_empresa) or (nullif(v_e_empresa_des::text, '') is null and nullif(i.des_empresa::text, '') is null)  then
if (v_no_cliente=i.no_cliente) or (nullif(v_no_cliente::text, '') is null and nullif(i.no_cliente::text, '') is null)  then
if (v_referencia=i.referencia) or (nullif(v_referencia::text, '') is null and nullif(i.referencia::text, '') is null) then
if (v_descripcion=i.descripcion) or (nullif(v_descripcion::text, '') is null and nullif(i.descripcion::text, '') is null) then
if (v_tipo_operacion =i.tipo_operacion) or (nullif(v_tipo_operacion::text, '') is null and nullif(i.tipo_operacion::text, '') is null) then
if (v_id_banco=i.id_banco) or (nullif(v_id_banco::text, '') is null and nullif(i.id_banco::text, '') is null) then
if (v_forma_pago=i.forma_pago) or (nullif(v_forma_pago::text, '') is null and nullif(i.forma_pago::text, '') is null) then
if (v_id_chequera=i.id_chequera) or (nullif(v_id_chequera::text, '') is null and nullif(i.id_chequera::text, '') is null) then
if (v_estatus_movimiento =i.estatus_movimiento) or (nullif(v_estatus_movimiento::text, '') is null and nullif(i.estatus_movimiento::text, '') is null) then
if (v_beneficiario =i.beneficiario) or (nullif(v_beneficiario::text, '') is null and nullif(i.beneficiario::text, '') is null) then
if (v_concepto =i.concepto) or (nullif(v_concepto::text, '') is null and nullif(i.concepto::text, '') is null) then
if (v_origen_movimiento = i.origen_movimiento) or (nullif(v_origen_movimiento::text, '') is null and nullif(i.origen_movimiento::text, '') is null)then
if (v_numero_de_partida = i.numero_de_partida) or (nullif(v_numero_de_partida::text, '') is null and nullif(i.numero_de_partida::text, '') is null) then
if (v_cia=i.oracle_segmento1) or (nullif(v_cia::text, '') is null and nullif(i.oracle_segmento1::text, '') is null) then
if (v_neg = i.oracle_segmento2) or (nullif(v_neg::text, '') is null and nullif(i.oracle_segmento2::text, '') is null) then
if (v_cta= i.oracle_segmento3) or (nullif(v_cta::text, '') is null and nullif(i.oracle_segmento3::text, '') is null) then
if (v_sct =i.oracle_segmento4) or (nullif(v_sct::text, '') is null and nullif(i.oracle_segmento4::text, '') is null) then
if (v_cc = i.oracle_segmento5) or (nullif(v_cc::text, '') is null and nullif(i.oracle_segmento5::text, '') is null) then
if (v_icia = i.oracle_segmento6) or (nullif(v_icia::text, '') is null and nullif(i.oracle_segmento6::text, '') is null) then
if (v_top = i.oracle_segmento7) or (nullif(v_top::text, '') is null and nullif(i.oracle_segmento7::text, '') is null) then
if (v_estatus = i.estatus) or (nullif(v_estatus::text, '') is null and nullif(i.estatus::text, '') is null) then
if (v_fecha_aplicacion =i.fecha_aplicacion) or (nullif(v_fecha_aplicacion::text, '') is null and nullif(i.fecha_aplicacion::text, '') is null) then
if (v_moneda_imp =i.moneda) or (nullif(v_moneda_imp::text, '') is null and nullif(i.moneda::text, '') is null) then
null;/* dmap converted statement start */
else
v_mensaje :=  concat('LA MONEDA=', v_moneda_imp, ' NO CORRESPONDE CON LA LINEA ORIGINAL=', i.moneda) ;/* dmap converted statement end */
end if;/* dmap converted statement start */
else
v_mensaje :=  concat('LA FECHA=', v_fecha_aplicacion, ' NO CORRESPONDE CON LA LINEA ORIGINAL=', i.fecha_aplicacion) ;/* dmap converted statement end */
end if;/* dmap converted statement start */
else
v_mensaje :=  concat('EL ESTATUS=', v_estatus, ' NO CORRESPONDE CON LA LINEA ORIGINAL=', i.estatus) ;/* dmap converted statement end */
end if;/* dmap converted statement start */
else
v_mensaje :=  concat('EL TOP=', v_top, ' NO CORRESPONDE CON LA LINEA ORIGINAL=', i.oracle_segmento7) ;/* dmap converted statement end */
end if;/* dmap converted statement start */
else
v_mensaje :=  concat('LA ICIA=', v_icia, ' NO CORRESPONDE CON LA LINEA ORIGINAL=', i.oracle_segmento6) ;/* dmap converted statement end */
end if;/* dmap converted statement start */
else
v_mensaje :=  concat('EL CC=', v_cc, ' NO CORRESPONDE CON LA LINEA ORIGINAL=', i.oracle_segmento5) ;/* dmap converted statement end */
end if;/* dmap converted statement start */
else
v_mensaje :=  concat('LA SCT=', v_sct, ' NO CORRESPONDE CON LA LINEA ORIGINAL=', i.oracle_segmento4) ;/* dmap converted statement end */
end if;/* dmap converted statement start */
else
v_mensaje :=  concat('LA CTA=', v_cta, ' NO CORRESPONDE CON LA LINEA ORIGINAL=', i.oracle_segmento3) ;/* dmap converted statement end */
end if;/* dmap converted statement start */
else
v_mensaje :=  concat('LA NEG=', v_neg, ' NO CORRESPONDE CON LA LINEA ORIGINAL=', i.oracle_segmento2) ;/* dmap converted statement end */
end if;/* dmap converted statement start */
else
v_mensaje :=  concat('LA CIA=', v_cia, ' NO CORRESPONDE CON LA LINEA ORIGINAL=', i.oracle_segmento1) ;/* dmap converted statement end */
end if;/* dmap converted statement start */
else
v_mensaje :=  concat('EL NO DE PARTIDA=', v_numero_de_partida, ' NO CORRESPONDE CON LA LINEA ORIGINAL=', i.numero_de_partida) ;/* dmap converted statement end */
end if;/* dmap converted statement start */
else
v_mensaje :=  concat('EL ORIGEN DEL MOVIMIENTO=', v_origen_movimiento, ' NO CORRESPONDE CON LA LINEA ORIGINAL=', i.origen_movimiento) ;/* dmap converted statement end */
end if;/* dmap converted statement start */
else
v_mensaje :=  concat('EL CONCEPTO=', v_concepto, ' NO CORRESPONDE CON LA LINEA ORIGINAL=', i.concepto) ;/* dmap converted statement end */
end if;/* dmap converted statement start */
else
v_mensaje :=  concat('EL BENEFICIARIO=', v_beneficiario, ' NO CORRESPONDE CON LA LINEA ORIGINAL=', i.beneficiario) ;/* dmap converted statement end */
end if;/* dmap converted statement start */
else
v_mensaje :=  concat('EL ESTATUS=', v_estatus_movimiento, ' NO CORRESPONDE CON LA LINEA ORIGINAL=', i.estatus_movimiento) ;/* dmap converted statement end */
end if;/* dmap converted statement start */
else
v_mensaje :=  concat('EL ID_CHEQUERA=', v_id_chequera, ' NO CORRESPONDE CON LA LINEA ORIGINAL=', i.id_chequera) ;/* dmap converted statement end */
end if;/* dmap converted statement start */
else
v_mensaje :=  concat('EL FORMA PAGO=', v_forma_pago, ' NO CORRESPONDE CON LA LINEA ORIGINAL=', i.forma_pago) ;/* dmap converted statement end */
end if;/* dmap converted statement start */
else
v_mensaje :=  concat('EL ID_BANCO=', v_id_banco, ' NO CORRESPONDE CON LA LINEA ORIGINAL=', i.id_banco) ;/* dmap converted statement end */
end if;/* dmap converted statement start */
else
v_mensaje :=  concat('EL TIPO DE OPERACION =', v_tipo_operacion, ' NO CORRESPONDE CON LA LINEA ORIGINAL=', i.tipo_operacion) ;/* dmap converted statement end */
end if;/* dmap converted statement start */
else
v_mensaje :=  concat('LA DESCRIPCION=', v_descripcion, ' NO CORRESPONDE CON LA LINEA ORIGINAL=', i.descripcion) ;/* dmap converted statement end */
end if;/* dmap converted statement start */
else
v_mensaje :=  concat('LA REFERENCIA=', v_referencia, ' NO CORRESPONDE CON LA LINEA ORIGINAL=', i.referencia) ;/* dmap converted statement end */
end if;/* dmap converted statement start */
else
v_mensaje :=  concat('EL NO DE CLIENTE=', v_no_cliente, ' NO CORRESPONDE CON LA LINEA ORIGINAL=', i.no_cliente) ;/* dmap converted statement end */
end if;/* dmap converted statement start */
else
v_mensaje :=  concat('LA EMPRESA=', v_e_empresa_des, ' NO CORRESPONDE CON LA LINEA ORIGINAL=', i.des_empresa) ;/* dmap converted statement end */
end if;/* dmap converted statement start */
else
v_mensaje :=  concat('EL RUBRO=', v_rubro, ' NO CORRESPONDE CON LA LINEA ORIGINAL=', i.rubro) ;/* dmap converted statement end */
end if;/* dmap converted statement start */
else
v_mensaje :=  concat('EL AGRUPAMIENTO= ', v_agrupamiento, ' NO CORRESPONDE CON LA LINEA ORIGINAL= ', i.agrupamiento) ;/* dmap converted statement end */
end if;/* dmap converted statement start */
else
v_mensaje :=  concat('LA DIVISION=', v_division, ' NO CORRESPONDE CON LA LINEA ORIGINAL=', i.division) ;/* dmap converted statement end */
end if;
end loop;
for i in select * from c_folios_soin_real(folio_set,estatus_movimiento ) loop
if (v_division=i.division) or (nullif(v_division::text, '') is null and nullif(i.division::text, '') is null) then
if (v_agrupamiento = i.agrupamiento) or (nullif(v_agrupamiento::text, '') is null and nullif(i.agrupamiento::text, '') is null)then
if (v_rubro = i.rubro) or (nullif(v_rubro::text, '') is null and nullif(i.rubro::text, '') is null) then
if (v_e_codigo =i.e_codigo) or (nullif(v_e_codigo::text, '') is null and nullif(i.e_codigo::text, '') is null)  then
if (v_e_empresa_des=i.des_empresa) or (nullif(v_e_empresa_des::text, '') is null and nullif(i.des_empresa::text, '') is null)  then
if (v_no_cliente=i.no_cliente) or (nullif(v_no_cliente::text, '') is null and nullif(i.no_cliente::text, '') is null) then
if (v_referencia =i.referencia) or (nullif(v_referencia::text, '') is null and nullif(i.referencia::text, '') is null) then
if (v_descripcion=i.descripcion) or (nullif(v_descripcion::text, '') is null and nullif(i.descripcion::text, '') is null) then
if (v_tipo_operacion=i.tipo_operacion) or (nullif(v_tipo_operacion::text, '') is null and nullif(i.tipo_operacion::text, '') is null) then
if (v_id_banco=i.id_banco) or (nullif(v_id_banco::text, '') is null and nullif(i.id_banco::text, '') is null) then
if (v_forma_pago =i.forma_pago) or (nullif(v_forma_pago::text, '') is null and nullif(i.forma_pago::text, '') is null) then
if (v_id_chequera =i.id_chequera) or (nullif(v_id_chequera::text, '') is null and nullif(i.id_chequera::text, '') is null) then
if (v_estatus_movimiento =i.estatus_movimiento) or (nullif(v_estatus_movimiento::text, '') is null and nullif(i.estatus_movimiento::text, '') is null) then
if (v_origen_movimiento = i.origen_movimiento) or (nullif(v_origen_movimiento::text, '') is null and nullif(i.origen_movimiento::text, '') is null)then
if (v_beneficiario = i.beneficiario) or (nullif(v_beneficiario::text, '') is null and nullif(i.beneficiario::text, '') is null) then
if (v_concepto = i.concepto) or (nullif(v_concepto::text, '') is null and nullif(i.concepto::text, '') is null) then
if (v_numero_de_partida = i.numero_de_partida_soin) or (nullif(v_numero_de_partida::text, '') is null and nullif(i.numero_de_partida_soin::text, '') is null) then
if (v_cta= i.ctam01) or (nullif(v_cta::text, '') is null and nullif(i.ctam01::text, '') is null) then
if (v_sct =i.ctam02) or (nullif(v_sct::text, '') is null and nullif(i.ctam02::text, '') is null) then
if (v_cc = i.ctam03) or (nullif(v_cc::text, '') is null and nullif(i.ctam03::text, '') is null) then
if (v_estatus = i.estatus) or (nullif(v_estatus::text, '') is null and nullif(i.estatus::text, '') is null) then
if (v_fecha_aplicacion = i.fecha_aplicacion) or (nullif(v_fecha_aplicacion::text, '') is null and nullif(i.fecha_aplicacion::text, '') is null) then
if (v_moneda_imp = i.moneda) or (nullif(v_moneda_imp::text, '') is null and  nullif(i.moneda::text, '') is null) then
if (v_importe_linea =i.importe_linea_tc_o) or (nullif(v_importe_linea::text, '') is null and nullif(i.importe_linea_tc_o::text, '') is null) then
null;/* dmap converted statement start */
else
v_mensaje :=  concat('EL IMPORTE=', v_importe_linea, ' NO CORRESPONDE CON LA LINEA ORIGINAL=', i.importe_linea_tc_o) ;/* dmap converted statement end */
end if;/* dmap converted statement start */
else
v_mensaje :=  concat('LA MONEDA=', v_moneda_imp, ' NO CORRESPONDE CON LA LINEA ORIGINAL=', i.moneda) ;/* dmap converted statement end */
end if;/* dmap converted statement start */
else
v_mensaje :=   concat('LA FECHA=', v_fecha_aplicacion, ' NO CORRESPONDE CON LA LINEA ORIGINAL=', i.fecha_aplicacion) ;/* dmap converted statement end */
end if;/* dmap converted statement start */
else
v_mensaje :=    concat('EL ESTATUS=', v_estatus, ' NO CORRESPONDE CON LA LINEA ORIGINAL=', i.estatus) ;/* dmap converted statement end */
end if;/* dmap converted statement start */
else
v_mensaje :=   concat('EL CC=', v_cc, ' NO CORRESPONDE CON LA LINEA ORIGINAL=', i.ctam03) ;/* dmap converted statement end */
end if;/* dmap converted statement start */
else
v_mensaje :=   concat('LA SCT=', v_sct, ' NO CORRESPONDE CON LA LINEA ORIGINAL=', i.ctam02) ;/* dmap converted statement end */
end if;/* dmap converted statement start */
else
v_mensaje :=   concat('LA CTA=', v_cta, ' NO CORRESPONDE CON LA LINEA ORIGINAL=', i.ctam01) ;/* dmap converted statement end */
end if;/* dmap converted statement start */
else
v_mensaje :=   concat('EL NO DE PARTIDA=', v_numero_de_partida, ' NO CORRESPONDE CON LA LINEA ORIGINAL=', i.numero_de_partida_soin) ;/* dmap converted statement end */
end if;/* dmap converted statement start */
else
v_mensaje :=   concat('EL CONCEPTO=', v_concepto, ' NO CORRESPONDE CON LA LINEA ORIGINAL=', i.concepto) ;/* dmap converted statement end */
end if;/* dmap converted statement start */
else
v_mensaje :=   concat('EL BENEFICIARIO=', v_beneficiario, ' NO CORRESPONDE CON LA LINEA ORIGINAL=', i.beneficiario) ;/* dmap converted statement end */
end if;/* dmap converted statement start */
else
v_mensaje :=   concat('EL ORIGEN DEL MOVIMIENTO=', v_origen_movimiento, ' NO CORRESPONDE CON LA LINEA ORIGINAL=', i.origen_movimiento) ;/* dmap converted statement end */
end if;/* dmap converted statement start */
else
v_mensaje :=   concat('EL ESTATUS DE MOVIMIENTO =', v_estatus_movimiento, ' NO CORRESPONDE CON LA LINEA ORIGINAL=', i.estatus_movimiento) ;/* dmap converted statement end */
end if;/* dmap converted statement start */
else
v_mensaje :=   concat('EL ID DE CHEQUERA=', v_id_chequera, ' NO CORRESPONDE CON LA LINEA ORIGINAL=', i.id_chequera) ;/* dmap converted statement end */
end if;/* dmap converted statement start */
else
v_mensaje :=  concat('LA FORMA PAGO=', v_forma_pago, ' NO CORRESPONDE CON LA LINEA ORIGINAL=', i.forma_pago) ;/* dmap converted statement end */
end if;/* dmap converted statement start */
else
v_mensaje :=   concat('EL ID BANCO=', v_id_banco, ' NO CORRESPONDE CON LA LINEA ORIGINAL=', i.id_banco) ;/* dmap converted statement end */
end if;/* dmap converted statement start */
else
v_mensaje :=   concat('EL TIPO DE OPERACION=', v_tipo_operacion, ' NO CORRESPONDE CON LA LINEA ORIGINAL=', i.tipo_operacion) ;/* dmap converted statement end */
end if;/* dmap converted statement start */
else
v_mensaje :=  concat('LA DESCRIPCION=', v_descripcion, ' NO CORRESPONDE CON LA LINEA ORIGINAL=', i.descripcion) ;/* dmap converted statement end */
end if;/* dmap converted statement start */
else
v_mensaje :=  concat('LA REFERENCIA=', v_referencia, ' NO CORRESPONDE CON LA LINEA ORIGINAL=', i.referencia) ;/* dmap converted statement end */
end if;/* dmap converted statement start */
else
v_mensaje :=  concat('EL NO DE CLIENTE =', v_no_cliente, ' NO CORRESPONDE CON LA LINEA ORIGINAL=', i.no_cliente) ;/* dmap converted statement end */
end if;/* dmap converted statement start */
else
v_mensaje :=  concat('LA EMPRESA=', v_e_empresa_des, ' NO CORRESPONDE CON LA LINEA ORIGINAL=', i.des_empresa) ;/* dmap converted statement end */
end if;/* dmap converted statement start */
else
v_mensaje :=  concat('EL CODIGO=', v_e_codigo, ' NO CORRESPONDE CON LA LINEA ORIGINAL=', i.e_codigo) ;/* dmap converted statement end */
end if;/* dmap converted statement start */
else
v_mensaje :=   concat('EL RUBRO=', v_rubro, ' NO CORRESPONDE CON LA LINEA ORIGINAL=', i.rubro) ;/* dmap converted statement end */
end if;/* dmap converted statement start */
else
v_mensaje :=  concat('EL AGRUPAMIENTO=', v_agrupamiento, ' NO CORRESPONDE CON LA LINEA ORIGINAL=', i.agrupamiento) ;/* dmap converted statement end */
end if;/* dmap converted statement start */
else
v_mensaje :=  concat('LA DIVISION=', v_division, ' NO CORRESPONDE CON LA LINEA ORIGINAL=', i.division) ;/* dmap converted statement end */
end if;
end loop;
end if;
if tipo_importacion = 'P' then
for i in select * from c_folios_oracle_ppto(code_combination,sct ) loop
if (v_division=i.division) or (nullif(v_division::text, '') is null and nullif(i.division::text, '') is null) then
if (v_agrupamiento = i.agrupamiento) or (nullif(v_agrupamiento::text, '') is null and nullif(i.agrupamiento::text, '') is null) then
if (v_rubro = i.rubro)or (nullif(v_rubro::text, '') is null and nullif(i.rubro::text, '') is null) then
if (v_e_empresa_des=i.des_empresa)or (nullif(v_e_empresa_des::text, '') is null and nullif(i.des_empresa::text, '') is null)  then
if (v_moneda_imp=i.moneda)or (nullif(v_moneda_imp::text, '') is null and nullif(i.moneda::text, '') is null)  then
if (v_code_combination=i.code_combination)or (nullif(v_code_combination::text, '') is null and nullif(i.code_combination::text, '') is null) then
if (v_descripcion=i.oracle_segmento1)or (nullif(v_descripcion::text, '') is null and nullif(i.oracle_segmento1::text, '') is null) then
if (v_tipo_operacion =i.oracle_segmento2)or (nullif(v_tipo_operacion::text, '') is null and nullif(i.oracle_segmento2::text, '') is null) then
if (v_id_banco=i.oracle_segmento3)or (nullif(v_id_banco::text, '') is null and nullif(i.oracle_segmento3::text, '') is null) then
if (v_forma_pago=i.oracle_segmento4)or (nullif(v_forma_pago::text, '') is null and nullif(i.oracle_segmento4::text, '') is null) then
if (v_id_chequera=i.oracle_segmento5)or (nullif(v_id_chequera::text, '') is null and nullif(i.oracle_segmento5::text, '') is null) then
if (v_estatus_movimiento =i.oracle_segmento6)or (nullif(v_estatus_movimiento::text, '') is null and nullif(i.oracle_segmento6::text, '') is null) then
if (v_beneficiario =i.oracle_segmento7)or (nullif(v_beneficiario::text, '') is null and nullif(i.oracle_segmento7::text, '') is null) then
if (v_concepto =i.version_importados)or (nullif(v_concepto::text, '') is null and nullif(i.version_importados::text, '') is null) then
null;/* dmap converted statement start */
else
v_mensaje :=  concat('EL ATRIBUTO 3=', v_concepto, ' NO CORRESPONDE CON LA LINEA ORIGINAL=', i.version_importados) ;/* dmap converted statement end */
end if;/* dmap converted statement start */
else
v_mensaje :=  concat('EL TOP=', v_top, ' NO CORRESPONDE CON LA LINEA ORIGINAL=', i.oracle_segmento7) ;/* dmap converted statement end */
end if;/* dmap converted statement start */
else
v_mensaje :=  concat('LA ICIA=', v_icia, ' NO CORRESPONDE CON LA LINEA ORIGINAL=', i.oracle_segmento6) ;/* dmap converted statement end */
end if;/* dmap converted statement start */
else
v_mensaje :=  concat('EL CC=', v_cc, ' NO CORRESPONDE CON LA LINEA ORIGINAL=', i.oracle_segmento5) ;/* dmap converted statement end */
end if;/* dmap converted statement start */
else
v_mensaje :=  concat('LA SCT=', v_sct, ' NO CORRESPONDE CON LA LINEA ORIGINAL=', i.oracle_segmento4) ;/* dmap converted statement end */
end if;/* dmap converted statement start */
else
v_mensaje :=  concat('LA CTA=', v_cta, ' NO CORRESPONDE CON LA LINEA ORIGINAL=', i.oracle_segmento3) ;/* dmap converted statement end */
end if;/* dmap converted statement start */
else
v_mensaje :=  concat('LA NEG =', v_neg, ' NO CORRESPONDE CON LA LINEA ORIGINAL=', i.oracle_segmento2) ;/* dmap converted statement end */
end if;/* dmap converted statement start */
else
v_mensaje :=  concat('LA CIA=', v_cia, ' NO CORRESPONDE CON LA LINEA ORIGINAL=', i.oracle_segmento1) ;/* dmap converted statement end */
end if;/* dmap converted statement start */
else
v_mensaje :=  concat('EL CODIGO=', v_code_combination, ' NO CORRESPONDE CON LA LINEA ORIGINAL=', i.code_combination) ;/* dmap converted statement end */
end if;/* dmap converted statement start */
else
v_mensaje :=  concat('LA MONEDA=', v_moneda_imp, ' NO CORRESPONDE CON LA LINEA ORIGINAL=', i.moneda) ;/* dmap converted statement end */
end if;/* dmap converted statement start */
else
v_mensaje :=  concat('LA EMPRESA=', v_e_empresa_des, ' NO CORRESPONDE CON LA LINEA ORIGINAL=', i.des_empresa) ;/* dmap converted statement end */
end if;/* dmap converted statement start */
else
v_mensaje :=  concat('EL RUBRO=', v_rubro, ' NO CORRESPONDE CON LA LINEA ORIGINAL=', i.rubro) ;/* dmap converted statement end */
end if;/* dmap converted statement start */
else
v_mensaje :=  concat('EL AGRUPAMIENTO= ', v_agrupamiento, ' NO CORRESPONDE CON LA LINEA ORIGINAL= ', i.agrupamiento) ;/* dmap converted statement end */
end if;/* dmap converted statement start */
else
v_mensaje :=  concat('LA DIVISION=', v_division, ' NO CORRESPONDE CON LA LINEA ORIGINAL=', i.division) ;/* dmap converted statement end */
end if;
end loop;
end if;
/*
for i in select * from cc_folios_soin_ppto(folio_set,numero_de_partida ) loop
if (v_division=i.division) or (v_division  is null and i.division is null) then
if v_agrupamiento = i.agrupamiento        then
if v_rubro      = i.rubro               then
if v_e_empresa_des=i.des_empresa  then
if v_no_cliente=i.moneda  then
if v_referencia=i.aejmap then
if v_descripcion=i.cncmap then
if v_tipo_operacion =i.ctacr1 then
if v_id_banco=i.ctacr2 then
if v_forma_pago=i.forma_pago then
else
v_mensaje := 'EL FORMA PAGO='||v_forma_pago||' NO CORRESPONDE CON LA LINEA ORIGINAL='||i.forma_pago;
end if;
else
v_mensaje := 'EL ID_BANCO='||v_id_banco||' NO CORRESPONDE CON LA LINEA ORIGINAL='||i.ctacr2;
end if;
else
v_mensaje := 'EL TIPO DE OPERACION ='||v_tipo_operacion||'NO CORRESPONDE CON LA LINEA ORIGINAL='||i.ctacr1;
end if;
else
v_mensaje := 'LA DESCRIPCION='||v_descripcion||' NO CORRESPONDE CON LA LINEA ORIGINAL='||i.cncmap;
end if;
else
v_mensaje := 'LA REFERENCIA='||v_referencia||' NO CORRESPONDE CON LA LINEA ORIGINAL='||i.aejmap;
end if;
else
v_mensaje := 'EL NO DE CLIENTE='||v_no_cliente||' NO CORRESPONDE CON LA LINEA ORIGINAL='||i.no_moneda;
end if;
else
v_mensaje := 'LA EMPRESA='||v_e_empresa_des||' NO CORRESPONDE CON LA LINEA ORIGINAL='||i.des_empresa;
end if;
else
v_mensaje := 'EL RUBRO='||v_rubro||' NO CORRESPONDE CON LA LINEA ORIGINAL='||i.rubro;
end if;
else
v_mensaje := 'EL AGRUPAMIENTO= '||v_agrupamiento||' NO CORRESPONDE CON LA LINEA ORIGINAL= '||i.agrupamiento;
end if;
else
v_mensaje := 'LA DIVISION='||v_division||' NO CORRESPONDE CON LA LINEA ORIGINAL='||i.division;
end if;
end loop;
*/
return v_mensaje;end;
--dmap converted function completed
$body$
language plpgsql
stable;
