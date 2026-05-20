create or replace procedure fecxc."fecxp_ejecuta_procesos"  () as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_proceso_id fecxp_ppto_extraccion_params.proceso_id%type;
v_proceso_nombre fecxp_ppto_extraccion_params.proceso_nombre%type;
v_fecha_ext_sig_ejecucion fecxp_ppto_extraccion_params.fecha_ext_sig_ejecucion%type;
v_version_fe_sig_ejecucion fecxp_ppto_extraccion_params.version_fe_sig_ejecucion%type;
v_periodo_ppto_sig_ejecucion fecxp_ppto_extraccion_params.periodo_ppto_sig_ejecucion%type;
v_version_ppto_sig_ejecucion fecxp_ppto_extraccion_params.version_ppto_sig_ejecucion%type;
v_estatus_ppto_sig_ejecucion fecxp_ppto_extraccion_params.estatus_ppto_sig_ejecucion%type;
v_usuario_ppto_sig_ejecucion fecxp_ppto_extraccion_params.usuario_ppto_sig_ejecucion%type;
v_fecha_ext_ult_ejecucion fecxp_ppto_extraccion_params.fecha_ext_ult_ejecucion%type;
v_estatus_ext_ult_ejecucion fecxp_ppto_extraccion_params.estatus_ext_ult_ejecucion%type;
v_version_fe_ult_ejecucion fecxp_ppto_extraccion_params.version_fe_ult_ejecucion%type;
v_periodo_ppto_ult_ejecucion fecxp_ppto_extraccion_params.periodo_ppto_ult_ejecucion%type;
v_version_ppto_ult_ejecucion fecxp_ppto_extraccion_params.version_ppto_ult_ejecucion%type;
v_estatus_ppto_ult_ejecucion fecxp_ppto_extraccion_params.estatus_ppto_ult_ejecucion%type;
v_usuario_ppto_ult_ejecucion fecxp_ppto_extraccion_params.usuario_ppto_ult_ejecucion%type;
v_atributo1    fecxp_ppto_extraccion_params.atributo1%type;
v_estatus_ejecucion_proceso fecxp_ppto_extraccion_params.estatus_proceso%type;
v_atributo2    fecxp_ppto_extraccion_params.atributo2%type;
/*20091030 v4 modificado para incluir la obtencion de cuentas contables ingresos*/
/*20090818 v3 modificado para quitar la automatizacion de los pptos*/
/* 20090801 v2 modificado para los avisos y la automatizacion*/
/*v1 modificado para separar aperturacion de extraccion set*/
--==  se toma en cuenta todos menos el proceso 2 que lo actualiza el ejb ==--
cursor_procesos cursor for
select    proceso_id, proceso_nombre, fecha_ext_sig_ejecucion, version_fe_sig_ejecucion, periodo_ppto_sig_ejecucion, version_ppto_sig_ejecucion, estatus_ppto_sig_ejecucion, usuario_ppto_sig_ejecucion, fecha_ext_ult_ejecucion, estatus_ext_ult_ejecucion, version_fe_ult_ejecucion, periodo_ppto_ult_ejecucion, version_ppto_ult_ejecucion, estatus_ppto_ult_ejecucion, usuario_ppto_ult_ejecucion, atributo1, atributo2
from    fecxp_ppto_extraccion_params
where    proceso_id <> 2
and        estatus_proceso = 'EN PROCESO'
order by proceso_id;
--== cursor para los reportes automaticos
--==  se toma en cuenta todos menos el proceso 2 que lo actualiza el ejb ==--
cursor_autom cursor for
select    proceso_id, proceso_nombre, estatus_ppto_sig_ejecucion, atributo1, estatus_proceso, usuario_ppto_sig_ejecucion,estatus_ext_ult_ejecucion
from    fecxp_ppto_extraccion_params
where    proceso_id in (11,12)
order by proceso_id;
/*bandera para detectar que cursor debe cerrar*/
v_contador integer:=0;
v_proc_id integer:=-1;
v_errcode numeric;
v_errmsg varchar(255);
begin 

