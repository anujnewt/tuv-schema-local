create or replace procedure usrdrc.pendium_ejercicio_social_pkg_find_ejercicios_metarow_pr (param_id_meta_row numeric, ejercicios_meta_row inout refcursor) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
open ejercicios_meta_row for
select
id_ejercicio_row,
ejercicio_social,
no_documentum,
fecha_documentum,
fecha_entrega,
tipo_document
from
pendium_ejercicio_social_tab
where
id_meta_row=param_id_meta_row
;end;
$body$
language plpgsql
;
