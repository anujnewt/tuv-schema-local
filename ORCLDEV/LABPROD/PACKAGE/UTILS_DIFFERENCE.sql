create or replace  function  labprod.utils_difference (p_expr1 varchar, p_expr2 varchar) returns numeric as $body$
declare
-- pgv moved types start
-- pgv moved types end
sound_ex_val_1 char(4);
sound_ex_val_2 char(4);
similarity numeric := 0;
idx numeric := 1;
--dmap conversion comment: global temp variables moved as local temp variables
default_char_size_temp numeric;
trancount_temp numeric;
--dmap conversion comment: declaration boundary ends
begin 

call labprod.utils_dmap_test_onetime_block_init();
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('LABPROD', 'UTILS');
--dmap conversion comment: gtt declaration added
if nullif(p_expr1::text, '') is null or nullif(p_expr2::text, '') is null then
return null;
end if;
sound_ex_val_1 := soundex(p_expr1);
sound_ex_val_2 := soundex(p_expr2);
loop
if oracle.substr(sound_ex_val_1, idx, 1) = oracle.substr(sound_ex_val_2, idx, 1) then
similarity := similarity + 1;
end if;
idx := idx + 1;
exit when idx > 4;
end loop;
return similarity;
exception
when others then
raise exception '%', dbms_utility.format_error_stack using errcode = '45000';end;
$body$
language plpgsql
;
