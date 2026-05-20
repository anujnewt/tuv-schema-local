create or replace  function  fecxc.fecxc_divxperiodo_pkg_folioset_fn ( pistconcepto varchar, pincodfolio numeric ) returns numeric as $body$
declare
-- pgv moved types start
-- pgv moved types end
lstfolioset varchar(100);
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
if pincodfolio < 0
then
lstfolioset := oracle.substr(pistconcepto,0,position(' ' in pistconcepto));
else
return null;
end if;
return lstfolioset;
exception
when others then
return 0;end;
$body$
language plpgsql
stable;
