create or replace  function  labprod.utils_round_ (p_expr numeric, p_len numeric, p_function numeric default 0) returns numeric as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_ret_value numeric;
--dmap conversion comment: global temp variables moved as local temp variables
default_char_size_temp numeric;
trancount_temp numeric;
--dmap conversion comment: declaration boundary ends
begin 

call labprod.utils_dmap_test_onetime_block_init();
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('LABPROD', 'UTILS');
--dmap conversion comment: gtt declaration added
if p_function = 0 then
v_ret_value := round(p_expr::numeric, p_len);
else
v_ret_value := trunc(p_expr, p_len);
end if;
return v_ret_value;
exception
when others then
raise exception '%', dbms_utility.format_error_stack using errcode = '45000';end;
$body$
language plpgsql
;
