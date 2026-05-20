create or replace  function  labconf.utils_bit_xor (p_raw1 bytea ,p_raw2 bytea) returns bytea as $body$
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
return  utl_raw.bit_xor(p_raw1,p_raw2);end;
$body$
language plpgsql
;
create or replace  function  labconf.utils_bit_xor (p_raw1 bytea ,p_raw2 bytea) returns bytea as $body$
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
return  utl_raw.bit_xor(p_raw1,p_raw2);end;
$body$
language plpgsql
;
