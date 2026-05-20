create or replace  function  labprod.utils_fetch_status (p_cursorfound boolean) returns numeric as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_fetch_status numeric := 0;
--dmap conversion comment: global temp variables moved as local temp variables
default_char_size_temp numeric;
trancount_temp numeric;
--dmap conversion comment: declaration boundary ends
begin 

call labprod.utils_dmap_test_onetime_block_init();
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('LABPROD', 'UTILS');
--dmap conversion comment: gtt declaration added
case
when p_cursorfound then
v_fetch_status := 0;
else
v_fetch_status := -1;
end case;
return v_fetch_status;
exception
when others then
raise exception '%', dbms_utility.format_error_stack using errcode = '45000';end;
$body$
language plpgsql
;
