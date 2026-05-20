create or replace procedure usrdrc.pendium_agregar_otros_pkg_find_one_agregar ( param_id_agregar_row numeric, p_id_agregar_row inout numeric, id_agregar_out inout varchar, agregar_out inout varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
select
id_agregar_row,
id_agregar,
agregar
into strict
p_id_agregar_row,
id_agregar_out,
agregar_out
from
pendium_agregar_tab
where
id_agregar_row = param_id_agregar_row
;end;
$body$
language plpgsql
;
