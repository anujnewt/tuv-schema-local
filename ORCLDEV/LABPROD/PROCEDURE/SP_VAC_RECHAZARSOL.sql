create or replace procedure labprod."sp_vac_rechazarsol"  ( keysol numeric, keyusu numeric, resultado inout numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
numdia decimal(10,2);
numani numeric(10);
keyemp numeric(10);
keycon varchar(3);
fecper timestamp(0);
begin
begin
select sol_numdia,sol_numani,sol_fecper,sol_keyemp,sol_keycon into strict numdia,numani,fecper,keyemp,keycon
from labprod.molosoli
where sol_keysol = keysol;
exception
when no_data_found then
resultado := 0;
return;
end;
begin
update labprod.molosoli set sol_status = 3,sol_fecmod = clock_timestamp()   ,
sol_hormod = to_char(clock_timestamp(),'HH24:MI:SS'),
sol_keyusu = keyusu
where sol_keysol = keysol;
update labprod.molodiad set dia_diasal = dia_diasal + numdia
where dia_keyemp = keyemp
and dia_keycon = keycon
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
