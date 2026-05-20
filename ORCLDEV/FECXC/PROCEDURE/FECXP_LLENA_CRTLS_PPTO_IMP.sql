create or replace procedure fecxc."fecxp_llena_crtls_ppto_imp"  () as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_id_sesion varchar(25) := to_char(clock_timestamp(),'DD-MM-YYYY');
v_contador_meses integer:=2;
v_existe_saldo_inicial integer;
v_meses_a_actualizar integer;
begin 

/* dmap converted statement start */
perform dbms_output.put_line( concat('INICIO ', to_char(clock_timestamp(),'YYYY-MM-DD HH:MM:SS') ) );/* dmap converted statement end */
v_contador_meses :=1;
select coalesce((max(mes))::numeric ,0) into strict v_meses_a_actualizar from  fecxc.fecxp_imp_dat_hist where procesado=0 and tipo_importacion='P';/* dmap converted statement start */
-----------------para la caratula de ppto importados--------------------------
insert  into fecxc.fecxp_ppto_caratula_impns(
e_codigo, des_empresa, id_sesion_pc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des, importe_linea, estatus,id_version,utilizar_reporte,id_linea,procesado)
select  d.e_empresa_imp , e.desc_emp, v_id_sesion, to_char(d.fecha,'YYYY'), d.mes, d.moneda_imp, m.tipo_cambio, d.cla_fe_id_imp, oracle.substr(cla_fe_des, 1, 25), (c.cla_atributo5)::numeric  * d.importe_linea, 'IMPORTADO',d.atributo_3,d.utilizar_reporte,md5(cast(d.ctid as text)),0
from    fecxc.fecxp_monedas_no_set m,
fecxc.fecxp_emp_no_set  e,
fecxc.fecxp_clasificacion_fe c,
fecxc.fecxp_imp_dat_hist d
where   1=1
and     d.tipo_importacion in ('S', 'P')
and     e.id_emp   = d.e_empresa_imp
and		m.mon_oracle = d.moneda_imp
and		m.mes = d.mes
and		m.periodo = (to_char(d.fecha, 'YYYY'))::numeric
and		c.cla_fe_id = d.cla_fe_id_imp
and     d.procesado = 0;/* dmap converted statement end *//* dmap converted statement start */
/* commit; */
perform dbms_output.put_line( concat('INICIO 3 ', to_char(clock_timestamp(),'YYYY-MM-DD HH:MM:SS'), ' ' , to_char(v_meses_a_actualizar) ) );/* dmap converted statement end *//* dmap converted statement start */
------------------------------------------------------------------------------------------------------------------------------------------
for c_meses in 1..12 loop
perform dbms_output.put_line( concat('INSERTANDO EL SALDO FINAL DEL MES ANTERIOR    ', to_char(v_contador_meses-1), 'COMO SALDO INICIAL DEL MES ACTUAL' , to_char(v_contador_meses))) ;/* dmap converted statement end */
if v_contador_meses > 1 then  ---no borra el saldo inicial de enero
---borrando saldo inicial del mes
delete from fecxc.fecxp_ppto_caratula_impns
where cla_fe_id like '%SI%'
and mes=v_contador_meses
and  procesado=0;
end if;/* dmap converted statement start */
---para calcular el saldo final saldo inicial enero
if v_contador_meses = 1 then
perform dbms_output.put_line( concat('CALCULANDO ENERO', to_char(clock_timestamp(),'YYYY-MM-DD HH:MM:SS') ) );/* dmap converted statement end */
insert into fecxc.fecxp_ppto_caratula_impns(e_codigo       ,   des_empresa, id_sesion_pc , periodo, mes,
moneda          ,   tipo_cambio, cla_fe_id    , cla_fe_des  ,
importe_linea   ,   estatus    ,   id_version  ,
utilizar_reporte,   id_linea   ,procesado)
select                                      e_codigo       ,   des_empresa, id_sesion_pc , periodo, mes,
moneda          ,   tipo_cambio, 'SF'         , 'SDO FINAL CHEQUERAS' ,
importe_linea   ,   estatus    ,   id_version  ,
utilizar_reporte,   id_linea   ,procesado
from fecxc.fecxp_ppto_caratula_impns
where mes =  1
and cla_fe_id like '%SI%'
and  procesado=0;
---para calcular el saldo final incremento efectivo neto del periodo
insert into fecxc.fecxp_ppto_caratula_impns(e_codigo       ,   des_empresa, id_sesion_pc , periodo, mes,
moneda          ,   tipo_cambio, cla_fe_id    , cla_fe_des  ,
importe_linea   ,   estatus    ,   id_version  ,
utilizar_reporte,   id_linea   ,procesado)
select                                      e_codigo       ,   des_empresa, id_sesion_pc , periodo, mes,
moneda          ,   tipo_cambio, 'SF'         , 'SDO FINAL CHEQUERAS' ,
importe_linea   ,   estatus    ,   id_version  ,
utilizar_reporte,   id_linea   ,procesado
from fecxc.fecxp_ppto_caratula_impns
where mes = 1
and cla_fe_id in (select  cla_fe_id
from    fecxp_clasificacion_fe
where   cla_atributo4 in ('01 INGRESOS OPERATIVOS','02 EGRESOS OPERATIVOS', '01 ACTIVIDADES DE INVERSION','01 ACTIVIDADES DE FINANCIAMIENTO'))
and  procesado=0;
/* commit; */
else      --calculando los demas meses
--insertando el saldo final del mes anterior como saldo final del mes actual
insert into fecxc.fecxp_ppto_caratula_impns(e_codigo  ,   des_empresa, id_sesion_pc, periodo, mes,moneda,   tipo_cambio, cla_fe_id, cla_fe_des, importe_linea, estatus,  id_version,utilizar_reporte,id_linea,procesado)
select
e_codigo, des_empresa, id_sesion_pc,
periodo, v_contador_meses, moneda,
tipo_cambio, 'SI', 'SDO INICIAL CHEQUERAS',
importe_linea, estatus,
id_version, utilizar_reporte, id_linea,procesado
from fecxc.fecxp_ppto_caratula_impns
where mes=(v_contador_meses-1)
and cla_fe_id like '%SF%'
and  procesado=0;
---para calcular el saldo final  a partir del saldo inicial
insert into fecxc.fecxp_ppto_caratula_impns(e_codigo       ,   des_empresa, id_sesion_pc , periodo, mes,
moneda          ,   tipo_cambio, cla_fe_id    , cla_fe_des  ,
importe_linea   ,   estatus    ,   id_version  ,
utilizar_reporte,   id_linea   ,procesado)
select                                      e_codigo       ,   des_empresa, id_sesion_pc , periodo, mes,
moneda          ,   tipo_cambio, 'SF'         , 'SDO FINAL CHEQUERAS' ,
importe_linea   ,   estatus    ,   id_version  ,
utilizar_reporte,   id_linea   ,procesado
from fecxc.fecxp_ppto_caratula_impns
where mes =  v_contador_meses
and cla_fe_id like '%SI%'
and  procesado=0;
---para calcular el saldo final a partir de incremento efectivo neto del periodo
insert into fecxc.fecxp_ppto_caratula_impns(e_codigo       ,   des_empresa, id_sesion_pc , periodo, mes,
moneda          ,   tipo_cambio, cla_fe_id    , cla_fe_des  ,
importe_linea   ,   estatus    ,   id_version  ,
utilizar_reporte,   id_linea   ,procesado)
select                                      e_codigo       ,   des_empresa, id_sesion_pc , periodo, mes,
moneda          ,   tipo_cambio, 'SF'         , 'SDO FINAL CHEQUERAS' ,
importe_linea   ,   estatus    ,   id_version  ,
utilizar_reporte,   id_linea   ,procesado
from fecxc.fecxp_ppto_caratula_impns
where mes = v_contador_meses
and cla_fe_id in (select  cla_fe_id
from    fecxp_clasificacion_fe
where   cla_atributo4 in ('01 INGRESOS OPERATIVOS','02 EGRESOS OPERATIVOS', '01 ACTIVIDADES DE INVERSION','01 ACTIVIDADES DE FINANCIAMIENTO'))
and  procesado=0;
end if;
v_contador_meses:=v_contador_meses+1;--incrementando el mes
/* commit; */
end loop;
---------------------------------------------------------------------------------------------------------------------------------------------
update fecxc.fecxp_imp_dat_hist
set  procesado = 1
where procesado = 0
and tipo_importacion = 'P';
update fecxc.fecxp_ppto_caratula_impns
set  procesado = 1
where procesado = 0;
/* commit; */
end;
$body$
language plpgsql
;
