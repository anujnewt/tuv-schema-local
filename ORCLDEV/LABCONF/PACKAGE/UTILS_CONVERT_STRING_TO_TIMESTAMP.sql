create or replace  function  labconf.utils_convert_string_to_timestamp (arg varchar) returns ts as $body$
declare
i record;

-- pgv moved types start
--dmap moved type current package utils;

/*  */

--dmap moved type current package utils;

current_setting('utils.dt_formats')::varchar2_array varchar(100)[];

-- pgv moved types end
--dmap conversion comment: global temp variables moved as local temp variables
default_char_size_temp numeric;

trancount_temp numeric;

--dmap conversion comment: declaration boundary ends
begin 

call labconf.utils_dmap_test_onetime_block_init();
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('LABCONF', 'UTILS');
--dmap conversion comment: gtt declaration added
for i in select * from current_setting('utils.dt_formats')::ARRAY_lower(varchar2_array, 1) .. current_setting('utils.dt_formats')::ARRAY_upper(varchar2_array, 1)
loop
begin
return to_timestamp(arg,current_setting('utils.dt_formats')::varchar2_array(i));
exception
when others then
null;
end;
end loop;
return  to_timestamp(arg,current_setting('utils.dt_formats')::varchar2_array(1));end;
$body$
language plpgsql
;
