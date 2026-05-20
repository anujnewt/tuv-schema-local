create or replace  function  labprod.utils_datename_ (p_part_expr varchar, p_date_expr ts) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_part varchar(15);
v_timestamp ts := p_date_expr;
v_wkday varchar(10);
v_year varchar(4);
v_temp varchar(30);
--dmap conversion comment: global temp variables moved as local temp variables
default_char_size_temp numeric;
trancount_temp numeric;
--dmap conversion comment: declaration boundary ends
begin 

call labprod.utils_dmap_test_onetime_block_init();
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('LABPROD', 'UTILS');
--dmap conversion comment: gtt declaration added
v_part := upper(p_part_expr);
if v_part in ('YEAR', 'YY', 'YYYY') then return to_char(v_timestamp, 'YYYY');
elsif v_part in ('QUARTER', 'QQ', 'Q') then return to_char(v_timestamp, 'Q');
elsif v_part in ('MONTH', 'MM', 'M') then return to_char(v_timestamp, 'Month');
elsif v_part in ('DAYOFYEAR', 'DY', 'Y') then return (to_char(v_timestamp, 'DDD'))::numeric;
elsif v_part in ('DAY', 'DD', 'D') then return to_char(v_timestamp, 'DD');
elsif v_part in ('WEEKDAY', 'DW', 'W') then return to_char(v_timestamp, 'Day');
elsif v_part in ('WEEK', 'WK', 'WW') then
return to_char(v_timestamp, 'WW');
elsif v_part in ('HOUR', 'HH') then return to_char(v_timestamp, 'fmHH24');
elsif v_part in ('MINUTE', 'MI', 'N') then return to_char(v_timestamp, 'fmMI');
elsif v_part in ('SECOND', 'SS', 'S') then return to_char(v_timestamp, 'fmSS');
elsif v_part in ('MILLISECOND', 'MS', 'FF3') then
v_temp := to_char(v_timestamp, 'FF3');
if v_temp = '000' then
return '0';
else
return v_temp;
end if;
elsif v_part in ('MICROSECOND', 'MCS', 'FF6') then
v_temp := to_char(v_timestamp, 'FF6');
if v_temp = '000000' then
return '0';
else
return v_temp;
end if;
elsif v_part in ('NANOSECOND', 'NS', 'FF9') then
v_temp := to_char(v_timestamp, 'FF9');
if v_temp = '000000000' then
return '0';
else
return v_temp;
end if;/* dmap converted statement start */
elsif v_part in ('TZOFFSET', 'TZ') then return concat( to_char(v_timestamp, 'TZH'), ':' , to_char(v_timestamp, 'TZM')) ;/* dmap converted statement end */
else
return null;
end if;
exception
when others then
raise exception '%', dbms_utility.format_error_stack using errcode = '45000';end;
$body$
language plpgsql
;
