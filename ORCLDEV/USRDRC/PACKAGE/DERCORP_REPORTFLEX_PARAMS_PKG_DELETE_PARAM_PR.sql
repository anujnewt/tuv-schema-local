create or replace procedure usrdrc.dercorp_reportflex_params_pkg_delete_param_pr ( p_id_reportflex numeric, p_id_param varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
delete from
dercorp_reportflex_params_tab
where
id_reportflex = p_id_reportflex
and
id_param        = p_id_param;end;
$body$
language plpgsql
;
