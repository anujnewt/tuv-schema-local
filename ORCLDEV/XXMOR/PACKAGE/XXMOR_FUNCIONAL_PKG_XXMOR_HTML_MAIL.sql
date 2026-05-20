create or replace  function  xxmor.xxmor_funcional_pkg_xxmor_html_mail ( p_id_solicitud integer, p_lineas varchar, p_orden_estatus integer ) returns text as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_orden_html          text;
v_ip_smtp_srv         varchar(30);
v_estatus_desc        varchar(100);
v_errores_linea       varchar(32000);
v_fuerza_ventas       varchar(100);
v_fecha               varchar(150);
v_id_paradigm         varchar(25);
v_id_onair            varchar(25);
v_color               varchar(10);
v_est_linea           varchar(5);
v_aux                 integer;
v_nombre_archivo      varchar(150);
v_dir_logo            varchar(200);
lsttxtfooter          varchar(3001);
cur_hdr_sol cursor for
select id_solicitud,
id_request,
id_seg_neg,
id_fza_ventas,
id_solicitud_hna,
(case when nullif(proc_por_linea::text, '') is not null then 'SI' else 'NO' end) proc_por_linea,
case when garantizado='1' then  'SI'  else 'NO' end  garantizado,
advid,
mcontid,
mcontid_cutin,
email,
agyestnum,
accthdrid,
rtcrddscr,
rtcrd,
rtcrddscr_cutin,
rtcrd_cutin,
comentarios,
secnum,
plataforma_canal,
agrupador,
prdid_desc,
prdid,
total_spots,
total_sin_desc,
total_con_desc,
tipo_facturacion,
descuento,
target,
created_date,
created_by,
updated_date,
updated_by,
orden_estatus,
fecha_concom,
tracking_id_concom,
aux1,
aux2,
aux3
from   xxmor_solicitudes_enc_tab
where  id_solicitud = p_id_solicitud;
v_hdr_sol record;
cur_det_sol cursor for
select id_solicitud,
linea,
linea_hna,
stnid,
fecha_inicio,
fecha_fin,
duracion,
buyuntid,
hora_inicio,
hora_fin,
spots,
lunes,
martes,
miercoles,
jueves,
viernes,
sabado,
domingo,
spots_x_semana,
tipo_servicio,
usr_chr,
spot_chr,
bn,
p,
marca,
version,
tarifasp_sin_desc,
tarifasp_con_desc,
tot_linea_sin_desc,
tot_linea_con_desc,
sobrecargo,
observaciones,
created_by,
created_date,
updated_date,
updated_by,
des_plataforma
from   xxmor_solicitudes_det_tab
where  id_solicitud = p_id_solicitud
and    position(linea  coalesce(p_lineas,linea)) > 0
order by linea asc;
v_det_sol record;
autorizaciones_cur cursor for
select cr.updated_by||' autorizo por '||cr.campo_concom as autorizacion_msg
from   xxmor_concom_rpta_tab cr
where  cr.id_solicitud         = p_id_solicitud
and    cr.numlinea_concom      = v_det_sol.linea
and    cr.estatus_orduni       = '20'
and    upper(cr.accion_concom) = 'AUTORIZACION'
and    not exists (select 1
from   xxmor_concom_rpta_tab cr2
where  cr2.id_solicitud         = cr.id_solicitud
and    cr2.numlinea_concom      = cr.numlinea_concom
and    upper(cr2.accion_concom) = 'RECHAZO'
);
--dmap conversion comment: global temp variables moved as local temp variables
glo_document_temp text;
--dmap conversion comment: declaration boundary ends
begin
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('XXMOR', 'XXMOR_FUNCIONAL_PKG');
--dmap conversion comment: gtt declaration added
--traemos el estatus de la orden
select desc_notificacion
into strict   v_estatus_desc
from   xxmor_ordenes_estatus_tab
where  id_notificacion = case when p_orden_estatus=20 then 10  else p_orden_estatus end;
--nombre del archivo relacionado a la orden
select a.nom_archivo_sol
into strict   v_nombre_archivo
from   xxmor_solicitudes_arch_tab     a,
xxmor_solicitudes_enc_tab      e,
xxmor_solicitudes_orig_enc_tab eo
where  e.id_solicitud    = p_id_solicitud
and    e.id_request      = eo.id_request
and    eo.id_archivo_sol = a.id_archivo_sol
and    e.id_seg_neg      = 1
and    e.id_seg_neg      = a.id_seg_neg;
--parametro ip de la imagen del correo
select valor_parametro
into strict   v_dir_logo
from   xxmor_conf_params_grls_tab
where  nombre_parametro = 'LogoMail';
open cur_hdr_sol;
fetch cur_hdr_sol
into  v_hdr_sol;
close cur_hdr_sol;
select to_char(clock_timestamp(),'Daydd Monthyyyy HH24:MI','NLS_LANGUAGE=SPANISH')
into strict   v_fecha
;
select xxmor_funcional_pkg_xxmor_ident_errores_fun(p_id_solicitud,v_det_sol.linea,'lineaMail')
into strict   v_errores_linea
;
begin
select nombre_fza_ventas
into strict   v_fuerza_ventas
from   xxmor_fzas_vtas_tab
where  id_fza_ventas = v_hdr_sol.id_fza_ventas
and    id_seg_neg    = 1;
exception
when no_data_found then
v_fuerza_ventas := 'SIN FUERZA DE VENTAS';
end;
begin
select estat_id_foraneo
into strict   v_id_paradigm
from   xxmor_solicitudes_est_rep_tab
where  id_sist      = 1
and    id_solicitud = p_id_solicitud
and    linea        = 0;
exception
when no_data_found then
v_id_paradigm := ' ';
end;
begin
select estat_id_foraneo
into strict   v_id_onair
from   xxmor_solicitudes_est_rep_tab
where  id_sist      = 2
and    id_solicitud = p_id_solicitud
and    linea        = 0;
exception
when no_data_found then
v_id_onair := ' ';
end;/* dmap converted statement start */
v_orden_html := concat('<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>televisa - orduni</title>
</head>
<body>
<table  width="1330" border="0" cellspacing="0" cellpadding="0">
<tr>
<td align="left" valign="middle"><table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#252671">
<tr>
<td width="180" rowspan="3" align="center" valign="middle"><!--img src="', V_DIR_LOGO, '" width="150" height="50"/--></td>
<td height="20" align="left">;</td>
</tr>
<tr>
<td height="20" align="left" valign="bottom" style="font-family:verdana, geneva, sans-serif; font-size:20px; font-weight:bold; color:#fff;">correo de notificacion</td>
</tr>
<tr>
<td height="30" align="left" valign="middle" style="font-family:verdana, geneva, sans-serif; font-size:14px; color:#fff;">de la orden no: ' , P_ID_SOLICITUD, '</td>
</tr>
</table></td>
</tr>
<tr>
<td>;</td>
</tr>
<tr>
<td bgcolor="#ff801a" height="1"></td>
</tr>
<tr>
<td bgcolor="#fbe194" height="1"></td>
</tr>
<tr>
<td>;</td>
</tr>
<tr>
<td bgcolor="#666666"><table width="100%" border="0" cellspacing="1" cellpadding="0" style="font-family:verdana, geneva, sans-serif; font-size:12px; color:#000;">
<tr>
<td style="padding: 3px; font-weight:bold;" align="center" valign="middle" bgcolor="#e4e4e4">clave cliente</td>
<td style="padding: 3px;" align="left" valign="middle" bgcolor="#ffffff">' , V_HDR_SOL.ADVID, '</td>
<td style="padding: 3px; font-weight:bold;" align="center" valign="middle" bgcolor="#e4e4e4">clave encabezado de<br/>cliente - agencia</td>
<td style="padding: 3px;" align="left" valign="middle" bgcolor="#ffffff">' , V_HDR_SOL.ACCTHDRID, '</td>
<td style="padding: 3px; font-weight:bold;" align="center" valign="middle" bgcolor="#e4e4e4">fuerza de<br/>ventas</td>
<td style="padding: 3px;" align="left" valign="middle" bgcolor="#ffffff">' , V_FUERZA_VENTAS, '</td>
<td style="padding: 3px; font-weight:bold;" align="center" valign="middle" bgcolor="#e4e4e4">cps - master contract</td>
<td style="padding: 3px;" align="left" valign="middle" bgcolor="#ffffff">' , V_HDR_SOL.MCONTID, '</td>
</tr>
<tr>
<td style="padding: 3px; font-weight:bold;" align="center" valign="middle" bgcolor="#e4e4e4">nombre tarifa</td>
<td style="padding: 3px;" align="left" valign="middle" bgcolor="#ffffff">' , V_HDR_SOL.rtcrddscr , '</td>
<td style="padding: 3px; font-weight:bold;" align="center" valign="middle" bgcolor="#e4e4e4">categoria de<br/>producto</td>
<td style="padding: 3px;" align="left" valign="middle" bgcolor="#ffffff">' , V_HDR_SOL.PRDID_DESC , '</td>
<td style="padding: 3px; font-weight:bold;" align="center" valign="middle" bgcolor="#e4e4e4">plataforma<br/>canal</td>
<td style="padding: 3px;" align="left" valign="middle" bgcolor="#ffffff">' , V_HDR_SOL.PLATAFORMA_CANAL , '</td>
<td style="padding: 3px; font-weight:bold;" align="center" valign="middle" bgcolor="#e4e4e4">ref folio</td>
<td style="padding: 3px;" align="left" valign="middle" bgcolor="#ffffff">' , V_HDR_SOL.AGYESTNUM , '</td>
</tr>
<tr>
<td style="padding: 3px; font-weight:bold;" align="center" valign="middle" bgcolor="#e4e4e4">nombre / email<br/>responsable(s)</td>
<td style="padding: 3px;" align="left" valign="middle" bgcolor="#ffffff">' , V_HDR_SOL.EMAIL , '</td>
<td style="padding: 3px; font-weight:bold;" align="center" valign="middle" bgcolor="#e4e4e4">target</td>
<td style="padding: 3px;" align="left" valign="middle" bgcolor="#ffffff">' , REPLACE(V_HDR_SOL.TARGET,'?',';') , '</td>
<td style="padding: 3px; font-weight:bold;" align="center" valign="middle" bgcolor="#e4e4e4">garantizado</td>
<td style="padding: 3px;" align="left" valign="middle" bgcolor="#ffffff">' , V_HDR_SOL.GARANTIZADO , '</td>
<td style="padding: 3px; font-weight:bold;" align="center" valign="middle" bgcolor="#e4e4e4">proc x linea</td>
<td style="padding: 3px;" align="left" valign="middle" bgcolor="#ffffff">' , V_HDR_SOL.PROC_POR_LINEA , '</td>
</tr>
<tr>
<td style="padding: 3px; font-weight:bold;" align="center" valign="middle" bgcolor="#e4e4e4">total spots</td>
<td style="padding: 3px;" align="left" valign="middle" bgcolor="#ffffff">' , V_HDR_SOL.TOTAL_SPOTS , '</td>
<td style="padding: 3px; font-weight:bold;" align="center" valign="middle" bgcolor="#e4e4e4">total tarifa referencia</td>
<td style="padding: 3px;" align="left" valign="middle" bgcolor="#ffffff">' , V_HDR_SOL.TOTAL_SIN_DESC , '</td>
<td style="padding: 3px; font-weight:bold;" align="center" valign="middle" bgcolor="#e4e4e4">total tarifa definitiva</td>
<td style="padding: 3px;" align="left" valign="middle" bgcolor="#ffffff">' , V_HDR_SOL.TOTAL_con_DESC , '</td>
<td style="padding: 3px; font-weight:bold;" align="center" valign="middle" bgcolor="#e4e4e4"></td>
<td style="padding: 3px;" align="left" valign="middle" bgcolor="#ffffff"></td>
</tr>
<tr>
<td style="padding: 3px; font-weight:bold;" align="center" valign="middle" bgcolor="#e4e4e4">tipo facturacion</td>
<td style="padding: 3px;" align="left" valign="middle" bgcolor="#ffffff">' , V_HDR_SOL.TIPO_FACTURACION , '</td>
<td style="padding: 3px; font-weight:bold;" align="center" valign="middle" bgcolor="#e4e4e4">ajuste variable contrato</td>
<td style="padding: 3px;" align="left" valign="middle" bgcolor="#ffffff">' , V_HDR_SOL.Descuento , '</td>
<td style="padding: 3px; font-weight:bold;" align="center" valign="middle" bgcolor="#e4e4e4">comentarios de la<br/>orden de servicio</td>
<td style="padding: 3px;" align="left" valign="middle" bgcolor="#ffffff" colspan="3" >' , V_HDR_SOL.comentarios , '</td>
</tr>
<tr>
<td style="padding: 3px; font-weight:bold;" align="center" valign="middle" bgcolor="#e4e4e4">id paradigm</td>
<td style="padding: 3px;" align="left" valign="middle"  bgcolor="#ffffff">', V_ID_PARADIGM, '</td>
<td style="padding: 3px; font-weight:bold;" align="center" valign="middle" bgcolor="#e4e4e4">id onair</td>
<td style="padding: 3px;" align="left" valign="middle"  bgcolor="#ffffff">', V_ID_ONAIR, '</td>
<td style="padding: 3px; font-weight:bold;" align="center" valign="middle" bgcolor="#e4e4e4">estatus encabezado</td>
<td style="padding: 3px;" align="left" valign="middle" colspan="3" bgcolor="#ffffff">' , xxmor_funcional_pkg_xxmor_ident_errores_fun(p_id_solicitud, null, 'lineaMail') , '</td>
</tr>
</table></td>
</tr>
<tr>
<td>;</td>
</tr>
<tr>
<td bgcolor="#ff801a" height="1"></td>
</tr>
<tr>
<td bgcolor="#fbe194" height="1"></td>
</tr>
<tr>
<td>;</td>
</tr>
<tr>
<td bgcolor="#666666">
<table width="100%" border="0" cellspacing="1" cellpadding="0" style="font-family:verdana, geneva, sans-serif; font-size:10px; color:#000;">
<!--tr>
<td bgcolor="#ffffff" width="30">;</td>
<td bgcolor="#ffffff" width="30">;</td>
<td bgcolor="#ffffff" width="30">;</td>
<td bgcolor="#ffffff" width="70">;</td>
<td colspan="2" align="center" valign="middle" bgcolor="#e4e4e4">fecha</td>
<td bgcolor="#ffffff" width="30">;</td>
<td bgcolor="#ffffff" width="100">;</td>
<td bgcolor="#ffffff" width="50">;</td>
<td bgcolor="#ffffff" width="50">;</td>
<td bgcolor="#ffffff" width="30">;</td>
<td colspan="7" align="center" valign="middle" bgcolor="#e4e4e4" style="font-weight:bold">cantidad de<br/>transmisiones</td>
<td bgcolor="#ffffff" width="30">;</td>
<td bgcolor="#ffffff" width="30">;</td>
<td bgcolor="#ffffff">;</td>
<td bgcolor="#ffffff">;</td>
<td bgcolor="#ffffff">;</td>
<td bgcolor="#ffffff">;</td>
<td bgcolor="#ffffff">;</td>
<td bgcolor="#ffffff">;</td>
<td bgcolor="#ffffff">;</td>
<td bgcolor="#ffffff">;</td>
<td bgcolor="#ffffff">;</td>
<td bgcolor="#ffffff">;</td>
<td bgcolor="#ffffff">;</td>
</tr-->
<tr>
<td align="center" valign="bottom" bgcolor="#e4e4e4">
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="font-family:verdana, geneva, sans-serif; font-size:10px; font-weight:bold; color:#000;">
<tr>
<td align="center" valign="middle">l</td>
</tr>
<tr>
<td align="center" valign="middle">?</td>
</tr>
<tr>
<td align="center" valign="middle">n</td>
</tr>
</table>
</td>
<td align="center" valign="bottom" bgcolor="#e4e4e4" style="padding-bottom:3px">estatus</td>
<td align="center" valign="bottom" bgcolor="#e4e4e4">
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="font-family:verdana, geneva, sans-serif; font-size:10px; font-weight:bold; color:#000;">
<tr>
<td align="center" valign="middle">id</td>
</tr>
<tr>
<td align="center" valign="middle">pgm</td>
</tr>
</table>
</td>
<td align="center" valign="bottom" bgcolor="#e4e4e4">
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="font-family:verdana, geneva, sans-serif; font-size:10px; font-weight:bold; color:#000;">
<tr>
<td align="center" valign="middle">id</td>
</tr>
<tr>
<td align="center" valign="middle">onair</td>
</tr>
</table>
</td>
<td align="center" valign="bottom" bgcolor="#e4e4e4"><table width="100%" border="0" cellspacing="0" cellpadding="0" style="font-family:verdana, geneva, sans-serif; font-size:10px; font-weight:bold; color:#000;">
<tr>
<td align="center" valign="middle">c</td>
</tr>
<tr>
<td align="center" valign="middle">a</td>
</tr>
<tr>
<td align="center" valign="middle">n</td>
</tr>
</table></td>
<td align="center" valign="bottom" bgcolor="#e4e4e4"><table width="100%" border="0" cellspacing="0" cellpadding="0" style="font-family:verdana, geneva, sans-serif; font-size:10px; color:#000;">
<tr>
<td align="center" valign="middle">fecha</td>
</tr>
<tr>
<td align="center" valign="middle">inicio</td>
</tr>
</table></td>
<td align="center" valign="bottom" bgcolor="#e4e4e4"><table width="100%" border="0" cellspacing="0" cellpadding="0" style="font-family:verdana, geneva, sans-serif; font-size:10px; color:#000;">
<tr>
<td align="center" valign="middle">fecha</td>
</tr>
<tr>
<td align="center" valign="middle">fin</td>
</tr>
</table></td>
<td align="center" valign="bottom" bgcolor="#e4e4e4"><table width="100%" border="0" cellspacing="0" cellpadding="0" style="font-family:verdana, geneva, sans-serif; font-size:10px; font-weight:bold; color:#000;">
<tr>
<td align="center" valign="middle">d</td>
</tr>
<tr>
<td align="center" valign="middle">u</td>
</tr>
<tr>
<td align="center" valign="middle">r</td>
</tr>
</table></td>
<td align="center" valign="bottom" bgcolor="#e4e4e4" style="padding-bottom:3px">programa /<br/>paquete /<br/>bloque horario</td>
<td align="center" valign="bottom" bgcolor="#e4e4e4"><table width="100%" border="0" cellspacing="0" cellpadding="0" style="font-family:verdana, geneva, sans-serif; font-size:10px; font-weight:bold; color:#000;">
<tr>
<td align="center" valign="middle">h</td>
<td align="center" valign="middle"> </td>
</tr>
<tr>
<td align="center" valign="middle">o</td>
<td align="center" valign="middle">i</td>
</tr>
<tr>
<td align="center" valign="middle">r</td>
<td align="center" valign="middle">n</td>
</tr>
<tr>
<td align="center" valign="middle">a</td>
<td align="center" valign="middle">i</td>
</tr>
</table></td>
<td align="center" valign="bottom" bgcolor="#e4e4e4"><table width="100%" border="0" cellspacing="0" cellpadding="0" style="font-family:verdana, geneva, sans-serif; font-size:10px; font-weight:bold; color:#000;">
<tr>
<td align="center" valign="middle">h</td>
<td align="center" valign="middle">;</td>
</tr>
<tr>
<td align="center" valign="middle">o</td>
<td align="center" valign="middle">f</td>
</tr>
<tr>
<td align="center" valign="middle">r</td>
<td align="center" valign="middle">i</td>
</tr>
<tr>
<td align="center" valign="middle">a</td>
<td align="center" valign="middle">n</td>
</tr>
</table></td>
<td align="center" valign="bottom" bgcolor="#e4e4e4"><table width="100%" border="0" cellspacing="0" cellpadding="0" style="font-family:verdana, geneva, sans-serif; font-size:10px; font-weight:bold; color:#000;">
<tr>
<td align="center" valign="middle">s</td>
<td align="center" valign="middle">x</td>
</tr>
<tr>
<td align="center" valign="middle">p</td>
<td align="center" valign="middle">;</td>
</tr>
<tr>
<td align="center" valign="middle">o</td>
<td align="center" valign="middle">s</td>
</tr>
<tr>
<td align="center" valign="middle">t</td>
<td align="center" valign="middle">e</td>
</tr>
<tr>
<td align="center" valign="middle">s</td>
<td align="center" valign="middle">m</td>
</tr>
</table>
</td>
<td width="20" align="center" valign="bottom" bgcolor="#e4e4e4"><table width="100%" border="0" cellspacing="0" cellpadding="0" style="font-family:verdana, geneva, sans-serif; font-size:10px; font-weight:bold; color:#000;">
<tr><td align="center">l</td>
</tr>
</table></td>
<td width="20" align="center" valign="bottom" bgcolor="#e4e4e4"><table width="100%" border="0" cellspacing="0" cellpadding="0" style="font-family:verdana, geneva, sans-serif; font-size:10px; font-weight:bold; color:#000;">
<tr>
<td align="center">m</td>
</tr>
<tr>
<td align="center">a</td>
</tr>
</table></td>
<td width="20" align="center" valign="bottom" bgcolor="#e4e4e4"><table width="100%" border="0" cellspacing="0" cellpadding="0" style="font-family:verdana, geneva, sans-serif; font-size:10px; font-weight:bold; color:#000;">
<tr>
<td align="center">m</td>
</tr>
<tr>
<td align="center">i</td>
</tr>
</table></td>
<td width="20" align="center" valign="bottom" bgcolor="#e4e4e4"><table width="100%" border="0" cellspacing="0" cellpadding="0" style="font-family:verdana, geneva, sans-serif; font-size:10px; font-weight:bold; color:#000;">
<tr>
<td align="center">j</td>
</tr>
</table></td>
<td width="20" align="center" valign="bottom" bgcolor="#e4e4e4"><table width="100%" border="0" cellspacing="0" cellpadding="0" style="font-family:verdana, geneva, sans-serif; font-size:10px; font-weight:bold; color:#000;">
<tr>
<td align="center">v</td>
</tr>
</table></td>
<td width="20" align="center" valign="bottom" bgcolor="#e4e4e4"><table width="100%" border="0" cellspacing="0" cellpadding="0" style="font-family:verdana, geneva, sans-serif; font-size:10px; font-weight:bold; color:#000;">
<tr>
<td align="center">s</td>
</tr>
</table></td>
<td width="20" align="center" valign="bottom" bgcolor="#e4e4e4"><table width="100%" border="0" cellspacing="0" cellpadding="0" style="font-family:verdana, geneva, sans-serif; font-size:10px; font-weight:bold; color:#000;">
<tr>
<td align="center">d</td>
</tr>
</table></td>
<td align="center" valign="bottom" bgcolor="#e4e4e4"><table width="100%" border="0" cellspacing="0" cellpadding="0" style="font-family:verdana, geneva, sans-serif; font-size:10px; font-weight:bold; color:#000;">
<tr>
<td align="center" valign="middle">t</td>
<td align="center" valign="middle">;</td>
</tr>
<tr>
<td align="center" valign="middle">o</td>
<td align="center" valign="middle">;</td>
</tr>
<tr>
<td align="center" valign="middle">t</td>
<td align="center" valign="middle">;</td>
</tr>
</table></td>
<td align="center" valign="bottom" bgcolor="#e4e4e4" style="padding-bottom:3px">tipo de servicio</td>
<td align="center" valign="bottom" bgcolor="#e4e4e4" style="padding-bottom:3px">bn</td>
<td align="center" valign="bottom" bgcolor="#e4e4e4" style="padding-bottom:3px">p</td>
<td align="center" valign="bottom" bgcolor="#e4e4e4" style="padding-bottom:3px">marca</td>
<td align="center" valign="bottom" bgcolor="#e4e4e4" style="padding-bottom:3px">version</td>
<td align="center" valign="bottom" bgcolor="#e4e4e4">
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="font-family:verdana, geneva, sans-serif; font-size:10px; color:#000;">
<tr>
<td align="center" valign="middle">tarifa referencia</td>
</tr>
<tr>
<td align="center" valign="middle">por spot</td>
</tr>
</table>
</td>
<td align="center" valign="bottom" bgcolor="#e4e4e4">
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="font-family:verdana, geneva, sans-serif; font-size:10px; color:#000;">
<tr>
<td align="center" valign="middle">tarifa definitiva</td>
</tr>
<tr>
<td align="center" valign="middle">por spot</td>
</tr>
</table>
</td>
<td align="center" valign="bottom" bgcolor="#e4e4e4">
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="font-family:verdana, geneva, sans-serif; font-size:10px; color:#000;">
<tr>
<td align="center" valign="middle">tot linea</td>
</tr>
<tr>
<td align="center" valign="middle">tarifa ref</td>
</tr>
</table>
</td>
<td align="center" valign="bottom" bgcolor="#e4e4e4">
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="font-family:verdana, geneva, sans-serif; font-size:10px; color:#000;">
<tr>
<td align="center" valign="middle">tot linea</td>
</tr>
<tr>
<td align="center" valign="middle">tarifa def</td>
</tr>
</table>
</td>
<td align="center" valign="bottom" bgcolor="#e4e4e4" style="padding-bottom:3px">ajuste</td>
<td align="center" valign="bottom" bgcolor="#e4e4e4" style="padding-bottom:3px">observaciones</td>
<td align="center" valign="bottom" bgcolor="#e4e4e4" style="padding-bottom:3px">plataforma</td>
</tr>') ;/* dmap converted statement end */
begin
open cur_det_sol;
loop
fetch cur_det_sol
into  v_det_sol;
exit when not found; /* apply on cur_det_sol */
if nullif(p_lineas::text, '') is null or coalesce(oracle.substr(p_lineas,(position(v_det_sol.linea in p_lineas) + length(v_det_sol.linea)),1),',') = ',' then
select xxmor_funcional_pkg_xxmor_orden_estatus_fun(p_id_solicitud, v_det_sol.linea,'ESTATUS_LINEA')
into strict   v_est_linea
;
begin
select estat_id_foraneo
into strict   v_id_paradigm
from   xxmor_solicitudes_est_rep_tab
where  id_sist      = 1
and    id_solicitud = p_id_solicitud
and    linea        = v_det_sol.linea;
exception
when no_data_found then
v_id_paradigm := ' ';
end;
begin
select estat_id_foraneo
into strict   v_id_onair
from   xxmor_solicitudes_est_rep_tab
where  id_sist      = 2
and    id_solicitud = p_id_solicitud
and    linea        = v_det_sol.linea;
exception
when no_data_found then
v_id_onair:= ' ';
end;
if v_est_linea = '36' then
v_color := 'FFFFFF'; --blanco
select desc_notificacion
into strict   v_errores_linea
from   xxmor_ordenes_estatus_tab
where  id_notificacion = 36;/* dmap converted statement start */
elsif v_est_linea = '46' then
/*select replace(desc_notificacion,orden, linea) || (select  por:  || replace(created_by,concomwsresponse,condiciones comerciales)
from xxmor_concom_rpta_tab c
where id_solicitud = p_id_solicitud
and numlinea_concom = v_det_sol.linea
and upper(accion_concom) = rechazo
and rownum = 1 )
into v_errores_linea
from xxmor_ordenes_estatus_tab
where id_notificacion = 46;
*/
select case created_by when 'ConComWsResponse' then 'Linea rechazada por: Condiciones Comerciales'
else  concat('Linea rechazada por: ', replace(created_by,'concomwsresponse','condiciones comerciales') , ' (' , campo_concom, ')'
) end
into strict   v_errores_linea
from   xxmor_concom_rpta_tab c
where  id_solicitud         = p_id_solicitud
and    numlinea_concom      = v_det_sol.linea
and    upper(accion_concom) = 'RECHAZO'  limit 1;/* dmap converted statement end *//* dmap converted statement start */
select concat( xxmor_funcional_pkg_xxmor_ident_errores_fun(p_id_solicitud,v_det_sol.linea,'lineaMail'), '
', v_errores_linea
) into strict v_errores_linea
;/* dmap converted statement end */
elsif v_est_linea = '45' then
select xxmor_funcional_pkg_xxmor_ident_errores_fun(p_id_solicitud,v_det_sol.linea,'lineaMail')
into strict   v_errores_linea
;
else
select replace(desc_notificacion,'Orden completa', 'Linea')
into strict   v_errores_linea
from   xxmor_ordenes_estatus_tab
where  id_notificacion = (v_est_linea)::numeric;
end if;/* dmap converted statement start */
for autorizacion in autorizaciones_cur loop
v_errores_linea :=  concat(v_errores_linea, '<br>' , autorizacion.autorizacion_msg) ;/* dmap converted statement end */
end loop;
select count(1)
into strict v_aux
from xxmor_solicitudes_det_tab
where tracking_id_concom = (select tracking_id_concom
from   xxmor_solicitudes_enc_tab
where  id_solicitud = p_id_solicitud
)
and id_solicitud         = p_id_solicitud
and linea                = v_det_sol.linea;
if v_aux > 0 then
v_color := 'F7DCC3';
else
v_color := 'FFFFFF';
end if;/* dmap converted statement start */
v_orden_html :=  concat(v_orden_html, '<tr>
<td align="center" width="10" valign="middle" bgcolor="#', V_COLOR, '">' , TO_CHAR(V_DET_SOL.LINEA) , '</td>
<td align="center" width="300" bgcolor="#', V_COLOR, '">' , V_ERRORES_LINEA , '</td>
<td align="center" width="40" bgcolor="#', V_COLOR, '">' , V_ID_PARADIGM , '</td>
<td align="center" width="40" bgcolor="#', V_COLOR, '">' , V_ID_ONAIR , '</td>
<td align="center" width="60" bgcolor="#', V_COLOR, '">' , V_DET_SOL.STNID, '</td>
<td align="center" width="60" bgcolor="#', V_COLOR, '">' , V_DET_SOL.FECHA_INICIO, '</td>
<td align="center" width="60" bgcolor="#', V_COLOR, '">' , V_DET_SOL.FECHA_FIN, '</td>
<td align="center" width="20" bgcolor="#', V_COLOR, '">' , V_DET_SOL.DURACION, '</td>
<td align="center" width="70" bgcolor="#', V_COLOR, '">' , V_DET_SOL.BUYUNTID, '</td>
<td align="center" width="30" bgcolor="#', V_COLOR, '">' , V_DET_SOL.HORA_INICIO, '</td>
<td align="center" width="30" bgcolor="#', V_COLOR, '">' , V_DET_SOL.HORA_FIN, '</td>
<td align="center" width="15" bgcolor="#', V_COLOR, '">' , V_DET_SOL.SPOTS, '</td>
<td align="center" width="15" bgcolor="#', V_COLOR, '">' , V_DET_SOL.LUNES, '</td>
<td align="center" width="15" bgcolor="#', V_COLOR, '">' , V_DET_SOL.MARTES, '</td>
<td align="center" width="15" bgcolor="#', V_COLOR, '">' , V_DET_SOL.MIERCOLES, '</td>
<td align="center" width="15" bgcolor="#', V_COLOR, '">' , V_DET_SOL.JUEVES, '</td>
<td align="center" width="15" bgcolor="#', V_COLOR, '">' , V_DET_SOL.VIERNES, '</td>
<td align="center" width="15" bgcolor="#', V_COLOR, '">' , V_DET_SOL.SABADO, '</td>
<td align="center" width="15" bgcolor="#', V_COLOR, '">' , V_DET_SOL.DOMINGO, '</td>
<td align="center" bgcolor="#', V_COLOR, '">' , V_DET_SOL.SPOTS_X_SEMANA, '</td>
<td align="center" bgcolor="#', V_COLOR, '">' , V_DET_SOL.TIPO_SERVICIO, '</td>
<td align="center" bgcolor="#', V_COLOR, '">' , V_DET_SOL.BN, '</td>
<td align="center" bgcolor="#', V_COLOR, '">' , V_DET_SOL.P, '</td>
<td align="center" bgcolor="#', V_COLOR, '">' , V_DET_SOL.MARCA, '</td>
<td align="center" bgcolor="#', V_COLOR, '">' , V_DET_SOL.VERSION, '</td>
<td align="center" bgcolor="#', V_COLOR, '">' , V_DET_SOL.TARIFASP_SIN_DESC, '</td>
<td align="center" bgcolor="#', V_COLOR, '">' , V_DET_SOL.TARIFASP_CON_DESC, '</td>
<td align="center" bgcolor="#', V_COLOR, '">' , V_DET_SOL.TOT_LINEA_SIN_DESC, '</td>
<td align="center" bgcolor="#', V_COLOR, '">' , V_DET_SOL.TOT_LINEA_CON_DESC, '</td>
<td align="center" bgcolor="#', V_COLOR, '">' , V_DET_SOL.SOBRECARGO, '</td>
<td align="center" bgcolor="#', V_COLOR, '">' , V_DET_SOL.OBSERVACIONES, '</td>
<td align="center" bgcolor="#', V_COLOR, '">' , V_DET_SOL.DES_PLATAFORMA, '</td>
</tr>') ;/* dmap converted statement end */
end if;
end loop;
close cur_det_sol;
begin
select valor_parametro
into strict   lsttxtfooter
from   xxmor_conf_params_grls_tab
where  nombre_parametro = 'EMAIL_TXT_ORD_ST_FOOTER';
exception
when no_data_found then
lsttxtfooter:= null;
end;/* dmap converted statement start */
v_orden_html :=  concat(v_orden_html, '</table></td>
</tr>
<tr><td>;</td></tr>
<tr style="font-size:small; font-weight:bold; font-family:sans-serif;">
<td>', lstTxtFooter, '</td>
</tr>
<tr><td>;</td></tr>
<tr><td bgcolor="#fce49f" height="3"></td></tr>
<tr><td bgcolor="#ff801a" height="3"></td></tr>
<tr><td bgcolor="#d50000" height="3"></td></tr>
<tr><td style="font-family:verdana, geneva, sans-serif; font-size:12px; font-weight:bold color:#000;">', v_fecha , '</td></tr>
</table>
</body>') ;/* dmap converted statement end */
end;
return v_orden_html;end;
$body$
language plpgsql
;
