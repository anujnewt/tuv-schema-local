create or replace procedure usrdrc.dercorp_consulta_pkg_get_sub_secciones_pr (sectionid numeric, resultset inout refcursor) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
open resultset for
select
*
from
dercorp_add_campo_sub_sec_tab
where
id_seccion = (case sectionid when 0 then id_seccion else sectionid end)
--and id_subseccion = 17
order by
num_order ,id_seccion, id_subseccion;end;
$body$
language plpgsql
;
