create or replace procedure xxmor.xxmor_funcional_pkg_xxmor_guarda_archivo_ord_pr ( p_nom_archivo varchar, p_archivo bytea, p_created_by varchar, o_id_archivo_sol inout integer, o_nom_arch_existe inout integer ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_id_archivo_sol        integer;
v_archivo_procesado     integer;
v_from                  varchar(80) := 'servicio_orduni__televisa.com.mx';
v_recipient             varchar(80);
v_subject               varchar(80) := 'El nombre del archivo ya existe';
lst_mail_host           varchar(30) := '10.7.4.218';
lin_mail_puerto         numeric       := 25;
v_body                  varchar(2000);
crlf                    varchar(2)  := chr(13)||chr(10);
v_mail_conn             utl_smtp.connection;
lst_error               varchar(2000);
--dmap conversion comment: global temp variables moved as local temp variables
glo_document_temp text;
--dmap conversion comment: declaration boundary ends
begin
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('XXMOR', 'XXMOR_FUNCIONAL_PKG');
--dmap conversion comment: gtt declaration added
select count(1)
into strict   o_nom_arch_existe
from   xxmor_solicitudes_arch_tab
where  nom_archivo_sol = p_nom_archivo
and    id_seg_neg      = 1;
if o_nom_arch_existe > 0 then
v_archivo_procesado := 0;
--sacamos el mail del administrador del sistemas
select valor_parametro
into strict   v_recipient
from   xxmor_conf_params_grls_tab
where  nombre_parametro = 'SysAdmin';
-- se obtien la direccion ip del smtp server
-- asi como el puerto.
select oracle.substr(valor_parametro,1,(position(':' in valor_parametro)-1)) servidor,
oracle.substr(valor_parametro,(position(':' in valor_parametro)+1))   puerto
into strict   lst_mail_host,
lin_mail_puerto
from   xxmor_conf_params_grls_tab
where  upper(nombre_parametro) = 'SMTP_SERVER';/* dmap converted statement start */
v_subject:=  concat(v_subject, ' (', p_nom_archivo , ')') ;/* dmap converted statement end *//* dmap converted statement start */
v_body := concat('El archivo del servidor FTP: ', p_nom_archivo, ' ya existe en la base de datos de orduni2 (', o_nom_arch_existe , ' veces) ') ;/* dmap converted statement end */
--v_body := v_body || el archivo se ha guardado con el id: ||v_id_archivo_sol|| en la tabla xxmor_solicitudes_arch_tab ;
begin
v_mail_conn := utl_smtp.open_connection(lst_mail_host, lin_mail_puerto);
utl_smtp.helo(v_mail_conn, lst_mail_host);
utl_smtp.mail(v_mail_conn, v_from);
utl_smtp.rcpt(v_mail_conn, v_recipient);/* dmap converted statement start */
utl_smtp.data(v_mail_conn,
concat('Date: ', to_char(clock_timestamp(), 'Dy, DD Mon YYYY hh24:mi:ss') , crlf , 'From: ' , v_from , crlf , 'Subject: ', v_subject , crlf , 'To: ' , v_recipient , crlf , crlf , v_body , crlf , ' ')  -- message body
--more message text|| crlf
);/* dmap converted statement end */
utl_smtp.\quit(v_mail_conn);
exception
-- when utl_smtp.transient_error or utl_smtp.permanent_error then
-- raise_application_error(-20000, unable to send mail: ||sqlerrm);
when others then
null;
end;
else
select nextval('xxmor_arch_sol_id_sq')
into strict   v_id_archivo_sol
;
v_archivo_procesado := 1;
insert into xxmor_solicitudes_arch_tab(
id_seg_neg,
id_archivo_sol,
archivo_sol,
nom_archivo_sol,
archivo_procesado,
envio_ws,
created_date,
created_by
)
values (
1,
v_id_archivo_sol,
p_archivo,
p_nom_archivo,
v_archivo_procesado,
1,
clock_timestamp(),
p_created_by
);
end if;
o_id_archivo_sol := v_id_archivo_sol;
exception
when others then
lst_error := sqlerrm;
-- se inserta en la tabla de errores el error encontrado
insert into xxmor_log_errores_tab(
id_error,
desc_error,
archivo_error,
metodo_error,
hora_error
)
values (       nextval('xxmor.xxmor_log_error_sq'),
lst_error,
'XXMOR_FUNCIONAL_PKG',
'XXMOR_GUARDA_ARCHIVO_ORD_PR',
clock_timestamp()
);end;
$body$
language plpgsql
;
