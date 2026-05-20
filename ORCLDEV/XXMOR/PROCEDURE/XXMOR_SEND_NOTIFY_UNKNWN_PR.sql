create or replace procedure xxmor."xxmor_send_notify_unknwn_pr"  (p_id_solicitud integer, p_lineas varchar ) as $body$
/*===============================================================
file name :            xxmor_send_notify_unknwn_pr.sql
nombre del mdulo :    morduni
created date :         29-sep-2014
author(s) :            soin
short description :    este script crea el procedimiento
xxmor_send_notify_unknwn_pr
el cual envia correo de notificacion cuando
se presenta la mezcla de ordenes
procedures contains :
related documents :    tv-pro-ant-01.doc
===============================================================*/
declare
c_mails record;
-- pgv moved types start
--dmap moved type other package xxmor_funcional_pkg;
-- pgv moved types end
v_mail_int          integer;
v_mail_ext          integer;
v_mail_fac          integer;
v_lista_mails       varchar(3000);
v_lista_mails_mkt   varchar(3000);
v_nombre_archivo    varchar(300);
v_autorizaciones    integer;
v_rechazos          integer;
v_errores_lin       numeric;
v_solicitud         XXMOR_FUNCIONAL_PKG_MOR_ENC_REC_TYPE;
v_mail_subject      varchar(300);
liinstatushead      numeric;
--mails de buyunit-mercadotecnia
add_buyunt_mkt_cur  cursor(c_id_solicitud integer) for
select (case when nullif(mkt_director::text, '') is not null then mkt_director||', ' else ' ' end)||
(case when nullif(mkt_gerente::text, '') is not null then mkt_gerente||', ' else ' ' end)||
(case when nullif(mkt_coordinador::text, '') is not null then mkt_coordinador||', ' else ' ' end)||
(case when nullif(mkt_ejecutivo::text, '') is not null then mkt_ejecutivo||', ' else ' ' end) as mails
from   xxmor_cat_buyunit_mkt_tab bm
where  exists (select 1
from   xxmor_solicitudes_enc_tab e,
xxmor_solicitudes_det_tab d,
xxmor_fzas_vtas_tab fv
where  e.id_solicitud   = c_id_solicitud
and    e.id_solicitud   = d.id_solicitud
and    e.id_fza_ventas  = fv.id_fza_ventas
and    fv.mercadotecnia = 1 --la orden tiene que ser de una fza de vtas de mkt
and    e.id_fza_ventas  = bm.id_fza_ventas
and    coalesce(trim(both d.buyuntid),'SIN BUYUNIT') = coalesce(trim(both bm.buyuntid),'SIN BUYUNIT')
);
mails_usrs_cur cursor for
select id_user,
administrador
from   xxmor_fzas_vtas_usuarios_tab
where  id_seg_neg    = 1
and    id_fza_ventas = (select id_fza_ventas
from   xxmor_solicitudes_enc_tab
where  id_solicitud = p_id_solicitud
)
and    administrador = 1;
lineas_orden_cur cursor for
select linea
from   xxmor_solicitudes_det_tab
where  id_solicitud =  p_id_solicitud;
begin
-- jlbs - se obtiene el estatus de la orden en la que se ecnuentra
select coalesce(orden_estatus,0)
into strict liinstatushead
from xxmor_solicitudes_enc_tab
where id_solicitud = p_id_solicitud;
-- jlbs
for linea_orden in lineas_orden_cur loop
v_errores_lin := 0;
select count(1)
into strict   v_errores_lin
from   xxmor_concom_rpta_tab
where  id_solicitud             = p_id_solicitud
and    coalesce(numlinea_concom,'0') = to_char(linea_orden.linea)
and    upper(accion_concom)     = 'RECHAZO'
and    estatus_orduni           = '10';
if v_errores_lin > 0 then
-- para actualizar a estatus 20 las lineas que fueron rechazadas y que
-- aun siguen con estatus 10.
update xxmor_concom_rpta_tab cr
set    cr.estatus_orduni = 20,
cr.updated_by     = 'ORDUNI',
cr.updated_date   = clock_timestamp()
where cr.id_solicitud       = p_id_solicitud
and upper(cr.accion_concom) in ('REPROCESO','AUTORIZACION')
and numlinea_concom         = to_char(linea_orden.linea)
and estatus_orduni          = '10';
end if;
end loop;
--revisamos si tiene rechazos
select count(1)
into strict   v_rechazos
from   xxmor_concom_rpta_tab
where  id_solicitud         = p_id_solicitud
and    upper(accion_concom) = 'RECHAZO'
and    estatus_orduni       = '10';
--revisamos si tiene autorizaciones
select count(1)
into strict   v_autorizaciones
from   xxmor_concom_rpta_tab
where  id_solicitud         = p_id_solicitud
and    upper(accion_concom) = 'AUTORIZACION'
and    estatus_orduni       = '10';
select id_solicitud,
advid,
accthdrid,
mcontid,
rtcrddscr,
comentarios,
id_fza_ventas,
email,
created_by
into strict   v_solicitud.id_solicitud,
v_solicitud.advid,
v_solicitud.accthdrid,
v_solicitud.mcontid,
v_solicitud.rtcrddscr,
v_solicitud.comentarios,
v_solicitud.id_fza_ventas,
v_solicitud.email,
v_solicitud.created_by
from   xxmor_solicitudes_enc_tab
where  id_solicitud =  p_id_solicitud;
begin
-- jlbs enviar a usuarios se toma como 100
select coalesce(usuario_interno,0),
coalesce(usuario_agencia,0),
coalesce(usuario_factur,0)
into strict   v_mail_int,
v_mail_ext,
v_mail_fac
from   xxmor_conf_notific_tab
where  id_seg_neg      = 1
and    id_fza_ventas   = v_solicitud.id_fza_ventas
and    id_notificacion = 100;
-- jlbs
exception
when no_data_found then
v_mail_int := 0;
v_mail_ext := 0;
v_mail_fac := 0;
end;
select a.nom_archivo_sol
into strict   v_nombre_archivo
from   xxmor_solicitudes_arch_tab     a,
xxmor_solicitudes_enc_tab      e,
xxmor_solicitudes_orig_enc_tab eo
where  e.id_solicitud    = p_id_solicitud
and    e.id_request      = eo.id_request
and    eo.id_archivo_sol = a.id_archivo_sol
and    e.id_seg_neg      = 1
and    e.id_seg_neg      = a.id_seg_neg;/* dmap converted statement start */
-- jlbs - se toma como notificacion 100
select  concat('Orden ', p_id_solicitud , ' (', v_nombre_archivo, ') Error al actualizar, Verifique la orden'
) into strict   v_mail_subject
from   xxmor_ordenes_estatus_tab
where  id_notificacion = 100
and    id_seg_neg      = 1;/* dmap converted statement end */
-- fin jlbs
v_lista_mails := null;/* dmap converted statement start */
--mail interno
if v_mail_int = 1 then
for destinatarios in mails_usrs_cur loop
v_lista_mails :=  concat(v_lista_mails, destinatarios.id_user , '__televisa.com.mx,') ;/* dmap converted statement end */
end loop;/* dmap converted statement start */
v_lista_mails:=  concat(v_lista_mails, v_solicitud.created_by , '__televisa.com.mx,') ;/* dmap converted statement end *//* dmap converted statement start */
perform dbms_output.put_line(  concat('sale mail interno: ', v_lista_mails)) ;/* dmap converted statement end */
end if;
--mail externo
if v_mail_ext = 1 and position('__' in v_solicitud.email) > 0 then
perform dbms_output.put_line( 'entra a mail externo');/* dmap converted statement start */
v_lista_mails:=  concat(v_lista_mails, trim(both lower(v_solicitud.email)), ',') ;/* dmap converted statement end *//* dmap converted statement start */
perform dbms_output.put_line(  concat('sale mail externo: ', v_lista_mails)) ;/* dmap converted statement end */
end if;/* dmap converted statement start */
--mail factur
if v_mail_fac = 1 then
v_lista_mails :=  concat(v_lista_mails, xxmor_funcional_pkg_xxmor_get_mails_factur_fun(p_id_solicitud), ',') ;/* dmap converted statement end *//* dmap converted statement start */
perform dbms_output.put_line(  concat('sale mail factur: ', v_lista_mails)) ;/* dmap converted statement end */
end if;/* dmap converted statement start */
-- se envia la notificacion despues de validacion
if length(v_lista_mails) > 5 then
perform dbms_output.put_line(  concat('V_LISTA_MAILS: ', v_lista_mails , ' V_MAIL_SUBJECT: ', v_mail_subject)) ;/* dmap converted statement end */
call xxmor_funcional_pkg_xxmor_html_email_pr(v_lista_mails, v_mail_subject, null, xxmor_funcional_pkg_xxmor_html_mail(p_id_solicitud, null, 10)  );
end if;/* dmap converted statement start */
for c_mails in select * from add_buyunt_mkt_cur(p_id_solicitud) loop
v_lista_mails_mkt :=  concat(v_lista_mails_mkt, c_mails.mails) ;/* dmap converted statement end *//* dmap converted statement start */
perform dbms_output.put_line(  concat('C_MAILS.MAILS: ', c_mails.mails)) ;/* dmap converted statement end */
end loop;/* dmap converted statement start */
if length(v_lista_mails_mkt ) > 5 then
select  concat('Orden ', p_id_solicitud , ' (', v_nombre_archivo, ') ' , desc_notificacion
) into strict   v_mail_subject
from   xxmor_ordenes_estatus_tab
where  id_notificacion = 84
and    id_seg_neg      = 1;/* dmap converted statement end *//* dmap converted statement start */
perform dbms_output.put_line(  concat('V_LISTA_MAILS_MKT: ', v_lista_mails_mkt , ' V_MAIL_SUBJECT: ', v_mail_subject)) ;/* dmap converted statement end */
call xxmor_funcional_pkg_xxmor_html_email_pr(v_lista_mails_mkt, v_mail_subject, null, xxmor_funcional_pkg_xxmor_html_mail(p_id_solicitud, p_lineas, liinstatushead)  );
end if;end;
$body$
language plpgsql
;
