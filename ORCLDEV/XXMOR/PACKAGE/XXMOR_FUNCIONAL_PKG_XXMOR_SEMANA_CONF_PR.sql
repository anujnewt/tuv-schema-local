create or replace procedure xxmor.xxmor_funcional_pkg_xxmor_semana_conf_pr ( p_ident_fza_ventas varchar, p_dia_inicio varchar, p_hora_inicio varchar, p_dia_fin varchar, p_hora_fin varchar, o_actualiza inout integer ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_se_actualiza  integer;
v_id_fza_vtas   integer;
--dmap conversion comment: global temp variables moved as local temp variables
glo_document_temp text;
--dmap conversion comment: declaration boundary ends
begin
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('XXMOR', 'XXMOR_FUNCIONAL_PKG');
--dmap conversion comment: gtt declaration added
select id_fza_ventas
into strict   v_id_fza_vtas
from   xxmor_fzas_vtas_tab fv
where  fv.ident_fza_ventas = p_ident_fza_ventas;
update xxmor_concom_rpta_tab r
set    estatus_orduni = '20',
updated_date   = clock_timestamp(),
updated_by     = 'SEMANA_CONF_PR'
where  position(upper('RETENCION') in upper(accion_concom)) > 0
and    r.estatus_orduni = '10'
and    exists (select 1
from   xxmor_solicitudes_enc_tab e
where  r.id_solicitud  = e.id_solicitud
and    e.id_fza_ventas = v_id_fza_vtas
);end;
$body$
language plpgsql
;
