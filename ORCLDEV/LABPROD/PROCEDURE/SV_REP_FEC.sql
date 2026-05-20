create or replace procedure labprod."sv_rep_fec"  ( ini varchar, fin varchar, reporte inout refcursor) as $body$
--nom_emp out char,
--fec_ini out date,
--fec_fin out date,
--dia_tom out decimal,
--per_tom out char)
declare
-- pgv moved types start
-- pgv moved types end
begin
open reporte for
select emp_nomemp,
rva_fecini,
rva_fecfin,
rva_diadis,
vac_status
from nmcoempl,
nmcorvac,
nmcocvac
where nmcoempl.emp_keyemp = nmcorvac.rva_keyemp
and nmcocvac.vac_keyemp   = nmcorvac.rva_keyemp
and nmcocvac.vac_period   = nmcorvac.rva_period
and (nmcorvac.rva_fecini between ini and fin)
union
select emp_nomemp,
dia_ini,
dia_fin,
num_dia,
sta_sol
from svtempsc,
nmcoempl
where nmcoempl.emp_keyemp = svtempsc.num_emp
and (svtempsc.dia_ini between ini and fin)
and (svtempsc.sta_sol = 'P'
or svtempsc.sta_sol   = 'A');end;
$body$
language plpgsql
;
