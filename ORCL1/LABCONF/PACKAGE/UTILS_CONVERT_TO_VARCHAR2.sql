create or replace  function  labconf.utils_convert_to_varchar2 (p_expr bytea, p_precision numeric default 0, p_scale numeric default 0, p_style numeric default 0) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_expr bytea;
--dmap conversion comment: global temp variables moved as local temp variables
default_char_size_temp numeric;
trancount_temp numeric;
--dmap conversion comment: declaration boundary ends
begin 

call labconf.utils_dmap_test_onetime_block_init();
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('LABCONF', 'UTILS');/* dmap converted statement start */
--dmap conversion comment: gtt declaration added
v_expr := select dmap_extension.dmap_dbms_lob_substr(p_expr);/* dmap converted statement end */
return utl_raw.cast_to_varchar2(v_expr);end;
$body$
language plpgsql
;
create or replace  function  labconf.utils_convert_to_varchar2 (p_expr bytea, p_precision numeric default 0, p_scale numeric default 0, p_style numeric default 0) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_expr bytea;
--dmap conversion comment: global temp variables moved as local temp variables
default_char_size_temp numeric;
trancount_temp numeric;
--dmap conversion comment: declaration boundary ends
begin 

call labconf.utils_dmap_test_onetime_block_init();
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('LABCONF', 'UTILS');/* dmap converted statement start */
--dmap conversion comment: gtt declaration added
v_expr := select dmap_extension.dmap_dbms_lob_substr(p_expr);/* dmap converted statement end */
return utl_raw.cast_to_varchar2(v_expr);end;
$body$
language plpgsql
;
create or replace  function  labconf.utils_convert_to_varchar2 (p_expr bytea, p_precision numeric default 0, p_scale numeric default 0, p_style numeric default 0) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_expr bytea;
--dmap conversion comment: global temp variables moved as local temp variables
default_char_size_temp numeric;
trancount_temp numeric;
--dmap conversion comment: declaration boundary ends
begin 

call labconf.utils_dmap_test_onetime_block_init();
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('LABCONF', 'UTILS');/* dmap converted statement start */
--dmap conversion comment: gtt declaration added
v_expr := select dmap_extension.dmap_dbms_lob_substr(p_expr);/* dmap converted statement end */
return utl_raw.cast_to_varchar2(v_expr);end;
$body$
language plpgsql
;
create or replace  function  labconf.utils_convert_to_varchar2 (p_expr bytea, p_precision numeric default 0, p_scale numeric default 0, p_style numeric default 0) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_expr bytea;
--dmap conversion comment: global temp variables moved as local temp variables
default_char_size_temp numeric;
trancount_temp numeric;
--dmap conversion comment: declaration boundary ends
begin 

call labconf.utils_dmap_test_onetime_block_init();
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('LABCONF', 'UTILS');/* dmap converted statement start */
--dmap conversion comment: gtt declaration added
v_expr := select dmap_extension.dmap_dbms_lob_substr(p_expr);/* dmap converted statement end */
return utl_raw.cast_to_varchar2(v_expr);end;
$body$
language plpgsql
;
create or replace  function  labconf.utils_convert_to_varchar2 (p_expr bytea, p_precision numeric default 0, p_scale numeric default 0, p_style numeric default 0) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_expr bytea;
--dmap conversion comment: global temp variables moved as local temp variables
default_char_size_temp numeric;
trancount_temp numeric;
--dmap conversion comment: declaration boundary ends
begin 

call labconf.utils_dmap_test_onetime_block_init();
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('LABCONF', 'UTILS');/* dmap converted statement start */
--dmap conversion comment: gtt declaration added
v_expr := select dmap_extension.dmap_dbms_lob_substr(p_expr);/* dmap converted statement end */
return utl_raw.cast_to_varchar2(v_expr);end;
$body$
language plpgsql
;
create or replace  function  labconf.utils_convert_to_varchar2 (p_expr bytea, p_precision numeric default 0, p_scale numeric default 0, p_style numeric default 0) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_expr bytea;
--dmap conversion comment: global temp variables moved as local temp variables
default_char_size_temp numeric;
trancount_temp numeric;
--dmap conversion comment: declaration boundary ends
begin 

call labconf.utils_dmap_test_onetime_block_init();
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('LABCONF', 'UTILS');/* dmap converted statement start */
--dmap conversion comment: gtt declaration added
v_expr := select dmap_extension.dmap_dbms_lob_substr(p_expr);/* dmap converted statement end */
return utl_raw.cast_to_varchar2(v_expr);end;
$body$
language plpgsql
;
