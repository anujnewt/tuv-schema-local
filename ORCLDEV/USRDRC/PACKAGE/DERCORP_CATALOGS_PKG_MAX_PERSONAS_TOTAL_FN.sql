create or replace  function  usrdrc.dercorp_catalogs_pkg_max_personas_total_fn (pinnrownum numeric) returns numeric as $body$
declare
-- pgv moved types start
-- pgv moved types end
linnummaximo  numeric := 0;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
--  begin
select max(person_id) + pinnrownum into strict linnummaximo
from dercorp_cat_personas_total_tab;
/* exception when others then
linnummaximo := 0;
end;*/
return linnummaximo;end;
--
--
$body$
language plpgsql
stable;
