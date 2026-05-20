create or replace procedure xxmor.xxmor_funcional_pkg_xxmor_notifica_fvtas_merca_pr ( pisttiponotif varchar, piinvalor numeric, piinidsolrequest numeric ) as $body$
declare
rcpt record;
-- pgv moved types start
--dmap moved type current package xxmor_funcional_pkg;
g_conexion              utl_smtp.connection;
-- pgv moved types end
lst_from             varchar(100);
lst_smtp_srv         varchar(100);
lin_smtp_prt         numeric;
lst_error            varchar(500) := null;
lst_mail             varchar(50);
lst_mail_orden       varchar(50);
lst_mails_notificar  varchar(3000);
lst_mails_destino    varchar(3000);
lst_subject          varchar(240) := null;
lst_fecha            varchar(50) := null;
lst_archivo_sol      varchar(100) := null;
lst_motivo           varchar(240) := null;
lst_fuerza_ventas    varchar(50) := null;
lst_requiere_aut     varchar(1);
lst_error_usr_smtp   varchar(1);
lst_usuario_smtp     varchar(50);
lst_password_smtp    varchar(50);
lst_ordenes_cutin    varchar(50);with recursive cte as (
mails_notificar_cur   cursor(pistmailsnotificar  varchar) is
with value_list as (select pistmailsnotificar as val )
select oracle.substr(val, (case when 1=1 then  0  else instr(val, ',', 1, level -1) end  + 1),
(case when instr(val, ',', 1, level) -1=-1 then  length(val)  else instr(val, ',', 1, level) -1 end )
-(case when level=1 then  0  else instr(val, ',', 1, level -1) end  + 1) + 1) correo
from value_list level <=(select (length(val) -length(replace(val, ',', null)))
from value_list) alias15  union all
mails_notificar_cur   cursor(pistmailsnotificar  varchar) is
with value_list as (select pistmailsnotificar as val )
select oracle.substr(val, (case when (c.level+1)=1 then  0  else instr(val, ',', 1, (c.level+1) -1) end  + 1),
(case when instr(val, ',', 1, (c.level+1)) -1=-1 then  length(val)  else instr(val, ',', 1, (c.level+1)) -1 end )
-(case when (c.level+1)=1 then  0  else instr(val, ',', 1, (c.level+1) -1) end  + 1) + 1) correo
from value_list level <=(select (length(val) -length(replace(val, ',', null)))
from value_list) join cte c on ()
) select * from cte;
ordenes_cutin_cur cursor for
select id_solicitud
from   xxmor_solicitudes_enc_tab
where  id_request = piinidsolrequest;
--dmap conversion comment: global temp variables moved as local temp variables
glo_document_temp text;
--dmap conversion comment: declaration boundary ends
begin
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('XXMOR', 'XXMOR_FUNCIONAL_PKG');
--dmap conversion comment: gtt declaration added
-- se obtien la direccion ip del smtp server
-- asi como el puerto.
begin
lst_smtp_srv := null;
lin_smtp_prt := null;
select oracle.substr(valor_parametro,1,(position(':' in valor_parametro)-1)) servidor,
oracle.substr(valor_parametro,(position(':' in valor_parametro)+1))   puerto
into strict   lst_smtp_srv,
lin_smtp_prt
from   xxmor_conf_params_grls_tab
where  upper(nombre_parametro) = 'SMTP_SERVER';
exception
when others then
lst_smtp_srv := null;
lin_smtp_prt := null;
end;/* dmap converted statement start */
if nullif(lst_smtp_srv::text, '') is not null and nullif(lin_smtp_prt::text, '') is not null then
perform dbms_output.put_line( concat('Servidor de Correo: ', lst_smtp_srv)) ;/* dmap converted statement end *//* dmap converted statement start */
perform dbms_output.put_line( concat('Puerto: ', lin_smtp_prt)) ;/* dmap converted statement end */
-- se verifica si es necesaria la autenticacion en el servidor smtp.
begin
lst_requiere_aut := 'N';
select coalesce(valor_parametro,'N') requiere_autenticacion
into strict   lst_requiere_aut
from   xxmor_conf_params_grls_tab
where  upper(nombre_parametro) = 'USAR_AUTENTICACION_ENV_CORREO';
exception
when others then
lst_requiere_aut := 'N';
end;
lst_usuario_smtp  := null;
lst_password_smtp := null;
if lst_requiere_aut = 'S' then
-- se obtien el usuario y contrase?a si es necesaria la
-- autenticacion en el servidor smtp.
begin
select oracle.substr(valor_parametro,1,(position('/' in valor_parametro)-1)) usuario,
oracle.substr(valor_parametro,(position('/' in valor_parametro)+1))   password
into strict   lst_usuario_smtp,
lst_password_smtp
from   xxmor_conf_params_grls_tab
where  upper(nombre_parametro) = 'USUARIO_ENVIO_CORREOS';
exception
when others then
lst_usuario_smtp  := null;
lst_password_smtp := null;
end;
if nullif(lst_usuario_smtp::text, '') is not null and nullif(lst_password_smtp::text, '') is not null then
lst_error_usr_smtp := 'N';/* dmap converted statement start */
lst_from :=  concat('<', lst_usuario_smtp, '__televisa.com.mx>') ;/* dmap converted statement end */
else
lst_error_usr_smtp := 'S';/* dmap converted statement start */
if nullif(lst_usuario_smtp::text, '') is not null then
lst_from :=  concat('<', lst_usuario_smtp, '__televisa.com.mx>') ;/* dmap converted statement end */
else
lst_from := '<servicio_orduni__televisa.com.mx>';
end if;
perform dbms_output.put_line('No Es Posible Enviar la Notificacion: Revise la Configuracion en Paramentros Generales del Usuario y Contrase?a para el Envio de Correos');
insert into xxmor_log_errores_tab(
id_error,
desc_error,
archivo_error,
metodo_error,
hora_error
)
values (
nextval('xxmor_log_error_sq'),
'No Es Posible Enviar la Notificacion: Revise la Configuracion en Paramentros Generales del Usuario y Contrase?a para el Envio de Correos',
null,
'Procedimiento XXMOR_HTML_EMAIL_PR',
clock_timestamp()
);
end if;
else
lst_error_usr_smtp := 'N';
lst_from := '<servicio_orduni__televisa.com.mx>';
end if;
if lst_error_usr_smtp = 'N' then
select to_char(clock_timestamp(),'day dd "de" month "de" yyyy hh24:mi','nls_date_language=spanish')
into strict   lst_fecha
;/* dmap converted statement start */
perform dbms_output.put_line( concat('lst_from: ', lst_from)) ;/* dmap converted statement end */
g_conexion := utl_smtp.open_connection( lst_smtp_srv, lin_smtp_prt );
utl_smtp.helo( g_conexion, lst_smtp_srv );
if lst_requiere_aut = 'S' then
utl_smtp.command( g_conexion, 'AUTH LOGIN' );
utl_smtp.command( g_conexion, utl_raw.cast_to_varchar2( utl_encode.base64_encode( encode(lst_usuario_smtp ::bytea, 'hex')::bytea)) );
utl_smtp.command( g_conexion, utl_raw.cast_to_varchar2( utl_encode.base64_encode( encode(lst_password_smtp ::bytea, 'hex')::bytea)) );
end if;
utl_smtp.mail( g_conexion, lst_from );/* dmap converted statement start */
if pisttiponotif = 'FVTAS' then
lst_subject :=  concat('No Fue Posible Obtener la Fuerza de Ventas para la Solicitud: ', piinidsolrequest) ;/* dmap converted statement end */
select sa.nom_archivo_sol,
se.email
into strict   lst_archivo_sol,
lst_mail_orden
from   xxmor_solicitudes_orig_enc_tab soe,
xxmor_solicitudes_enc_tab      se,
xxmor_solicitudes_arch_tab     sa
where  soe.id_request     = se.id_request
and    soe.id_archivo_sol = sa.id_archivo_sol
and    se.id_solicitud    = piinidsolrequest;
begin
select valor_parametro
into strict   lst_mails_notificar
from   xxmor_conf_params_grls_tab
where  upper(nombre_parametro) = 'CORREOS_FVTAS';
exception
when no_data_found then
lst_mails_notificar := 'NDFVTAS';
--lst_mails_notificar := omejiam__televisa.com.mx,osmemo__gmail.com,;
when others then
lst_mails_notificar := 'OTHERS';
end;
else -- merca
select sa.nom_archivo_sol,
soe.email
into strict   lst_archivo_sol,
lst_mail_orden
from   xxmor_solicitudes_orig_enc_tab soe,
xxmor_solicitudes_arch_tab     sa
where  soe.id_archivo_sol = sa.id_archivo_sol
and    soe.id_request     = piinidsolrequest;/* dmap converted statement start */
lst_subject :=  concat('Detalles en la Generacion de las 2 Ordenes de Mercadotecnia para el archivo: ', lst_archivo_sol) ;/* dmap converted statement end */
begin
select valor_parametro
into strict   lst_mails_notificar
from   xxmor_conf_params_grls_tab
where  upper(nombre_parametro) = 'CORREOS_MERCA';
exception
when no_data_found then
lst_mails_notificar := 'NDMERCA';
--lst_mails_notificar := omejiam__televisa.com.mx,osmemo__gmail.com,;
when others then
lst_mails_notificar := 'OTHERS';
end;
end if;/* dmap converted statement start */
if position('__' in lst_mails_notificar) > 0 then
if position('__' in lst_mail_orden) > 0 then
lst_mails_notificar :=  concat(lst_mails_notificar, lst_mail_orden, ',') ;/* dmap converted statement end */
end if;/* dmap converted statement start */
perform dbms_output.put_line( concat('lst_mails_notificar:', lst_mails_notificar)) ;/* dmap converted statement end *//* dmap converted statement start */
for rcpt in select * from mails_notificar_cur(lst_mails_notificar) loop
begin
perform dbms_output.put_line( concat('RCPT.CORREO:', rcpt.correo)) ;/* dmap converted statement end *//* dmap converted statement start */
if nullif(rcpt.correo::text, '') is not null then
lst_mail :=   concat('<', trim(both rcpt.correo), '>') ;/* dmap converted statement end *//* dmap converted statement start */
perform dbms_output.put_line( concat('lst_mail:', lst_mail)) ;/* dmap converted statement end */
utl_smtp.rcpt( g_conexion, lst_mail );/* dmap converted statement start */
lst_mails_destino :=  concat(lst_mails_destino, lst_mail, ',') ;/* dmap converted statement end *//* dmap converted statement start */
perform dbms_output.put_line( concat('lst_mails_destino FOR:', lst_mails_destino)) ;/* dmap converted statement end */
end if;/* dmap converted statement start */
exception
when others then
insert into xxmor_log_errores_tab(id_error, desc_error, archivo_error, metodo_error)
values (nextval('xxmor_log_error_sq'),  concat('No pudo enviarse la notificacion a el siguiente destinatario:', lst_mail, '  ') , null,  concat('Procedimiento XXMOR_NOTIFICA_FVTAS_MERCA_PR subject: ', lst_subject, ',...) ')) ;/* dmap converted statement end */
end;
end loop;
lst_mails_destino := oracle.substr(lst_mails_destino,1,length(lst_mails_destino)-1);/* dmap converted statement start */
perform dbms_output.put_line( concat('lst_mails_destino:', lst_mails_destino)) ;/* dmap converted statement end */
-- start body of email
--
utl_smtp.open_data(g_conexion);/* dmap converted statement start */
utl_smtp.write_data(g_conexion,  concat('From', ': ', lst_from, utl_tcp.crlf)) ;/* dmap converted statement end *//* dmap converted statement start */
utl_smtp.write_data(g_conexion,  concat('To', ': ', lst_mails_destino, utl_tcp.crlf)) ;/* dmap converted statement end *//* dmap converted statement start */
utl_smtp.write_data(g_conexion,  concat('Subject', ': ', lst_subject, utl_tcp.crlf)) ;/* dmap converted statement end *//* dmap converted statement start */
utl_smtp.write_data(g_conexion,  concat('MIME-version: 1.0', utl_tcp.crlf)) ;/* dmap converted statement end *//* dmap converted statement start */
utl_smtp.write_data(g_conexion,  concat('Content-Type: ', 'text/html; charset=utf-8', utl_tcp.crlf)) ;/* dmap converted statement end *//* dmap converted statement start */
utl_smtp.write_data(g_conexion,  concat('Content-Transfer-Encoding: ', '8bit', utl_tcp.crlf)) ;/* dmap converted statement end */
/*****************************************************************/
call dmap_extension.p_dmap_set_pkg_var('XXMOR' , 'XXMOR_FUNCIONAL_PKG', 'GLO_DOCUMENT', 'LONG',(null)::text, 'N');
-- **********
--
call xxmor_funcional_pkg_xxcc_crea_html_fvtas_merca_pr('<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">');
call xxmor_funcional_pkg_xxcc_crea_html_fvtas_merca_pr('<html>');
--
call xxmor_funcional_pkg_xxcc_crea_html_fvtas_merca_pr('<style type="text/css">');
call xxmor_funcional_pkg_xxcc_crea_html_fvtas_merca_pr('<!--');
call xxmor_funcional_pkg_xxcc_crea_html_fvtas_merca_pr('table {color:#000000; font-size: 10pt; font-weight: bold; line-height:1.5; padding:2px; text-align:left}');
call xxmor_funcional_pkg_xxcc_crea_html_fvtas_merca_pr('h1, h2, h3, h4 {color: #00000}');
call xxmor_funcional_pkg_xxcc_crea_html_fvtas_merca_pr('h3 {font-size: 16pt}');
call xxmor_funcional_pkg_xxcc_crea_html_fvtas_merca_pr('td {background-color: #f7f7e7; color: #000000; font-weight: NORMAL; font-SIZE: 11pt; border-style: solid; border-width: 1; border-color: #CCCC99; white-SPACE: nowrap}');
call xxmor_funcional_pkg_xxcc_crea_html_fvtas_merca_pr('tr {background-color: #f7f7e7; color: #000000; font-weight: NORMAL; font-SIZE: 11pt; white-SPACE: nowrap}');
call xxmor_funcional_pkg_xxcc_crea_html_fvtas_merca_pr('th {background-color: #CCCC99; color: #336699; height: 20; border-style: solid; border-width: 1; border-left-color: #f7f7e7; border-right-color: #f7f7e7; border-top-width: 0; border-bottom-width: 0; white-SPACE: nowrap}');
call xxmor_funcional_pkg_xxcc_crea_html_fvtas_merca_pr('-->');
call xxmor_funcional_pkg_xxcc_crea_html_fvtas_merca_pr('</style>');
--
call xxmor_funcional_pkg_xxcc_crea_html_fvtas_merca_pr('<head>');
call xxmor_funcional_pkg_xxcc_crea_html_fvtas_merca_pr('<title> CORREO DE NOTIFICACION </title>');
call xxmor_funcional_pkg_xxcc_crea_html_fvtas_merca_pr('</head>');
call xxmor_funcional_pkg_xxcc_crea_html_fvtas_merca_pr('<BODY>');
call xxmor_funcional_pkg_xxcc_crea_html_fvtas_merca_pr('<p>');/* dmap converted statement start */
--xxmor_funcional_pkg_xxcc_crea_html_fvtas_merca_pr(<br>);
--xxmor_funcional_pkg_xxcc_crea_html_fvtas_merca_pr(<br>);
call xxmor_funcional_pkg_xxcc_crea_html_fvtas_merca_pr( concat('<b><CENTER><FONT SIZE=4 COLOR="black" align="button"> CORREO DE NOTIFICACI', chr(38), 'Oacute;', 'N </FONT></CENTER></b>')) ;/* dmap converted statement end */
call xxmor_funcional_pkg_xxcc_crea_html_fvtas_merca_pr('</p>');
--xxmor_funcional_pkg_xxcc_crea_html_fvtas_merca_pr(<br>);
-- **********
-- **********
call xxmor_funcional_pkg_xxcc_crea_html_fvtas_merca_pr('<p>');
call xxmor_funcional_pkg_xxcc_crea_html_fvtas_merca_pr('    <br> Estimado Usuario: ');
call xxmor_funcional_pkg_xxcc_crea_html_fvtas_merca_pr('    <br>');/* dmap converted statement start */
call xxmor_funcional_pkg_xxcc_crea_html_fvtas_merca_pr( concat('    <br> Por medio del presente le notificamos que el d', chr(38), 'iacute;', 'a de hoy: ', lst_fecha, ',')) ;/* dmap converted statement end */
if pisttiponotif = 'FVTAS' then
if piinvalor = 0 then
lst_motivo := 'no existe ninguna Fuerza de Ventas con los datos de la solicitud';
elsif piinvalor = 1 then
lst_motivo := 'existe mas de una Fuerza de Ventas con los datos de la solicitud';
else
select nombre_fza_ventas
into strict   lst_fuerza_ventas
from   xxmor_fzas_vtas_tab
where  id_seg_neg    = 1
and    id_fza_ventas = piinvalor;/* dmap converted statement start */
lst_motivo :=  concat('la Fuerza de Ventas: ', lst_fuerza_ventas, ' esta Inactiva') ;/* dmap converted statement end */
end if;/* dmap converted statement start */
call xxmor_funcional_pkg_xxcc_crea_html_fvtas_merca_pr( concat('         No fue posible obtener la Fuerza de Ventas para la Solicitud ', piinidsolrequest, ', asociada al archivo ', lst_archivo_sol, ',')) ;/* dmap converted statement end *//* dmap converted statement start */
call xxmor_funcional_pkg_xxcc_crea_html_fvtas_merca_pr( concat('         debido a que ', lst_motivo, '.')) ;/* dmap converted statement end *//* dmap converted statement start */
else
if piinvalor = 0 then
call xxmor_funcional_pkg_xxcc_crea_html_fvtas_merca_pr( concat('         No fue posible crear la orden del Master Contract de Ingresos (CUTIN) asociada al archivo ', lst_archivo_sol, '.')) ;/* dmap converted statement end *//* dmap converted statement start */
elsif piinvalor = 1 then
call xxmor_funcional_pkg_xxcc_crea_html_fvtas_merca_pr( concat('         No fue posible crear la orden del Master Contract Normal asociada al archivo ', lst_archivo_sol, '.')) ;/* dmap converted statement end *//* dmap converted statement start */
else
for rsol in ordenes_cutin_cur loop
lst_ordenes_cutin :=  concat(lst_ordenes_cutin, rsol.id_solicitud, ',') ;/* dmap converted statement end */
end loop;
lst_ordenes_cutin := oracle.substr(lst_ordenes_cutin,1,length(lst_ordenes_cutin)-1);/* dmap converted statement start */
call xxmor_funcional_pkg_xxcc_crea_html_fvtas_merca_pr( concat('         se crearon las 2 ordenes de Mercadotecnia CUTIN, asociadas al arvhivo ', lst_archivo_sol, ',')) ;/* dmap converted statement end *//* dmap converted statement start */
call xxmor_funcional_pkg_xxcc_crea_html_fvtas_merca_pr( concat('         pero el n', chr(38), 'uacute;', 'mero de l', chr(38), 'iacute;', 'neas no es correcto en una de ellas.')) ;/* dmap converted statement end *//* dmap converted statement start */
call xxmor_funcional_pkg_xxcc_crea_html_fvtas_merca_pr( concat('         Por favor revise las solicitudes generadas (', lst_ordenes_cutin, ').')) ;/* dmap converted statement end */
end if;
end if;
call xxmor_funcional_pkg_xxcc_crea_html_fvtas_merca_pr('    <br>');
--xxmor_funcional_pkg_xxcc_crea_html_fvtas_merca_pr(    <br>);
--xxmor_funcional_pkg_xxcc_crea_html_fvtas_merca_pr(    <br>);
--xxmor_funcional_pkg_xxcc_crea_html_fvtas_merca_pr(    <br> agradeciendo de antemano su atenci||chr(38)||oacute;||n.  muchas gracias!!!!!.);
call xxmor_funcional_pkg_xxcc_crea_html_fvtas_merca_pr('    <br>');
call xxmor_funcional_pkg_xxcc_crea_html_fvtas_merca_pr('    <br> Saludos.');
call xxmor_funcional_pkg_xxcc_crea_html_fvtas_merca_pr('</p>');
-- **********
-- **********
call xxmor_funcional_pkg_xxcc_crea_html_fvtas_merca_pr('</BODY>');
call xxmor_funcional_pkg_xxcc_crea_html_fvtas_merca_pr('</html>');
-- **********
-- finalizamos
perform dbms_output.put_line('===>  Correo Enviado');
utl_smtp.close_data(g_conexion);
utl_smtp.\quit(g_conexion);
else
perform dbms_output.put_line('No Es Posible Enviar la Notificacion: Revise la Configuracion en Parametros Generales de los Correos de Notificacion');
if lst_mails_notificar = 'NDFVTAS' then
lst_error := 'Revise la Configuracion en Parametros Generales de los Correos de Notificacion para Fuerza de Ventas';
elsif lst_mails_notificar = 'NDMERCA' then
lst_error := 'Revise la Configuracion en Parametros Generales de los Correos de Notificacion para Mercadotecnia';
else
lst_error := sqlerrm;
end if;/* dmap converted statement start */
insert into xxmor_log_errores_tab(
id_error,
desc_error,
archivo_error,
metodo_error,
hora_error
)
values (
nextval('xxmor_log_error_sq'),
concat('No Es Posible Enviar la Notificacion: ', lst_error) ,
null,
'Procedimiento XXMOR_NOTIFICA_FVTAS_MERCA_PR',
clock_timestamp()
);/* dmap converted statement end */
end if;
end if;
else
perform dbms_output.put_line('No Es Posible Enviar la Notificacion: Revise la Configuracion en Parametros Generales del Servidor y Puerto para el Envio de Correos');
insert into xxmor_log_errores_tab(
id_error,
desc_error,
archivo_error,
metodo_error,
hora_error
)
values (
nextval('xxmor_log_error_sq'),
'No Es Posible Enviar la Notificacion: Revise la Configuracion en Parametros Generales del Servidor y Puerto para el Envio de Correos',
null,
'Procedimiento XXMOR_NOTIFICA_FVTAS_MERCA_PR',
clock_timestamp()
);
end if;/* dmap converted statement start */
exception
when others then
perform dbms_output.put_line( concat('Error al generar el correo: ', sqlerrm)) ;/* dmap converted statement end */
lst_error := sqlerrm;/* dmap converted statement start */
insert into xxmor_log_errores_tab(
id_error,
desc_error,
archivo_error,
metodo_error
)
values (
nextval('xxmor_log_error_sq'),
concat('No Es Posible Enviar la Notificacion: ', lst_error) ,
null,
'Procedimiento XXMOR_NOTIFICA_FVTAS_MERCA_PR'
);/* dmap converted statement end */end;
$body$
language plpgsql
;
