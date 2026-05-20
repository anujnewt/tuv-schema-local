create or replace  function  labprod.utils_commit_transaction_state () returns numeric as $body$
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
if dmap_extension.f_dmap_get_pkg_var('LABPROD' , 'UTILS', 'TRANCOUNT', 'NUMBER', 'Y')::numeric <= 1 then
/* commit; */
end if;
call utils_resettrancount();
return 1;
exception when others then
return 3;end;
$body$
language plpgsql
;
