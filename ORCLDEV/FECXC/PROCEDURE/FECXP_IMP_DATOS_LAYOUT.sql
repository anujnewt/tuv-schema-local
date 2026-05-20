create or replace procedure fecxc."fecxp_imp_datos_layout"  ( v_id_sesion fecxp_importacion_datos.atributo_1%type, v_tipo_imp varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_errores integer:= 0;
v_valida_linea varchar(4000):='BIEN';
c_datos_importados cursor for select    tipo_importacion, e_empresa_imp, cla_fe_id_imp,
importe_linea, moneda_imp, mes,
fecha, atributo_1, atributo_2,
atributo_3, atributo_4, estatus_origen,
division, agrupamiento, rubro,
folio_set, no_cliente, referencia,
descripcion, tipo_operacion, id_banco,
forma_pago, id_chequera, estatus_movimiento,
beneficiario, concepto, origen_movimiento,
numero_de_partida, cia, neg,
cta, sct, cc,
icia, top, estatus,
fecha_aplicacion, e_empresa_des, cla_fe_des,
code_combination
from fecxc.fecxp_importacion_datos
where atributo_1 = v_id_sesion;
begin 

-- ***** debugueo *****
update    fecxp_importacion_datos
set        estatus_origen = 'EN ESPERA'
where    atributo_1 = v_id_sesion;
-- ***** valida registros *****
---****inserta el mes y fecha*****----
update fecxc.fecxp_importacion_datos d
set mes=to_char(fecha_aplicacion,'MM'),
fecha=fecha_aplicacion
where d.atributo_1 = v_id_sesion;
----*******+inserta tipo de importacion *****----
update fecxc.fecxp_importacion_datos d
set tipo_importacion =v_tipo_imp
where d.atributo_1 = v_id_sesion
and nullif(tipo_importacion::text, '') is null;
-- ***** asigna estatus a registros validados en parametros de importacion*****
update    fecxp_importacion_datos d
set        estatus_origen = (
select    p.estatus_origen
from    fecxp_importacion_datos_params p,
fecxc_empresas e
where    e.e_codigo = d.e_empresa_imp
and        p.tipoempresa = e.tipoempresa
and        p.tipo_importacion = d.tipo_importacion
)
where    d.estatus_origen = 'EN ESPERA'
and        d.atributo_1 = v_id_sesion;
-- ***** valida empresa *****
update    fecxp_importacion_datos d
set       estatus_origen = 'EMPRESA INVALIDA'
where     d.estatus_origen = 'VALIDO'
and        not exists (
select    e.e_codigo
from      fecxc_empresas e
where     e.e_codigo = d.e_empresa_imp
)
and        d.atributo_1 = v_id_sesion;
update    fecxp_importacion_datos d
set       estatus_origen = 'EMPRESA INVALIDA'
where     not exists (
select    e.e_codigo
from     fecxc_empresas e
where    e.e_codigo    = d.e_empresa_imp
and      e.des_empresa = d.e_empresa_des
)
and        d.atributo_1 = v_id_sesion;
-- ***** valida moneda *****
update    fecxp_importacion_datos d
set        estatus_origen = 'MONEDA INVALIDA'
where    d.estatus_origen = 'VALIDO'
and        not exists (
select    1
from    fecxp_monedas m
where    m.mon_oracle = d.moneda_imp
)
and        d.atributo_1 = v_id_sesion;
-- ***** valida clasificacion fe *****
update    fecxp_importacion_datos d
set        estatus_origen = 'CLASIFICACION FE INVALIDA'
where    d.estatus_origen = 'VALIDO'
and        not exists (
select    1
from    fecxp_clasificacion_fe c
where    c.cla_fe_id = d.cla_fe_id_imp
)
and        d.atributo_1 = v_id_sesion;
update    fecxp_importacion_datos d
set        estatus_origen = 'CLASIFICACION FE INVALIDA'
where    d.estatus_origen = 'VALIDO'
and        not exists (
select 1 from fecxc.fecxp_clasificacion_fe a
where a.cla_fe_id  = d.cla_fe_id_imp
and   a.cla_fe_des = d.cla_fe_des
)
and        d.atributo_1 = v_id_sesion;/* dmap converted statement start */
-- ***** guarda bit?coras *****
-- *****  empresa invalida *****
insert    into fecxp_bitacora_errores(
id_sesion, mensaje)
select    v_id_sesion,  concat(estatus_origen, ': ' , e_empresa_des
) from    fecxp_importacion_datos
where    estatus_origen = 'EMPRESA INVALIDA'
and        atributo_1 = v_id_sesion
group by estatus_origen, e_empresa_des;/* dmap converted statement end *//* dmap converted statement start */
-- *****  moneda invalida *****
insert    into fecxp_bitacora_errores(
id_sesion, mensaje)
select    v_id_sesion,  concat(estatus_origen, ': ' , moneda_imp
) from    fecxp_importacion_datos
where    estatus_origen = 'MONEDA INVALIDA'
and        atributo_1 = v_id_sesion
group by estatus_origen, moneda_imp;/* dmap converted statement end *//* dmap converted statement start */
-- *****  clasificacion fe invalida *****
insert    into fecxp_bitacora_errores(
id_sesion, mensaje)
select    v_id_sesion,  concat(estatus_origen, ': ' , cla_fe_id_imp , '    ' , cla_fe_des
) from    fecxp_importacion_datos
where    estatus_origen = 'CLASIFICACION FE INVALIDA'
and        atributo_1 = v_id_sesion
group by estatus_origen, cla_fe_des,cla_fe_id_imp;/* dmap converted statement end *//* dmap converted statement start */
-- *****  clasificaciones fe repetidas *****
/*insert into fecxp_bitacora_errores (
id_sesion, mensaje)
select    v_id_sesion, 'CLASIFICACION REPETIDA: ' || cla_fe_id_imp || ' EN LA EMPRESA :' || e_empresa_imp || '. MES :' || mes
from    fecxp_importacion_datos
where    estatus_origen = 'VALIDO'
and        atributo_1 = v_id_sesion
group by tipo_importacion, e_empresa_imp, cla_fe_id_imp, moneda_imp, mes, to_number(to_char (fecha::text, 'MM'))
having count (cla_fe_id_imp) > 1;*/
-- *****  los que se quedaron en espera *****
insert    into fecxp_bitacora_errores(
id_sesion, mensaje)
select    v_id_sesion,  concat('REGISTRO INV?LIDO : CLASIFICACION : ', cla_fe_des , '. EMPRESA :' , e_empresa_des , '. MES :' , mes
) from    fecxp_importacion_datos
where    estatus_origen <> 'VALIDO'
and        atributo_1 = v_id_sesion;/* dmap converted statement end */
-- *****  saldo final *****
insert    into fecxp_bitacora_errores(
id_sesion, mensaje)
select    v_id_sesion, 'LA CLASIFICACI?N SF - SALDO FINAL ES PRIVADA'
from    fecxp_importacion_datos
where    atributo_1 = v_id_sesion
and      cla_fe_id_imp = 'SF'
group by cla_fe_id_imp;
-- *****  version fe num?rica *****
insert    into fecxp_bitacora_errores(
id_sesion, mensaje)
select    v_id_sesion, 'VERSION FE - EL CAMPO ATRIBUTO_3 SOLO PUEDE SER NUM?RICO'
from    fecxp_importacion_datos
where    tipo_importacion in ('S', 'P')
and        atributo_1 = v_id_sesion
and        ascii(atributo_3) <= 48
and        ascii(atributo_3) >= 57
group by cla_fe_id_imp;
/*
---******valida lineas insertadas vs lineas originales********---
if v_validar_lineas='1' then
for i in c_datos_importados loop
v_valida_linea:=fecxc.fecxp_valida_linea_importada(v_tipo_imp,i.code_combination,i.folio_set,i.e_empresa_imp,i.numero_de_partida,i.estatus_movimiento,i.sct,i.division,i.agrupamiento,i.rubro,i.e_empresa_des,i.moneda_imp,i.cta,i.cc,i.icia,i.id_segmento, i.mes_num, i.version_extraidos, v_id_sesion );
if v_valida_linea!= 'BIEN' then                                                                                                                                                            --id_segmento   e_codigo   mes_num  version_extraidos
insert into fecxp_bitacora_errores (id_sesion, mensaje) values( v_id_sesion,v_valida_linea );
end if;
end loop;
end if;
*/
-- ***** procesa registros *****
select    count(id_sesion)
into strict    v_errores
from    fecxp_bitacora_errores
where    id_sesion = v_id_sesion;
if v_errores > 0 then
delete    from fecxp_importacion_datos
where    atributo_1 = v_id_sesion;
--null;
else
-- ***** manda los registros importados a hist?rico *****
insert    into    fecxp_importacion_datos_hist(
tipo_empresa_imp, tipo_importacion, e_empresa_imp, cla_fe_id_imp, importe_linea,
moneda_imp, mes, fecha, atributo_1, atributo_2, atributo_3, atributo_4,e_empresa_des, cla_fe_des, division,
agrupamiento, rubro, folio_set, no_cliente, referencia, descripcion,  tipo_operacion, id_banco, forma_pago, id_chequera,
estatus_movimiento, beneficiario,  concepto, origen_movimiento, numero_de_partida,    cia, neg, cta,
sct, cc, icia,    top, estatus, fecha_aplicacion,code_combination)
select    e.tipoempresa, i.tipo_importacion, i.e_empresa_imp, i.cla_fe_id_imp, i.importe_linea,
i.moneda_imp, i.mes, fecha, i.atributo_1, i.atributo_2, i.atributo_3, i.atributo_4,e_empresa_des, cla_fe_des, division,
agrupamiento, rubro, folio_set, no_cliente, referencia, descripcion,  tipo_operacion, id_banco, forma_pago, id_chequera,
estatus_movimiento, beneficiario,  concepto, origen_movimiento, numero_de_partida,    cia, neg, cta,
sct, cc, icia,    top, estatus, fecha_aplicacion,i.code_combination
from    fecxp_importacion_datos i,
fecxc_empresas e
where    i.atributo_1 = v_id_sesion
and        e.e_codigo = i.e_empresa_imp;
-- ***** manda los registros importados a bit?cora *****
insert    into    fecxp_imp_datos_bitacora(
tipo_empresa_imp, tipo_importacion, e_empresa_imp, cla_fe_id_imp, importe_linea,
moneda_imp, mes, fecha, atributo_1, atributo_2, atributo_3, atributo_4, accion, fecha_accion,e_empresa_des, cla_fe_des, division,
agrupamiento, rubro, folio_set, no_cliente, referencia, descripcion,  tipo_operacion, id_banco, forma_pago, id_chequera,
estatus_movimiento, beneficiario,  concepto, origen_movimiento, numero_de_partida,    cia, neg, cta,
sct, cc, icia,    top, estatus, fecha_aplicacion,code_combination)
select  e.tipoempresa, i.tipo_importacion, i.e_empresa_imp, i.cla_fe_id_imp, i.importe_linea,
i.moneda_imp, i.mes, fecha, i.atributo_1, i.atributo_2, i.atributo_3, i.atributo_4, 'ALTA', clock_timestamp(),
i.e_empresa_des, i.cla_fe_des, i.division, i.agrupamiento, i.rubro, i.folio_set,  i.no_cliente, i.referencia, i.descripcion,
i.tipo_operacion, i.id_banco, i.forma_pago,   i.id_chequera, i.estatus_movimiento, i.beneficiario,   i.concepto, i.origen_movimiento,
i.numero_de_partida,   i.cia, i.neg, i.cta,i.sct, i.cc, i.icia,i.top, i.estatus, i.fecha_aplicacion,i.code_combination
from    fecxp_importacion_datos i,
fecxc_empresas e
where    i.atributo_1 = v_id_sesion
and        e.e_codigo = i.e_empresa_imp;
-- ***** limpia registros importados *****
delete    from fecxp_importacion_datos
where    atributo_1 = v_id_sesion;
insert    into    fecxp_bitacora_errores(id_sesion, mensaje)
values (v_id_sesion, 'OPERACI?N REALIZADA CON ?XITO ');
end if;
/* commit; */
end;
$body$
language plpgsql
;
