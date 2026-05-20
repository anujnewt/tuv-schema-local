create or replace procedure usrdrc.dercorp_reportflex_pkg_get_reporte_pr (resultset inout refcursor, idreportflex integer) as $body$
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
dercorp_reportflex_tab
where
id_reportflex = idreportflex;end;
$body$
language plpgsql
;
