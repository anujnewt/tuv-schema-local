create or replace  function  labconf.utils_oct (p_num varchar) returns varchar as $body$
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
return utils_to_base(p_num, 8);
exception
when others then
raise exception '%', dbms_utility.format_error_stack using errcode = '45000';end;
$body$
language plpgsql
;
