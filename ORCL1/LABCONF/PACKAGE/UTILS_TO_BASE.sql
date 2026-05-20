create or replace  function  labconf.utils_to_base (p_dec numeric, p_base numeric) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_str varchar(255);
v_num numeric;
v_hex varchar(16) := '0123456789ABCDEF';
--dmap conversion comment: global temp variables moved as local temp variables
default_char_size_temp numeric;
trancount_temp numeric;
--dmap conversion comment: declaration boundary ends
begin 

call labconf.utils_dmap_test_onetime_block_init();
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('LABCONF', 'UTILS');
--dmap conversion comment: gtt declaration added
v_num := p_dec;
if nullif(p_dec::text, '') is null or nullif(p_base::text, '') is null then
return null;
end if;
if trunc(p_dec) <> p_dec or p_dec < 0 then
raise program_error;
end if;/* dmap converted statement start */
loop
v_str := oracle. concat(substr(v_hex, mod(v_num, p_base) + 1, 1), v_str) ;/* dmap converted statement end */
v_num := trunc(v_num / p_base);
exit when v_num = 0;
end loop;
return v_str;
exception
when others then
raise exception '%', dbms_utility.format_error_stack using errcode = '45000';end;
$body$
language plpgsql
;
