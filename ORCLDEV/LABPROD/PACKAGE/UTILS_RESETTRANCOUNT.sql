create or replace procedure labprod.utils_resettrancount () as $body$
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
call dmap_extension.p_dmap_set_pkg_var('LABPROD' , 'UTILS', 'TRANCOUNT', 'NUMBER',(0)::text, 'Y');end;
$body$
language plpgsql
;
