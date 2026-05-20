create or replace  function  labprod.utils_month_ (p_date_str varchar) returns numeric as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_date timestamp(0);
v_dateformat varchar(50);
--dmap conversion comment: global temp variables moved as local temp variables
default_char_size_temp numeric;
trancount_temp numeric;
--dmap conversion comment: declaration boundary ends
begin 

call labprod.utils_dmap_test_onetime_block_init();
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('LABPROD', 'UTILS');
--dmap conversion comment: gtt declaration added
v_date := utils_convert_string_to_timestamp(p_date_str);
if nullif(v_date::text, '') is null then
return null;
end if;
return (to_char(v_date, 'MM'))::numeric;
exception
when others then
raise exception '%', dbms_utility.format_error_stack using errcode = '45000';end;
$body$
language plpgsql
;
create or replace  function  labprod.utils_month_ (p_date_str varchar) returns numeric as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_date timestamp(0);
v_dateformat varchar(50);
--dmap conversion comment: global temp variables moved as local temp variables
default_char_size_temp numeric;
trancount_temp numeric;
--dmap conversion comment: declaration boundary ends
begin 

call labprod.utils_dmap_test_onetime_block_init();
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('LABPROD', 'UTILS');
--dmap conversion comment: gtt declaration added
v_date := utils_convert_string_to_timestamp(p_date_str);
if nullif(v_date::text, '') is null then
return null;
end if;
return (to_char(v_date, 'MM'))::numeric;
exception
when others then
raise exception '%', dbms_utility.format_error_stack using errcode = '45000';end;
$body$
language plpgsql
;
create or replace  function  labprod.utils_month_ (p_date_str varchar) returns numeric as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_date timestamp(0);
v_dateformat varchar(50);
--dmap conversion comment: global temp variables moved as local temp variables
default_char_size_temp numeric;
trancount_temp numeric;
--dmap conversion comment: declaration boundary ends
begin 

call labprod.utils_dmap_test_onetime_block_init();
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('LABPROD', 'UTILS');
--dmap conversion comment: gtt declaration added
v_date := utils_convert_string_to_timestamp(p_date_str);
if nullif(v_date::text, '') is null then
return null;
end if;
return (to_char(v_date, 'MM'))::numeric;
exception
when others then
raise exception '%', dbms_utility.format_error_stack using errcode = '45000';end;
$body$
language plpgsql
;
create or replace  function  labprod.utils_month_ (p_date_str varchar) returns numeric as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_date timestamp(0);
v_dateformat varchar(50);
--dmap conversion comment: global temp variables moved as local temp variables
default_char_size_temp numeric;
trancount_temp numeric;
--dmap conversion comment: declaration boundary ends
begin 

call labprod.utils_dmap_test_onetime_block_init();
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('LABPROD', 'UTILS');
--dmap conversion comment: gtt declaration added
v_date := utils_convert_string_to_timestamp(p_date_str);
if nullif(v_date::text, '') is null then
return null;
end if;
return (to_char(v_date, 'MM'))::numeric;
exception
when others then
raise exception '%', dbms_utility.format_error_stack using errcode = '45000';end;
$body$
language plpgsql
;
