create or replace procedure usrdrc.dercorp_reportflex_pkg_get_field_pr (resultset inout refcursor, idfield integer) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
open resultset for
select
flexrepfield.id_campo,
flexrepfield.id_seccion_row,
flexrepfield.id_order,
flexrepfield.id_add_campo,
flexfield.nom_campo,
flexfield.des_tipo_campo,
flexfield.id_catalogo,
coalesce(flexfield.id_flex_tbl,0) id_flex_tbl,
flexrepfield.atributo1
from
dercorp_reportflex_campo_tab flexrepfield
left join dercorp_add_campo_tab flexfield on  flexfield.id_add_campo = flexrepfield.id_add_campo
where
flexrepfield.id_campo = idfield
;end;
$body$
language plpgsql
;
