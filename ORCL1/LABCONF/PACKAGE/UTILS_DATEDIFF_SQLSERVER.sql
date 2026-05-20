create or replace  function  labconf.utils_datediff_sqlserver (p_datepart varchar, p_start_date_expr ts, p_end_date_expr ts) returns numeric as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_ret_value numeric := null;
v_part varchar(15);
v_start_ts  ts;
v_end_ts  ts;
v_start_date  timestamp(0);
v_end_date  timestamp(0);
--dmap conversion comment: global temp variables moved as local temp variables
default_char_size_temp numeric;
trancount_temp numeric;
--dmap conversion comment: declaration boundary ends
begin 

call labconf.utils_dmap_test_onetime_block_init();
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('LABCONF', 'UTILS');
--dmap conversion comment: gtt declaration added
v_part := p_datepart;
v_start_ts := p_start_date_expr;
v_end_ts := p_end_date_expr;/* dmap converted statement start */
v_start_date := to_date( concat(extract(year from v_start_ts), '-' , extract(month from v_start_ts) , '-' , extract(day from v_start_ts)) , 'YYYY-MM-DD');/* dmap converted statement end *//* dmap converted statement start */
v_end_date := to_date( concat(extract(year from v_end_ts), '-' , extract(month from v_end_ts) , '-' , extract(day from v_end_ts)) , 'YYYY-MM-DD');/* dmap converted statement end */
v_part := upper(p_datepart);
if v_part in ('YEAR', 'YY', 'YYYY') then
v_ret_value :=extract(year from v_end_ts) - extract(year from v_start_ts);
elsif v_part in ('QUARTER', 'QQ', 'Q') then
v_ret_value := round(months_between(v_end_ts::numeric, v_start_ts) / 3);
elsif v_part in ('MONTH', 'MM', 'M') then
v_ret_value := round(months_between(trunc(v_end_ts, 'MM'), trunc(v_start_ts, 'MM')));
elsif v_part in ('DAYOFYEAR', 'DY', 'Y') then
v_ret_value := round(cast(v_end_ts as timestamp(0)) - cast(v_start_ts as timestamp(0)));
elsif v_part in ('DAY', 'DD', 'D') then
v_ret_value := round(v_end_date - v_start_date);
elsif v_part in ('WEEK', 'WK', 'WW') then
v_ret_value := round((cast(v_end_ts as timestamp(0)) - cast(v_start_ts as timestamp(0))) / 7);
elsif v_part in ('WEEKDAY', 'DW', 'W') then
if extract(year from v_end_ts) = extract(year from v_start_ts) then
v_ret_value := extract(day from v_end_ts) - extract(day from v_start_ts);
else
v_ret_value := round((trunc(v_end_ts, 'DD') - trunc(v_start_ts, 'DD')) / 7);
end if;
elsif v_part in ('HOUR', 'HH') then
v_ret_value := round(v_end_date - v_start_date) * 24;
v_ret_value := round(v_ret_value + (extract(hour from v_end_ts) - extract(hour from v_start_ts)));
elsif v_part in ('MINUTE', 'MI', 'N') then
v_ret_value := round(v_end_date - v_start_date) * 24 * 60;
v_ret_value := v_ret_value + ((extract(hour from v_end_ts) - extract(hour from v_start_ts)) * 60);
v_ret_value := round(v_ret_value + (extract(minute from v_end_ts) - extract(minute from v_start_ts)));
elsif v_part in ('SECOND', 'SS', 'S') then
v_ret_value := round(v_end_date - v_start_date) * 24 * 60 * 60;
v_ret_value := v_ret_value + ((extract(hour from v_end_ts) - extract(hour from v_start_ts)) * 60 * 60);
v_ret_value := v_ret_value + ((extract(minute from v_end_ts) - extract(minute from v_start_ts)) * 60);
v_ret_value := round(v_ret_value + (extract(second from v_end_ts) - extract(second from v_start_ts)));
elsif v_part in ('MILLISECOND', 'MS') then
v_ret_value := round(v_end_date - v_start_date) * 24 * 60 * 60 * 1000;
v_ret_value := v_ret_value + ((extract(hour from v_end_ts) - extract(hour from v_start_ts)) * 60 * 60 * 1000);
v_ret_value := v_ret_value + ((extract(minute from v_end_ts) - extract(minute from v_start_ts)) * 60 * 1000);
v_ret_value := round(v_ret_value + ((extract(second from v_end_ts) - extract(second from v_start_ts)) * 1000));
elsif v_part in ('MICROSECOND', 'MCS') then
v_ret_value := round(v_end_date - v_start_date) * 24 * 60 * 60 * 1000000;
v_ret_value := v_ret_value + ((extract(hour from v_end_ts) - extract(hour from v_start_ts)) * 60 * 60 * 1000000);
v_ret_value := v_ret_value + ((extract(minute from v_end_ts) - extract(minute from v_start_ts)) * 60 * 1000000);
v_ret_value := round(v_ret_value + ((extract(second from v_end_ts) - extract(second from v_start_ts)) * 1000000));
elsif v_part in ('NANOSECOND', 'NS') then
v_ret_value := round(v_end_date - v_start_date) * 24 * 60 * 60 * 1000000000;
v_ret_value := v_ret_value + ((extract(hour from v_end_ts) - extract(hour from v_start_ts)) * 60 * 60 * 1000000000);
v_ret_value := v_ret_value + ((extract(minute from v_end_ts) - extract(minute from v_start_ts)) * 60 * 1000000000);
v_ret_value := round(v_ret_value + ((extract(second from v_end_ts) - extract(second from v_start_ts)) * 1000000000));
end if;
return v_ret_value;
exception
when others then
raise exception '%', dbms_utility.format_error_stack using errcode = '45000';end;
$body$
language plpgsql
;
