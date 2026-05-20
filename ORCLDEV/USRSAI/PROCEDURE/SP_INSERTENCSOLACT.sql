create or replace procedure usrsai."sp_insertencsolact"  ( keydep varchar, nomresp varchar, fecgra varchar, fecair varchar, observ varchar, keyusu varchar, stssol numeric, obscar varchar, ccdesprov varchar, ccprov varchar, sigid inout numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
sigid := 0;
select coalesce(max(esa_numsol), 0) + 1 into strict sigid from encsolact;
insert into encsolact(esa_numsol, esa_keydep, esa_nomresp, esa_fecsol, esa_fecgra, esa_fecair, esa_observ,esa_keyusu, esa_stssol, esa_obscar, esa_desori, esa_cdcori) values (sigid, keydep, nomresp, clock_timestamp(), to_timestamp(fecgra,'dd/mm/yyyy'), to_timestamp(fecair,'dd/mm/yyyy'), observ, keyusu, stssol, obscar, ccdesprov, ccprov);end;
$body$
language plpgsql
;
