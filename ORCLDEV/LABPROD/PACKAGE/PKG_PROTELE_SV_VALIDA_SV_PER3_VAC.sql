create or replace  function  labprod.pkg_protele_sv_valida_sv_per3_vac ( num integer) returns integer as $body$
declare
-- pgv moved types start
-- pgv moved types end
n_existe integer;
max_periodo integer;
begin 

-- package does not have global variables
--dmap conversion comment: gtt declaration added
execute '/* DUE TO RESTRICTION OF APG, THIS REQUIRES MANUAL VALIDATION. PLEASE VALIDATE. */ SET SESSION DATESTYLE TO ''SQL,DMY'';' ; /* dmap converted statement */
begin
select max(vac_antigu)
into strict max_periodo
from nmcocvac
where 1=1
and vac_keyemp      = num;
exception
when no_data_found then
max_periodo := 0;
end;
begin
select count(*)
into strict n_existe
from nmcocvac
where 1=1
and vac_salper      = 0
and vac_keyemp      = num
and vac_antigu      = max_periodo
and vac_status='V'
and to_char(clock_timestamp(),'DD/MM/RR') > add_months(to_char(vac_fecfin,'DD/MM/RR'),-3);
return n_existe;
exception
when no_data_found then
return 0;
end;end;
$body$
language plpgsql
stable;
