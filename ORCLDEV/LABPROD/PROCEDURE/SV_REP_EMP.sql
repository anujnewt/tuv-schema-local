create or replace procedure labprod."sv_rep_emp"  ( num integer, reporte inout refcursor) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
open reporte for
select rva_fecini,
rva_fecfin,
rva_diadis,
rva_period
from nmcorvac
where nmcorvac.rva_keyemp = num
union
select dia_ini,
dia_fin,
num_dia,
per_vac
from svtempsc
where svtempsc.sta_sol = 'P'
and svtempsc.num_emp   = num;end;
$body$
language plpgsql
;
