create or replace  function  labprod.utils_datediff_ (p_datepart varchar, p_start_date_expr ts, p_end_date_expr ts) returns numeric as $body$
declare
-- pgv moved types start
-- pgv moved types end
--dmap conversion comment: global temp variables moved as local temp variables
default_char_size_temp numeric;
trancount_temp numeric;
--dmap conversion comment: declaration boundary ends
begin 

call labprod.utils_dmap_test_onetime_block_init();
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('LABPROD', 'UTILS');
--dmap conversion comment: gtt declaration added
if dmap_extension.f_dmap_get_pkg_var('LABPROD' , 'UTILS', 'DATABASE_TYPE', 'VARCHAR2', 'Y')::varchar = dmap_extension.f_dmap_get_pkg_var('LABPROD' , 'UTILS', 'SYBASE', 'VARCHAR2', 'Y')::varchar then
return utils_datediff_sybase(upper(p_datepart),p_start_date_expr,p_end_date_expr);
else
return utils_datediff_sqlserver(p_datepart,p_start_date_expr,p_end_date_expr);
end if;end;
$body$
language plpgsql
;
