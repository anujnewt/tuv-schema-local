create or replace procedure usrdrc.pendium_ejercicio_social_pkg_find_one_ejercicio ( param_id_ejercicio_row numeric, id_ejercicio_out inout numeric, ejercicio_out inout numeric, no_documentum_out inout varchar, fecha_documentum_out inout varchar, fecha_entrega_out inout varchar, tipo_document_out inout varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
select
id_ejercicio_row,
ejercicio_social,
no_documentum,
fecha_documentum,
fecha_entrega,
tipo_document
into strict
id_ejercicio_out,
ejercicio_out,
no_documentum_out,
fecha_documentum_out,
fecha_entrega_out,
tipo_document_out
from
pendium_ejercicio_social_tab
where
id_ejercicio_row=param_id_ejercicio_row
;end;
$body$
language plpgsql
;
