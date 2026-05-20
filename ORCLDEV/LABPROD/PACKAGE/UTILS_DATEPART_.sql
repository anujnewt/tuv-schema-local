create or replace  function  labprod.utils_datepart_ (p_part_expr varchar, p_date_expr ts) returns numeric as $body$
declare
i record;

-- pgv moved types start
--dmap moved type current package utils;

/*  */

--dmap moved type current package utils;

current_setting('utils.dt_formats')::varchar2_array varchar(100)[];

-- pgv moved types end
v_part varchar(15) := p_part_expr;

v_timestamp ts := p_date_expr;

v_wkday varchar(10);

v_year varchar(4);

--dmap conversion comment: global temp variables moved as local temp variables
default_char_size_temp numeric;

trancount_temp numeric;

--dmap conversion comment: declaration boundary ends
begin 

call labprod.utils_dmap_test_onetime_block_init();
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('LABPROD', 'UTILS');
--dmap conversion comment: gtt declaration added
v_part := upper(p_part_expr);
if v_part in ('YEAR', 'YY', 'YYYY') then  return (to_char(v_timestamp, 'YYYY'))::numeric;
elsif v_part in ('QUARTER', 'QQ', 'Q')  then return (to_char(v_timestamp, 'Q'))::numeric;
elsif v_part in ('MONTH', 'MM', 'M') then return (to_char(v_timestamp, 'MM'))::numeric;
elsif v_part in ('DAYOFYEAR', 'DY', 'Y') then return (to_char(v_timestamp, 'DDD'))::numeric;
elsif v_part in ('DAY', 'DD', 'D') then return (to_char(v_timestamp, 'DD'))::numeric;
elsif v_part in ('WEEKDAY', 'DW', 'W') then return (to_char(v_timestamp, 'D'))::numeric;
elsif v_part in ('WEEK', 'WK', 'WW') then
v_year := to_char(v_timestamp, 'YYYY');/* dmap converted statement start */
for i in select * from current_setting('utils.dt_formats')::ARRAY_lower(varchar2_array, 1) .. current_setting('utils.dt_formats')::ARRAY_upper(varchar2_array, 1)
loop
begin
v_wkday := to_char(to_date( concat('01-01-', v_year) , current_setting('utils.dt_formats')::varchar2_array(i)), 'DAY');/* dmap converted statement end */
exit;
exception
when others then
null;
end;
end loop;
if v_wkday = to_char(v_timestamp, 'DAY') then
return (to_char(v_timestamp, 'WW'))::numeric;
else
return (to_char(v_timestamp, 'WW'))::numeric  + 1;
end if;
elsif v_part in ('HOUR', 'HH') then return (to_char(v_timestamp, 'HH24'))::numeric;
elsif v_part in ('MINUTE', 'MI', 'N') then return (to_char(v_timestamp, 'MI'))::numeric;
elsif v_part in ('SECOND', 'SS', 'S') then return (to_char(v_timestamp, 'SS'))::numeric;
elsif v_part in ('MILLISECOND', 'MS', 'FF3') then return (to_char(v_timestamp, 'FF3'))::numeric;
elsif v_part in ('MICROSECOND', 'MCS', 'US', 'FF6') then return (to_char(v_timestamp, 'FF6'))::numeric;
elsif v_part in ('NANOSECOND', 'NS', 'FF9') then return (to_char(v_timestamp, 'FF9'))::numeric;
elsif v_part in ('CALYEAROFWEEK', 'CYR', 'IYYY') then return (to_char(v_timestamp, 'IYYY'))::numeric;
elsif v_part in ('CALWEEKOFYEAR', 'CWK', 'IW') then return (to_char(v_timestamp, 'IW'))::numeric;
elsif v_part in ('CALDAYOFWEEK', 'CDW', 'D') then return (to_char(v_timestamp, 'D'))::numeric  - 1;
else
return null;
end if;
exception
when others then
raise exception '%', dbms_utility.format_error_backtrace using errcode = '45000';end;
$body$
language plpgsql
;
