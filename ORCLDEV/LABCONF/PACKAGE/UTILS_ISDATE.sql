create or replace  function  labconf.utils_isdate (p_expr varchar) returns numeric as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_is_valid_date integer := 0;
--dmap conversion comment: global temp variables moved as local temp variables
default_char_size_temp numeric;
trancount_temp numeric;
--dmap conversion comment: declaration boundary ends
begin 

call labconf.utils_dmap_test_onetime_block_init();
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('LABCONF', 'UTILS');
--dmap conversion comment: gtt declaration added
if nullif(utils_convert_string_to_timestamp(p_expr)::text, '') is not null then
return 1;
else
select (case when nullif(to_timestamp(p_expr)::text, '') is not null then 1 else 0 end) into strict v_is_valid_date;
return v_is_valid_date;
end if;
exception
when others then
return 0;end;
$body$
language plpgsql
;
