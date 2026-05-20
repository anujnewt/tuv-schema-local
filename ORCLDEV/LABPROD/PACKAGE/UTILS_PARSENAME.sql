create or replace  function  labprod.utils_parsename (p_object_name varchar, p_object_piece numeric) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
ret_val varchar(150) := null;
pos numeric;
v_next_pos numeric;
--dmap conversion comment: global temp variables moved as local temp variables
default_char_size_temp numeric;
trancount_temp numeric;
--dmap conversion comment: declaration boundary ends
begin 

call labprod.utils_dmap_test_onetime_block_init();
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('LABPROD', 'UTILS');
--dmap conversion comment: gtt declaration added
if nullif(p_object_name::text, '') is null then
return null;
end if;
if not dbms_db_version.ver_le_9_2 then
if p_object_piece = 1 then
ret_val := regexp_substr(p_object_name, '(^[^\.]+$)|(\.[^\.]+$)');
ret_val := replace(ret_val, '.', '');
elsif p_object_piece = 2 then
ret_val := regexp_substr(p_object_name, '([^\.]+)\.([^\.]+$)');
ret_val := regexp_replace(ret_val, '\.([^\.]+$)', '');
elsif p_object_piece = 3 then
ret_val := regexp_substr(p_object_name, '([^\.]+)\.([^\.]*)\.([^\.]+$)');
ret_val := regexp_replace(ret_val, '\.([^\.]*)\.([^\.]+$)', '');
elsif p_object_piece = 4 then
ret_val := regexp_substr(p_object_name, '^([^\.]+)\.([^\.]*)\.([^\.]*)\.([^\.]+$)');
if nullif(ret_val::text, '') is not null then
ret_val := regexp_replace(p_object_name, '^([^\.]+)\.([^\.]*)\.([^\.]*)\.([^\.]+$)', '\1');
end if;
end if;
else
ret_val := p_object_name;
v_next_pos := length(p_object_name);
for i in 1 .. p_object_piece loop
pos := instr(p_object_name, '.', -1, i);
if pos > 0 then
ret_val := oracle.substr(p_object_name, pos + 1, v_next_pos - pos);
end if;
v_next_pos := pos;
end loop;
if length(ret_val) = 0 then
return null;
end if;
end if;
return ret_val;
exception
when others then
raise exception '%', dbms_utility.format_error_stack using errcode = '45000';end;
$body$
language plpgsql
;
