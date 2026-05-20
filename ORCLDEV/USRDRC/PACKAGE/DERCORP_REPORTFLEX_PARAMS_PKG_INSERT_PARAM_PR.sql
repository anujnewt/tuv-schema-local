create or replace procedure usrdrc.dercorp_reportflex_params_pkg_insert_param_pr ( p_id_reportflex numeric, p_id_param varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
insert into dercorp_reportflex_params_tab(
id_reportflex ,
id_param
)
values (
p_id_reportflex,
p_id_param
);end;
$body$
language plpgsql
;
