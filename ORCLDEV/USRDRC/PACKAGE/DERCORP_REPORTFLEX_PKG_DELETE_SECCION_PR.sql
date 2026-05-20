create or replace procedure usrdrc.dercorp_reportflex_pkg_delete_seccion_pr (idseccion integer) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
delete from dercorp_reportflex_seccion_tab
where
id_seccion = idseccion;
delete from dercorp_reportflex_campo_tab
where
id_seccion_row in (
select id_seccion_row
from dercorp_reportflex_s_row_tab
where
id_seccion = idseccion
);
delete from dercorp_reportflex_s_row_tab
where
id_seccion = idseccion;end;
$body$
language plpgsql
;
