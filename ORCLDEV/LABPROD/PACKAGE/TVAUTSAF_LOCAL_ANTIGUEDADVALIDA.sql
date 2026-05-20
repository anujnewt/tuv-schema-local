create or replace  function  labprod.tvautsaf_local_antiguedadvalida (fecaux labprod.nmcoempl.emp_fecaux%type) returns integer as $body$
declare
-- pgv moved types start
-- pgv moved types end
--dmap conversion comment: global temp variables moved as local temp variables
total_temp integer;
banco_temp varchar;
bandera_temp integer;
nombre__temp varchar;
--dmap conversion comment: declaration boundary ends
begin 

call dmap_extension.pkg_var_dmap_tab_to_gtt_init('LABPROD', 'TVAUTSAF_LOCAL');
--dmap conversion comment: gtt declaration added
-- bandera
if fecaux < clock_timestamp() then
call dmap_extension.p_dmap_set_pkg_var('LABPROD' , 'TVAUTSAF_LOCAL', 'BANDERA', 'INTEGER',(1)::text, 'N');
else
call dmap_extension.p_dmap_set_pkg_var('LABPROD' , 'TVAUTSAF_LOCAL', 'BANDERA', 'INTEGER',(0)::text, 'N');
end if;
return dmap_extension.f_dmap_get_pkg_var('LABPROD' , 'TVAUTSAF_LOCAL', 'BANDERA', 'INTEGER', 'N')::integer;end;
$body$
language plpgsql
;
