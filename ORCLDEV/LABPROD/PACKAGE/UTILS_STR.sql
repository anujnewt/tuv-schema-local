create or replace  function  labprod.utils_str (p_expr numeric, p_len numeric default 10, p_scale numeric default 0) returns varchar as $body$
declare
v_ret_val varchar(50);
v_temp_val numeric;
v_format_str varchar(50);
v_len numeric;
v_val numeric;
v_has_decimal boolean := false;
begin 

if position('.' in to_char(p_expr)) > 0 then
v_has_decimal := true;
v_len := length(oracle.substr(to_char(p_expr), 1, position('.' in to_char(p_expr))-1));
else
v_len := length(to_char(p_expr));
end if;
if p_len < v_len then
return trim(both lpad(' '::text, p_len+1, '*'::text)::text);
end if;
v_temp_val := p_expr;
if p_len >= v_len then
v_temp_val := round(v_temp_val::numeric, p_scale);
else
v_temp_val := round((v_temp_val)::numeric, 0);
end if;
if p_scale > 0 and v_has_decimal then
if v_len >= (p_len - p_scale) then
v_format_str := lpad(' '::text, v_len+1, '9'::text);
else
v_format_str := lpad(' '::text, (p_len - p_scale), '9');
end if;
v_format_str := trim(both v_format_str);/* dmap converted statement start */
if position('.' in to_char(p_expr)::text) != p_len then
v_format_str :=  concat(v_format_str, '.') ;/* dmap converted statement end */
v_format_str := rpad(v_format_str, p_len, '9');
end if;
else
v_format_str := trim(both lpad(' '::text, p_len+1, '9'::text)::text);
end if;
v_ret_val := to_char(v_temp_val, v_format_str);
return v_ret_val;
exception
when others then
raise exception '%', dbms_utility.format_error_stack using errcode = '45000';end;
$body$
language plpgsql
stable;
