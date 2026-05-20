create or replace procedure usrdrc.pendium_asunto_pkg_create_asunto_metarow_pr (param_id_meta_row numeric, param_id_empresa numeric, param_id_asunto varchar, param_asunto varchar, pinuserid numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
var_seq numeric;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
select
nextval('pendium_asunto_seq') into strict var_seq
;
insert into pendium_asunto_tab(
id_meta_row,
id_asunto_row,
id_empresa,
id_asunto,
asunto,
num_created_by,
fec_creation_date,
num_last_updated_by,
fec_last_update_date
)values (
param_id_meta_row,
var_seq,
param_id_empresa,
param_id_asunto,
param_asunto,
pinuserid,
clock_timestamp(),
pinuserid,
clock_timestamp()
);end;
$body$
language plpgsql
;
