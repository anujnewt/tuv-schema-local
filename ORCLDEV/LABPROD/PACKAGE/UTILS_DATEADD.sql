create or replace  function  labprod.utils_dateadd (p_interval varchar, p_interval_val numeric, p_date_str varchar) returns ts as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_ts ts;
--dmap conversion comment: global temp variables moved as local temp variables
default_char_size_temp numeric;
trancount_temp numeric;
--dmap conversion comment: declaration boundary ends
begin 

call labprod.utils_dmap_test_onetime_block_init();
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('LABPROD', 'UTILS');
--dmap conversion comment: gtt declaration added
v_ts := utils_convert_string_to_timestamp(p_date_str);
return utils_dateadd_(p_interval, p_interval_val, v_ts);
exception
when others then
raise exception '%', dbms_utility.format_error_stack using errcode = '45000';end;
$body$
language plpgsql
;
create or replace  function  labprod.utils_dateadd (p_interval varchar, p_interval_val numeric, p_date_str varchar) returns ts as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_ts ts;
--dmap conversion comment: global temp variables moved as local temp variables
default_char_size_temp numeric;
trancount_temp numeric;
--dmap conversion comment: declaration boundary ends
begin 

call labprod.utils_dmap_test_onetime_block_init();
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('LABPROD', 'UTILS');
--dmap conversion comment: gtt declaration added
v_ts := utils_convert_string_to_timestamp(p_date_str);
return utils_dateadd_(p_interval, p_interval_val, v_ts);
exception
when others then
raise exception '%', dbms_utility.format_error_stack using errcode = '45000';end;
$body$
language plpgsql
;
create or replace  function  labprod.utils_dateadd (p_interval varchar, p_interval_val numeric, p_date_str varchar) returns ts as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_ts ts;
--dmap conversion comment: global temp variables moved as local temp variables
default_char_size_temp numeric;
trancount_temp numeric;
--dmap conversion comment: declaration boundary ends
begin 

call labprod.utils_dmap_test_onetime_block_init();
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('LABPROD', 'UTILS');
--dmap conversion comment: gtt declaration added
v_ts := utils_convert_string_to_timestamp(p_date_str);
return utils_dateadd_(p_interval, p_interval_val, v_ts);
exception
when others then
raise exception '%', dbms_utility.format_error_stack using errcode = '45000';end;
$body$
language plpgsql
;
create or replace  function  labprod.utils_dateadd (p_interval varchar, p_interval_val numeric, p_date_str varchar) returns ts as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_ts ts;
--dmap conversion comment: global temp variables moved as local temp variables
default_char_size_temp numeric;
trancount_temp numeric;
--dmap conversion comment: declaration boundary ends
begin 

call labprod.utils_dmap_test_onetime_block_init();
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('LABPROD', 'UTILS');
--dmap conversion comment: gtt declaration added
v_ts := utils_convert_string_to_timestamp(p_date_str);
return utils_dateadd_(p_interval, p_interval_val, v_ts);
exception
when others then
raise exception '%', dbms_utility.format_error_stack using errcode = '45000';end;
$body$
language plpgsql
;
