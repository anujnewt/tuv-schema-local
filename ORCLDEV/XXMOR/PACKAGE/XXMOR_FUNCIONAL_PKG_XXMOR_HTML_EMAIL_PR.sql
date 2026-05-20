create or replace procedure xxmor.xxmor_funcional_pkg_xxmor_html_email_pr ( p_mails_notificar varchar, p_subject varchar, p_text varchar default null, p_html text  default null) as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_buffer_size      constant integer := 4000;
v_buffer_next      integer := 4000;
v_body_buffer      varchar(8000);
v_from             varchar(100);
lst_smtp_srv       varchar(100);
lin_smtp_prt       numeric;
lst_error          varchar(500) := null;
v_temp             varchar(100);
v_mails_to         varchar(3000);
v_cuenta_dirs      integer;
l_boundary         varchar(255) := 'a1b2c3d4e3f2g1';
l_connection       utl_smtp.connection;
l_body_html        text:= null;
l_offset           numeric;
l_ammount          numeric;
l_temp             varchar(32767) := null;
lst_requiere_aut   varchar(1);
lst_error_usr_smtp varchar(1);
lst_usuario_smtp   varchar(50);
lst_password_smtp  varchar(50);with recursive cte as (
mails_notificar_cur is cursor
with value_list as (select p_mails_notificar  as val )
select oracle.substr(val, (case when 1=1 then  0  else instr(val, ',', 1, level -1) end  + 1),
(case when instr(val, ',', 1, level) -1=-1 then  length(val)  else instr(val, ',', 1, level) -1 end )
-(case when level=1 then  0  else instr(val, ',', 1, level -1) end  + 1) + 1) correo
from value_list level <=(select (length(val) -length(replace(val, ',', null)))
from value_list) alias14  union all
mails_notificar_cur is cursor
with value_list as (select p_mails_notificar  as val )
select oracle.substr(val, (case when (c.level+1)=1 then  0  else instr(val, ',', 1, (c.level+1) -1) end  + 1),
(case when instr(val, ',', 1, (c.level+1)) -1=-1 then  length(val)  else instr(val, ',', 1, (c.level+1)) -1 end )
-(case when (c.level+1)=1 then  0  else instr(val, ',', 1, (c.level+1) -1) end  + 1) + 1) correo
from value_list level <=(select (length(val) -length(replace(val, ',', null)))
from value_list) join cte c on ()
) select * from cte;
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
v_from :=  concat('<', lst_usuario_smtp, '__televisa.com.mx>') ;/* dmap converted statement end */
else
lst_error_usr_smtp := 'S';/* dmap converted statement start */
if nullif(lst_usuario_smtp::text, '') is not null then
v_from :=  concat('<', lst_usuario_smtp, '__televisa.com.mx>') ;/* dmap converted statement end */
else
v_from := '<servicio_orduni__televisa.com.mx>';
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
v_from := '<servicio_orduni__televisa.com.mx>';
end if;/* dmap converted statement start */
if lst_error_usr_smtp = 'N' then
perform dbms_output.put_line( concat('V_FROM: ', v_from)) ;/* dmap converted statement end */
--v_from := <||lst_usuario_smtp||__televisa.com.mx>;
l_connection := utl_smtp.open_connection( lst_smtp_srv, lin_smtp_prt );
utl_smtp.helo( l_connection, lst_smtp_srv );
if lst_requiere_aut = 'S' then
utl_smtp.command( l_connection, 'AUTH LOGIN' );
utl_smtp.command( l_connection, utl_raw.cast_to_varchar2( utl_encode.base64_encode( encode(lst_usuario_smtp ::bytea, 'hex')::bytea)) );
utl_smtp.command( l_connection, utl_raw.cast_to_varchar2( utl_encode.base64_encode( encode(lst_password_smtp ::bytea, 'hex')::bytea)) );
end if;
utl_smtp.mail( l_connection, v_from );/* dmap converted statement start */
perform dbms_output.put_line( concat(' P_MAILS_NOTIFICAR:', p_mails_notificar)) ;/* dmap converted statement end *//* dmap converted statement start */
for rcpt in mails_notificar_cur loop
begin
perform dbms_output.put_line( concat('RCPT.CORREO:', rcpt.correo)) ;/* dmap converted statement end *//* dmap converted statement start */
if nullif(rcpt.correo::text, '') is not null then
v_temp :=    concat('<', trim(both rcpt.correo) , '>') ;/* dmap converted statement end *//* dmap converted statement start */
perform dbms_output.put_line( concat('V_TEMP:', v_temp)) ;/* dmap converted statement end */
utl_smtp.rcpt( l_connection, v_temp );/* dmap converted statement start */
v_mails_to :=  concat(v_mails_to, v_temp, ',') ;/* dmap converted statement end *//* dmap converted statement start */
perform dbms_output.put_line( concat('V_MAILS_TO FOR:', v_mails_to)) ;/* dmap converted statement end */
end if;/* dmap converted statement start */
exception
when others then
insert into xxmor_log_errores_tab(id_error, desc_error, archivo_error, metodo_error)
values (nextval('xxmor_log_error_sq'),  concat('No pudo enviarse la notificacion a el siguiente destinatario:', v_temp, '  ') , null,  concat('procedure XXMOR_HTML_EMAIL_PR subject: ', p_subject, ',...) ')) ;/* dmap converted statement end */
end;
end loop;
v_mails_to := oracle.substr(v_mails_to,1,length(v_mails_to)-1);/* dmap converted statement start */
perform dbms_output.put_line( concat('V_MAILS_TO:', v_mails_to)) ;/* dmap converted statement end *//* dmap converted statement start */
l_temp :=  concat(l_temp, 'MIME-Version: 1.0' , chr(13) , chr(10)) ;/* dmap converted statement end *//* dmap converted statement start */
l_temp :=  concat(l_temp, 'To: ' , p_mails_notificar , chr(13) , chr(10)) ;/* dmap converted statement end *//* dmap converted statement start */
l_temp :=  concat(l_temp, 'From: Servicio OrdUni' , v_from , chr(13) , chr(10)) ;/* dmap converted statement end *//* dmap converted statement start */
l_temp :=  concat(l_temp, 'Subject: ' , p_subject , chr(13) , chr(10)) ;/* dmap converted statement end *//* dmap converted statement start */
l_temp :=  concat(l_temp, 'Reply-To: ' , v_from , chr(13) , chr(10)) ;/* dmap converted statement end *//* dmap converted statement start */
l_temp :=  concat(l_temp, 'Content-Type: multipart/alternative; boundary=' , chr(34) , l_boundary , chr(34) , chr(13) , chr(10)) ;/* dmap converted statement end *//* dmap converted statement start */
----------------------------------------------------
-- write the headers
call dmap_extension.dmap_dbms_lob_createtemporary( l_body_html, false, 10 );/* dmap converted statement end */
dbms_lob.write(l_body_html,length(l_temp),1,l_temp);/* dmap converted statement start */
----------------------------------------------------
-- write the text boundary
l_offset := dmap_extension.dmap_dbms_lob_getlength(l_body_html) + 1;/* dmap converted statement end *//* dmap converted statement start */
l_temp   :=  concat('--', l_boundary , chr(13), chr(10)) ;/* dmap converted statement end *//* dmap converted statement start */
l_temp   :=  concat(l_temp, 'content-type: text/plain; charset=us-ascii' , chr(13) , chr(10) , chr(13) , chr(10)) ;/* dmap converted statement end */
dbms_lob.write(l_body_html,length(l_temp),l_offset,l_temp);/* dmap converted statement start */
----------------------------------------------------
-- este cacho es para enviar un mail en forma de texto pero no se usa aqui
-- l_offset := select dmap_extension.dmap_dbms_lob_getlength(l_body_html) + 1;
-- dbms_lob.write(l_body_html,length(p_text),l_offset,p_text);
----------------------------------------------------
-- write the html boundary
l_temp   := concat( chr(13), chr(10), chr(13), chr(10), '--' , l_boundary , chr(13) , chr(10)) ;/* dmap converted statement end *//* dmap converted statement start */
l_temp   :=  concat(l_temp, 'content-type: text/html;' , chr(13) , chr(10) , chr(13) , chr(10)) ;/* dmap converted statement end *//* dmap converted statement start */
l_offset := dmap_extension.dmap_dbms_lob_getlength(l_body_html) + 1;/* dmap converted statement end */
dbms_lob.write(l_body_html,length(l_temp),l_offset,l_temp);/* dmap converted statement start */
----------------------------------------------------
-- write the html portion of the message
for i in 0 .. floor(dmap_extension.dmap_dbms_lob_getlength(p_html) / v_buffer_size) loop
call dmap_extension.dmap_dbms_lob_read(p_html, v_buffer_next, i * v_buffer_size + 1, v_body_buffer);/* dmap converted statement end *//* dmap converted statement start */
l_offset := dmap_extension.dmap_dbms_lob_getlength(l_body_html) + 1;/* dmap converted statement end */
dbms_lob.write(l_body_html,length(v_body_buffer),l_offset,v_body_buffer);
end loop;
--dbms_output.put_line(v_body_buffer);
dbms_lob.write(l_body_html,length(v_body_buffer),l_offset,v_body_buffer);/* dmap converted statement start */
----------------------------------------------------
-- write the final html boundary
l_temp   := concat( chr(13), chr(10) , '--' , l_boundary , '--' , chr(13)) ;/* dmap converted statement end *//* dmap converted statement start */
l_offset := dmap_extension.dmap_dbms_lob_getlength(l_body_html) + 1;/* dmap converted statement end */
dbms_lob.write(l_body_html,length(l_temp),l_offset,l_temp);
----------------------------------------------------
-- send the email in 1900 byte chunks to utl_smtp
l_offset  := 1;
l_ammount := 1900;
begin
utl_smtp.open_data(l_connection);/* dmap converted statement start */
while l_offset < dmap_extension.dmap_dbms_lob_getlength(l_body_html) loop
utl_smtp.write_data(l_connection,
oracle.substr(l_body_html, l_offset, l_ammount));/* dmap converted statement end */
l_offset  := l_offset + l_ammount;/* dmap converted statement start */
l_ammount := oracle.least(1900,dmap_extension.dmap_dbms_lob_getlength(l_body_html) - l_ammount);/* dmap converted statement end */
end loop;
utl_smtp.close_data(l_connection);/* dmap converted statement start */
--utl_smtp.quit( l_connection );
call dmap_extension.dmap_dbms_lob_freetemporary(l_body_html);/* dmap converted statement end */
exception
when others then
utl_smtp.\quit(l_connection);
end;
utl_smtp.\quit(l_connection);
perform dbms_output.put_line('Correo Enviado');
end if;
else
perform dbms_output.put_line('No Es Posible Enviar la Notificacion: Revise la Configuracion en Paramentros Generales del Servidor y Puerto para el Envio de Correos');
insert into xxmor_log_errores_tab(
id_error,
desc_error,
archivo_error,
metodo_error,
hora_error
)
values (
nextval('xxmor_log_error_sq'),
'No Es Posible Enviar la Notificacion: Revise la Configuracion en Paramentros Generales del Servidor y Puerto para el Envio de Correos',
null,
'Procedimiento XXMOR_HTML_EMAIL_PR',
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
'Procedimiento XXMOR_HTML_EMAIL_PR'
);/* dmap converted statement end */end;
$body$
language plpgsql
;
