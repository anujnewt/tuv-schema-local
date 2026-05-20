create or replace procedure xxmor.xxmor_funcional_pkg_xxmor_env_notificacion_pr ( p_solicitud xxmor_funcional_pkg_xxmor_funcional_pkg_mor_enc_rec_type ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_solicitud      xxmor_funcional_pkg_xxmor_funcional_pkg_mor_enc_rec_type;
v_jobn           integer;
v_part1          varchar(3000);
v_part2          varchar(3000);
v_aux            varchar(3000);
v_mail_estatus   varchar(100);
v_mail_int       integer;
v_mail_ext       integer;
v_mail_fac       integer;
v_lista_mails    varchar(3000);
v_nombre_archivo varchar(300);
mails_usrs_cur cursor for
select id_user,
administrador
from   xxmor_fzas_vtas_usuarios_tab
where  id_seg_neg    = 1
and    id_fza_ventas = p_solicitud.id_fza_ventas
and    administrador = 1;with recursive cte as (
mails_factur_cur is cursor
with value_list as (select mails_factur||',' as val from xxmor_sol_factur_mails_tab where id_solicitud = p_solicitud.id_solicitud)
select oracle.substr(val, (case when 1=1 then  0  else instr(val, ',', 1, level -1) end  + 1),
(case when instr(val, ',', 1, level) -1=-1 then  length(val)  else instr(val, ',', 1, level) -1 end )
-(case when level=1 then  0  else instr(val, ',', 1, level -1) end  + 1) + 1) correo
from value_list level <=(select (length(val) -length(replace(val, ',', null)))
from value_list) alias14  union all
mails_factur_cur is cursor
with value_list as (select mails_factur||',' as val from xxmor_sol_factur_mails_tab where id_solicitud = p_solicitud.id_solicitud)
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
perform dbms_output.put_line('ENTRA -->XXMOR_ENV_NOTIFICACION_PR');
begin
select coalesce(usuario_interno,0),
coalesce(usuario_agencia,0),
coalesce(usuario_factur,0)
into strict   v_mail_int,
v_mail_ext,
v_mail_fac
from   xxmor_conf_notific_tab
where  id_seg_neg      = 1
and    id_fza_ventas   = p_solicitud.id_fza_ventas
and    id_notificacion = p_solicitud.orden_estatus;
exception
when no_data_found then
v_mail_int := 0;
v_mail_ext := 0;
v_mail_fac := 0;
end;
select a.nom_archivo_sol
into strict   v_nombre_archivo
from   xxmor_solicitudes_arch_tab a,
xxmor_solicitudes_enc_tab e,
xxmor_solicitudes_orig_enc_tab eo
where  e.id_solicitud    = p_solicitud.id_solicitud
and    e.id_request      = eo.id_request
and    eo.id_archivo_sol = a.id_archivo_sol
and    e.id_seg_neg      = 1
and    e.id_seg_neg      = a.id_seg_neg;/* dmap converted statement start */
select  concat('Orden ', p_solicitud.id_solicitud, '(', v_nombre_archivo, ') ', desc_notificacion
) into strict   v_mail_estatus
from   xxmor.xxmor_ordenes_estatus_tab
where  id_notificacion = p_solicitud.orden_estatus
and    id_seg_neg      = 1;/* dmap converted statement end *//* dmap converted statement start */
v_part1 :=  concat('declare
v_solicitud xxmor_funcional_pkg_xxmor_funcional_pkg_mor_enc_rec_type;
begin
v_solicitud.id_solicitud  := ', P_SOLICITUD.ID_SOLICITUD , ';
v_solicitud.advid         := ''', p_solicitud.advid , ''';
v_solicitud.accthdrid     := ''', p_solicitud.accthdrid , ''';
v_solicitud.mcontid       := ''', p_solicitud.mcontid , ''';
v_solicitud.rtcrddscr     := ''', p_solicitud.rtcrddscr , ''';
v_solicitud.comentarios   := ''', p_solicitud.comentarios , ''';
v_solicitud.orden_estatus := ' , P_SOLICITUD.ORDEN_ESTATUS , ';
v_solicitud.email         := ''') ;/* dmap converted statement end */
v_part2 := ''';
begin
--   xxmor_funcional_pkg_xxmor_sol_notificacion_pr( v_solicitud );
end;
/* commit; */
end; ';
v_lista_mails   := 'begin
call xxmor_funcional_pkg_xxmor_html_email_pr (''';/* dmap converted statement start */
--dbms_output.put_line(v_part1||marodriguezg__televisa.com.mx||v_part2);
--
if v_mail_int = 1 then
for destinatarios in mails_usrs_cur loop
v_aux :=  concat(v_part1, destinatarios.id_user , '__televisa.com.mx' , v_part2) ;/* dmap converted statement end *//* dmap converted statement start */
--dbms_output.put_line(v_aux);
--sys.dbms_job.submit(v_jobn,  v_aux);
v_aux :=  concat(v_part1, p_solicitud.created_by , '__televisa.com.mx' , v_part2) ;/* dmap converted statement end *//* dmap converted statement start */
v_lista_mails:=  concat(v_lista_mails, destinatarios.id_user , '__televisa.com.mx,') ;/* dmap converted statement end */
--dbms_output.put_line(v_aux);
--sys.dbms_job.submit(v_jobn,  v_aux);
end loop;/* dmap converted statement start */
if nullif(p_solicitud.created_by::text, '') is not null then
v_lista_mails:=  concat(v_lista_mails, p_solicitud.created_by , '__televisa.com.mx,') ;/* dmap converted statement end */
end if;
end if;/* dmap converted statement start */
--mail externo
if v_mail_ext = 1 and position('__' in p_solicitud.email) > 0 then
v_aux :=  concat(v_part1, trim(both lower(p_solicitud.email)) , v_part2) ;/* dmap converted statement end *//* dmap converted statement start */
--dbms_output.put_line(v_aux);
v_lista_mails:=  concat(v_lista_mails, trim(both lower(p_solicitud.email)), ',') ;/* dmap converted statement end */
--sys.dbms_job.submit(v_jobn,  v_aux);
end if;/* dmap converted statement start */
--mail factur
if v_mail_fac = 1 then
for destinatarios in mails_factur_cur loop
v_aux :=  concat(v_part1, destinatarios.correo, v_part2) ;/* dmap converted statement end */
perform dbms_output.put_line( destinatarios.correo);/* dmap converted statement start */
--sys.dbms_job.submit(v_jobn,  v_aux);
--dbms_output.put_line(v_aux);
--sys.dbms_job.submit(v_jobn,  v_aux);
if position(destinatarios.correo in v_lista_mails) = 0 then
v_lista_mails :=  concat(v_lista_mails, destinatarios.correo, ',') ;/* dmap converted statement end */
end if;
end loop;
end if;/* dmap converted statement start */
--si no se identifico fza de ventas enviar al administrador del sistema
if p_solicitud.id_fza_ventas = 0 then
select  concat(v_part1, trim(both valor_parametro), v_part2
) into strict   v_aux
from   xxmor_conf_params_grls_tab
where  nombre_parametro = 'SysAdmin';/* dmap converted statement end *//* dmap converted statement start */
select  concat(v_lista_mails, trim(both valor_parametro)
) into strict   v_lista_mails
from   xxmor_conf_params_grls_tab
where  nombre_parametro = 'SysAdmin'
and    position(valor_parametro in v_lista_mails) = 0;/* dmap converted statement end */
--sys.dbms_job.submit(v_jobn,  v_aux);
end if;/* dmap converted statement start */
v_lista_mails :=  concat(v_lista_mails, ''',''', v_mail_estatus , ''',null,xxmor_funcional_pkg_xxmor_html_mail(', P_SOLICITUD.ID_SOLICITUD , ', null, 10)); end;') ;/* dmap converted statement end */
dbms_job.submit(v_jobn,  v_lista_mails);/* dmap converted statement start */
perform dbms_output.put_line( concat('V_LISTA_MAILS: ', trim(both v_lista_mails))) ;/* dmap converted statement end */
perform dbms_output.put_line('SALE -->XXMOR_ENV_NOTIFICACION_PR');end;
$body$
language plpgsql
;
create or replace procedure xxmor.xxmor_funcional_pkg_xxmor_env_notificacion_pr ( p_id_solicitud integer, p_lineas varchar, p_id_notificacion varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_solicitud     xxmor_funcional_pkg_xxmor_funcional_pkg_mor_enc_rec_type;
v_created_by    varchar(100);
v_email         varchar(100);
v_id_fza_ventas integer;
v_tracking_id   integer;
--dmap conversion comment: global temp variables moved as local temp variables
glo_document_temp text;
--dmap conversion comment: declaration boundary ends
begin
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('XXMOR', 'XXMOR_FUNCIONAL_PKG');
--dmap conversion comment: gtt declaration added
perform dbms_output.put_line('ENTRA XXMOR_ENV_NOTIFICACION_PR2');
select created_by,
email,
id_fza_ventas
into strict   v_created_by,
v_email,
v_id_fza_ventas
from   xxmor_solicitudes_enc_tab
where  id_solicitud = p_id_solicitud;
v_solicitud.id_solicitud  := p_id_solicitud;
v_solicitud.orden_estatus := p_id_notificacion;
v_solicitud.created_by    := v_created_by;
v_solicitud.email         := v_email;
v_solicitud.id_fza_ventas := v_id_fza_ventas;
call xxmor_funcional_pkg_xxmor_env_notificacion_pr( v_solicitud );
perform dbms_output.put_line('SALE XXMOR_ENV_NOTIFICACION_PR2');end;
$body$
language plpgsql
;
