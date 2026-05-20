create or replace procedure labprod."sv_his_cola"  ( emp integer, num integer, his_cola inout refcursor) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
open his_cola for
select emp_nomemp,
rva_fecini,
rva_fecfin,
rva_diadis,
rva_period
from nmcoempl,
nmcorvac,
eocoplza
where nmcoempl.emp_keyemp = nmcorvac.rva_keyemp
and nmcorvac.rva_fecini between(select max(dia_ini) from svtempsc where num_emp = emp and sta_sol = 'P'
)
and (select max(dia_ini) from svtempsc where num_emp = emp and sta_sol = 'P') + 10
and nmcorvac.rva_keyemp = eocoplza.plz_keyemp
and eocoplza.plz_cverem = num
and nmcorvac.rva_diadis > 0;end;
$body$
language plpgsql
;
