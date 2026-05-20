create or replace  function  labconf.utils_biginttohex (p_expr numeric) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
l_number numeric;
--dmap conversion comment: global temp variables moved as local temp variables
default_char_size_temp numeric;
trancount_temp numeric;
--dmap conversion comment: declaration boundary ends
begin 

call labconf.utils_dmap_test_onetime_block_init();
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('LABCONF', 'UTILS');
--dmap conversion comment: gtt declaration added
l_number       := p_expr;
if l_number    <= -2147483647 then
l_number     := -2147483647;
elsif l_number >= 2147483647 then
l_number     := 2147483647;
end if;
return rawtohex(utl_raw.cast_from_binary_integer(l_number));end;
$body$
language plpgsql
;
create or replace  function  labconf.utils_biginttohex (p_expr numeric) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
l_number numeric;
--dmap conversion comment: global temp variables moved as local temp variables
default_char_size_temp numeric;
trancount_temp numeric;
--dmap conversion comment: declaration boundary ends
begin 

call labconf.utils_dmap_test_onetime_block_init();
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('LABCONF', 'UTILS');
--dmap conversion comment: gtt declaration added
l_number       := p_expr;
if l_number    <= -2147483647 then
l_number     := -2147483647;
elsif l_number >= 2147483647 then
l_number     := 2147483647;
end if;
return rawtohex(utl_raw.cast_from_binary_integer(l_number));end;
$body$
language plpgsql
;
