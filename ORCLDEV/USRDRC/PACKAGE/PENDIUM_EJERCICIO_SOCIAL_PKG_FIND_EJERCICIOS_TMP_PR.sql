create or replace procedure usrdrc.pendium_ejercicio_social_pkg_find_ejercicios_tmp_pr (param_id_empresa numeric, ejercicios_temp inout refcursor) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
open ejercicios_temp for
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
id_empresa=param_id_empresa
and
nullif(id_meta_row::text, '') is null
;end;
$body$
language plpgsql
;
