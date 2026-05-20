create or replace procedure labprod."sv_rep_can"  ( num integer, ini varchar, fin varchar, reporte inout refcursor) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
open reporte for
select rva_fecini,
rva_fecfin,
rva_diadis
from nmcorvac,
nmcocvac
where nmcocvac.vac_keyemp = nmcorvac.rva_keyemp
and trim(both nmcocvac.vac_period)   = trim(both nmcorvac.rva_period)
and nmcocvac.vac_status   = 'V'
and (nmcorvac.rva_fecini between to_timestamp(ini,'yyyy/MM/dd') and to_timestamp(fin,'yyyy/MM/dd'))
and nmcorvac.rva_keyemp = num;end;
$body$
language plpgsql
;
