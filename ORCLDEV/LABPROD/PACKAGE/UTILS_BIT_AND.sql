create or replace  function  labprod.utils_bit_and (p_num1 numeric ,p_raw1 bytea) returns bytea as $body$
declare
-- pgv moved types start
-- pgv moved types end
--dmap conversion comment: global temp variables moved as local temp variables
default_char_size_temp numeric;
trancount_temp numeric;
--dmap conversion comment: declaration boundary ends
begin 

call labprod.utils_dmap_test_onetime_block_init();
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('LABPROD', 'UTILS');
--dmap conversion comment: gtt declaration added
return  utl_raw.bit_and(utl_raw.cast_from_number(p_num1),p_raw1);end;
$body$
language plpgsql
;
create or replace  function  labprod.utils_bit_and (p_num1 numeric ,p_raw1 bytea) returns bytea as $body$
declare
-- pgv moved types start
-- pgv moved types end
--dmap conversion comment: global temp variables moved as local temp variables
default_char_size_temp numeric;
trancount_temp numeric;
--dmap conversion comment: declaration boundary ends
begin 

call labprod.utils_dmap_test_onetime_block_init();
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('LABPROD', 'UTILS');
--dmap conversion comment: gtt declaration added
return  utl_raw.bit_and(utl_raw.cast_from_number(p_num1),p_raw1);end;
$body$
language plpgsql
;
create or replace  function  labprod.utils_bit_and (p_num1 numeric ,p_raw1 bytea) returns bytea as $body$
declare
-- pgv moved types start
-- pgv moved types end
--dmap conversion comment: global temp variables moved as local temp variables
default_char_size_temp numeric;
trancount_temp numeric;
--dmap conversion comment: declaration boundary ends
begin 

call labprod.utils_dmap_test_onetime_block_init();
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('LABPROD', 'UTILS');
--dmap conversion comment: gtt declaration added
return  utl_raw.bit_and(utl_raw.cast_from_number(p_num1),p_raw1);end;
$body$
language plpgsql
;
create or replace  function  labprod.utils_bit_and (p_num1 numeric ,p_raw1 bytea) returns bytea as $body$
declare
-- pgv moved types start
-- pgv moved types end
--dmap conversion comment: global temp variables moved as local temp variables
default_char_size_temp numeric;
trancount_temp numeric;
--dmap conversion comment: declaration boundary ends
begin 

call labprod.utils_dmap_test_onetime_block_init();
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('LABPROD', 'UTILS');
--dmap conversion comment: gtt declaration added
return  utl_raw.bit_and(utl_raw.cast_from_number(p_num1),p_raw1);end;
$body$
language plpgsql
;
