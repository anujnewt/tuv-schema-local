create or replace  function  xxmor.xxmor_funcional_pkg_xxmor_notificacion_fun ( p_id_solicitud numeric, p_lineas varchar, p_advid varchar, p_accthdrid varchar, p_mcontid varchar, p_rtcrddscr varchar, p_email varchar, p_comentarios varchar, p_orden_estatus numeric, p_email_to varchar ) returns integer as $body$
declare
-- pgv moved types start
-- pgv moved types end
p_solicitud xxmor_funcional_pkg_xxmor_funcional_pkg_mor_enc_rec_type;
--dmap conversion comment: global temp variables moved as local temp variables
glo_document_temp text;
--dmap conversion comment: declaration boundary ends
begin
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('XXMOR', 'XXMOR_FUNCIONAL_PKG');
--dmap conversion comment: gtt declaration added
p_solicitud.id_solicitud  := p_id_solicitud;
p_solicitud.advid         := p_advid;
p_solicitud.accthdrid     := p_accthdrid;
p_solicitud.mcontid       := p_mcontid;
p_solicitud.rtcrddscr     := p_rtcrddscr;
p_solicitud.email         := p_email;
p_solicitud.comentarios   := p_comentarios;
p_solicitud.orden_estatus := p_orden_estatus;
--p_solicitud.email_to      := p_email_to;
call xxmor_funcional_pkg_xxmor_sol_notificacion_pr( p_solicitud );
return 0;
/*exception
when others then
insert into xxmor_log_errores_tab(id_error, desc_error, archivo_error, metodo_error)
values(xxmor_log_error_sq.nextval, no pudo enviarse la notificacion, null, procedure call xxmor_funcional_pkg_xxmor_html_email_pr (to:||p_email||, subject:  ,...) );*/
end;
$body$
language plpgsql
;
