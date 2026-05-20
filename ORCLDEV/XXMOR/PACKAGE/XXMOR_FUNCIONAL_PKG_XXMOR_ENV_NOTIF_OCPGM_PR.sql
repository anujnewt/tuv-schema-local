create or replace procedure xxmor.xxmor_funcional_pkg_xxmor_env_notif_ocpgm_pr ( p_id_solicitud integer ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_lineas_ord          integer;
v_lineas_insertadas   integer;
v_est_enc             integer;
v_solicitud           xxmor_funcional_pkg_xxmor_funcional_pkg_mor_enc_rec_type;
v_created_by          varchar(100);
v_email               varchar(100);
v_id_fza_ventas       integer;
v_tracking_id         integer;
--dmap conversion comment: global temp variables moved as local temp variables
glo_document_temp text;
--dmap conversion comment: declaration boundary ends
begin
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('XXMOR', 'XXMOR_FUNCIONAL_PKG');
--dmap conversion comment: gtt declaration added
select orden_estatus
into strict v_est_enc
from xxmor_solicitudes_enc_tab
where id_solicitud = p_id_solicitud;
select count(1)
into strict v_lineas_ord
from xxmor_solicitudes_det_tab
where id_solicitud = p_id_solicitud;
select count(1)
into strict v_lineas_insertadas
from xxmor_solicitudes_det_tab
where linea_estatus = 60
and   id_solicitud = p_id_solicitud;
if (v_lineas_insertadas = v_lineas_ord and v_lineas_insertadas != 0) then
select created_by, email, id_fza_ventas
into strict  v_created_by, v_email, v_id_fza_ventas
from xxmor_solicitudes_enc_tab
where id_solicitud = p_id_solicitud;
v_solicitud.id_solicitud  := p_id_solicitud;
v_solicitud.orden_estatus := 4;
v_solicitud.created_by    := v_created_by;
v_solicitud.email         := v_email;
v_solicitud.id_fza_ventas := v_id_fza_ventas;
-- xxmor_funcional_pkg_xxmor_env_notificacion_pr( v_solicitud );
end if;end;
$body$
language plpgsql
;
