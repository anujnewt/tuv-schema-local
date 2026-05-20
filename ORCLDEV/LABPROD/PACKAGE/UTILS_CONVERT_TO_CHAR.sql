create or replace  function  labprod.utils_convert_to_char (p_expr timestamp(0) , p_precision numeric default null, p_scale numeric default 0, p_style numeric default null) returns char as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_format varchar(50);
v_result char(4000);
--dmap conversion comment: global temp variables moved as local temp variables
default_char_size_temp numeric;
trancount_temp numeric;
--dmap conversion comment: declaration boundary ends
begin 

call labprod.utils_dmap_test_onetime_block_init();
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('LABPROD', 'UTILS');
--dmap conversion comment: gtt declaration added
return utils_convert_to_char_(p_expr,p_precision,p_scale,p_style);end;
$body$
language plpgsql
;
create or replace  function  labprod.utils_convert_to_char (p_expr timestamp(0) , p_precision numeric default null, p_scale numeric default 0, p_style numeric default null) returns char as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_format varchar(50);
v_result char(4000);
--dmap conversion comment: global temp variables moved as local temp variables
default_char_size_temp numeric;
trancount_temp numeric;
--dmap conversion comment: declaration boundary ends
begin 

call labprod.utils_dmap_test_onetime_block_init();
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('LABPROD', 'UTILS');
--dmap conversion comment: gtt declaration added
return utils_convert_to_char_(p_expr,p_precision,p_scale,p_style);end;
$body$
language plpgsql
;
create or replace  function  labprod.utils_convert_to_char (p_expr timestamp(0) , p_precision numeric default null, p_scale numeric default 0, p_style numeric default null) returns char as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_format varchar(50);
v_result char(4000);
--dmap conversion comment: global temp variables moved as local temp variables
default_char_size_temp numeric;
trancount_temp numeric;
--dmap conversion comment: declaration boundary ends
begin 

call labprod.utils_dmap_test_onetime_block_init();
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('LABPROD', 'UTILS');
--dmap conversion comment: gtt declaration added
return utils_convert_to_char_(p_expr,p_precision,p_scale,p_style);end;
$body$
language plpgsql
;
create or replace  function  labprod.utils_convert_to_char (p_expr timestamp(0) , p_precision numeric default null, p_scale numeric default 0, p_style numeric default null) returns char as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_format varchar(50);
v_result char(4000);
--dmap conversion comment: global temp variables moved as local temp variables
default_char_size_temp numeric;
trancount_temp numeric;
--dmap conversion comment: declaration boundary ends
begin 

call labprod.utils_dmap_test_onetime_block_init();
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('LABPROD', 'UTILS');
--dmap conversion comment: gtt declaration added
return utils_convert_to_char_(p_expr,p_precision,p_scale,p_style);end;
$body$
language plpgsql
;
create or replace  function  labprod.utils_convert_to_char (p_expr timestamp(0) , p_precision numeric default null, p_scale numeric default 0, p_style numeric default null) returns char as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_format varchar(50);
v_result char(4000);
--dmap conversion comment: global temp variables moved as local temp variables
default_char_size_temp numeric;
trancount_temp numeric;
--dmap conversion comment: declaration boundary ends
begin 

call labprod.utils_dmap_test_onetime_block_init();
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('LABPROD', 'UTILS');
--dmap conversion comment: gtt declaration added
return utils_convert_to_char_(p_expr,p_precision,p_scale,p_style);end;
$body$
language plpgsql
;
