create or replace  function  labconf.utils_license_enabled ( server varchar default 'ase_server') returns integer as $body$
declare
-- pgv moved types start
-- pgv moved types end
ret_val numeric := 0;
--dmap conversion comment: global temp variables moved as local temp variables
default_char_size_temp numeric;
trancount_temp numeric;
--dmap conversion comment: declaration boundary ends
begin 

call labconf.utils_dmap_test_onetime_block_init();
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('LABCONF', 'UTILS');
--dmap conversion comment: gtt declaration added
if (lower(server) = 'ase_server'
or lower(server) = 'ase_ha'
or lower(server) = 'ase_dtm'
or lower(server) = 'ase_java'
or lower(server) = 'ase_asm')
then return 1;
else return 0;
end if;end;
$body$
language plpgsql
;
