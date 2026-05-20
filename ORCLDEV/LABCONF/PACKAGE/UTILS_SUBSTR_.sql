create or replace  function  labconf.utils_substr_ (p_expr varchar,p_precision numeric default null) returns char as $body$
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
default_char_size_temp := dmap_extension.f_dmap_get_pkg_var('LABCONF' , 'UTILS', 'DEFAULT_CHAR_SIZE', 'NUMBER', 'Y')::numeric;
--dmap conversion comment: gtt declaration added
if nullif(p_precision::text, '') is null then
return oracle.substr(p_expr, 1, default_char_size_temp);
call dmap_extension.p_dmap_set_pkg_var('LABCONF' , 'UTILS', 'DEFAULT_CHAR_SIZE', 'NUMBER',(default_char_size_temp)::text, 'Y');
else
return oracle.substr(p_expr,1,p_precision);
end if;end;
$body$
language plpgsql
;
