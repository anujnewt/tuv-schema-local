create or replace  function  xxmor.xxmor_funcional_pkg_xxmor_env_mail_or_mc_fun ( p_id_request integer ) returns integer as $body$
declare
-- pgv moved types start
-- pgv moved types end
sol_mcontid_mal_cur cursor for
select id_solicitud
from   xxmor_solicitudes_enc_tab
where  id_request         = p_id_request
and    id_seg_neg         = 1
and    position('.'  mcontid) = 0;
v_solicitud       xxmor_funcional_pkg_xxmor_funcional_pkg_mor_enc_rec_type;
v_created_by      varchar(100);
v_email           varchar(100);
v_id_fza_ventas   integer;
v_tracking_id     integer;
v_return          integer;
--dmap conversion comment: global temp variables moved as local temp variables
glo_document_temp text;
--dmap conversion comment: declaration boundary ends
begin
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('XXMOR', 'XXMOR_FUNCIONAL_PKG');
--dmap conversion comment: gtt declaration added
perform dbms_output.put_line('hola_rec_type');
for c_ord_mal in sol_mcontid_mal_cur loop
select created_by,
email,
id_fza_ventas
into strict   v_created_by,
v_email,
v_id_fza_ventas
from   xxmor_solicitudes_enc_tab
where  id_solicitud = c_ord_mal.id_solicitud;
v_solicitud.id_solicitud   := c_ord_mal.id_solicitud;
v_solicitud.orden_estatus  := 46;
v_solicitud.created_by     := v_created_by;
v_solicitud.email          := v_email;
v_solicitud.id_fza_ventas  := v_id_fza_ventas;
call xxmor_funcional_pkg_xxmor_env_notificacion_pr( v_solicitud );
perform dbms_output.put_line(v_solicitud.email);
--xxmor_funcional_pkg_xxmor_env_notificacion_pr(c_ord_mal.id_solicitud, null, 46);
--xxmor_funcional_pkg_xxmor_env_notificacion_pr(c_ord_mal.id_solicitud);
v_return := v_return + 1;
end loop;
return v_return;
perform dbms_output.put_line('bye bye');end;
$body$
language plpgsql
;
