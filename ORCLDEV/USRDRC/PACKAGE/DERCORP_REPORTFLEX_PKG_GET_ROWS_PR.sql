create or replace procedure usrdrc.dercorp_reportflex_pkg_get_rows_pr (resultset inout refcursor, idseccion integer) as $body$
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
dercorp_reportflex_s_row_tab
where
id_seccion = idseccion
order by
id_order;end;
$body$
language plpgsql
;
