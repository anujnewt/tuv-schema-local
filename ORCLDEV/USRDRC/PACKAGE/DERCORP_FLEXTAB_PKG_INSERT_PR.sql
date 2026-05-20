create or replace procedure usrdrc.dercorp_flextab_pkg_insert_pr ( param_id_empresa varchar ,param_id_flex_tab varchar ,new_id inout integer ,pinuserid numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
var_seq numeric;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
select
nextval('dercorp_metatbl_seq') into strict var_seq
;
insert into dercorp_metatbl_tab(
id_meta_row,
id_flex_tbl,
id_empresa,
num_created_by,
fec_creation_date
)
values (
var_seq,
param_id_flex_tab,
param_id_empresa,
pinuserid,
clock_timestamp()
);
new_id := var_seq;end;
$body$
language plpgsql
;
