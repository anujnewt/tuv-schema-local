create or replace  function  labprod.utils_patindex (p_pattern varchar, p_expr varchar, p_format varchar) returns numeric as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_search_pattern varchar(100);
v_pos numeric := 0;
v_charsfmt varchar(20) := 'using chars';
v_charactersfmt  varchar(20) := 'using characters';
v_bytesfmt varchar(20) := 'using bytes';
v_format varchar(20);
v_errmsg varchar(50) := 'Invalid format: ';
--dmap conversion comment: global temp variables moved as local temp variables
default_char_size_temp numeric;
trancount_temp numeric;
--dmap conversion comment: declaration boundary ends
begin 

call labprod.utils_dmap_test_onetime_block_init();
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('LABPROD', 'UTILS');
--dmap conversion comment: gtt declaration added
if nullif(p_pattern::text, '') is null or nullif(p_expr::text, '') is null then
return null;
end if;
if not dbms_db_version.ver_le_9_2 then
v_search_pattern := p_pattern;
v_search_pattern := replace(v_search_pattern, '\', '\');
v_search_pattern := replace(v_search_pattern, '*', '\*');
v_search_pattern := replace(v_search_pattern, '+', '\+');
v_search_pattern := replace(v_search_pattern, '?', '\?');
v_search_pattern := replace(v_search_pattern, '|', '\|');
v_search_pattern := replace(v_search_pattern, '^', '\^');
v_search_pattern := replace(v_search_pattern, '$', '\$');
v_search_pattern := replace(v_search_pattern, '.', '\.');
v_search_pattern := replace(v_search_pattern, '{', '\{');
v_search_pattern := replace(v_search_pattern, '_', '.');
v_format := lower(p_format);
if v_format = v_charsfmt or v_format = v_charactersfmt then
if oracle.substr(v_search_pattern, 1, 1) != '%' and
oracle.substr(v_search_pattern, -1, 1) != '%' then
v_search_pattern := '^' || v_search_pattern || '$';
elsif oracle.substr(v_search_pattern, 1, 1) != '%' then
v_search_pattern := '^' || oracle.substr(v_search_pattern, 1, length(v_search_pattern) - 1);
elsif oracle.substr(v_search_pattern, -1, 1) != '%' then
v_search_pattern := oracle.substr(v_search_pattern, 2) || '$';
else
v_search_pattern := oracle.substr(v_search_pattern, 2, length(v_search_pattern) - 2);
end if;
elsif v_format = v_bytesfmt then
if oracle.substr(v_search_pattern, 1, 1) != '%' and
oracle.substr(v_search_pattern, -1, 1) != '%' then
v_search_pattern := '^' || v_search_pattern || '$';
elsif oracle.substr(v_search_pattern, 1, 1) != '%' then
v_search_pattern := '^' || oracle.substr(v_search_pattern, 1, lengthb(v_search_pattern) - 1);
elsif oracle.substr(v_search_pattern, -1, 1) != '%' then
v_search_pattern := oracle.substr(v_search_pattern, 2) || '$';
else
v_search_pattern := oracle.substr(v_search_pattern, 2, lengthb(v_search_pattern) - 2);
end if;
else
v_errmsg := v_errmsg || p_format;
raise exception '%', v_errmsg using errcode = '45001';
end if;
v_pos := regexp_instr(p_expr, v_search_pattern);
else
v_pos := 0;
end if;
return v_pos;
exception
when others then
raise exception '%', dbms_utility.format_error_stack using errcode = '45000';
end;
$body$
language plpgsql
;
