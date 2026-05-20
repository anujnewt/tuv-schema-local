create or replace  function  xxmor.xxmor_funcional_pkg_xxmor_orden_estatus_fun ( p_id_solicitud integer, p_linea integer, p_tipo varchar ) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_orden_estatus         integer;
v_estatus_linea         integer;
v_estatus_enc           integer;
v_rechazo_enc           integer;
v_tot_lineas            integer;
v_rpta_cc_sin_e         integer;
v_rpta_cc               integer;
v_rpta_cc_con_e         integer;
v_tot_est_rep           integer;
v_tot_est_rep_e0        integer;
v_tot_est_rep_e2        integer;
v_tot_reprocesos        integer;
v_tot_rechazos          integer;
v_tot_retencion         integer;
v_tot_autorizacion      integer;
v_tot_lin_en_rep        integer;
v_sin_fza_vtas          integer;
v_agru_multiple         integer;
estatus_concom_cur cursor for
select 'Linea(s) con '|| lower(accion_concom) as accion_concom
from (select distinct lower(accion_concom) accion_concom
from  xxmor_concom_rpta_tab cr
where id_solicitud = p_id_solicitud
and estatus_orduni = '10'
/*and not exists       ( select distinct id_solicitud, numlinea_concom
from  xxmor_concom_rpta_tab crr
where estatus_orduni            = 10
and upper(accion_concom)        =rechazo
and cr.id_solicitud = crr.id_solicitud
and cr.numlinea_concom = crr.numlinea_concom
)*/
) alias2
order by 1 asc;
estatus_replica_cur cursor for
select distinct
case estat_rep when '1' then 'Insertando en Paradigm'
when '2' then 'Linea(s) en Paradigm'
when '3' then 'Error al insertar linea(s) a Paradigm'
else estat_rep
end            as estat_rep
from   xxmor_solicitudes_est_rep_tab e
where  estat_rep   != 0
and    id_solicitud = p_id_solicitud
order by 1 asc;
v_output   varchar(3000);
--dmap conversion comment: global temp variables moved as local temp variables
glo_document_temp text;
--dmap conversion comment: declaration boundary ends
begin
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('XXMOR', 'XXMOR_FUNCIONAL_PKG');
--dmap conversion comment: gtt declaration added
--estatus para insercion
if p_tipo = 'BANDERA_INSERT' then
/*  select count(1)
into   v_tot_lineas
from   xxmor_solicitudes_det_tab
where  id_solicitud = p_id_solicitud;
dbms_output.put_line(v_tot_lineas || v_tot_lineas );
*/
--errores en el encabezado
select count(1)
into strict   v_rpta_cc_con_e
from   xxmor_concom_rpta_tab
where  id_solicitud           = p_id_solicitud
and    upper(posicion_concom) = 'ENCABEZADO'
and    estatus_orduni         = '10';
--errores en las lineas
select count(1)
into strict   v_tot_lineas
from (select to_char(linea)
from   xxmor_solicitudes_det_tab
where  id_solicitud = p_id_solicitud
except
select distinct(numlinea_concom)
from   xxmor_concom_rpta_tab
where  id_solicitud    = p_id_solicitud
and    nullif(numlinea_concom::text, '') is not null
and    estatus_orduni  = '10'
) alias3;
-- select count(1) +v_tot_lineas
-- into   v_tot_lineas
-- from   xxmor_solicitudes_est_rep_tab
-- where  aux3 = 1
-- and    linea = 0
-- and    id_solicitud =  p_id_solicitud;
--si el encabezado no tiene errores y al menos hay una linea para insertar entonces dejar insertar (1) si no pues no (0)
if v_tot_lineas > 0 and v_rpta_cc_con_e = 0 then
v_output := '1';
else
v_output := '0';
end if;
--si la orden es de agrupador multiple entonces se revisa si se retiene o si continua
if v_output = '1' then
v_output := xxmor_funcional_pkg_xxmor_sol_agr_mult_val_fun(p_id_solicitud);
end if;
return v_output;
end if;/* dmap converted statement start */
--saber el estatus de la orden de acuerdo a los resultados de concom
if p_tipo = 'ESTATUS_CONCOM' then
for c_estatus in estatus_concom_cur loop
v_output :=  concat(v_output, c_estatus.accion_concom, ', ') ;/* dmap converted statement end */
end loop;
v_output := oracle.substr(v_output,1,length(v_output)-2);
return v_output;
end if;/* dmap converted statement start */
--saber el estatus de la orden cuando esta es enviada a paradigm
if p_tipo = 'ESTATUS_REPLICA' then
for c_estatus in estatus_replica_cur loop
v_output :=  concat(v_output, c_estatus.estat_rep, ', ') ;/* dmap converted statement end */
end loop;
v_output := oracle.substr(v_output,1,length(v_output)-2);
return v_output;
end if;
if p_tipo = 'ESTATUS_ORDEN' then
--sin fuerza de ventas
select count(1)
into strict   v_sin_fza_vtas
from   xxmor_solicitudes_enc_tab
where  id_solicitud  = p_id_solicitud
and    id_fza_ventas = 0;
if v_sin_fza_vtas = 1 then
select desc_notificacion
into strict   v_output
from   xxmor_ordenes_estatus_tab
where  id_notificacion = 25;
return v_output;
end if;
--aun no ha respondido concom 1 vez estatus inicial
select count(1)
into strict   v_rpta_cc
from   xxmor_concom_rpta_tab
where  id_solicitud = p_id_solicitud;
if v_rpta_cc=0 then
--revisar si ya se envio a cc
select orden_estatus
into strict   v_orden_estatus
from   xxmor_solicitudes_enc_tab
where  id_solicitud = p_id_solicitud;
if v_orden_estatus = 30 then
select desc_notificacion
into strict   v_output
from   xxmor_ordenes_estatus_tab
where  id_notificacion = 30;
return v_output;
end if;
--estatus inicial
select desc_notificacion
into strict   v_output
from   xxmor_ordenes_estatus_tab
where  id_notificacion = 11;
return v_output;
end if;
select count(distinct numlinea_concom )
into strict   v_tot_rechazos
from   xxmor_concom_rpta_tab
where  id_solicitud                          = p_id_solicitud
and    estatus_orduni                        = '10'
and    nullif(numlinea_concom::text, '') is not null
and    position('RECHAZO' in upper(accion_concom)) > 0;
select count(1)
into strict   v_rechazo_enc
from   xxmor_concom_rpta_tab
where  id_solicitud                          = p_id_solicitud
and    estatus_orduni                        = '10'
and    nullif(numlinea_concom::text, '') is null
and    position('RECHAZO' in upper(accion_concom)) > 0;
--dbms_output.put_line(rechazos: ||v_tot_rechazos);
select count(distinct numlinea_concom )
into strict   v_tot_reprocesos
from   xxmor_concom_rpta_tab
where  id_solicitud         = p_id_solicitud
and    estatus_orduni       = '10'
and    upper(accion_concom) in ('REENVIO','REPROCESO');
select count(1)
into strict   v_tot_autorizacion
from   xxmor_concom_rpta_tab
where  id_solicitud                               = p_id_solicitud
and    estatus_orduni                             = '10'
and    position('AUTORIZACION' in upper(accion_concom)) > 0;
select count(1)
into strict   v_tot_retencion
from   xxmor_concom_rpta_tab
where  id_solicitud                            = p_id_solicitud
and    estatus_orduni                          = '10'
and    position('RETENCION' in upper(accion_concom)) > 0;
select orden_estatus
into strict   v_orden_estatus
from   xxmor_solicitudes_enc_tab
where  id_solicitud = p_id_solicitud;
select count(1)
into strict   v_tot_lineas
from   xxmor_solicitudes_det_tab
where  id_solicitud = p_id_solicitud;/* dmap converted statement start */
perform dbms_output.put_line( concat('V_TOT_LINEAS ', v_tot_lineas)  );/* dmap converted statement end */
--total de lineas en reproceso
select count(1)
into strict   v_tot_lin_en_rep
from   xxmor_solicitudes_det_tab
where  id_solicitud  = p_id_solicitud
and    linea_estatus = 30;/* dmap converted statement start */
perform dbms_output.put_line( concat('V_TOT_LINEAS_REP (en reproceso )', v_tot_lin_en_rep)  );/* dmap converted statement end */
-- total de errores corregidos de la orden
select count(distinct coalesce(numlinea_concom,'0'))
into strict   v_rpta_cc_con_e
from   xxmor_concom_rpta_tab
where  id_solicitud    = p_id_solicitud
and    estatus_orduni != '20';/* dmap converted statement start */
perform dbms_output.put_line( concat('V_RPTA_CC_CON_E ', v_rpta_cc_con_e)  );/* dmap converted statement end */
-- total de errores sin ser corregidos de la orden
select count(distinct coalesce(numlinea_concom,'0'))
into strict   v_rpta_cc_sin_e
from   xxmor_concom_rpta_tab
where  id_solicitud   = p_id_solicitud
and    estatus_orduni = '20';/* dmap converted statement start */
perform dbms_output.put_line( concat('V_RPTA_CC_SIN_E ', v_rpta_cc_sin_e)  );/* dmap converted statement end */
--- total de lineas sin instertar en sistema final
select count(1)
into strict   v_tot_est_rep_e0
from   xxmor_solicitudes_est_rep_tab e
where  estat_rep   != '2'
and    id_solicitud = p_id_solicitud;/* dmap converted statement start */
perform dbms_output.put_line( concat('V_TOT_EST_REP_E0 ', v_tot_est_rep_e0)  );/* dmap converted statement end */
--- total de lineas instertadas en sistema final
select count(1)
into strict   v_tot_est_rep_e2
from   xxmor_solicitudes_est_rep_tab e
where  estat_rep    = '2'
and    id_solicitud = p_id_solicitud;/* dmap converted statement start */
perform dbms_output.put_line( concat('V_TOT_EST_REP_E2 ', v_tot_est_rep_e2)  );/* dmap converted statement end */
--total de lineas tratadas de insertar
select count(1)
into strict   v_tot_est_rep
from   xxmor_solicitudes_est_rep_tab e
where  estat_rep   != '0'
and    id_solicitud = p_id_solicitud;/* dmap converted statement start */
perform dbms_output.put_line( concat('V_TOT_EST_REP_E0 ', v_tot_est_rep_e0)  );/* dmap converted statement end */
--toda la orden esta en sistema final
if v_tot_est_rep_e2 = v_tot_lineas+1 then
select desc_notificacion
into strict   v_output
from   xxmor_ordenes_estatus_tab
where  id_notificacion = 60;
return v_output;
--todas las lineas estan rechazadas
elsif v_tot_rechazos = v_tot_lineas then
select desc_notificacion
into strict   v_output
from   xxmor_ordenes_estatus_tab
where  id_notificacion = 46;
return v_output;
--el encabezado fue rechazado
elsif v_rechazo_enc > 0 then
select desc_notificacion
into strict   v_output
from   xxmor_ordenes_estatus_tab
where  id_notificacion = 46;
return v_output;
--toda la orden esta retenida
elsif v_tot_retencion = v_tot_lineas then
select desc_notificacion
into strict   v_output
from   xxmor_ordenes_estatus_tab
where  id_notificacion = 36;
return v_output;
--la orden esta lista para ser enviada
elsif v_tot_est_rep_e2 = 0 and v_rpta_cc_sin_e = v_tot_lineas +1 and v_rpta_cc_con_e = 0 then --se suma mas 1 por el encabezado
select desc_notificacion
into strict   v_output
from   xxmor_ordenes_estatus_tab
where  id_notificacion = 47;
return v_output;/* dmap converted statement start */
elsif (v_tot_reprocesos + v_tot_rechazos + v_tot_retencion + v_tot_autorizacion + v_tot_lin_en_rep ) > 0 and v_tot_est_rep >0 then
perform dbms_output.put_line( concat('ESTATUS REP > 0 ', v_tot_est_rep_e0 , ' TOT_RPTA_CC >0')  );/* dmap converted statement end *//* dmap converted statement start */
for c_estatus in estatus_replica_cur loop
v_output :=  concat(v_output, c_estatus.estat_rep, ', ') ;/* dmap converted statement end */
end loop;/* dmap converted statement start */
for c_estatus in estatus_concom_cur loop
v_output :=  concat(v_output, c_estatus.accion_concom, ', ') ;/* dmap converted statement end */
end loop;/* dmap converted statement start */
if v_tot_lin_en_rep > 0 then
select  concat(v_output, desc_notificacion, ', '
) into strict   v_output
from   xxmor_ordenes_estatus_tab
where  id_notificacion = 30;/* dmap converted statement end */
end if;
v_output := oracle.substr(v_output,1,length(v_output)-2);
return v_output;/* dmap converted statement start */
elsif (v_tot_reprocesos + v_tot_rechazos + v_tot_retencion + v_tot_autorizacion) > 0 and v_tot_est_rep =0 then
perform dbms_output.put_line( concat('ESTATUS REP = 0 ', v_tot_est_rep_e0 , ' TOT_RPTA_CC >0')  );/* dmap converted statement end *//* dmap converted statement start */
for c_estatus in estatus_concom_cur loop
v_output :=  concat(v_output, c_estatus.accion_concom, ', ') ;/* dmap converted statement end */
end loop;
v_output := oracle.substr(v_output,1,length(v_output)-2);
return v_output;/* dmap converted statement start */
elsif (v_tot_reprocesos + v_tot_rechazos + v_tot_retencion + v_tot_autorizacion) = 0 and v_tot_est_rep >0 then
perform dbms_output.put_line( concat('ESTATUS REP > 0 ', v_tot_est_rep_e0 , ' TOT_RPTA_CC = 0')  );/* dmap converted statement end *//* dmap converted statement start */
for c_estatus in estatus_replica_cur loop
v_output :=  concat(v_output, c_estatus.estat_rep, ', ') ;/* dmap converted statement end */
end loop;
v_output := oracle.substr(v_output,1,length(v_output)-2);/* dmap converted statement start */
perform dbms_output.put_line( concat('V_OUTPUT ', v_output)  );/* dmap converted statement end */
return v_output;/* dmap converted statement start */
elsif v_tot_est_rep_e2 > 0 then
for c_estatus in estatus_replica_cur loop
v_output :=  concat(v_output, c_estatus.estat_rep, ', ') ;/* dmap converted statement end */
end loop;
v_output := oracle.substr(v_output,1,length(v_output)-2);/* dmap converted statement start */
for c_estatus in estatus_replica_cur loop
v_output :=  concat(v_output, c_estatus.estat_rep, ', ') ;/* dmap converted statement end */
end loop;
v_output := oracle.substr(v_output,1,length(v_output)-2);
return v_output;/* dmap converted statement start */
--            elsif v_orden_estatus in (10,20,25,30,33)  then
--
--                select desc_notificacion
--                into v_output
--                from xxmor_ordenes_estatus_tab
--                where id_notificacion = v_orden_estatus;
--
--                return v_output;
else
for c_estatus in estatus_replica_cur loop
v_output :=  concat(v_output, c_estatus.estat_rep, ', ') ;/* dmap converted statement end */
end loop;/* dmap converted statement start */
for c_estatus in estatus_concom_cur loop
v_output :=  concat(v_output, c_estatus.accion_concom, ', ') ;/* dmap converted statement end */
end loop;
v_output := oracle.substr(v_output,1,length(v_output)-2);
return v_output;
end if;
return 'Procesando';
end if;
if p_tipo = 'ESTATUS_LINEA' then
select count(1)
into strict   v_rpta_cc
from   xxmor_concom_rpta_tab
where  id_solicitud    = p_id_solicitud
and    numlinea_concom = p_linea;
if v_rpta_cc = 0 then
return '11';
end if;
select count(1)
into strict   v_tot_retencion
from   xxmor_concom_rpta_tab
where  id_solicitud                            = p_id_solicitud
and    numlinea_concom                         = p_linea
and    estatus_orduni                          = '10'
and    position('RETENCION' in upper(accion_concom)) > 0;
if v_tot_retencion > 0 then
return '36';
end if;
select count(1)
into strict   v_tot_rechazos
from   xxmor_concom_rpta_tab
where  id_solicitud                          = p_id_solicitud
and    numlinea_concom                       = p_linea
and    estatus_orduni                        = '10'
and    position('RECHAZO' in upper(accion_concom)) > 0;
if v_tot_rechazos > 0 then
return '46';
end if;
select count(1)
into strict   v_tot_reprocesos
from   xxmor_concom_rpta_tab
where  id_solicitud         = p_id_solicitud
and    numlinea_concom      = p_linea
and    estatus_orduni       = '10'
and    upper(accion_concom) in ('REENVIO','REPROCESO');
select count(1)
into strict   v_tot_autorizacion
from   xxmor_concom_rpta_tab
where  id_solicitud                               = p_id_solicitud
and    numlinea_concom                            = p_linea
and    estatus_orduni                             = '10'
and    position('AUTORIZACION' in upper(accion_concom)) > 0;
if v_tot_autorizacion > 0 or v_tot_reprocesos > 0 then
return '45';
end if;
select (linea_estatus)::numeric
into strict   v_estatus_linea
from   xxmor_solicitudes_det_tab
where  id_solicitud = p_id_solicitud
and    linea        = p_linea;/* dmap converted statement start */
if v_estatus_linea in (30, 33) then
return to_char(v_estatus_linea,000000000000000);/* dmap converted statement end */
end if;
select case estat_rep when '1' then 50
when '2' then 60
when '3' then 55
else null
end
into strict   v_estatus_linea
from   xxmor_solicitudes_est_rep_tab e
where  e.id_solicitud = p_id_solicitud
and    e.linea        = p_linea;
if v_estatus_linea in (50,60,55) then
return v_estatus_linea;
end if;
if v_tot_reprocesos = 0 then
return 47;
end if;/* dmap converted statement start */
if nullif(v_estatus_linea::text, '') is not null then
return to_char(v_estatus_linea,000000000000000);/* dmap converted statement end */
end if;
return '0';
end if;
if p_tipo = 'ESTATUS_ORD_N' then
--reproceso
select count(1)
into strict   v_rpta_cc_sin_e
from   xxmor_concom_rpta_tab
where  id_solicitud   = p_id_solicitud
and    estatus_orduni = '20';
select count(1)
into strict   v_rpta_cc
from   xxmor_concom_rpta_tab
where  id_solicitud   = p_id_solicitud
and    estatus_orduni = '10';/* dmap converted statement start */
if v_rpta_cc = 0 and v_rpta_cc_sin_e > 0 then
return to_char('30',00);/* dmap converted statement end */
end if;/* dmap converted statement start */
perform dbms_output.put_line( concat('V_RPTA_CC_SIN_E ', v_rpta_cc_sin_e)  );/* dmap converted statement end *//* dmap converted statement start */
perform dbms_output.put_line( concat('V_RPTA_CC_coN_E ', v_rpta_cc_con_e)  );/* dmap converted statement end */
/*--
select to_number(orden_estatus)
into   v_orden_estatus
from   xxmor_solicitudes_enc_tab
where  id_solicitud = p_id_solicitud;
dbms_output.put_line(v_orden_estatus estatus fisico|| v_orden_estatus );
dbms_output.put_line(-------------------------------------- );
if v_orden_estatus in (30, 33, 42) then
return to_char(v_estatus_linea);
end if;
dbms_output.put_line(v_orden_estatus estatus fisico|| v_orden_estatus );
dbms_output.put_line(-------------------------------------- );
*/
select count(1)
into strict   v_tot_reprocesos
from (select distinct
numlinea_concom
from   xxmor_concom_rpta_tab
where  id_solicitud   = p_id_solicitud
and    estatus_orduni = '10'
) alias1;
--and    upper(accion_concom) in (rechazo, autorizacion);
if  v_tot_reprocesos > 0 then
return '45';
end if;/* dmap converted statement start */
perform dbms_output.put_line( concat('V_TOT_REPROCESOS ', v_tot_reprocesos)  );/* dmap converted statement end */
select count(1)
into strict   v_tot_est_rep
from   xxmor_solicitudes_est_rep_tab e
where  estat_rep    = '1'
and    id_solicitud = p_id_solicitud;/* dmap converted statement start */
perform dbms_output.put_line( concat('V_TOT_EST_REP ', v_tot_est_rep)  );/* dmap converted statement end */
if v_tot_est_rep > 0 then
return 50;
end if;
select count(1)
into strict   v_tot_lineas
from   xxmor_solicitudes_det_tab
where  id_solicitud = p_id_solicitud;
select count(1)
into strict   v_tot_est_rep_e2
from   xxmor_solicitudes_est_rep_tab e
where  estat_rep    = '2'
and    id_solicitud = p_id_solicitud;
if v_tot_lineas = v_tot_est_rep_e2 then
return '60';
end if;
select count(1)
into strict   v_tot_est_rep
from   xxmor_solicitudes_est_rep_tab e
where  estat_rep    = '3'
and    id_solicitud = p_id_solicitud;
if v_tot_est_rep >0 then
return '55';
end if;
select count(1)
into strict   v_tot_retencion
from (select distinct
numlinea_concom
from   xxmor_concom_rpta_tab
where  id_solicitud                            = p_id_solicitud
and    estatus_orduni                          = '10'
and    nullif(numlinea_concom::text, '') is not null
and    position('RETENCION' in upper(accion_concom)) > 0
) alias3;
if v_tot_lineas = v_tot_retencion then
return '36';
end if;
select count(1)
into strict   v_tot_rechazos
from (select distinct
numlinea_concom
from   xxmor_concom_rpta_tab
where  id_solicitud                          = p_id_solicitud
and    estatus_orduni                        = '10'
and    nullif(numlinea_concom::text, '') is not null
and    position('RECHAZO' in upper(accion_concom)) > 0
) alias3;
if v_tot_lineas = v_tot_rechazos then
return '46';
end if;
return '0';
end if;
if p_tipo = 'LINEA_BIEN' then
--si 1 ->linea bien
--si 0 pues mal
select count(1)
into strict   v_output
from (select distinct
id_solicitud,
numlinea_concom
from   xxmor_concom_rpta_tab
where  id_solicitud    = p_id_solicitud
and    nullif(numlinea_concom::text, '') is not null
and    id_seg_neg      = 1
and    numlinea_concom = p_linea
except
select distinct
id_solicitud,
numlinea_concom
from   xxmor_concom_rpta_tab r
where  id_solicitud    = p_id_solicitud
and    nullif(numlinea_concom::text, '') is not null
and    estatus_orduni  = '10'
and    id_seg_neg      = 1
and    numlinea_concom = p_linea
) alias1;
return v_output;
end if;
return 'x';end;
$body$
language plpgsql
;
