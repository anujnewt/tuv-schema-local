create or replace procedure usrdrc.dercorp_consulta_pkg_get_secciones_pr (piinrolid numeric,resultset inout refcursor --, sectionid varchar2
) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
open resultset for
select   cs.*
from     dercorp_add_campo_seccion_tab  cs,
dercorp_rol_seccion_tab        rs
where    cs.id_seccion = rs.id_seccion
and      rs.id_rol     = piinrolid
--and      (to_char(cs.id_seccion) = sectionid or sectionid = *)
and      cs.id_seccion not in (23,24) -- jjaq para que no aparezca poderes especial y apoderados
order by  cs.id_seccion;end;
$body$
language plpgsql
;
