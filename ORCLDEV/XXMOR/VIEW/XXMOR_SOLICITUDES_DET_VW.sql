-- dmap_object_gen_tag : type : view name : xxmor_solicitudes_det_vw
set search_path = xxmor,oracle,dmap_extension,public;/* dmap converted statement start */

create or replace view "xxmor_solicitudes_det_vw"  ("id_solicitud", "linea", "linea_hna", "reprocesos", "stnid", "err_stnid", "fecha_inicio", "err_fecha_inicio", "fecha_fin", "err_fecha_fin", "duracion", "err_duracion", "buyuntid", "err_buyuntid", "hora_inicio", "err_hora_inicio", "hora_fin", "err_hora_fin", "spots", "err_spots", "lunes", "err_lunes", "martes", "err_martes", "miercoles", "err_miercoles", "jueves", "err_jueves", "viernes", "err_viernes", "sabado", "err_sabado", "domingo", "err_domingo", "spots_x_semana", "err_spots_x_semana", "tipo_servicio", "err_tipo_servicio", "usr_chr", "err_usr_chr", "spot_chr", "err_spot_chr", "bn", "err_bn", "p", "err_p", "marca", "err_marca", "version", "err_version", "tarifasp_sin_desc", "err_tarifasp_sin_desc", "tarifasp_con_desc", "err_tarifasp_con_desc", "tot_linea_sin_desc", "err_tot_linea_sin_desc", "tot_linea_con_desc", "err_tot_linea_con_desc", "sobrecargo", "err_sobrecargo", "observaciones", "err_observaciones", "err_rechazo", "id_prdg", "id_onair", "linea_estatus", "matloc_null", "matloc", "fecha_final", "aut_openlog", "aut_tm", "aut_sobregargo", "aut_urgente", "des_plataforma", "mcontid") as select
sd.id_solicitud,
sd.linea,
sd.linea_hna,
(
select
count(1)
from (
select distinct
crt.id_solicitud,
crt.numlinea_concom
from
xxmor_concom_rpta_tab crt
where
crt.estatus_orduni = '10'
and upper(accion_concom) in ('REPROCESO',
'REENVIO')
except
select distinct
crt.id_solicitud,
crt.numlinea_concom
from
xxmor_concom_rpta_tab crt
where
crt.estatus_orduni = '10'
and upper(accion_concom) in ('RECHAZO',
'RETENCION') ) re
where
re.id_solicitud = sd.id_solicitud
and re.numlinea_concom = sd.linea ) reprocesos,
sd.stnid,
coalesce(xxmor.xxmor_funcional_pkg_xxmor_ident_errores_fun( sd.id_solicitud, sd.linea, 'STNID' ) ,0
) err_stnid,
sd.fecha_inicio,
coalesce(xxmor.xxmor_funcional_pkg_xxmor_ident_errores_fun( sd.id_solicitud, sd.linea,
'FECHA_INICIO' ) ,0) err_fecha_inicio,
sd.fecha_fin,
coalesce(xxmor.xxmor_funcional_pkg_xxmor_ident_errores_fun( sd.id_solicitud, sd.linea, 'FECHA_FIN'
) ,0) err_fecha_fin,
sd.duracion,
coalesce(xxmor.xxmor_funcional_pkg_xxmor_ident_errores_fun( sd.id_solicitud, sd.linea, 'DURACION' )
,0) err_duracion,
sd.buyuntid,
coalesce(xxmor.xxmor_funcional_pkg_xxmor_ident_errores_fun( sd.id_solicitud, sd.linea, 'BUYUNTID' )
,0) err_buyuntid,
sd.hora_inicio,
coalesce(xxmor.xxmor_funcional_pkg_xxmor_ident_errores_fun( sd.id_solicitud, sd.linea,
'HORA_INICIO' ) ,0) err_hora_inicio,
sd.hora_fin,
coalesce(xxmor.xxmor_funcional_pkg_xxmor_ident_errores_fun( sd.id_solicitud, sd.linea, 'HORA_FIN' )
,0) err_hora_fin,
coalesce(sd.spots, xxmor_funcional_pkg_xxmor_sol_totales_fun( sd.id_solicitud, sd.linea, 'SP_X_L' )
) spots,
xxmor.xxmor_funcional_pkg_xxmor_ident_errores_fun( sd.id_solicitud, sd.linea, 'SPOTS' )
err_spots,
sd.lunes,
coalesce(xxmor.xxmor_funcional_pkg_xxmor_ident_errores_fun( sd.id_solicitud, sd.linea, 'LUNES' ) ,0
) err_lunes,
sd.martes,
coalesce(xxmor.xxmor_funcional_pkg_xxmor_ident_errores_fun( sd.id_solicitud, sd.linea, 'MARTES' ) ,
0) err_martes,
sd.miercoles,
coalesce(xxmor.xxmor_funcional_pkg_xxmor_ident_errores_fun( sd.id_solicitud, sd.linea, 'MIERCOLES'
) ,0) err_miercoles,
sd.jueves,
coalesce(xxmor.xxmor_funcional_pkg_xxmor_ident_errores_fun( sd.id_solicitud, sd.linea, 'JUEVES' ) ,
0) err_jueves,
sd.viernes,
coalesce(xxmor.xxmor_funcional_pkg_xxmor_ident_errores_fun( sd.id_solicitud, sd.linea, 'VIERNES' )
,0) err_viernes,
sd.sabado,
coalesce(xxmor.xxmor_funcional_pkg_xxmor_ident_errores_fun( sd.id_solicitud, sd.linea, 'SABADO' ) ,
0) err_sabado,
sd.domingo,
coalesce(xxmor.xxmor_funcional_pkg_xxmor_ident_errores_fun( sd.id_solicitud, sd.linea, 'DOMINGO' )
, 0) err_domingo,
coalesce(sd.spots_x_semana, xxmor.xxmor_funcional_pkg_xxmor_sol_totales_fun( sd.id_solicitud,
sd.linea, 'SS_X_L' ) ) spots_x_semana,
coalesce(xxmor.xxmor_funcional_pkg_xxmor_ident_errores_fun( sd.id_solicitud, sd.linea,
'SPOTS_X_SEMANA' ) ,0) err_spots_x_semana,
sd.tipo_servicio,
coalesce(xxmor.xxmor_funcional_pkg_xxmor_ident_errores_fun( sd.id_solicitud, sd.linea,
'TIPO_SERVICIO' ) ,0) err_tipo_servicio,
sd.usr_chr,
coalesce(xxmor.xxmor_funcional_pkg_xxmor_ident_errores_fun( sd.id_solicitud, sd.linea, 'USR_CHR' )
,0) err_usr_chr,
sd.spot_chr,
coalesce(xxmor.xxmor_funcional_pkg_xxmor_ident_errores_fun( sd.id_solicitud, sd.linea, 'SPT_CHR' )
,0) err_spot_chr,
sd.bn,
coalesce(xxmor.xxmor_funcional_pkg_xxmor_ident_errores_fun( sd.id_solicitud, sd.linea, 'BN' ) ,0)
err_bn,
sd.p,
coalesce(xxmor.xxmor_funcional_pkg_xxmor_ident_errores_fun( sd.id_solicitud, sd.linea, 'P' ) ,0)
err_p,
sd.marca,
coalesce(xxmor.xxmor_funcional_pkg_xxmor_ident_errores_fun( sd.id_solicitud, sd.linea, 'MARCA' ) ,0
) err_marca,
sd.version,
coalesce(xxmor.xxmor_funcional_pkg_xxmor_ident_errores_fun( sd.id_solicitud, sd.linea, 'VERSION' )
,0)                                              err_version,
to_char(sd.tarifasp_sin_desc, '999999999999.99') tarifasp_sin_desc,
coalesce(xxmor.xxmor_funcional_pkg_xxmor_ident_errores_fun( sd.id_solicitud, sd.linea,
'TARIFASP_SIN_DESC' ) ,0) err_tarifasp_sin_desc,
((sd.tarifasp_sin_desc)::numeric  * 1 -- se comenta para evitar error con dblink - xxmor_funcional_pkg_xxmor_desc_mcontid_fun(se.id_solicitud)
) tarifasp_con_desc,
coalesce(xxmor.xxmor_funcional_pkg_xxmor_ident_errores_fun( sd.id_solicitud, sd.linea,
'TARIFASP_CON_DESC' ) ,0) err_tarifasp_con_desc,
to_char((sd.tarifasp_sin_desc)::numeric  * xxmor.xxmor_funcional_pkg_xxmor_sol_totales_fun( sd.id_solicitud, sd.linea, 'SP_X_L' ) ,'999999999999.99') tot_linea_sin_desc,
coalesce(xxmor.xxmor_funcional_pkg_xxmor_ident_errores_fun( sd.id_solicitud, sd.linea,
'TOT_LINEA_SIN_DESC' ) ,0) err_tot_linea_sin_desc,
to_char((sd.tarifasp_sin_desc)::numeric  * xxmor.xxmor_funcional_pkg_xxmor_sol_totales_fun( sd.id_solicitud, sd.linea, 'SP_X_L' ) * 1 -- se comenta para evitar error con dblink - xxmor.xxmor_funcional_pkg_xxmor_desc_mcontid_fun(se.id_solicitud)
,'999999999999.99') tot_linea_con_desc,
coalesce(xxmor.xxmor_funcional_pkg_xxmor_ident_errores_fun( sd.id_solicitud, sd.linea,
'TOT_LINEA_CON_DESC' ) ,0) err_tot_linea_con_desc,
sd.sobrecargo,
coalesce(xxmor.xxmor_funcional_pkg_xxmor_ident_errores_fun( sd.id_solicitud, sd.linea, 'SOBRECARGO'
) ,0) err_sobrecargo,
sd.observaciones,
coalesce(xxmor.xxmor_funcional_pkg_xxmor_ident_errores_fun( sd.id_solicitud, sd.linea,
'OBSERVACIONES' ) ,0) err_observaciones,
coalesce(xxmor.xxmor_funcional_pkg_xxmor_ident_errores_fun( sd.id_solicitud, sd.linea, 'RECHAZO' )
,0) err_rechazo,
--r.estat_id_foraneo id_prdg,
(
select
ser.estat_id_foraneo
from
xxmor_solicitudes_est_rep_tab ser
where
ser.id_solicitud = se.id_solicitud::NUMERIC
and ser.linea = sd.linea::NUMERIC ) id_prdg,
ro.estat_id_foraneo            id_onair,
--nvl (sd.linea_estatus, 0)   as linea_estatus,
coalesce(xxmor_funcional_pkg_xxmor_orden_estatus_fun( sd.id_solicitud, sd.linea, 'ESTATUS_LINEA' )
,0)                     linea_estatus,
coalesce(fza.matloc_null, 0) matloc_null,
coalesce(fza.matloc, 0)      matloc,
coalesce(xxmor.xxmor_funcional_pkg_xxmor_sol_fechas_fun( sd.id_solicitud, sd.linea, 'F_U_T' ) ,0)
fecha_final,
coalesce(
(
select
xcr.desc_concom||'/'||xcr.detalle_concom
from
xxmor_concom_rpta_tab xcr
where
upper(xcr.campo_concom) = 'OPENLOG'
and upper(xcr.accion_concom) = 'AUTORIZACION'
and upper(xcr.posicion_concom) = 'LINEA'
and coalesce(xcr.estatus_orduni, '10') = '10'
and xcr.id_solicitud = sd.id_solicitud::NUMERIC
and xcr.numlinea_concom = sd.linea::VARCHAR ),'0' ) aut_openlog,
coalesce(
(
select
xcr.desc_concom||'/'|| xcr.detalle_concom
from
xxmor_concom_rpta_tab xcr
where
upper(xcr.campo_concom) = 'TARIFA_MANUAL'
and upper(xcr.accion_concom) = 'AUTORIZACION'
and upper(xcr.posicion_concom) = 'LINEA'
and coalesce(xcr.estatus_orduni, '10') = '10'
and xcr.id_solicitud = sd.id_solicitud::NUMERIC
and xcr.numlinea_concom = sd.linea::VARCHAR ),'0' ) aut_tm,
coalesce(
(
select
xcr.desc_concom||'/'||xcr.detalle_concom
from
xxmor_concom_rpta_tab xcr
where
upper(xcr.campo_concom) = 'SOBRECARGO'
and upper(xcr.accion_concom) = 'AUTORIZACION'
and upper(xcr.posicion_concom) = 'LINEA'
and coalesce(xcr.estatus_orduni, '10') = '10'
and xcr.id_solicitud = sd.id_solicitud::NUMERIC
and xcr.numlinea_concom = sd.linea::VARCHAR ),'0' ) aut_sobregargo,
coalesce(
(
select
xcr.desc_concom||'/'||xcr.detalle_concom
from
xxmor_concom_rpta_tab xcr
where
upper(xcr.campo_concom) = 'URGENTE'
and upper(xcr.accion_concom) = 'AUTORIZACION'
and upper(xcr.posicion_concom) = 'LINEA'
and coalesce(xcr.estatus_orduni, '10') = '10'
and xcr.id_solicitud = sd.id_solicitud::NUMERIC
and xcr.numlinea_concom = sd.linea::VARCHAR ),'0' ) aut_urgente,
sd.des_plataforma,
se.mcontid
from xxmor_solicitudes_enc_tab se, xxmor_fzas_vtas_tab fza, xxmor_solicitudes_det_tab sd
left outer join xxmor_solicitudes_est_rep_tab r on (sd.id_solicitud = r.id_solicitud and 0 = r.linea and 1 = r.id_sist)
left outer join xxmor_solicitudes_est_rep_tab ro on (sd.id_solicitud = ro.id_solicitud and 0 = ro.linea and 2 = ro.id_sist)
where se.id_seg_neg = 1::NUMERIC       and sd.id_solicitud = se.id_solicitud::NUMERIC and se.id_fza_ventas = fza.id_fza_ventas::NUMERIC  order by
sd.linea;/* dmap converted statement end */
-- estimed cost of view [ xxmor_solicitudes_det_vw ]: 2.00;
