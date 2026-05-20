create or replace  function  labconf.utils_quotename (p_str varchar, p_delimiters varchar default '[]') returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_ret_val varchar(150) := null;
--dmap conversion comment: global temp variables moved as local temp variables
default_char_size_temp numeric;
trancount_temp numeric;
--dmap conversion comment: declaration boundary ends
begin 

call labconf.utils_dmap_test_onetime_block_init();
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('LABCONF', 'UTILS');/* dmap converted statement start */
--dmap conversion comment: gtt declaration added
if p_delimiters = '[]' then
v_ret_val :=  concat('[', replace(p_str, ']', ']]') , ']') ;/* dmap converted statement end *//* dmap converted statement start */
elsif p_delimiters = '"' then
v_ret_val :=  concat('"', p_str , '"') ;/* dmap converted statement end *//* dmap converted statement start */
elsif p_delimiters = '''' then
v_ret_val :=  concat('''', p_str , '''') ;/* dmap converted statement end */
end if;
return v_ret_val;
exception
when others then
raise exception '%', dbms_utility.format_error_stack using errcode = '45000';end;
$body$
language plpgsql
;
