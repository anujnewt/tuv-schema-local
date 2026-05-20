create or replace  function  labconf.utils_isnumeric (p_expr varchar) returns numeric as $body$
declare
-- pgv moved types start
-- pgv moved types end
numeric_val numeric;
temp_str varchar(50);
--dmap conversion comment: global temp variables moved as local temp variables
default_char_size_temp numeric;
trancount_temp numeric;
--dmap conversion comment: declaration boundary ends
begin 

call labconf.utils_dmap_test_onetime_block_init();
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('LABCONF', 'UTILS');
--dmap conversion comment: gtt declaration added
temp_str := p_expr;
if oracle.substr(temp_str, 1, 1) = '$' then
temp_str := oracle.substr(temp_str, 2);
end if;
numeric_val := (temp_str)::numeric;
return 1;
exception
when others then
return 0;end;
$body$
language plpgsql
;
