create or replace procedure usrdrc.dercorp_reportflex_params_pkg_select_params_pr ( idreportflex numeric, resultset inout refcursor) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
open resultset for
select
id_param,
param_value
from
dercorp_reportflex_params_tab
where
id_reportflex = idreportflex;end;
$body$
language plpgsql
;
