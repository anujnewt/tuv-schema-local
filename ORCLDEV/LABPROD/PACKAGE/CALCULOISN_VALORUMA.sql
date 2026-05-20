create or replace  function  labprod.calculoisn_valoruma () returns numeric as $body$
declare
-- pgv moved types start
-- pgv moved types end
wn_valor decimal(18,6);
begin 

-- package does not have global variables
--dmap conversion comment: gtt declaration added
select tab_eledos into strict wn_valor
from labprod.nmlotabn
where tab_keytab = '002'
and tab_eleuno = 1;
return wn_valor;
exception when others then
return 0;end;
$body$
language plpgsql
stable;
