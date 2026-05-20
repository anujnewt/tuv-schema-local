create or replace  function  labconf.utils_datediff_sybase (p_datepart varchar, p_start_date_expr ts, p_end_date_expr ts) returns numeric as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_ret_value numeric := null;
v_diff interval day(9) to second(9);
v_years numeric;
v_weeks numeric;
v_days numeric;
v_hours numeric;
v_minutes numeric;
v_seconds numeric;
v_milliseconds numeric;
v_microseconds numeric;
--dmap conversion comment: global temp variables moved as local temp variables
default_char_size_temp numeric;
trancount_temp numeric;
--dmap conversion comment: declaration boundary ends
begin 

call labconf.utils_dmap_test_onetime_block_init();
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('LABCONF', 'UTILS');
--dmap conversion comment: gtt declaration added
v_diff := p_end_date_expr -  p_start_date_expr;
v_days := extract(day from v_diff);
v_hours := extract(hour from v_diff);
v_minutes :=extract(minute from v_diff);
v_seconds :=extract(second from v_diff);
v_milliseconds := v_seconds - trunc(v_seconds);
v_milliseconds := round(v_milliseconds*10)*100;
v_microseconds := v_seconds - trunc(v_seconds);
v_microseconds := trunc(v_microseconds * 1000000);
if p_datepart in ('WEEK', 'WK', 'WW') then
v_ret_value :=  (next_day(trunc(p_end_date_expr),'Sunday') -  next_day(trunc(p_start_date_expr),'Sunday'))/7;
elsif p_datepart in ('DAY', 'DD', 'D','DAYOFYEAR', 'DY', 'Y') then
v_ret_value :=  trunc(p_end_date_expr) -  trunc(p_start_date_expr);
elsif p_datepart in ('HOUR', 'HH') then
v_ret_value := (v_days*24)+v_hours;
elsif p_datepart in ('MINUTE', 'MI', 'N') then
v_ret_value :=(v_days*24*60)+(v_hours*60)+v_minutes;
elsif p_datepart in ('SECOND', 'SS', 'S') then
v_ret_value := (v_days*24*60*60)+(v_hours*60*60)+(v_minutes*60)+trunc(v_seconds);
elsif p_datepart in ('MILLISECOND', 'MS') then
v_ret_value := (v_days*24*60*60*1000)+(v_hours*60*60*1000)+(v_minutes*60*1000)+(trunc(v_seconds) * '1000 days'::interval)+v_milliseconds;
elsif p_datepart in ('MICROSECOND', 'MCS') then
v_ret_value := (v_days*24*60*60*1000000)+(v_hours*60*60*1000000)+(v_minutes*60*1000000)+(trunc(v_seconds) * '1000000 days'::interval)+v_microseconds;
elsif p_datepart in ('NANOSECOND', 'NS') then
v_ret_value := (v_days*24*60*60*1000000)+(v_hours*60*60*1000000)+(v_minutes*60*1000000)+(trunc(v_seconds) * '1000000000 days'::interval)+(v_microseconds*100);
elsif p_datepart in ('QUARTER', 'QQ', 'Q') then
v_ret_value :=   (to_char(p_end_date_expr,'YYYY')*4 +
to_char(p_end_date_expr,'Q'))
-
(to_char(p_start_date_expr,'YYYY')*4  +
to_char(p_start_date_expr,'Q'));
elsif p_datepart in ('WEEKDAY', 'DW', 'W') then
v_ret_value :=  trunc((trunc(p_end_date_expr) -  trunc(p_start_date_expr))/7);
else
v_ret_value := utils_datediff_sqlserver(p_datepart,p_start_date_expr,p_end_date_expr);
end if;
return v_ret_value;
exception
when others then
raise exception '%', dbms_utility.format_error_stack using errcode = '45000';end;
$body$
language plpgsql
;
