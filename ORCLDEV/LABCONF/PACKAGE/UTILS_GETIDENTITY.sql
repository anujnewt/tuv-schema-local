create or replace  function  labconf.utils_getidentity () returns numeric as $body$
declare
-- pgv moved types start
-- pgv moved types end
--dmap conversion comment: global temp variables moved as local temp variables
default_char_size_temp numeric;
trancount_temp numeric;
--dmap conversion comment: declaration boundary ends
begin 

call labconf.utils_dmap_test_onetime_block_init();
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('LABCONF', 'UTILS');
--dmap conversion comment: gtt declaration added
return dmap_extension.f_dmap_get_pkg_var('LABCONF' , 'UTILS', 'IDENTITY_VALUE', 'NUMBER', 'Y')::numeric;end;
$body$
language plpgsql
;
