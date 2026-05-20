create or replace procedure fecxc."fecxp_imp_datos_layout_ns"  ( v_id_sesion fecxc.fecxp_importacion_datos_ns.atributo_1%type ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_errores integer:= 0;
v_periodo integer:=0;
begin 

-- ***** debugueo *****
update    fecxc.fecxp_importacion_datos_ns
set        estatus_origen = 'EN ESPERA'
where    atributo_1 = v_id_sesion;
-- ***** valida registros *****
-- ***** asigna estatus a registros validados en parametros de importacion*****
/*update    fecxp_importacion_datos_ns d
set        estatus_origen = (
select    p.estatus_origen
from    fecxp_importacion_datos_params p,
fecxc.fecxp_emp_no_set  e
where    e.id_emp = d.e_empresa_imp
and        p.tipoempresa = e.tipoempresa
and        p.tipo_importacion = d.tipo_importacion
)
where    d.estatus_origen = 'EN ESPERA'
and        d.atributo_1 = v_id_sesion;*/
update    fecxc.fecxp_importacion_datos_ns d
set        estatus_origen ='VALIDO'
where      d.estatus_origen =  'EN ESPERA'
and        d.atributo_1 = v_id_sesion;
-- dbms_output.put_line('ACTUALIZO');
-- ***** valida empresa *****
update    fecxc.fecxp_importacion_datos_ns d
set        estatus_origen = 'EMPRESA INVALIDA'
where      d.estatus_origen = 'VALIDO'
and        not exists (
select    e.id_emp
from    fecxc.fecxp_emp_no_set  e
where    e.id_emp  = d.e_empresa_imp
)
and        d.atributo_1 = v_id_sesion;
-- ***** valida moneda *****
update    fecxc.fecxp_importacion_datos_ns d
set        estatus_origen = 'MONEDA INVALIDA'
where    d.estatus_origen = 'VALIDO'
and        not exists (
select    1
from    fecxc.fecxp_monedas_no_set m
where    m.mon_oracle = d.moneda_imp
)
and        d.atributo_1 = v_id_sesion;
-- ***** valida clasificacion fe *****
update    fecxc.fecxp_importacion_datos_ns d
set       estatus_origen = 'CLASIFICACION FE INVALIDA'
where     d.estatus_origen = 'VALIDO'
and       not exists (
select    1
from    fecxc.fecxp_clasificacion_fe c
where    c.cla_fe_id = d.cla_fe_id_imp
)
and        d.atributo_1 = v_id_sesion;/* dmap converted statement start */
-- ***** guarda bitacoras *****
-- *****  empresa invalida *****
insert  into fecxc.fecxp_bit_err_ns(
id_sesion, mensaje)
select  v_id_sesion,  concat(estatus_origen, ': ' , e_empresa_imp
) from    fecxc.fecxp_importacion_datos_ns
where   estatus_origen = 'EMPRESA INVALIDA'
and     atributo_1 = v_id_sesion
group by estatus_origen, e_empresa_imp;/* dmap converted statement end *//* dmap converted statement start */
-- *****  moneda invalida *****
insert  into fecxc.fecxp_bit_err_ns(
id_sesion, mensaje)
select  v_id_sesion,  concat(estatus_origen, ': ' , moneda_imp
) from    fecxc.fecxp_importacion_datos_ns
where   estatus_origen = 'MONEDA INVALIDA'
and     atributo_1 = v_id_sesion
group by estatus_origen, moneda_imp;/* dmap converted statement end *//* dmap converted statement start */
-- *****  clasificacion fe invalida *****
insert  into fecxc.fecxp_bit_err_ns(
id_sesion, mensaje)
select  v_id_sesion,  concat(estatus_origen, ': ' , cla_fe_id_imp
) from    fecxc.fecxp_importacion_datos_ns
where   estatus_origen = 'CLASIFICACION FE INVALIDA'
and     atributo_1 = v_id_sesion
group by estatus_origen, cla_fe_id_imp;/* dmap converted statement end *//* dmap converted statement start */
-- *****  clasificaciones fe repetidas *****
insert into fecxc.fecxp_bit_err_ns(
id_sesion, mensaje)
select  v_id_sesion,  concat('CLASIFICACION REPETIDA: ', cla_fe_id_imp , ' EN LA EMPRESA :' , e_empresa_imp , '. MES :' , mes
) from    fecxc.fecxp_importacion_datos_ns
where   estatus_origen = 'VALIDO'
and     atributo_1 = v_id_sesion
group by tipo_importacion, e_empresa_imp, cla_fe_id_imp, importe_linea ,moneda_imp, mes, (to_char(fecha, 'MM'))::numeric ,atributo_1, atributo_2 ,atributo_3, atributo_4
having count(cla_fe_id_imp) > 1;/* dmap converted statement end *//* dmap converted statement start */
-- *****  los que se quedaron en espera *****
insert into fecxc.fecxp_bit_err_ns(
id_sesion, mensaje)
select  v_id_sesion,  concat('REGISTRO INVALIDO : CLASIFICACION : ', cla_fe_id_imp , '. EMPRESA :' , e_empresa_imp , '. MES :' , mes
) from    fecxc.fecxp_importacion_datos_ns
where   estatus_origen <> 'VALIDO'
and     atributo_1 = v_id_sesion;/* dmap converted statement end */
-- *****  saldo final *****
insert into fecxc.fecxp_bit_err_ns(
id_sesion, mensaje)
select   v_id_sesion, 'LA CLASIFICACION SF - SALDO FINAL ES PRIVADA'
from     fecxc.fecxp_importacion_datos_ns
where    atributo_1 = v_id_sesion
and      cla_fe_id_imp = 'SF'
group by cla_fe_id_imp;
-- *****  version fe numerica *****
insert  into fecxc.fecxp_bit_err_ns(
id_sesion, mensaje)
select   v_id_sesion, 'VERSION FE - EL CAMPO ATRIBUTO_3 SOLO PUEDE SER NUMERICO'
from     fecxc.fecxp_importacion_datos_ns
where    tipo_importacion in ('S', 'P')
and      atributo_1 = v_id_sesion
and      ascii(atributo_3) <= 48
and      ascii(atributo_3) >= 57
group by cla_fe_id_imp;
--  ***** verifica periodo vs version **** --
begin
select count(*) into strict v_periodo from fecxc.fecxp_importacion_datos_ns
where to_char(fecha,'YYYY') != (select distinct oracle.substr(atributo_3,0,4) from fecxc.fecxp_importacion_datos_ns);
exception
when others then
v_periodo:=2;
end;
-- ***** periodo vs version*****
if v_periodo > 1 then
insert  into fecxc.fecxp_bit_err_ns(
id_sesion, mensaje)
select   v_id_sesion, 'PERIODO Y VERSION NO CONCUERDAN'
from     fecxc.fecxp_importacion_datos_ns
where    atributo_1 = v_id_sesion;
end if;
-- ***** procesa registros *****
select  count(id_sesion)
into strict    v_errores
from    fecxc.fecxp_bit_err_ns
where   id_sesion = v_id_sesion;
if v_errores > 0 then
delete   from fecxc.fecxp_importacion_datos_ns
where    atributo_1 = v_id_sesion;
else
-- ***** manda los registros importados a historico ***** ---
---------
insert into fecxc.fecxp_imp_dat_hist(---25/mar/2009 se quito lo del tipo de empresa
/*tipo_empresa_imp,*/
tipo_importacion, e_empresa_imp, cla_fe_id_imp, importe_linea,
moneda_imp, mes, fecha, atributo_1, atributo_2, atributo_3, atributo_4,utilizar_reporte)
select   /* e.tipoempresa, */
i.tipo_importacion, i.e_empresa_imp, i.cla_fe_id_imp, i.importe_linea,
i.moneda_imp, i.mes, fecha, i.atributo_1, i.atributo_2, i.atributo_3, i.atributo_4, i.utilizar_reporte
from    fecxc.fecxp_importacion_datos_ns i,
fecxc.fecxp_emp_no_set  e
where   i.atributo_1 = v_id_sesion
and     e.id_emp = i.e_empresa_imp;
-- ***** manda los registros importados a bitacora *****
insert into fecxc.fecxp_imp_datos_bit_ns(---25/mar/2009 se quito lo del tipo de empresa
/*tipo_empresa_imp,*/
tipo_importacion, e_empresa_imp, cla_fe_id_imp, importe_linea,
moneda_imp, mes, fecha, atributo_1, atributo_2, atributo_3, atributo_4, accion, fecha_accion,utilizar_reporte)
select  /* e.tipoempresa,*/
i.tipo_importacion, i.e_empresa_imp, i.cla_fe_id_imp, i.importe_linea,
i.moneda_imp, i.mes, fecha, i.atributo_1, i.atributo_2, i.atributo_3, i.atributo_4, 'ALTA', clock_timestamp(), i.utilizar_reporte
from    fecxc.fecxp_importacion_datos_ns i,
fecxc.fecxp_emp_no_set  e
where    i.atributo_1 = v_id_sesion
and      e.id_emp = i.e_empresa_imp;
-- ***** llena las tablas de presupuesto y reales con los registros importados *****
call fecxc.fecxp_llena_crtls_ppto_imp ();
call fecxc.fecxp_llena_crtls_real_imp ();
-- ***** limpia registros importados ***** --
delete    from fecxc.fecxp_importacion_datos_ns
where    atributo_1 = v_id_sesion;
insert    into    fecxc.fecxp_bit_err_ns(id_sesion, mensaje)
values (v_id_sesion, 'OPERACION REALIZADA CON EXITO');
end if;
/* commit; */
end;
$body$
language plpgsql
;
