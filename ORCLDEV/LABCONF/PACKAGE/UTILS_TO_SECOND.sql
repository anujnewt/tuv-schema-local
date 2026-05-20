create or replace  function  labconf.utils_to_second (p_time varchar) returns numeric as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_hours numeric;
v_minutes numeric;
v_seconds numeric;
v_tot_seconds numeric;
--dmap conversion comment: global temp variables moved as local temp variables
default_char_size_temp numeric;
trancount_temp numeric;
--dmap conversion comment: declaration boundary ends
begin 

call labconf.utils_dmap_test_onetime_block_init();
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('LABCONF', 'UTILS');
--dmap conversion comment: gtt declaration added
v_hours := regexp_replace(p_time, '((\d{1,2})\:(\d{2})\:(\d{2}))', '\2');
v_minutes := regexp_replace(p_time, '((\d{1,2})\:(\d{2})\:(\d{2}))', '\3');
v_seconds := regexp_replace(p_time, '((\d{1,2})\:(\d{2})\:(\d{2}))', '\4');
v_tot_seconds := v_hours * 60 * 60 + v_minutes * 60 + v_seconds;
return v_tot_seconds;
exception
when others then
raise exception '%', dbms_utility.format_error_stack using errcode = '45000';end;
$body$
language plpgsql
;
