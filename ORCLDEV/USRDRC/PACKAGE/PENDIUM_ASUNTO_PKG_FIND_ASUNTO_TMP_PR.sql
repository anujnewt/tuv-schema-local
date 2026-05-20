create or replace procedure usrdrc.pendium_asunto_pkg_find_asunto_tmp_pr (param_id_empresa numeric, asuntos_temp inout refcursor) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
open asuntos_temp for
select
id_asunto_row,
id_asunto,
asunto
from
pendium_asunto_tab
where
id_empresa=param_id_empresa
and
nullif(id_meta_row::text, '') is null
order by  id_asunto_row asc;end;
$body$
language plpgsql
;
