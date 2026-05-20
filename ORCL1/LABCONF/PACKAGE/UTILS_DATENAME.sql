create or replace  function  labconf.utils_datename (p_part_expr varchar, p_date_expr tstz) returns varchar as $body$
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
return utils_datename(p_part_expr , cast(p_date_expr as ts));end;
$body$
language plpgsql
;
create or replace  function  labconf.utils_datename (p_part_expr varchar, p_date_expr tstz) returns varchar as $body$
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
return utils_datename(p_part_expr , cast(p_date_expr as ts));end;
$body$
language plpgsql
;
create or replace  function  labconf.utils_datename (p_part_expr varchar, p_date_expr tstz) returns varchar as $body$
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
return utils_datename(p_part_expr , cast(p_date_expr as ts));end;
$body$
language plpgsql
;
create or replace  function  labconf.utils_datename (p_part_expr varchar, p_date_expr tstz) returns varchar as $body$
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
return utils_datename(p_part_expr , cast(p_date_expr as ts));end;
$body$
language plpgsql
;
