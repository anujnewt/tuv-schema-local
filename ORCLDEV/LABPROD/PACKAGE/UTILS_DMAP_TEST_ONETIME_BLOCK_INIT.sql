create or replace procedure labprod.utils_dmap_test_onetime_block_init () as $body$
declare
-- pgv moved types start
--dmap moved type current package utils;







current_setting('utils.dt_formats')::varchar2_array varchar(100)[];







--dmap moved type current package utils;







current_setting('utils.dt_')::varchar2_array varchar(100)[];







--dmap moved type current package utils;







current_setting('utils.dt_nls')::varchar2_array varchar(100)[];







--dmap moved type current package utils;







current_setting('utils.dt_time')::varchar2_array varchar(100)[];







--dmap moved type current package utils;







current_setting('utils.dt_year')::varchar2_array varchar(100)[];







--dmap moved type current package utils;







current_setting('utils.dt_month')::varchar2_array varchar(100)[];







--dmap moved type current package utils;







/*  */

--dmap moved type current package utils;







current_setting('utils.dt_day')::varchar2_array varchar(100)[];







-- pgv moved types end
l_one_time_block_invoked text;







--dmap conversion comment: global temp variables moved as local temp variables
default_char_size_temp numeric;







trancount_temp numeric;







--dmap conversion comment: declaration boundary ends
begin 
 
 
 
 
 
 

call dmap_extension.pkg_var_dmap_tab_to_gtt_init('LABPROD', 'UTILS');
--dmap conversion comment: gtt declaration added
l_one_time_block_invoked := dmap_extension.f_dmap_get_pkg_var('LABPROD','UTILS', 'ONE_TIME_BLOCK_INVOKED', null);
if nullif(l_one_time_block_invoked::text, '') is null then
perform set_config('utils.dt_day', varchar2_array(
'fxfmdd/mm/yy',
'fxfmdd/mm/yyyy',
'fxfmdd.mm.yy',
'fxfmdd.mm.yyyy',
'fxfmdd-mm-yy',
'fxfmdd-mm-yyyy',
'fxfmdd mon yy',
'fxfmdd mon yyyy',
'dd mon yyyy hh24:mi:ssxff3',
'fxdd mon yyyy hh12:mi:ss:ff3AM',
'fxdd/mm/yy hh12:mi:ss:ff3AM',
'fmdd yyyy MONTH',
'fmdd Month',
'fmdd Month yy',
'fmdd Month yyyy',
'fxddmmyy',
'fxddmmyyyy',
'fxdd-Mon-yy',
'fxdd-MON-yy',
'fxdd-Mon-yyyy',
'fxdd-MON-yyyy'
), false);
perform set_config('utils.dt_month', varchar2_array(
'fxfmmm/dd/yyyy hh24:mi:ss',
'fmmon dd yyyy hh:miAM',
'fxfmmm/dd/yy',
'fxfmmm/dd/yyyy',
'fxfmMon dd, yy',
'fxfmMon dd, yyyy',
'mon dd yyyy hh12:mi:ssxff3am',
'fxfmmm-dd-yy',
'fxfmmm-dd-yyyy',
'fmMONTH, yyyy',
'MON yyyy',
'fmMONTH dd, yyyy',
'mm/yy',
'mm/yyyy',
'fmMonth dd, yyyy',
'fmMonth dd',
'mm-yy',
'mm-yyyy',
'fxmmddyy',
'fxmmddyyyy',
'Mon-yy',
'Mon-yyyy',
'MON-yy',
'MON-yyyy'
), false);
perform set_config('utils.dt_year', varchar2_array(
'fxfmyy.mm.dd',
'fxfmyyyy.mm.dd',
'fxfmyy/mm/dd',
'fxfmyyyy/mm/dd',
'yymmdd',
'yyyymmdd',
'fxyyyy-mm-dd hh24:mi:ss',
'fxyyyy-mm-dd hh24:mi:ssxff3',
'fxyyyy-mm-dd"T"hh12:mi:ssxff3',
'fxyyyy-mm-dd hh12:mi:ssxff3',
'fxyyyymmdd hh24:mi:ss',
'fxyyyy-mm-dd',
'fxyyyy-mm-dd hh12:mi:ss',
'yyyy MON',
'yy/mm',
'yyyy/mm',
'yy-mm',
'yyyy-mm'
), false);
perform set_config('utils.dt_time', varchar2_array(
'hh:mi:ss',
'hh24:mi:ssxff3',
'hh12 AM',
'hh12:mi:ss AM'
), false);
perform set_config('utils.dt_nls', varchar2_array(
getnlsdateformat,
getnlstsformat,
getnlstsformat
), false);
perform set_config('utils.dt_', varchar2_array(
'fxfmmm/dd/yyyy hh24:mi:ss.ff9',
'yyyy-mm-dd hh24:mi:ss.ff9'
), false);
perform set_config('utils.dt_formats', current_setting('utils.dt_month')::varchar2_array multiset
union
current_setting('utils.dt_year')::varchar2_array multiset
union
current_setting('utils.dt_nls')::varchar2_array multiset
union
current_setting('utils.dt_timestamp')::varchar2_array, false);
call dmap_extension.p_dmap_set_pkg_var('LABPROD','UTILS', 'ONE_TIME_BLOCK_INVOKED', null, null, 'Y');
end if;
exception
when others then
raise notice ' error %', sqlerrm;
null;end;
$body$
language plpgsql
;