--==  cambia estatus del proceso de ejecucion de procesos ==--
update    fecxp_ppto_extraccion_params
set        estatus_proceso = 'EN PROCESO'
where    proceso_id = 0;
/* commit; */
--==  clasificacion de cuentas sesgun politicas de clasificacion de fe ==--
open    cursor_procesos;
loop
fetch    cursor_procesos
into    v_proceso_id, v_proceso_nombre, v_fecha_ext_sig_ejecucion, v_version_fe_sig_ejecucion, v_periodo_ppto_sig_ejecucion, v_version_ppto_sig_ejecucion, v_estatus_ppto_sig_ejecucion, v_usuario_ppto_sig_ejecucion, v_fecha_ext_ult_ejecucion, v_estatus_ext_ult_ejecucion, v_version_fe_ult_ejecucion, v_periodo_ppto_ult_ejecucion, v_version_ppto_ult_ejecucion, v_estatus_ppto_ult_ejecucion, v_usuario_ppto_ult_ejecucion, v_atributo1, v_atributo2;
exit when not found; /* apply on cursor_procesos */
v_contador:=1;
if v_proceso_id = 1 then
-- extraccion ppto oracle
call fecxp_genera_ver_ppto_erp (v_version_fe_sig_ejecucion, v_usuario_ppto_sig_ejecucion, v_atributo1, v_periodo_ppto_sig_ejecucion, v_version_ppto_sig_ejecucion, v_estatus_ppto_sig_ejecucion);
end if;
-- if v_proceso_id = 2 then -- es el ejb de ppto soin
-- extraccion ppto soin
-- end if;
if v_proceso_id = 3 then
-- copia ppto erp
call fecxp_copia_ppto_erp (v_version_ppto_sig_ejecucion, v_version_fe_sig_ejecucion, v_usuario_ppto_sig_ejecucion, v_atributo1);
end if;
if v_proceso_id = 4 then
-- copia ppto soin
call fecxp_copia_ppto_soin (v_version_ppto_sig_ejecucion, v_version_fe_sig_ejecucion, v_usuario_ppto_sig_ejecucion, v_atributo1);
end if;
if v_proceso_id = 5 then
-- genera encabezados de ppto erp
call fecxp_genera_ver_ppto_enc ('O');
end if;
if v_proceso_id = 6 then
-- genera encabezados de ppto soin
call fecxp_genera_ver_ppto_enc ('S');
end if;
if v_proceso_id = 7 then
--dependiendo del reporte elegir su registro para bitacora
if v_atributo2 = '1' or v_atributo2 = '2' or v_atributo2 = '3' then
if v_atributo2 = '1' then
v_proc_id := 13;
end if;
if v_atributo2 = '2' then
v_proc_id := 14;
end if;
if v_atributo2 = '3' then
v_proc_id := 15;
end if;
end if;
execute(v_estatus_ppto_sig_ejecucion);
end if;
if v_proceso_id = 8 then
-- convierte presupuesto
if v_estatus_ppto_sig_ejecucion = 'ORACLE' then
call fecxp_ppto_op_a_ppto_fe_erp (v_version_fe_sig_ejecucion, v_usuario_ppto_sig_ejecucion, v_atributo1);
else
call fecxp_ppto_op_a_ppto_fe_soin (v_version_fe_sig_ejecucion, v_usuario_ppto_sig_ejecucion, v_atributo1);
end if;
end if;
if v_proceso_id = 9 then
-- ejecuta la aperturacion de folios oracle
execute(v_estatus_ppto_sig_ejecucion);
end if;
if v_proceso_id = 16 then
-- ejecuta la extraccion de cuentas de ingresos
execute(v_estatus_ppto_sig_ejecucion);
end if;
if v_proceso_id = 17 then
-- ejecuta la extraccion de cuentas de ingresos
execute(v_estatus_ppto_sig_ejecucion);
end if;
if v_proceso_id = 18 then
-- ejecuta la extraccion de cuentas de ingresos
execute(v_estatus_ppto_sig_ejecucion);
end if;
if v_proceso_id = 19 then
-- ejecuta la extraccion de cuentas de ingresos
execute(v_estatus_ppto_sig_ejecucion);
end if;
if v_proceso_id = 20 then
-- ejecuta la extraccion de historicos y no set
execute(v_estatus_ppto_sig_ejecucion);
end if;
update    fecxp_ppto_extraccion_params
set        fecha_ext_sig_ejecucion = to_timestamp('19000101','YYYYMMDD'),
version_fe_sig_ejecucion = 0,
periodo_ppto_sig_ejecucion = 2006,
version_ppto_sig_ejecucion = 0,
estatus_ppto_sig_ejecucion = 'INACTIVO',
usuario_ppto_sig_ejecucion = null,
fecha_ext_ult_ejecucion = fecha_ext_sig_ejecucion,
estatus_ext_ult_ejecucion = 'EXITOSO',
version_fe_ult_ejecucion = version_fe_sig_ejecucion,
periodo_ppto_ult_ejecucion = periodo_ppto_sig_ejecucion,
version_ppto_ult_ejecucion = version_ppto_sig_ejecucion,
estatus_ppto_ult_ejecucion = estatus_ppto_sig_ejecucion,
usuario_ppto_ult_ejecucion = usuario_ppto_sig_ejecucion,
estatus_proceso = 'INACTIVO',
fec_fin = clock_timestamp(),
atributo2 = null
where    proceso_id = v_proceso_id;
/*actualizar bitacora por reporte*/
if v_atributo2 = '1' or v_atributo2 = '2' or v_atributo2 = '3' then
--actualizar la bitacora de cada reporte
update fecxp_ppto_extraccion_params
set(estatus_ext_ult_ejecucion, fec_ini, fec_fin, usuario_ppto_ult_ejecucion,estatus_ppto_ult_ejecucion, atributo1, atributo2) =
(select estatus_ext_ult_ejecucion, fec_ini, fec_fin, usuario_ppto_ult_ejecucion, estatus_ppto_ult_ejecucion, atributo1, atributo2
from fecxp_ppto_extraccion_params
where proceso_id = 7)
where proceso_id = v_proc_id;
end if;
/*para enviar mensaje de finalizacion en pantalla*/
update fecxp_ppto_extraccion_params
set alertar = 1
where    proceso_id = v_proceso_id
and        alertar=2;
/* commit; */
end loop;
close cursor_procesos;
update    fecxp_ppto_extraccion_params
set        estatus_proceso = 'INACTIVO'
where    proceso_id = 0;
/* commit; */
/*=============================================inicia parte de reportes automaticos=======================================================*/
update    fecxp_ppto_extraccion_params
set        estatus_proceso = 'EN EJECUCION'
where    proceso_id = 0;
/* commit; */
open    cursor_autom;
loop
fetch    cursor_autom
into    v_proceso_id, v_proceso_nombre, v_estatus_ppto_sig_ejecucion, v_atributo1,v_estatus_ejecucion_proceso, v_usuario_ppto_sig_ejecucion, v_estatus_ext_ult_ejecucion;
exit when not found; /* apply on cursor_autom */
v_contador:=2;
/*para el primer reporte*/
if v_estatus_ejecucion_proceso= 'EN EJECUCION' then
-- reportes automaticos
execute(v_estatus_ppto_sig_ejecucion);
/*marcar fin de proceso*/
update    fecxp_ppto_extraccion_params
set        estatus_proceso='AUTOMATICO',
estatus_ext_ult_ejecucion = 'EXITOSO',
fec_fin = clock_timestamp()
where    proceso_id = v_proceso_id;
/*para enviar mensaje de finalizacion en pantalla*/
update fecxp_ppto_extraccion_params
set alertar = 1
where    proceso_id = v_proceso_id
and        alertar=2;
/* commit; */
end if;
if v_estatus_ejecucion_proceso= 'EN ESPERA' then
/*marcar inicio del reporte para la pantalla */
update    fecxp_ppto_extraccion_params
set        estatus_proceso='EN EJECUCION',
fec_ini = clock_timestamp()
where    proceso_id = v_proceso_id;
/* commit; */
-- reportes automaticos
execute(v_estatus_ppto_sig_ejecucion);
/*marcar fin de proceso*/
update    fecxp_ppto_extraccion_params
set        estatus_proceso='AUTOMATICO',
estatus_ext_ult_ejecucion = 'EXITOSO',
fec_fin = clock_timestamp(),
atributo2 = null
where    proceso_id = v_proceso_id;
/*para enviar mensaje de finalizacion en pantalla*/
update fecxp_ppto_extraccion_params
set alertar = 1
where    proceso_id = v_proceso_id
and        alertar=2;
/* commit; */
end if;
end loop;
close cursor_autom;
update    fecxp_ppto_extraccion_params
set        estatus_proceso = 'INACTIVO'
where    proceso_id = 0;
/* commit; */
exception
when no_data_found then
if v_contador=1 then
close cursor_procesos;
else
close cursor_autom;
end if;
v_errcode := sqlstate;
v_errmsg := oracle.substr(sqlerrm,1,254);/* dmap converted statement start */
update fecxp_ppto_extraccion_params
set atributo2 =  concat('Error: ', v_errcode , ' - ' , v_errmsg , '.'
) where proceso_id=v_proceso_id;/* dmap converted statement end */
/* commit; */
if v_proceso_id = 7 then
update fecxp_ppto_extraccion_params
set fec_fin = clock_timestamp(),
estatus_proceso = 'ERROR',
estatus_ext_ult_ejecucion ='ERROR'
where proceso_id=v_proceso_id;
if v_atributo2 = '1' or v_atributo2 = '2' or v_atributo2 = '3' then
--actualizar la bitacora de cada reporte
update fecxp_ppto_extraccion_params
set(estatus_ext_ult_ejecucion, fec_ini, fec_fin, usuario_ppto_ult_ejecucion,estatus_ppto_ult_ejecucion, atributo1, atributo2) =
(select estatus_ext_ult_ejecucion, fec_ini, fec_fin, usuario_ppto_ult_ejecucion, estatus_ppto_ult_ejecucion, atributo1, atributo2
from fecxp_ppto_extraccion_params
where proceso_id = 7)
where proceso_id = v_proc_id;
end if;
/* commit; */
end if;
if v_proceso_id = 11  or  v_proceso_id = 12 then
update fecxp_ppto_extraccion_params
set fec_fin = clock_timestamp(),
estatus_ext_ult_ejecucion ='ERROR'
where proceso_id = v_proceso_id;
--para detener la ejecucion del resto
update fecxp_ppto_extraccion_params
set estatus_proceso= 'AUTOMATICO'
where proceso_id in (11,12);
/* commit; */
end if;/* dmap converted statement start */
raise exception '%',  concat('Error:', sqlstate , ' - ' , sqlerrm)  using errcode = '45000';/* dmap converted statement end */
when others then
if v_contador=1 then
close cursor_procesos;
else
close cursor_autom;
end if;
v_errcode := sqlstate;
v_errmsg := oracle.substr(sqlerrm,1,254);/* dmap converted statement start */
update fecxp_ppto_extraccion_params
set atributo2 =  concat('Error: ', v_errcode , ' - ' , v_errmsg , '.'
) where proceso_id=v_proceso_id;/* dmap converted statement end */
/* commit; */
/* commit; */
/*si hubo un error entonces detener su ejecucion, no incluye aperturacion para que siga reintentando*/
if v_proceso_id = 7   then
update fecxp_ppto_extraccion_params
set fec_fin = clock_timestamp(),
estatus_proceso = 'ERROR',
estatus_ext_ult_ejecucion ='ERROR'
where proceso_id=v_proceso_id;
if v_atributo2 = '1' or v_atributo2 = '2' or v_atributo2 = '3' then
--actualizar la bitacora de cada reporte
update fecxp_ppto_extraccion_params
set(estatus_ext_ult_ejecucion, fec_ini, fec_fin, usuario_ppto_ult_ejecucion,estatus_ppto_ult_ejecucion, atributo1, atributo2) =
(select estatus_ext_ult_ejecucion, fec_ini, fec_fin, usuario_ppto_ult_ejecucion, estatus_ppto_ult_ejecucion, atributo1, atributo2
from fecxp_ppto_extraccion_params
where proceso_id = 7)
where proceso_id = v_proc_id;
end if;
/* commit; */
end if;
if v_proceso_id = 11  or  v_proceso_id = 12 then
update fecxp_ppto_extraccion_params
set fec_fin = clock_timestamp(),
estatus_ext_ult_ejecucion ='ERROR'
where proceso_id = v_proceso_id;
--para detener la ejecucion del resto
update fecxp_ppto_extraccion_params
set estatus_proceso= 'AUTOMATICO'
where proceso_id in (11,12);
/* commit; */
end if;/* dmap converted statement start */
raise exception '%',  concat('Error:', sqlstate , ' - ' , sqlerrm)  using errcode = '45000';/* dmap converted statement end */
/*no detener la aperturacion ya que con los reintentos podria ejecutarse bien cuando es not parsed*/
end;
$body$
language plpgsql
;
