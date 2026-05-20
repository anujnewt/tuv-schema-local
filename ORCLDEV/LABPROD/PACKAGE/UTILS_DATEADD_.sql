create or replace  function  labprod.utils_dateadd_ (p_interval varchar, p_interval_val numeric, p_date_exp ts) returns ts as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_ucase_interval varchar(10);
v_date ts;
v_datestr varchar(30);
v_result ts;
--dmap conversion comment: global temp variables moved as local temp variables
default_char_size_temp numeric;
trancount_temp numeric;
--dmap conversion comment: declaration boundary ends
begin 

call labprod.utils_dmap_test_onetime_block_init();
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('LABPROD', 'UTILS');
--dmap conversion comment: gtt declaration added
v_date := p_date_exp;
v_ucase_interval := upper(p_interval);
if v_ucase_interval in ('YEAR', 'YY', 'YYYY')
then
return add_months(v_date, p_interval_val * 12);
elsif v_ucase_interval in ('QUARTER', 'QQ', 'Q')
then
if last_day(v_date) = v_date then
v_datestr := extract(month from v_date) + (p_interval_val * 3);/* dmap converted statement start */
v_datestr :=  concat(v_datestr, '-' , extract(day from v_date) , '-' , extract(year from v_date)) ;/* dmap converted statement end *//* dmap converted statement start */
v_datestr :=  concat(v_datestr, ' ' , to_char(v_date, 'HH12') , ':' , to_char(v_date, 'MI') , ':' , to_char(v_date, 'SS')) ;/* dmap converted statement end *//* dmap converted statement start */
v_datestr :=  concat(v_datestr, '.' , to_char(v_date, 'FF3 AM')) ;/* dmap converted statement end */
v_result := to_timestamp(v_datestr, 'MM-DD-YYYY HH12:MI:SS.FF3 AM');
return v_result;
else
return add_months(v_date, p_interval_val * 3);
end if;
elsif v_ucase_interval in ('MONTH', 'MM', 'M')
then
begin
v_result := v_date + numtoyminterval(p_interval_val, 'MONTH') + numtodsinterval(0, 'HOUR');
exception when others then
v_result := add_months(v_date, p_interval_val);
end;
return v_result;
elsif v_ucase_interval in ('DAYOFYEAR', 'DY', 'Y', 'DAY', 'DD', 'D', 'WEEKDAY', 'DW', 'W')
then
return v_date + numtodsinterval(p_interval_val, 'DAY');
elsif v_ucase_interval in ('WEEK', 'WK', 'WW')
then
return v_date + (p_interval_val * 7);
elsif v_ucase_interval in ('HOUR', 'HH')
then
return v_date + numtodsinterval(p_interval_val, 'HOUR');
elsif v_ucase_interval in ('MINUTE', 'MI', 'N')
then
return v_date + numtodsinterval(p_interval_val, 'MINUTE');
elsif v_ucase_interval in ('SECOND', 'SS', 'S')
then
return v_date + numtodsinterval(p_interval_val, 'SECOND');
elsif v_ucase_interval in ('MILLISECOND', 'MS')
then
return v_date + numtodsinterval(3.33 * round(p_interval_val/3.33)::numeric, 'SECOND')/1000;
else
return null;
end if;
exception
when others then
raise exception '%', dbms_utility.format_error_stack using errcode = '45000';end;
$body$
language plpgsql
;
