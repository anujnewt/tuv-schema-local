create or replace  function  labprod.utils_getnlsdateformat () returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
dt_format varchar(50);
--dmap conversion comment: global temp variables moved as local temp variables
default_char_size_temp numeric;
trancount_temp numeric;
--dmap conversion comment: declaration boundary ends
begin 

call labprod.utils_dmap_test_onetime_block_init();
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('LABPROD', 'UTILS');
--dmap conversion comment: gtt declaration added
select value into strict dt_format from v$nls_parameters where parameter = 'NLS_DATE_FORMAT';
return dt_format;end;
$body$
language plpgsql
;
