create or replace  function  labprod.utils_convert_to_char_ (p_expr ts , p_precision numeric default 0, p_scale numeric default 0, p_style numeric default null) returns char as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_format varchar(100);
v_result varchar(4000);
--dmap conversion comment: global temp variables moved as local temp variables
default_char_size_temp numeric;
trancount_temp numeric;
--dmap conversion comment: declaration boundary ends
begin 

call labprod.utils_dmap_test_onetime_block_init();
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('LABPROD', 'UTILS');
--dmap conversion comment: gtt declaration added
if nullif(p_style::text, '') is not null then
v_format := utils_get_format_from_style(p_style);
v_result := to_char(p_expr,v_format);
else
v_result := to_char(p_expr);
end if;
return utils_substr_(v_result,p_precision);end;
$body$
language plpgsql
;
