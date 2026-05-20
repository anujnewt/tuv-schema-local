create or replace  function  labconf.utils_ident_incr (p_sequence varchar) returns numeric as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_incr_by numeric;
--dmap conversion comment: global temp variables moved as local temp variables
default_char_size_temp numeric;
trancount_temp numeric;
--dmap conversion comment: declaration boundary ends
begin 

call labconf.utils_dmap_test_onetime_block_init();
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('LABCONF', 'UTILS');
--dmap conversion comment: gtt declaration added
select increment_by into strict v_incr_by
from user_sequences
where sequence_name like upper(p_sequence);
return v_incr_by;
exception
when others then
raise exception '%', dbms_utility.format_error_stack using errcode = '45000';end;
$body$
language plpgsql
;
