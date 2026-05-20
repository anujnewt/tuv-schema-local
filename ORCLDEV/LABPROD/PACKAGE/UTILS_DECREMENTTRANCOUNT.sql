create or replace procedure labprod.utils_decrementtrancount () as $body$
declare
-- pgv moved types start
-- pgv moved types end
--dmap conversion comment: global temp variables moved as local temp variables
default_char_size_temp numeric;
trancount_temp numeric;
--dmap conversion comment: declaration boundary ends
begin 

call labprod.utils_dmap_test_onetime_block_init();
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('LABPROD', 'UTILS');
--dmap conversion comment: gtt declaration added
if dmap_extension.f_dmap_get_pkg_var('LABPROD' , 'UTILS', 'TRANCOUNT', 'NUMBER', 'Y')::numeric > 0 then
call dmap_extension.p_dmap_set_pkg_var('LABPROD' , 'UTILS', 'TRANCOUNT', 'NUMBER',(dmap_extension.f_dmap_get_pkg_var('LABPROD' , 'UTILS', 'TRANCOUNT', 'NUMBER', 'Y')::numeric - 1)::text, 'Y');
end if;end;
$body$
language plpgsql
;
