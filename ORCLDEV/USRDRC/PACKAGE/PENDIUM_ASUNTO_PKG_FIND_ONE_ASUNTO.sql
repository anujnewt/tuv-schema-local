create or replace procedure usrdrc.pendium_asunto_pkg_find_one_asunto ( param_id_asunto_row numeric, p_id_asunto_row inout numeric, id_asunto_out inout varchar, asunto_out inout varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
select
id_asunto_row,
id_asunto,
asunto
into strict
p_id_asunto_row,
id_asunto_out,
asunto_out
from
pendium_asunto_tab
where
id_asunto_row = param_id_asunto_row
;end;
$body$
language plpgsql
;
