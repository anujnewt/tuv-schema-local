create or replace procedure usrdrc.dercorp_fusion_cpy_pkg_cpy_pr (meta_key numeric, id_empresa numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
var_seq numeric;
cur_cpy_metatbl_row cursor for
select *
from dercorp_metatbl_tab
where id_meta_row = meta_key;
row_cpy record;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
select
nextval('dercorp_metatbl_seq') into strict var_seq
;
open cur_cpy_metatbl_row;
fetch cur_cpy_metatbl_row into row_cpy;
close cur_cpy_metatbl_row;
row_cpy.id_meta_row := var_seq;
row_cpy.id_empresa := id_empresa;
insert into dercorp_metatbl_tab
values (row_cpy.*);end;
$body$
language plpgsql
;
