create or replace procedure labprod.tvcdesaf_desafiliar ( recurp nmcoempl.emp_recurp%type , keycon nmloconc.con_keycon%type, resultado inout numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
--dmap conversion comment: global temp variables moved as local temp variables
base_temp varchar;
--dmap conversion comment: declaration boundary ends
begin 

call dmap_extension.pkg_var_dmap_tab_to_gtt_init('LABPROD', 'TVCDESAF');
--dmap conversion comment: gtt declaration added
--busca el empleado en tvnomdes
call dmap_extension.p_dmap_set_pkg_var('LABPROD' , 'TVCDESAF', 'BASE', 'VARCHAR2',(labprod.fn_basedatos_curp(recurp))::text, 'N');
if dmap_extension.f_dmap_get_pkg_var('LABPROD' , 'TVCDESAF', 'BASE', 'VARCHAR2', 'N')::varchar = 'TVNOMINA' then
tvcdesaf_local.desafiliar(recurp, keycon, resultado);
/*
apsi 231017
else
tvcdesaf_local.desafiliar__rtelecom(recurp, keycon, resultado);
*/
end if;end;
$body$
language plpgsql
;
