create or replace procedure fecxc."fecxp_llena_forecast_ns"  (v_periodo integer, v_versiones_real_h varchar, v_version_ppto_h integer, v_versiones_real_ns varchar, v_version_ppto_ns integer, v_comentario varchar, v_usuario varchar ) as $body$
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
v_error_num    integer;
v_error_code   varchar(400);
begin 

/* dmap converted statement start */
perform dbms_output.put_line( concat('INICIO ', to_char(clock_timestamp(),'DD-MM-YYYY HH:MM:SS'))) ;/* dmap converted statement end */
delete
from fecxc.fecxp_forecast_ns;--se borra la tabla del forecast no set
/* commit; */
----para el real de historicos---------------------------
loop
v_token_p := fecxc.fecxp_stringtokenizer( v_versiones_real_h , v_contador_p  , ',');
exit when nullif(v_token_p::text, '') is null;/* dmap converted statement start */
if v_token_p !=0 then
--to_char(v_version_p):=to_number(v_periodo||lpad(v_token_p::text, 2, '0'::text));
v_version_p:=( concat(v_periodo, v_token_p)::numeric) ;/* dmap converted statement end *//* dmap converted statement start */
perform dbms_output.put_line( concat('MES->', v_contador_p, ' ID_VERSION->', to_char(v_version_p))) ;/* dmap converted statement end */
case
when v_contador_p = 1  then
v_enero := 1;
v_ultimo_mes_reales:=1;/* dmap converted statement start */
insert into fecxc.fecxp_forecast_ns(e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des,
importe_linea, estatus, tipo_caratula,id_version,tipo_ppto_real,tipo_empresa)
select                                         e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des,
importe_linea, estatus, tipo_caratula,id_version,'r','set'
from fecxc.fecxp_real_caratula_h
where periodo     = v_periodo
and   mes         = v_enero
and   id_version  = to_char(v_version_p)
and rowid not in ( select md5(cast(a.ctid as text)) from fecxp_real_caratula_h a,
fecxp_real_caratula_impns b
where a.e_codigo=b.e_codigo
and a.periodo=b.periodo
and a.mes=b.mes
and b.utilizar_reporte='S');/* dmap converted statement end */
when v_contador_p = 2  then
v_febrero   := 2;
v_ultimo_mes_reales:=2;/* dmap converted statement start */
insert into fecxc.fecxp_forecast_ns(e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des,
importe_linea, estatus, tipo_caratula,id_version,tipo_ppto_real,tipo_empresa)
select                                         e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des,
importe_linea, estatus, tipo_caratula,id_version,'r','set'
from fecxc.fecxp_real_caratula_h
where periodo     = v_periodo
and   mes         = v_febrero
and   id_version  = to_char(v_version_p)
and rowid not in ( select md5(cast(a.ctid as text)) from fecxp_real_caratula_h a,
fecxp_real_caratula_impns b
where a.e_codigo=b.e_codigo
and a.periodo=b.periodo
and a.mes=b.mes
and b.utilizar_reporte='S');/* dmap converted statement end */
when v_contador_p = 3  then
v_marzo     := 3;
v_ultimo_mes_reales:=3;/* dmap converted statement start */
insert into fecxc.fecxp_forecast_ns(e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des,
importe_linea, estatus, tipo_caratula,id_version,tipo_ppto_real,tipo_empresa)
select                                         e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des,
importe_linea, estatus, tipo_caratula,id_version,'r','set'
from fecxc.fecxp_real_caratula_h
where periodo     = v_periodo
and   mes         = v_marzo
and   id_version  = to_char(v_version_p)
and rowid not in ( select md5(cast(a.ctid as text)) from fecxp_real_caratula_h a,
fecxp_real_caratula_impns b
where a.e_codigo=b.e_codigo
and a.periodo=b.periodo
and a.mes=b.mes
and b.utilizar_reporte='S');/* dmap converted statement end */
when v_contador_p = 4  then
v_abril     := 4;
v_ultimo_mes_reales:=4;/* dmap converted statement start */
insert into fecxc.fecxp_forecast_ns(e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des,
importe_linea, estatus, tipo_caratula,id_version,tipo_ppto_real,tipo_empresa)
select                                         e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des,
importe_linea, estatus, tipo_caratula,id_version,'r','set'
from fecxc.fecxp_real_caratula_h
where periodo     = v_periodo
and   mes         = v_abril
and   id_version  = to_char(v_version_p)
and rowid not in ( select md5(cast(a.ctid as text)) from fecxp_real_caratula_h a,
fecxp_real_caratula_impns b
where a.e_codigo=b.e_codigo
and a.periodo=b.periodo
and a.mes=b.mes
and b.utilizar_reporte='S');/* dmap converted statement end */
when v_contador_p = 5  then
v_mayo      := 5;
v_ultimo_mes_reales:=5;/* dmap converted statement start */
insert into fecxc.fecxp_forecast_ns(e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des,
importe_linea, estatus, tipo_caratula,id_version,tipo_ppto_real,tipo_empresa)
select                                         e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des,
importe_linea, estatus, tipo_caratula,id_version,'r','set'
from fecxc.fecxp_real_caratula_h
where periodo     = v_periodo
and   mes         = v_mayo
and   id_version  = to_char(v_version_p)
and rowid not in ( select md5(cast(a.ctid as text)) from fecxp_real_caratula_h a,
fecxp_real_caratula_impns b
where a.e_codigo=b.e_codigo
and a.periodo=b.periodo
and a.mes=b.mes
and b.utilizar_reporte='S');/* dmap converted statement end */
when v_contador_p = 6  then
v_junio     := 6;
v_ultimo_mes_reales:=6;/* dmap converted statement start */
insert into fecxc.fecxp_forecast_ns(e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des,
importe_linea, estatus, tipo_caratula,id_version,tipo_ppto_real,tipo_empresa)
select                                         e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des,
importe_linea, estatus, tipo_caratula,id_version,'r','set'
from fecxc.fecxp_real_caratula_h
where periodo     = v_periodo
and   mes         = v_junio
and   id_version  = to_char(v_version_p)
and rowid not in ( select md5(cast(a.ctid as text)) from fecxp_real_caratula_h a,
fecxp_real_caratula_impns b
where a.e_codigo=b.e_codigo
and a.periodo=b.periodo
and a.mes=b.mes
and b.utilizar_reporte='S');/* dmap converted statement end */
when v_contador_p = 7  then
v_julio     := 7;
v_ultimo_mes_reales:=7;/* dmap converted statement start */
insert into fecxc.fecxp_forecast_ns(e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des,
importe_linea, estatus, tipo_caratula,id_version,tipo_ppto_real,tipo_empresa)
select                                         e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des,
importe_linea, estatus, tipo_caratula,id_version,'r','set'
from fecxc.fecxp_real_caratula_h
where periodo     = v_periodo
and   mes         = v_julio
and   id_version  = to_char(v_version_p)
and rowid not in ( select md5(cast(a.ctid as text)) from fecxp_real_caratula_h a,
fecxp_real_caratula_impns b
where a.e_codigo=b.e_codigo
and a.periodo=b.periodo
and a.mes=b.mes
and b.utilizar_reporte='S');/* dmap converted statement end */
when v_contador_p = 8  then
v_agosto    := 8;
v_ultimo_mes_reales:=8;/* dmap converted statement start */
insert into fecxc.fecxp_forecast_ns(e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des,
importe_linea, estatus, tipo_caratula,id_version,tipo_ppto_real,tipo_empresa)
select                                         e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des,
importe_linea, estatus, tipo_caratula,id_version,'r','set'
from fecxc.fecxp_real_caratula_h
where periodo     = v_periodo
and   mes         = v_agosto
and   id_version  = to_char(v_version_p)
and rowid not in ( select md5(cast(a.ctid as text)) from fecxp_real_caratula_h a,
fecxp_real_caratula_impns b
where a.e_codigo=b.e_codigo
and a.periodo=b.periodo
and a.mes=b.mes
and b.utilizar_reporte='S');/* dmap converted statement end */
when v_contador_p = 9  then
v_septiembre:= 9;
v_ultimo_mes_reales:=9;/* dmap converted statement start */
insert into fecxc.fecxp_forecast_ns(e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des,
importe_linea, estatus, tipo_caratula,id_version,tipo_ppto_real,tipo_empresa)
select                                         e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des,
importe_linea, estatus, tipo_caratula,id_version,'r','set'
from fecxc.fecxp_real_caratula_h
where periodo     = v_periodo
and   mes         = v_septiembre
and   id_version  = to_char(v_version_p)
and rowid not in ( select md5(cast(a.ctid as text)) from fecxp_real_caratula_h a,
fecxp_real_caratula_impns b
where a.e_codigo=b.e_codigo
and a.periodo=b.periodo
and a.mes=b.mes
and b.utilizar_reporte='S');/* dmap converted statement end */
when v_contador_p = 10 then
v_octubre   := 10;
v_ultimo_mes_reales:=10;/* dmap converted statement start */
insert into fecxc.fecxp_forecast_ns(e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des,
importe_linea, estatus, tipo_caratula,id_version,tipo_ppto_real,tipo_empresa)
select                                         e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des,
importe_linea, estatus, tipo_caratula,id_version,'r','set'
from fecxc.fecxp_real_caratula_h
where periodo     = v_periodo
and   mes         = v_octubre
and   id_version  = to_char(v_version_p)
and rowid not in ( select md5(cast(a.ctid as text)) from fecxp_real_caratula_h a,
fecxp_real_caratula_impns b
where a.e_codigo=b.e_codigo
and a.periodo=b.periodo
and a.mes=b.mes
and b.utilizar_reporte='S');/* dmap converted statement end */
when v_contador_p = 11 then
v_noviembre := 11;
v_ultimo_mes_reales:=11;/* dmap converted statement start */
insert into fecxc.fecxp_forecast_ns(e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des,
importe_linea, estatus, tipo_caratula,id_version,tipo_ppto_real,tipo_empresa)
select                                         e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des,
importe_linea, estatus, tipo_caratula,id_version,'r','set'
from fecxc.fecxp_real_caratula_h
where periodo     = v_periodo
and   mes         = v_noviembre
and   id_version  = to_char(v_version_p)
and rowid not in ( select md5(cast(a.ctid as text)) from fecxp_real_caratula_h a,
fecxp_real_caratula_impns b
where a.e_codigo=b.e_codigo
and a.periodo=b.periodo
and a.mes=b.mes
and b.utilizar_reporte='S');/* dmap converted statement end */
when v_contador_p = 12 then
v_diciembre := 12;
v_ultimo_mes_reales:=12;/* dmap converted statement start */
insert into fecxc.fecxp_forecast_ns(e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des,
importe_linea, estatus, tipo_caratula,id_version,tipo_ppto_real,tipo_empresa)
select                                         e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des,
importe_linea, estatus, tipo_caratula,id_version,'r','set'
from fecxc.fecxp_real_caratula_h
where periodo     = v_periodo
and   mes         = v_diciembre
and   id_version  = to_char(v_version_p)
and rowid not in ( select md5(cast(a.ctid as text)) from fecxp_real_caratula_h a,
fecxp_real_caratula_impns b
where a.e_codigo=b.e_codigo
and a.periodo=b.periodo
and a.mes=b.mes
and b.utilizar_reporte='S');/* dmap converted statement end */
end case;
end if;
v_contador_p := v_contador_p + 1;
/* commit; */
end loop;/* dmap converted statement start */
-----para el presupuesto  de historicos---------------------------
insert into fecxc.fecxp_forecast_ns(e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des,
importe_linea, estatus, tipo_caratula,id_version,tipo_ppto_real,tipo_empresa)
select                                              e_codigo, des_empresa, id_sesion_pc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des,
importe_linea, estatus,''            ,id_version,'p','set'
from fecxc.fecxp_ppto_caratula_h
where periodo     = v_periodo
--and   id_version  = v_periodo||lpad(to_char(v_version_ppto_h::text, 2, '0'::text)
and   id_version  =  concat(v_periodo, v_version_ppto_h
) and mes not in (v_enero,v_febrero,v_marzo,v_abril,v_mayo,v_junio,v_julio,v_agosto,v_septiembre,v_octubre,v_noviembre,v_diciembre)
and rowid not in ( select md5(cast(a.ctid as text)) from fecxp_real_caratula_h a,
fecxp_ppto_caratula_impns b
where a.e_codigo=b.e_codigo
and a.periodo=b.periodo
and a.mes=b.mes
and b.utilizar_reporte='S');/* dmap converted statement end */
/* commit; */
----------------------------------------------------------------------------------------------------------------------------------
-------reiniciamos variables para  llenar con informacion de las empresas no set ----------------------------------------
v_version_p    :=0;
v_token_p:= null;
v_contador_p   := 1;--para recorrer las versiones
v_enero        :=0;
v_febrero      :=0;
v_marzo        :=0;
v_abril        :=0;
v_mayo         :=0;
v_junio        :=0;
v_julio        :=0;
v_agosto       :=0;
v_septiembre   :=0;
v_octubre      :=0;
v_noviembre    :=0;
v_diciembre    :=0;
v_ultimo_mes_reales :=0;
v_contador_ppto :=0;
---para el real de no set---------------------------
loop
v_token_p := fecxc.fecxp_stringtokenizer( v_versiones_real_ns , v_contador_p  , ',');
exit when nullif(v_token_p::text, '') is null;/* dmap converted statement start */
if v_token_p !=0 then
--to_char(v_version_p):=to_number(v_periodo||lpad(v_token_p::text, 2, '0'::text));
v_version_p:=( concat(v_periodo, v_token_p)::numeric) ;/* dmap converted statement end *//* dmap converted statement start */
perform dbms_output.put_line( concat('NO SET MES->', v_contador_p, ' ID_VERSION->', to_char(v_version_p))) ;/* dmap converted statement end */
case
when v_contador_p = 1  then
v_enero := 1;
v_ultimo_mes_reales:=1;
insert into fecxc.fecxp_forecast_ns(e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des,
importe_linea, estatus, tipo_caratula,id_version,tipo_ppto_real,tipo_empresa)
select                                         e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des,
importe_linea, estatus, tipo_caratula,id_version,'r','no set'
from fecxc.fecxp_real_caratula_impns
where periodo     = v_periodo
and   mes         = v_enero
and   id_version  = to_char(v_version_p)
and   utilizar_reporte='S';
when v_contador_p = 2  then
v_febrero   := 2;
v_ultimo_mes_reales:=2;
insert into fecxc.fecxp_forecast_ns(e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des,
importe_linea, estatus, tipo_caratula,id_version,tipo_ppto_real,tipo_empresa)
select                                         e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des,
importe_linea, estatus, tipo_caratula,id_version,'r','no set'
from fecxc.fecxp_real_caratula_impns
where periodo     = v_periodo
and   mes         = v_febrero
and   id_version  = to_char(v_version_p)
and   utilizar_reporte='S';
when v_contador_p = 3  then
v_marzo     := 3;
v_ultimo_mes_reales:=3;
insert into fecxc.fecxp_forecast_ns(e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des,
importe_linea, estatus, tipo_caratula,id_version,tipo_ppto_real,tipo_empresa)
select                                         e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des,
importe_linea, estatus, tipo_caratula,id_version,'r','no set'
from fecxc.fecxp_real_caratula_impns
where periodo     = v_periodo
and   mes         = v_marzo
and   id_version  = to_char(v_version_p)
and   utilizar_reporte='S';
when v_contador_p = 4  then
v_abril     := 4;
v_ultimo_mes_reales:=4;
insert into fecxc.fecxp_forecast_ns(e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des,
importe_linea, estatus, tipo_caratula,id_version,tipo_ppto_real,tipo_empresa)
select                                         e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des,
importe_linea, estatus, tipo_caratula,id_version,'r','no set'
from fecxc.fecxp_real_caratula_impns
where periodo     = v_periodo
and   mes         = v_abril
and   id_version  = to_char(v_version_p)
and   utilizar_reporte='S';
when v_contador_p = 5  then
v_mayo      := 5;
v_ultimo_mes_reales:=5;
insert into fecxc.fecxp_forecast_ns(e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des,
importe_linea, estatus, tipo_caratula,id_version,tipo_ppto_real,tipo_empresa)
select                                         e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des,
importe_linea, estatus, tipo_caratula,id_version,'r','no set'
from fecxc.fecxp_real_caratula_impns
where periodo     = v_periodo
and   mes         = v_mayo
and   id_version  = to_char(v_version_p)
and   utilizar_reporte='S';
when v_contador_p = 6  then
v_junio     := 6;
v_ultimo_mes_reales:=6;
insert into fecxc.fecxp_forecast_ns(e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des,
importe_linea, estatus, tipo_caratula,id_version,tipo_ppto_real,tipo_empresa)
select                                         e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des,
importe_linea, estatus, tipo_caratula,id_version,'r','no set'
from fecxc.fecxp_real_caratula_impns
where periodo     = v_periodo
and   mes         = v_junio
and   id_version  = to_char(v_version_p)
and   utilizar_reporte='S';
when v_contador_p = 7  then
v_julio     := 7;
v_ultimo_mes_reales:=7;
insert into fecxc.fecxp_forecast_ns(e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des,
importe_linea, estatus, tipo_caratula,id_version,tipo_ppto_real,tipo_empresa)
select                                         e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des,
importe_linea, estatus, tipo_caratula,id_version,'r','no set'
from fecxc.fecxp_real_caratula_impns
where periodo     = v_periodo
and   mes         = v_julio
and   id_version  = to_char(v_version_p)
and   utilizar_reporte='S';
when v_contador_p = 8  then
v_agosto    := 8;
v_ultimo_mes_reales:=8;
insert into fecxc.fecxp_forecast_ns(e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des,
importe_linea, estatus, tipo_caratula,id_version,tipo_ppto_real,tipo_empresa)
select                                         e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des,
importe_linea, estatus, tipo_caratula,id_version,'r','no set'
from fecxc.fecxp_real_caratula_impns
where periodo     = v_periodo
and   mes         = v_agosto
and   id_version  = to_char(v_version_p)
and   utilizar_reporte='S';
when v_contador_p = 9  then
v_septiembre:= 9;
v_ultimo_mes_reales:=9;
insert into fecxc.fecxp_forecast_ns(e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des,
importe_linea, estatus, tipo_caratula,id_version,tipo_ppto_real,tipo_empresa)
select                                         e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des,
importe_linea, estatus, tipo_caratula,id_version,'r','no set'
from fecxc.fecxp_real_caratula_impns
where periodo     = v_periodo
and   mes         = v_septiembre
and   id_version  = to_char(v_version_p)
and   utilizar_reporte='S';
when v_contador_p = 10 then
v_octubre   := 10;
v_ultimo_mes_reales:=10;
insert into fecxc.fecxp_forecast_ns(e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des,
importe_linea, estatus, tipo_caratula,id_version,tipo_ppto_real,tipo_empresa)
select                                         e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des,
importe_linea, estatus, tipo_caratula,id_version,'r','no set'
from fecxc.fecxp_real_caratula_impns
where periodo     = v_periodo
and   mes         = v_octubre
and   id_version  = to_char(v_version_p)
and   utilizar_reporte='S';
when v_contador_p = 11 then
v_noviembre := 11;
v_ultimo_mes_reales:=11;
insert into fecxc.fecxp_forecast_ns(e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des,
importe_linea, estatus, tipo_caratula,id_version,tipo_ppto_real,tipo_empresa)
select                                         e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des,
importe_linea, estatus, tipo_caratula,id_version,'r','no set'
from fecxc.fecxp_real_caratula_impns
where periodo     = v_periodo
and   mes         = v_noviembre
and   id_version  = to_char(v_version_p)
and   utilizar_reporte='S';
when v_contador_p = 12 then
v_diciembre := 12;
v_ultimo_mes_reales:=12;
insert into fecxc.fecxp_forecast_ns(e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des,
importe_linea, estatus, tipo_caratula,id_version,tipo_ppto_real,tipo_empresa)
select                                         e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des,
importe_linea, estatus, tipo_caratula,id_version,'r','no set'
from fecxc.fecxp_real_caratula_impns
where periodo     = v_periodo
and   mes         = v_diciembre
and   id_version  = to_char(v_version_p)
and   utilizar_reporte='S';
end case;
end if;
v_contador_p := v_contador_p + 1;
/* commit; */
end loop;/* dmap converted statement start */
-----para el presupuesto de no set---------------------------
insert into fecxc.fecxp_forecast_ns(e_codigo, des_empresa, id_sesion_rc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des,
importe_linea, estatus, tipo_caratula,id_version,tipo_ppto_real,tipo_empresa)
select                                              e_codigo, des_empresa, id_sesion_pc, periodo, mes, moneda, tipo_cambio, cla_fe_id, cla_fe_des,
importe_linea, estatus,'',id_version,'p','no set'
from fecxc.fecxp_ppto_caratula_impns
where periodo     = v_periodo
and   id_version  =  concat(v_periodo, v_version_ppto_ns
) and mes not in (v_enero,v_febrero,v_marzo,v_abril,v_mayo,v_junio,v_julio,v_agosto,v_septiembre,v_octubre,v_noviembre,v_diciembre);/* dmap converted statement end */
--dbms_output.put_line('MESES DE PPTO->'||v_enero||v_febrero||v_marzo||v_abril||v_mayo||v_junio||v_julio||v_agosto||v_septiembre||v_octubre||v_noviembre||v_diciembre) ;
/* commit; */
----------------------------------------------------------------------------------------------------------------------------------
v_contador_ppto:=v_ultimo_mes_reales;
v_contador_ppto:=0;
v_ultimo_mes_reales:=0;
v_ultimo_mes_reales:=v_ultimo_mes_reales+1;
for ic in v_ultimo_mes_reales..12 loop
----------pasar el saldo final del ultimo mes de reales al primero de presupuesto------------
--dbms_output.put_line('ULTIMO MES DE REALES->'||v_contador_ppto||' PRIMER MES DE PRESUPUESTO->'||(v_contador_ppto+1)) ;
if (v_contador_ppto+1) >1 then --excepto enero
delete from fecxc.fecxp_forecast_ns
where mes = (v_contador_ppto+1)
and  cla_fe_id in ('si','si coin', 'SI INV');
--insertar los registros de saldos finales del ultimo mes de reales en los de saldos iniciales del primer mes de presupuesto
insert into fecxc.fecxp_forecast_ns(e_codigo, des_empresa, id_sesion_rc,
periodo, mes, moneda,
tipo_cambio, cla_fe_id, cla_fe_des,
importe_linea, estatus, tipo_caratula,
id_version, tipo_ppto_real, tipo_empresa)
select
e_codigo, des_empresa, id_sesion_rc,
periodo, (v_contador_ppto+1), moneda,
tipo_cambio, case when cla_fe_id='SF' then 'SI' when cla_fe_id='SF INV' then 'SI INV' when cla_fe_id='SF COIN' then 'SI COIN'  else cla_fe_id end ,
case when cla_fe_des='SDO FINAL CHEQUERAS' then 'SDO INICIAL CHEQUERAS' when cla_fe_des='SDO FINAL INVERSION' then 'SDO INICIAL INVERSION' when cla_fe_des='SDO FINAL COINVERSION' then 'SDO INICIAL COINVERSION' when cla_fe_des='SALDO FINAL' then 'SALDO INICIAL'  else cla_fe_des end ,
importe_linea, estatus, tipo_caratula,
id_version, tipo_ppto_real,tipo_empresa
from fecxc.fecxp_forecast_ns
where mes = v_contador_ppto
and  cla_fe_id in ('sf','sf coin', 'SF INV');
-- and  cla_fe_des in ('sdo inicial chequeras','sdo inicial coinversion','sdo inicial inversion');
/* commit; */
-----borrar el saldo final del mes
delete from fecxc.fecxp_forecast_ns
where mes = (v_contador_ppto+1)
and  cla_fe_id in ('sf','sf coin', 'SF INV');
/* commit; */
---insertando saldos finales
insert into fecxc.fecxp_forecast_ns(e_codigo, des_empresa, id_sesion_rc,
periodo, mes, moneda,
tipo_cambio, cla_fe_id, cla_fe_des,
importe_linea, estatus, tipo_caratula,
id_version, tipo_ppto_real, tipo_empresa)
select
e_codigo, des_empresa, id_sesion_rc,
periodo, (v_contador_ppto+1), moneda,
tipo_cambio,  cla_fe_id,
cla_fe_des,
importe_linea, estatus, tipo_caratula,
id_version, tipo_ppto_real, tipo_empresa
from fecxc.fecxp_forecast_ns
where mes = v_contador_ppto
and  cla_fe_id in ('sf','sf coin', 'SF INV');/* dmap converted statement start */
/* commit; */
--insertando ==incremento neto de efectivo del periodo como saldo final
insert into fecxc.fecxp_forecast_ns(e_codigo,
des_empresa,
id_sesion_rc,
periodo, mes, moneda,
tipo_cambio, cla_fe_id, cla_fe_des,
importe_linea, estatus, tipo_caratula,
id_version, tipo_ppto_real,tipo_empresa)
select     distinct        empresa_cod,
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
c.tipo_empresa
from    (
select  b.id_seg   segmento_empresa_cod,
b.desc_seg segmento_empresa_des,
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
id_sesion_rc,
c.tipo_empresa
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
id_version ,
id_sesion_rc,
c.tipo_empresa
from    fecxc.fecxp_forecast_ns c
where   c.mes= (v_contador_ppto+1)
and  periodo=v_periodo
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
id_version,
id_sesion_rc,
c.tipo_empresa
from    fecxc.fecxp_forecast_ns c
where   c.mes= (v_contador_ppto+1)
and  periodo=v_periodo
) c,
fecxc.fecxp_clasificacion_fe f,
fecxc.fecxp_emp_x_segmento_no_set  a,
fecxc.fecxp_seg_no_set b,
fecxc.fecxp_monedas_no_set m
where    c.cla_fe_id = f.cla_fe_id
and        c.periodo <= (to_char(clock_timestamp(),'YYYY'))::numeric
and        f.cla_atributo4 in ('01 actividades de inversion','01 actividades de financiamiento','01 ingresos operativos','02 egresos operativos')
and        a.id_segmento not in (11, 15, 17,18, 20, 26, 6, 13, 25)
and        a.id_segmento = b.id_seg
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
group by b.id_seg,
b.desc_seg,
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
id_sesion_rc,
c.tipo_empresa) c;/* dmap converted statement end */
/* commit; */
v_contador_ppto:=v_contador_ppto+1;
else  ---solo enero
delete from fecxp_forecast_ns
where mes = 1
and  cla_fe_id in ('sf','sf coin', 'SF INV');
/* commit; */
--insertar los registros de saldos iniciales de enero como finales enero
insert into fecxc.fecxp_forecast_ns(e_codigo, des_empresa, id_sesion_rc,
periodo, mes, moneda,
tipo_cambio, cla_fe_id, cla_fe_des,
importe_linea, estatus, tipo_caratula,
id_version, tipo_ppto_real, tipo_empresa)
select
e_codigo, des_empresa, id_sesion_rc,
periodo, 1, moneda,
tipo_cambio, case when cla_fe_id='SI' then 'SF' when cla_fe_id='SI INV' then 'SF INV' when cla_fe_id='SI COIN' then 'SF COIN'  else cla_fe_id end ,
case when cla_fe_des='SDO INICIAL CHEQUERAS' then 'SDO FINAL CHEQUERAS' when cla_fe_des='SDO INICIAL INVERSION' then 'SDO FINAL INVERSION' when cla_fe_des='SDO INICIAL COINVERSION' then 'SDO FINAL COINVERSION' when cla_fe_des='SALDO INICIAL' then 'SALDO FINAL'  else cla_fe_des end ,
importe_linea, estatus, tipo_caratula,
id_version, tipo_ppto_real, tipo_empresa
from fecxc.fecxp_forecast_ns
where mes = 1
and  cla_fe_id in ('si','si coin', 'SI INV');/* dmap converted statement start */
/* commit; */
---insertando ==incremento neto de efectivo del periodo como saldo final
insert into fecxc.fecxp_forecast_ns(             e_codigo,
des_empresa,
id_sesion_rc,
periodo, mes, moneda,
tipo_cambio, cla_fe_id, cla_fe_des,
importe_linea, estatus, tipo_caratula,
id_version, tipo_ppto_real,tipo_empresa)
select     distinct        empresa_cod,
empresa_des,
c.id_sesion_rc,
c.periodo,
1,
c.moneda,
c.tipo_cambio,
'SF' as cla_fe_id,
'SALDO FINAL' as cla_fe_des,
c.real_mon_origen,
c.estatus,
c.tipo_caratula,
c.id_version,
'P',
c.tipo_empresa
from (
select    b.id_seg segmento_empresa_cod,
b.desc_seg segmento_empresa_des,
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
id_sesion_rc,
c.tipo_empresa
from (
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
id_version ,
id_sesion_rc,
c.tipo_empresa
from    fecxc.fecxp_forecast_ns c
where   c.mes= 1
and  periodo= v_periodo
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
id_version,
id_sesion_rc,
c.tipo_empresa
from    fecxc.fecxp_forecast_ns c
where   c.mes= 1
and  periodo= v_periodo
) c,
fecxc.fecxp_clasificacion_fe f,
fecxc.fecxp_emp_x_segmento_no_set  a,
fecxc.fecxp_seg_no_set b,
fecxc.fecxp_monedas_no_set m
where    c.cla_fe_id = f.cla_fe_id
and        c.periodo <= (to_char(clock_timestamp(),'YYYY'))::numeric
and        f.cla_atributo4 in ('01 actividades de inversion','01 actividades de financiamiento','01 ingresos operativos','02 egresos operativos')
and        a.id_segmento not in (11, 15, 17,18, 20, 26, 6, 13, 25)
and        a.id_segmento = b.id_seg
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
group by b.id_seg,
b.desc_seg,
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
id_sesion_rc,
c.tipo_empresa) c;/* dmap converted statement end */
/* commit; */
v_contador_ppto:=v_contador_ppto+1;
end if;
end loop;
update fecxp_ppto_extraccion_params
set estatus_proceso = 'INACTIVO',estatus_ext_ult_ejecucion= 'EXITOSO'
where proceso_id =20;/* dmap converted statement start */
-------------------------bitacora-----------------------------------------------------------------------------------------------------------------
insert into fecxc.bitacora_forecast_ns(
fecha_creacion, ver_ene_hist, ver_feb_hist,
ver_mar_hist, ver_abr_hist, ver_may_hist,
ver_jun_hist, ver_jul_hist, ver_ago_hist,
ver_sep_hist, ver_oct_hist, ver_nov_hist,
ver_dic_hist, ver_ene_ns, ver_feb_ns,
ver_mar_ns, ver_abr_ns, ver_may_ns,
ver_jun_ns, ver_jul_ns, ver_ago_ns,
ver_sep_ns, ver_oct_ns, ver_nov_ns,
ver_dic_ns,ppto_hist ,ppto_ns,  comentario, usuario)
values (clock_timestamp() , concat(v_periodo, oracle.substr(v_versiones_real_h,0,1) ) ,  concat(v_periodo, oracle.substr(v_versiones_real_h,3,1)) ,
concat(v_periodo, oracle.substr(v_versiones_real_h,5,1)) , concat(v_periodo, oracle.substr(v_versiones_real_h,7,1) ) , concat(v_periodo, oracle.substr(v_versiones_real_h,9,1) ) ,
concat(v_periodo, oracle.substr(v_versiones_real_h,11,1)) , concat(v_periodo, oracle.substr(v_versiones_real_h,13,1)) , concat(v_periodo, oracle.substr(v_versiones_real_h,15,1) ) ,
concat(v_periodo, oracle.substr(v_versiones_real_h,17,1)) , concat(v_periodo, oracle.substr(v_versiones_real_h,19,1)) , concat(v_periodo, oracle.substr(v_versiones_real_h,21,1)) ,
concat(v_periodo, oracle.substr(v_versiones_real_h,23,1)) , concat(v_periodo, oracle.substr(v_versiones_real_ns,0,1) ) ,  concat(v_periodo, oracle.substr(v_versiones_real_ns,3,1)) ,
concat(v_periodo, oracle.substr(v_versiones_real_ns,5,1)) , concat(v_periodo, oracle.substr(v_versiones_real_ns,7,1) ) , concat(v_periodo, oracle.substr(v_versiones_real_ns,9,1) ) ,
concat(v_periodo, oracle.substr(v_versiones_real_ns,11,1)) , concat(v_periodo, oracle.substr(v_versiones_real_ns,13,1)) , concat(v_periodo, oracle.substr(v_versiones_real_ns,15,1) ) ,
concat(v_periodo, oracle.substr(v_versiones_real_ns,17,1)) , concat(v_periodo, oracle.substr(v_versiones_real_ns,19,1)) , concat(v_periodo, oracle.substr(v_versiones_real_ns,21,1)) ,
concat(v_periodo, oracle.substr(v_versiones_real_ns,23,1)) ,( concat(to_char(v_periodo), to_char(v_version_ppto_h))::numeric ) ,( concat(to_char(v_periodo), to_char(v_version_ppto_ns))::numeric ) ,v_comentario,v_usuario);/* dmap converted statement end *//* dmap converted statement start */
--------------------------------------------------------------------------------------------------------------------------------------------------
perform dbms_output.put_line( concat('TERMINO ', to_char(clock_timestamp(),'DD-MM-YYYY HH:MM:SS'))) ;/* dmap converted statement end */
/* commit; */
exception
when others then
v_error_num:= sqlerrm;
v_error_code:= sqlstate;/* dmap converted statement start */
update fecxp_ppto_extraccion_params
set estatus_proceso = 'INACTIVO',estatus_ext_ult_ejecucion= 'ERROR' ,
atributo2 =  concat('An error was encountered - ', v_error_code, ' -ERROR- ', v_error_num
) where proceso_id =20;/* dmap converted statement end *//* dmap converted statement start */
raise exception '%',  concat('An error was encountered - ', sqlstate, ' -ERROR- ', sqlerrm)  using errcode = '45001';/* dmap converted statement end */
rollback;end;
$body$
language plpgsql
;
