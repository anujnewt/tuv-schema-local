create or replace  function  labconf.utils_radians (p_degree numeric) returns numeric as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_rad numeric;
--dmap conversion comment: global temp variables moved as local temp variables
default_char_size_temp numeric;
trancount_temp numeric;
--dmap conversion comment: declaration boundary ends
begin 

call labconf.utils_dmap_test_onetime_block_init();
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('LABCONF', 'UTILS');
--dmap conversion comment: gtt declaration added
v_rad := p_degree / 180 * utils_pi();
if position('.' in to_char(p_degree)) = 0 then
v_rad := floor(v_rad);
else
v_rad := round((p_degree / 180 * utils_pi())::numeric,18);
end if;
return v_rad;
exception
when others then
raise exception '%', dbms_utility.format_error_stack using errcode = '45000';end;
$body$
language plpgsql
;
