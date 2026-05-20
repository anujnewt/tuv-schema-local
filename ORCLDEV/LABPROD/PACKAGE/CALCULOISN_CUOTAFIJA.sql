create or replace  function  labprod.calculoisn_cuotafija (ws_key_ent varchar,wn_por_adi numeric,ws_key_tab varchar,wn_base numeric) returns numeric as $body$
declare
-- pgv moved types start
-- pgv moved types end
wn_result decimal(8,2);
begin 

-- package does not have global variables
--dmap conversion comment: gtt declaration added
wn_result := 0;
if nullif(ws_key_tab::text, '') is not null then
select tab_eletre into strict wn_result
from labprod.nmlotabn
where tab_keytab = ws_key_tab
and tab_eleuno <= wn_base
and tab_eledos >= wn_base;
end if;
return wn_result;end;
$body$
language plpgsql
stable;
