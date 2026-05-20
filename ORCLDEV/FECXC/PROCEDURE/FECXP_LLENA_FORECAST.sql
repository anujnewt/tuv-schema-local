create or replace procedure fecxc."fecxp_llena_forecast"  (v_periodo integer, v_versiones_real varchar, v_version_ppto integer, v_id_version_forecast integer, v_operacion integer, v_nombre_version varchar, v_comentario varchar, v_usuario varchar ) as $body$
----1 es para insertar la version, 0 es para borrar la version  )
declare
-- pgv moved types start
-- pgv moved types end
v_version_p    integer; --para el manejo de las versiones
v_token_p      varchar(100);
v_contador_p   integer := 1;--para recorrer las versiones
v_enero        integer:=0;
v_febrero      integer:=0;
v_marzo        integer:=0;
v_abril        integer:=0;
v_mayo         integer:=0;
v_junio        integer:=0;
v_julio        integer:=0;
v_agosto       integer:=0;
v_septiembre   integer:=0;
v_octubre      integer:=0;
v_noviembre    integer:=0;
v_diciembre    integer:=0;
v_ultimo_mes_reales integer:=0;
v_contador_ppto integer:=0;
begin 

if v_operacion=1 then
----para el real---------------------------
loop
v_token_p := fecxp_stringtokenizer( v_versiones_real , v_contador_p  , ',');
exit when nullif(v_token_p::text, '') is null;/* dmap converted statement start */
if v_token_p !=0 then
--v_version_p:=to_number(v_periodo||lpad(v_token_p::text, 2, '0'::text));
v_version_p:=( concat(v_periodo, v_token_p)::numeric) ;/* dmap converted statement end *//* dmap converted statement start */
perform dbms_output.put_line( concat('MES->', v_contador_p, ' ID_VERSION->', v_version_p)) ;/* dmap converted statement end */
case
when v_contador_p = 1  then
v_enero := 1;
v_ultimo_mes_reales:=1;
insert into fecxc.fecxp_forecast_h(e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des,
importe_linea, estatus, tipo_caratula,id_version,tipo_ppto_real,id_version_forecast)
select                                         e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des,
importe_linea, estatus, tipo_caratula,id_version,'R',v_id_version_forecast
from fecxc.fecxp_real_caratula_h
where periodo     = v_periodo
and   mes         = v_enero
and   id_version  = v_version_p;
when v_contador_p = 2  then
v_febrero   := 2;
v_ultimo_mes_reales:=2;
insert into fecxc.fecxp_forecast_h(e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des,
importe_linea, estatus, tipo_caratula,id_version,tipo_ppto_real,id_version_forecast)
select                                         e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des,
importe_linea, estatus, tipo_caratula,id_version,'R',v_id_version_forecast
from fecxc.fecxp_real_caratula_h
where periodo     = v_periodo
and   mes         = v_febrero
and   id_version  = v_version_p;
when v_contador_p = 3  then
v_marzo     := 3;
v_ultimo_mes_reales:=3;
insert into fecxc.fecxp_forecast_h(e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des,
importe_linea, estatus, tipo_caratula,id_version,tipo_ppto_real,id_version_forecast)
select                                         e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des,
importe_linea, estatus, tipo_caratula,id_version,'R',v_id_version_forecast
from fecxc.fecxp_real_caratula_h
where periodo     = v_periodo
and   mes         = v_marzo
and   id_version  = v_version_p;
when v_contador_p = 4  then
v_abril     := 4;
v_ultimo_mes_reales:=4;
insert into fecxc.fecxp_forecast_h(e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des,
importe_linea, estatus, tipo_caratula,id_version,tipo_ppto_real,id_version_forecast)
select                                         e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des,
importe_linea, estatus, tipo_caratula,id_version,'R',v_id_version_forecast
from fecxc.fecxp_real_caratula_h
where periodo     = v_periodo
and   mes         = v_abril
and   id_version  = v_version_p;
when v_contador_p = 5  then
v_mayo      := 5;
v_ultimo_mes_reales:=5;
insert into fecxc.fecxp_forecast_h(e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des,
importe_linea, estatus, tipo_caratula,id_version,tipo_ppto_real,id_version_forecast)
select                                         e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des,
importe_linea, estatus, tipo_caratula,id_version,'R',v_id_version_forecast
from fecxc.fecxp_real_caratula_h
where periodo     = v_periodo
and   mes         = v_mayo
and   id_version  = v_version_p;
when v_contador_p = 6  then
v_junio     := 6;
v_ultimo_mes_reales:=6;
insert into fecxc.fecxp_forecast_h(e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des,
importe_linea, estatus, tipo_caratula,id_version,tipo_ppto_real,id_version_forecast)
select                                         e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des,
importe_linea, estatus, tipo_caratula,id_version,'R',v_id_version_forecast
from fecxc.fecxp_real_caratula_h
where periodo     = v_periodo
and   mes         = v_junio
and   id_version  = v_version_p;
when v_contador_p = 7  then
v_julio     := 7;
v_ultimo_mes_reales:=7;
insert into fecxc.fecxp_forecast_h(e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des,
importe_linea, estatus, tipo_caratula,id_version,tipo_ppto_real,id_version_forecast)
select                                         e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des,
importe_linea, estatus, tipo_caratula,id_version,'R',v_id_version_forecast
from fecxc.fecxp_real_caratula_h
where periodo     = v_periodo
and   mes         = v_julio
and   id_version  = v_version_p;
when v_contador_p = 8  then
v_agosto    := 8;
v_ultimo_mes_reales:=8;
insert into fecxc.fecxp_forecast_h(e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des,
importe_linea, estatus, tipo_caratula,id_version,tipo_ppto_real,id_version_forecast)
select                                         e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des,
importe_linea, estatus, tipo_caratula,id_version,'R',v_id_version_forecast
from fecxc.fecxp_real_caratula_h
where periodo     = v_periodo
and   mes         = v_agosto
and   id_version  = v_version_p;
when v_contador_p = 9  then
v_septiembre:= 9;
v_ultimo_mes_reales:=9;
insert into fecxc.fecxp_forecast_h(e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des,
importe_linea, estatus, tipo_caratula,id_version,tipo_ppto_real,id_version_forecast)
select                                         e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des,
importe_linea, estatus, tipo_caratula,id_version,'R',v_id_version_forecast
from fecxc.fecxp_real_caratula_h
where periodo     = v_periodo
and   mes         = v_septiembre
and   id_version  = v_version_p;
when v_contador_p = 10 then
v_octubre   := 10;
v_ultimo_mes_reales:=10;
insert into fecxc.fecxp_forecast_h(e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des,
importe_linea, estatus, tipo_caratula,id_version,tipo_ppto_real,id_version_forecast)
select                                         e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des,
importe_linea, estatus, tipo_caratula,id_version,'R',v_id_version_forecast
from fecxc.fecxp_real_caratula_h
where periodo     = v_periodo
and   mes         = v_octubre
and   id_version  = v_version_p;
when v_contador_p = 11 then
v_noviembre := 11;
v_ultimo_mes_reales:=11;
insert into fecxc.fecxp_forecast_h(e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des,
importe_linea, estatus, tipo_caratula,id_version,tipo_ppto_real,id_version_forecast)
select                                         e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des,
importe_linea, estatus, tipo_caratula,id_version,'R',v_id_version_forecast
from fecxc.fecxp_real_caratula_h
where periodo     = v_periodo
and   mes         = v_noviembre
and   id_version  = v_version_p;
when v_contador_p = 12 then
v_diciembre := 12;
v_ultimo_mes_reales:=12;
insert into fecxc.fecxp_forecast_h(e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des,
importe_linea, estatus, tipo_caratula,id_version,tipo_ppto_real,id_version_forecast)
select                                         e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des,
importe_linea, estatus, tipo_caratula,id_version,'R',v_id_version_forecast
from fecxc.fecxp_real_caratula_h
where periodo     = v_periodo
and   mes         = v_diciembre
and   id_version  = v_version_p;
end case;
end if;
v_contador_p := v_contador_p + 1;
/* commit; */
end loop;/* dmap converted statement start */
-----para el presupuesto---------------------------
insert into fecxc.fecxp_forecast_h(e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des,
importe_linea, estatus, tipo_caratula,id_version,tipo_ppto_real,id_version_forecast)
select                                              e_codigo, des_empresa, id_sesion_pc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des,
importe_linea, estatus,''            ,id_version,'P',v_id_version_forecast
from fecxc.fecxp_ppto_caratula_h
where periodo     = v_periodo
--and   id_version  = v_periodo||lpad(v_version_ppto::text, 2, '0'::text)
and   id_version  =  concat(v_periodo, v_version_ppto
) and mes not in (v_enero,v_febrero,v_marzo,v_abril,v_mayo,v_junio,v_julio,v_agosto,v_septiembre,v_octubre,v_noviembre,v_diciembre);/* dmap converted statement end */
/* commit; */
v_contador_ppto:=v_ultimo_mes_reales;
v_ultimo_mes_reales:=v_ultimo_mes_reales+1;/* dmap converted statement start */
for ic in v_ultimo_mes_reales..12 loop
----------pasar el saldo final del ultimo mes de reales al primero de presupuesto------------
perform dbms_output.put_line( concat('ULTIMO MES DE REALES->', v_contador_ppto, ' PRIMER MES DE PRESUPUESTO->', (v_contador_ppto+1))) ;/* dmap converted statement end */
delete from fecxp_forecast_h
where mes = (v_contador_ppto+1)
and  cla_fe_id in ('si','si coin', 'SI INV')
and  id_version_forecast=v_id_version_forecast;
--and  cla_fe_des in ('sdo inicial chequeras','sdo inicial coinversion','sdo inicial inversion');
/* commit; */
--insertar los registros de saldos finales del ultimo mes de reales en los de saldos iniciales del primer mes de presupuesto
insert into fecxc.fecxp_forecast_h(e_codigo, des_empresa, id_sesion_rc,
periodo, mes, moneda,
tipo_cambio, cla_fe_id, cla_fe_des,
importe_linea, estatus, tipo_caratula,
id_version, tipo_ppto_real, id_version_forecast)
select
e_codigo, des_empresa, id_sesion_rc,
periodo, (v_contador_ppto+1), moneda,
tipo_cambio, case when cla_fe_id='SF' then 'SI' when cla_fe_id='SF INV' then 'SI INV' when cla_fe_id='SF COIN' then 'SI COIN'  else cla_fe_id end ,
case when cla_fe_des='SDO FINAL CHEQUERAS' then 'SDO INICIAL CHEQUERAS' when cla_fe_des='SDO FINAL INVERSION' then 'SDO INICIAL INVERSION' when cla_fe_des='SDO FINAL COINVERSION' then 'SDO INICIAL COINVERSION' when cla_fe_des='SALDO FINAL' then 'SALDO INICIAL'  else cla_fe_des end ,
importe_linea, estatus, tipo_caratula,
id_version, tipo_ppto_real, id_version_forecast
from fecxc.fecxp_forecast_h
where mes = v_contador_ppto
and  cla_fe_id in ('sf','sf coin', 'SF INV')
and  id_version_forecast=v_id_version_forecast;
-- and  cla_fe_des in ('sdo inicial chequeras','sdo inicial coinversion','sdo inicial inversion');
/* commit; */
-----borrar el saldo final del mes
delete from fecxp_forecast_h
where mes = (v_contador_ppto+1)
and  cla_fe_id in ('sf','sf coin', 'SF INV')
and  id_version_forecast=v_id_version_forecast;
/* commit; */
---insertando saldos finales
insert into fecxc.fecxp_forecast_h(e_codigo, des_empresa, id_sesion_rc,
periodo, mes, moneda,
tipo_cambio, cla_fe_id, cla_fe_des,
importe_linea, estatus, tipo_caratula,
id_version, tipo_ppto_real, id_version_forecast)
select
e_codigo, des_empresa, id_sesion_rc,
periodo, (v_contador_ppto+1), moneda,
tipo_cambio,  cla_fe_id,
cla_fe_des,
importe_linea, estatus, tipo_caratula,
id_version, tipo_ppto_real, id_version_forecast
from fecxc.fecxp_forecast_h
where mes = v_contador_ppto
and  cla_fe_id in ('sf','sf coin', 'SF INV');/* dmap converted statement start */
/* commit; */
--insertando ==incremento neto de efectivo del periodo como saldo final
--insertando ==incremento neto de efectivo del periodo como saldo final
insert into fecxc.fecxp_forecast_h(e_codigo,
des_empresa,
id_sesion_rc,
periodo, mes, moneda,
tipo_cambio, cla_fe_id, cla_fe_des,
importe_linea, estatus, tipo_caratula,
id_version, tipo_ppto_real, id_version_forecast)
select     distinct  empresa_cod,
empresa_des,
c.id_sesion_rc,
c.periodo,
(v_contador_ppto+1),
c.moneda,
c.tipo_cambio,
'SF' as cla_fe_id,
'SALDO FINAL' as cla_fe_des,
c.real_mon_origen,
c.estatus,
c.tipo_caratula,
c.id_version,
'P',
c.id_version_forecast
from    (
select    b.id_segmento segmento_empresa_cod,
b.des_segmento segmento_empresa_des,
to_char(c.e_codigo)  empresa_cod,
c.des_empresa  empresa_des,
c.moneda moneda,
--c.moneda || ' TC: ' || to_char (m.tipo_cambio) moneda,
to_char(c.periodo) as periodo,
to_char(to_timestamp(c.mes,'MM'), 'MONTH', 'NLS_DATE_LANGUAGE=SPANISH') as mes,
to_char(lpad(c.mes::text, 2, '0'::text)::text) as mes_num,
m.tipo_cambio,
'INCREM' clave_flujo,
'INCREMENTO NETO DE EFECTIVO DEL PERIODO' concepto_flujo,
(f.cla_atributo1)::numeric  orden,
'INCREMENTO NETO DE EFECTIVO DEL PERIODO' rubro,
'INCREMENTO NETO DE EFECTIVO DEL PERIODO' agrupamiento,
'06 INCREMENTO NETO DE EFECTIVO DEL PERIODO' divison,
(f.cla_atributo3)::numeric  signo,
sum(c.real_mon_origen) real_mon_origen,
sum(c.real_mon_origen * m.tipo_cambio) real_mon_funcional,
0 real_mon_origen_acum,
0 real_mon_funcional_acum,
0 real_mon_funcional_acum2,
0 real_mon_origen_acum2,
'NO GENERA SALDO' tipo_afectacion,
estatus,
tipo_caratula,
id_version,
id_version_forecast,
id_sesion_rc
from    (
select  c.e_codigo,
c.des_empresa,
c.moneda,
c.periodo,
c.mes,
c.tipo_cambio,
c.cla_fe_id,
c.importe_linea real_mon_origen,
0 ppto_mon_origen,
0 real_mon_origen_acum,
0 ppto_mon_origen_acum,
c.estatus,
c.tipo_caratula,
id_version_forecast,
id_version ,
id_sesion_rc
from    fecxp_forecast_h c
where   c.mes= (v_contador_ppto+1)
and  id_version_forecast=v_id_version_forecast
and  periodo=v_periodo
--where   id_version = fecxp_set_version_h_get_version
union all
select    c.e_codigo,
c.des_empresa,
c.moneda,
c.periodo,
c.mes,
c.tipo_cambio,
c.cla_fe_id,
0 real_mon_origen,
0 ppto_mon_origen,
case
--                when c.cla_fe_id = 'SI' then case c.mes when 1 then c.importe_linea else 0 end
--                when c.cla_fe_id in ('SF', 'SF2', 'COLUMBUS', 'COMTELVI', 'GRUPO ESPA?A', 'NDUAL', 'COMPRA USD') then case c.mes when to_number(to_char (sysdate::text, 'MM')) - 1 then c.importe_linea else 0 end
when c.cla_fe_id in ('SI', 'COLUMBUS I', 'COMTELVI I', 'GRUPO ESPA?A I', 'NOTA D I', 'compra dls i','si coin', 'SI INV' ) then
case c.mes when 1 then c.importe_linea else 0 end
when c.cla_fe_id in ('SF', 'SF2', 'COLUMBUS F', 'COMTELVI F', 'GRUPO ESPA?A F', 'NOTA D F', 'compra dls f','sf coin', 'SF INV') then
case c.mes when (to_char(clock_timestamp(), 'MM'))::numeric  - 1 then c.importe_linea else 0 end
else
c.importe_linea
end real_mon_origen_acum,
0 ppto_mon_origen_acum,
c.estatus,
c.tipo_caratula,
id_version_forecast,
id_version,
id_sesion_rc
from    fecxp_forecast_h c
where   c.mes= (v_contador_ppto+1)
and  id_version_forecast=v_id_version_forecast
and  periodo=v_periodo
) c,
fecxp_clasificacion_fe f,
fecxc_emp_x_segmento a,
fecxc_segmentos_flujo b,
fecxp_monedas m
where    c.cla_fe_id = f.cla_fe_id
and        c.periodo <= (to_char(clock_timestamp(),'YYYY'))::numeric
and        f.cla_atributo4 in ('01 actividades de inversion','01 actividades de financiamiento','01 ingresos operativos','02 egresos operativos')
and        a.id_segmento not in (11, 15, 17,18, 20, 26, 6, 13, 25)
and        a.id_segmento = b.id_segmento
and        c.e_codigo = a.e_codigo
and        m.mon_oracle = c.moneda
and        m.periodo =
case when  c.cla_fe_id in ('si','si coin', 'SI INV')
then
case c.mes when 1
then c.periodo - 1
else c.periodo
end
else c.periodo
end
and        m.mes =
case when  c.cla_fe_id in ('si','si coin', 'SI INV')
then
case c.mes when 1
then 12
else c.mes - 1
end
else c.mes
end
and f.cla_fe_des not in ('CANCELACIONES')
group by b.id_segmento,
b.des_segmento,
to_char(c.e_codigo),
c.des_empresa,
c.moneda ,
concat(c.moneda, ' TC: ' , to_char(m.tipo_cambio)) ,
to_char(c.periodo),
to_char(to_timestamp(c.mes,'MM'), 'MONTH', 'NLS_DATE_LANGUAGE=SPANISH'),
to_char(lpad(c.mes::text, 2, '0'::text)::text),
m.tipo_cambio,
(f.cla_atributo1)::numeric ,
(f.cla_atributo3)::numeric ,
estatus,
tipo_caratula,
id_version,
id_version_forecast,
id_sesion_rc) c;/* dmap converted statement end */
/* commit; */
/*
insert into fecxc.fecxp_forecast_h (e_codigo, des_empresa, id_sesion_rc,
periodo, mes, moneda,
tipo_cambio, cla_fe_id, cla_fe_des,
importe_linea, estatus, tipo_caratula,
id_version, tipo_ppto_real, id_version_forecast)
select       distinct   c.e_codigo,
c.des_empresa,
c.id_sesion_rc,
c.periodo,
(v_contador_ppto+1),
c.moneda,
c.tipo_cambio,
'SF' as cla_fe_id,
'SDO FINAL CHEQUERAS' as cla_fe_des,
c.real_mon_origen,
c.estatus,
c.tipo_caratula,
c.id_version,
'P',
c.id_version_forecast
from    (
select  c.e_codigo,
c.des_empresa,
c.id_sesion_rc,
c.moneda,
c.periodo,
c.mes,
c.tipo_cambio,
c.cla_fe_id,
c.cla_fe_des,
c.importe_linea real_mon_origen,
0 ppto_mon_origen,
0 real_mon_origen_acum,
0 ppto_mon_origen_acum,
c.estatus,
c.id_version,
c.tipo_caratula,
id_version_forecast
from    fecxp_forecast_h c
where   c.mes= (v_contador_ppto+1)
and  id_version_forecast=v_id_version_forecast
and  periodo=v_periodo
union all
select    c.e_codigo,
c.des_empresa,
c.id_sesion_rc,
c.moneda,
c.periodo,
c.mes,
c.tipo_cambio,
c.cla_fe_id,
c.cla_fe_des,
0 real_mon_origen,
0 ppto_mon_origen,
case
--                when c.cla_fe_id = 'SI' then case c.mes when 1 then c.importe_linea else 0 end
--                when c.cla_fe_id in ('SF', 'SF2', 'COLUMBUS', 'COMTELVI', 'GRUPO ESPA?A', 'NDUAL', 'COMPRA USD') then case c.mes when to_number(to_char (sysdate::text, 'MM')) - 1 then c.importe_linea else 0 end
when c.cla_fe_id in ('SI', 'COLUMBUS I', 'COMTELVI I', 'GRUPO ESPA?A I', 'NOTA D I', 'compra dls i','si coin', 'SI INV' ) then
case c.mes when 1 then c.importe_linea else 0 end
when c.cla_fe_id in ('SF', 'SF2', 'COLUMBUS F', 'COMTELVI F', 'GRUPO ESPA?A F', 'NOTA D F', 'compra dls f','sf coin', 'SF INV') then
case c.mes when to_number(to_char (sysdate::text, 'MM')) - 1 then c.importe_linea else 0 end
else
c.importe_linea
end real_mon_origen_acum,
0 ppto_mon_origen_acum,
c.estatus,
c.id_version,
c.tipo_caratula,
c.id_version_forecast
from    fecxp_forecast_h c
where   c.mes= (v_contador_ppto+1)
and  id_version_forecast=v_id_version_forecast
and  periodo=v_periodo
) c,
fecxp_clasificacion_fe f,
fecxc_emp_x_segmento a,
fecxc_segmentos_flujo b,
fecxp_monedas m
where    c.cla_fe_id = f.cla_fe_id
and        c.periodo <= to_number(to_char(sysdate::text, 'YYYY'))
and        f.cla_atributo4 in ('01 actividades de inversion','01 actividades de financiamiento','01 ingresos operativos','02 egresos operativos')
and        a.id_segmento not in (11, 15, 17,18, 20, 26, 6, 13, 25)
and        a.id_segmento = b.id_segmento
and        c.e_codigo = a.e_codigo
and        m.mon_oracle = c.moneda
and        m.periodo =
case when  c.cla_fe_id in ('si','si coin', 'SI INV')
then
case c.mes when 1
then c.periodo - 1
else c.periodo
end
else c.periodo
end
and        m.mes =
case when  c.cla_fe_id in ('si','si coin', 'SI INV')
then
case c.mes when 1
then 12
else c.mes - 1
end
else c.mes
end;
--and f.cla_fe_des not in ('cancelaciones','ingresos interempresas');
/* commit; */
/*
--------insertando la fluctuacion cambiaria como saldo final
insert into fecxc.fecxp_forecast_h (e_codigo, des_empresa, id_sesion_rc,
periodo, mes, moneda,
tipo_cambio, cla_fe_id, cla_fe_des,
importe_linea, estatus, tipo_caratula,
id_version, tipo_ppto_real, id_version_forecast)
select       distinct   c.e_codigo,
c.des_empresa,
c.id_sesion_rc,
c.periodo,
(v_contador_ppto+1),
c.moneda,
c.tipo_cambio,
'SF' as cla_fe_id,
'SALDO FINAL' as cla_fe_des,
c.real_mon_origen,
c.estatus,
c.tipo_caratula,
c.id_version,
'P',
c.id_version_forecast
from    (
select    c.e_codigo,
c.des_empresa,
c.moneda,
c.periodo,
c.mes,
c.tipo_cambio,
c.cla_fe_id,
c.importe_linea real_mon_origen,
0 ppto_mon_origen,
0 real_mon_origen_acum,
0 ppto_mon_origen_acum,
c.estatus,
c.tipo_caratula,
c.id_version_forecast,
c.id_version,
c.id_sesion_rc
from    fecxp_forecast_h c
where c.mes=  (v_contador_ppto+1)
union all
select    c.e_codigo,
c.des_empresa,
c.moneda,
c.periodo,
c.mes,
c.tipo_cambio,
c.cla_fe_id,
0 real_mon_origen,
0 ppto_mon_origen,
case
--                when c.cla_fe_id = 'SI' then case c.mes when 1 then c.importe_linea else 0 end
--                when c.cla_fe_id in ('SF', 'SF2', 'COLUMBUS', 'COMTELVI', 'GRUPO ESPA?A', 'NDUAL', 'COMPRA USD') then case c.mes when to_number(to_char (sysdate::text, 'MM')) - 1 then c.importe_linea else 0 end
when c.cla_fe_id in ('SI', 'COLUMBUS I', 'COMTELVI I', 'GRUPO ESPA?A I', 'NOTA D I', 'compra dls i','si coin', 'SI INV' ) then
case c.mes when 1 then c.importe_linea else 0 end
when c.cla_fe_id in ('SF', 'SF2', 'COLUMBUS F', 'COMTELVI F', 'GRUPO ESPA?A F', 'NOTA D F', 'compra dls f','sf coin', 'SF INV') then
case c.mes when to_number(to_char (sysdate::text, 'MM')) - 1 then c.importe_linea else 0 end
else
c.importe_linea
end real_mon_origen_acum,
0 ppto_mon_origen_acum,
c.estatus,
c.tipo_caratula,
c.id_version_forecast,
c.id_version,
c.id_sesion_rc
from    fecxp_forecast_h c
where c.mes=  (v_contador_ppto+1)
) c,
fecxp_clasificacion_fe f,
fecxc_emp_x_segmento a,
fecxc_segmentos_flujo b,
fecxp_monedas m,
fecxp_monedas n
where    c.cla_fe_id = f.cla_fe_id
and        c.periodo <= to_number(to_char(sysdate::text, 'YYYY'))
and        a.id_segmento not in (11, 15, 17,18, 20, 26, 6, 13, 25)
and        a.id_segmento = b.id_segmento
and        c.e_codigo = a.e_codigo
and     n.mon_oracle = c.moneda
and        n.periodo = c.periodo
and     n.mes = c.mes
and        m.mon_oracle = c.moneda
and        m.periodo =
case when  c.cla_fe_id in ('si','si coin', 'SI INV')
then
case c.mes when 1
then c.periodo - 1
else c.periodo
end
else c.periodo
end
and        m.mes =
case when  c.cla_fe_id in ('si','si coin', 'SI INV')
then
case c.mes when 1
then 12
else c.mes - 1
end
else c.mes
end
and ((c.real_mon_origen * n.tipo_cambio) - (c.real_mon_origen * m.tipo_cambio))<>0
and f.cla_fe_des not in ('CANCELACIONES');**/
/* commit; */
v_contador_ppto:=v_contador_ppto+1;
end loop;
/* commit; */
end if;
if v_operacion=0 then
delete
from  fecxc.fecxp_forecast_h
where id_version_forecast    = v_id_version_forecast;
/* commit; */
end if;
/* commit; */
insert into fecxp_bitacora_historicos(proceso_id, proceso_nombre         , created_by, date_created, id_version           , desc_version, periodo, mes, comentario, tipo_operacion)
select                                        19, 'HISTORICO DE FORECAST', v_usuario , clock_timestamp()     , v_id_version_forecast, v_nombre_version, v_periodo, 0, v_comentario, case when v_operacion=1 then 'REGISTRA VERSION' else 'ELIMINA VERSION' end;
/* commit; */
update fecxp_ppto_extraccion_params
set estatus_proceso = 'INACTIVO',estatus_ext_ult_ejecucion= 'EXITOSO'
where proceso_id =19;
exception
when others then
update fecxp_ppto_extraccion_params
set estatus_proceso = 'INACTIVO',estatus_ext_ult_ejecucion= 'ERROR'
where proceso_id =19;/* dmap converted statement start */
raise exception '%',  concat('An error was encountered - ', sqlstate, ' -ERROR- ', sqlerrm)  using errcode = '45001';/* dmap converted statement end */
rollback;end;
$body$
language plpgsql
;
