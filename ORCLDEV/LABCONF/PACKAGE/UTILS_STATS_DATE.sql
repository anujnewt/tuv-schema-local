create or replace  function  labconf.utils_stats_date (p_table varchar, p_index varchar) returns timestamp(0) as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_last_analyzed timestamp(0);
--dmap conversion comment: global temp variables moved as local temp variables
default_char_size_temp numeric;
trancount_temp numeric;
--dmap conversion comment: declaration boundary ends
begin 

call labconf.utils_dmap_test_onetime_block_init();
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('LABCONF', 'UTILS');
--dmap conversion comment: gtt declaration added
select last_analyzed into strict v_last_analyzed
from user_ind_statistics
where table_name like upper(p_table)
and index_name like upper(p_index);
return v_last_analyzed;
exception
when others then
raise exception '%', dbms_utility.format_error_stack using errcode = '45000';end;
$body$
language plpgsql
;
