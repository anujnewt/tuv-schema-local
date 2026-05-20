create or replace procedure usrdrc.pendium_ejercicio_social_pkg_create_ejercicios_metarow_pr (param_id_meta_row numeric, param_id_empresa numeric, param_ejercicio numeric, param_documentum varchar, param_fecha_doc varchar, param_fecha_ent varchar, pinuserid numeric, param_tipo_doc varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
var_seq numeric;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
select
nextval('pendium_ejercicio_soc_seq') into strict var_seq
;
insert into pendium_ejercicio_social_tab(
id_meta_row,
id_ejercicio_row,
id_empresa,
ejercicio_social,
no_documentum,
fecha_documentum,
fecha_entrega,
num_created_by,
fec_creation_date,
tipo_document,
num_last_updated_by,
fec_last_update_date
)values (
param_id_meta_row,
var_seq,
param_id_empresa,
param_ejercicio,
param_documentum,
param_fecha_doc,
param_fecha_ent,
pinuserid,
clock_timestamp(),
param_tipo_doc,
pinuserid,
clock_timestamp()
);end;
--ulr 15-03-2017 obtener ejercicios temporales
$body$
language plpgsql
;
