create or replace  function  labprod.utils_ident_seed (p_sequence varchar) returns numeric as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_seed numeric;
--dmap conversion comment: global temp variables moved as local temp variables
default_char_size_temp numeric;
trancount_temp numeric;
--dmap conversion comment: declaration boundary ends
begin 

call labprod.utils_dmap_test_onetime_block_init();
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('LABPROD', 'UTILS');
--dmap conversion comment: gtt declaration added
select min_value into strict v_seed
from user_sequences
where sequence_name like upper(p_sequence);
return v_seed;
exception
when others then
raise exception '%', dbms_utility.format_error_stack using errcode = '45000';end;
$body$
language plpgsql
;
