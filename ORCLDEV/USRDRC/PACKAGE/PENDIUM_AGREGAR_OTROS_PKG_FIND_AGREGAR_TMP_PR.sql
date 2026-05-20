create or replace procedure usrdrc.pendium_agregar_otros_pkg_find_agregar_tmp_pr (param_id_empresa numeric, agregar_temp inout refcursor) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
open agregar_temp for
select
id_agregar_row,
id_agregar,
agregar
from
pendium_agregar_tab
where
id_empresa=param_id_empresa
and
nullif(id_meta_row::text, '') is null
order by  id_agregar_row asc;end;
$body$
language plpgsql
;
