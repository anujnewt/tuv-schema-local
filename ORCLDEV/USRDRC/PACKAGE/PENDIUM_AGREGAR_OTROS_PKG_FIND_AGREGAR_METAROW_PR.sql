create or replace procedure usrdrc.pendium_agregar_otros_pkg_find_agregar_metarow_pr (param_id_meta_row numeric, agregar_meta_row inout refcursor) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
open agregar_meta_row for
select
id_agregar_row,
id_agregar,
agregar
from
pendium_agregar_tab
where
id_meta_row = param_id_meta_row
order by  id_agregar_row asc;end;
$body$
language plpgsql
;
