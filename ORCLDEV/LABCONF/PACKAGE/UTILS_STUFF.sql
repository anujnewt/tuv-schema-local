create or replace  function  labconf.utils_stuff (p_expr varchar, p_startidx numeric, p_len numeric, p_replace_expr varchar) returns varchar as $body$
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
return replace(p_expr, oracle.substr(p_expr, p_startidx, p_len), p_replace_expr);
exception
when others then
raise exception '%', dbms_utility.format_error_stack using errcode = '45000';end;
$body$
language plpgsql
;
