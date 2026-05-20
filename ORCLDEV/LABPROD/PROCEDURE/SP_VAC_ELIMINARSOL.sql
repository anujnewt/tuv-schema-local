create or replace procedure labprod."sp_vac_eliminarsol"  ( keysol numeric, keycon varchar, resultado inout numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
numdia decimal(10,2);
numani numeric(10);
keyemp numeric(10);
fecper timestamp(0);
begin
begin
select sol_numdia,sol_numani,sol_fecper,sol_keyemp into strict numdia,numani,fecper,keyemp
from labprod.molosoli
where sol_keysol = keysol;
exception
when no_data_found then
resultado := 0;
return;
end;
begin
delete from labprod.molotrpr where trp_keycon = 'VA' and trp_ca2aux = keysol and trp_keyemp = keyemp;
delete from labprod.molosoli where sol_keysol = keysol;
update labprod.molodiad set dia_diasal = dia_diasal + numdia
where dia_keyemp = keyemp
and dia_keycon = 'VA'
and dia_numani = numani
and dia_fecini = fecper;
/* commit; */
resultado := 0;
exception
when others then
resultado := 1;
return;
end;end;
$body$
language plpgsql
;
