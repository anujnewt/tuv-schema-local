create or replace procedure usrdrc.pendium_agregar_otros_pkg_create_agregar_pr (param_id_empresa numeric, param_id_agregar varchar, param_agregar varchar, pinuserid numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
var_seq numeric;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
select
nextval('pendium_agregar_seq') into strict var_seq
;
insert into pendium_agregar_tab(
id_agregar_row,
id_empresa,
id_agregar,
agregar,
num_created_by,
fec_creation_date,
num_last_updated_by,
fec_last_update_date
)values (
var_seq,
param_id_empresa,
param_id_agregar,
param_agregar,
pinuserid,
clock_timestamp(),
pinuserid,
clock_timestamp()
);end;
$body$
language plpgsql
;
