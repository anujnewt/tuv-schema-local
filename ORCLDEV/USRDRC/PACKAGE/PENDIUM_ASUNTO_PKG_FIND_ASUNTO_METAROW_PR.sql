create or replace procedure usrdrc.pendium_asunto_pkg_find_asunto_metarow_pr (param_id_meta_row numeric, asunto_meta_row inout refcursor) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
open asunto_meta_row for
select
id_asunto_row,
id_asunto,
asunto
from
pendium_asunto_tab
where
id_meta_row = param_id_meta_row
order by  id_asunto_row asc;end;
$body$
language plpgsql
;
