create or replace  function  xxmor.xxmor_funcional_pkg_xxmor_es_sol_agr_mult_fun ( p_id_solicitud integer ) returns integer as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_conf_agr_mult    integer;
v_return           integer;
--dmap conversion comment: global temp variables moved as local temp variables
glo_document_temp text;
--dmap conversion comment: declaration boundary ends
begin
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('XXMOR', 'XXMOR_FUNCIONAL_PKG');
--dmap conversion comment: gtt declaration added
select count(agrupador_multiple) as agrupadormultiple
into strict   v_conf_agr_mult
from   xxmor_cat_agrupador_mult_tab
where  agrupador_multiple = (select agrupador
from   xxmor.xxmor_solicitudes_enc_tab
where id_solicitud = p_id_solicitud
);
if v_conf_agr_mult > 1 then
return 1;
else
return 0;
end if;end;
$body$
language plpgsql
;
