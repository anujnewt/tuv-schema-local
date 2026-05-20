create or replace procedure xxmor.xxmor_funcional_pkg_xxmor_env_mail_or_mc_pr ( p_id_request integer, p_id_estatus integer ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
sol_mcontid_mal_cur cursor for
select id_solicitud
from   xxmor_solicitudes_enc_tab e
where  e.id_seg_neg         = 1
--and    instr(e.mcontid,.) = 0
and    exists (select 1
from   xxmor_solicitudes_orig_enc_tab oe
where  e.id_request = oe.id_request
and    oe.aux1      = p_id_request
);
v_solicitud       xxmor_funcional_pkg_xxmor_funcional_pkg_mor_enc_rec_type;
v_created_by      varchar(100);
v_email           varchar(100);
v_id_fza_ventas   integer;
v_tracking_id     integer;
v_mcontid         varchar(30);
--dmap conversion comment: global temp variables moved as local temp variables
glo_document_temp text;
--dmap conversion comment: declaration boundary ends
begin
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('XXMOR', 'XXMOR_FUNCIONAL_PKG');/* dmap converted statement start */
--dmap conversion comment: gtt declaration added
for c_ord_mal in sol_mcontid_mal_cur loop
perform dbms_output.put_line( concat('hola_rec_type id_sol: ', c_ord_mal.id_solicitud)) ;/* dmap converted statement end */
select created_by, email, id_fza_ventas, mcontid
into strict  v_created_by, v_email, v_id_fza_ventas, v_mcontid
from xxmor_solicitudes_enc_tab
where id_solicitud = c_ord_mal.id_solicitud;
v_solicitud.id_solicitud   := c_ord_mal.id_solicitud;
v_solicitud.orden_estatus  := p_id_estatus;
v_solicitud.created_by     := v_created_by;
v_solicitud.email          := v_email;
v_solicitud.id_fza_ventas  := v_id_fza_ventas;
if p_id_estatus = 5000 then
v_solicitud.orden_estatus  := 46;
call xxmor_funcional_pkg_xxmor_env_notificacion_pr( v_solicitud );
else
call xxmor_funcional_pkg_xxmor_env_notificacion_st_pr(c_ord_mal.id_solicitud, null, p_id_estatus);
end if;
--no se obtuvo fuerza de ventas
if nullif(v_id_fza_ventas::text, '') is null then
v_solicitud.orden_estatus  := 25;
call xxmor_funcional_pkg_xxmor_env_notificacion_pr( v_solicitud );
end if;
-- no tiene master contract
if nullif(v_mcontid::text, '') is null then
v_solicitud.orden_estatus  := 46;
call xxmor_funcional_pkg_xxmor_env_notificacion_pr( v_solicitud );
end if;
perform dbms_output.put_line(v_solicitud.email);
end loop;
perform dbms_output.put_line('bye bye');end;
$body$
language plpgsql
;
