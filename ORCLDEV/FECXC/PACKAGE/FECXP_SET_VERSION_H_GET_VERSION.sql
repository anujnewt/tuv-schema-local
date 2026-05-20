create or replace  function  fecxc.fecxp_set_version_h_get_version () returns integer as $body$
declare
-- pgv moved types start
-- pgv moved types end
--dmap conversion comment: global temp variables moved as local temp variables
g_version_id_temp integer;
--dmap conversion comment: declaration boundary ends
begin
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('FECXC', 'FECXP_SET_VERSION_H');
--dmap conversion comment: gtt declaration added
return dmap_extension.f_dmap_get_pkg_var('FECXC' , 'FECXP_SET_VERSION_H', 'G_VERSION_ID', 'INTEGER', 'N')::integer;end;
$body$
language plpgsql
;
