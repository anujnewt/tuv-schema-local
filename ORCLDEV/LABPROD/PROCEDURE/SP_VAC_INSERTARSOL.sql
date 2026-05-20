create or replace procedure labprod."sp_vac_insertarsol"  ( keyemp numeric, keycon varchar, fecini timestamp(0), fecfin timestamp(0), numdia numeric, status numeric, empaut numeric, keyusu numeric, keymot varchar, observ varchar, numani numeric, fecper timestamp(0), keysol inout numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
keypro smallint;
begin
select emp_keypro into strict keypro
from labprod.nmcoempl
where emp_keyemp = keyemp;
insert into labprod.molosoli(sol_keyemp,sol_keycon,sol_fecini,sol_fecfin,sol_numdia,sol_status,sol_empaut,sol_keyusu,sol_keymot,sol_observ,sol_fecmod,sol_hormod,
sol_keypro,sol_numani,sol_fecper)
values (keyemp    ,keycon    ,fecini    ,fecfin    ,numdia    ,status    ,empaut    ,keyusu    ,keymot    ,observ    ,clock_timestamp()   ,to_char(clock_timestamp(), 'HH24:MI:SS'),
keypro    ,numani    ,fecper)
returning sol_keysol into keysol;
/* commit; */
end;
$body$
language plpgsql
;
