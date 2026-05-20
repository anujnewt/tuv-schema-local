create or replace procedure labprod."sv_dat_per"  ( num integer, dat_per inout refcursor) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
open dat_per for
select vac_period,
vac_antigu,
vac_fecini,
vac_fecfin,
vac_fecpre,
vac_diavac,
vac_dtomad,
vac_salper,
vac_status
from nmcocvac
where vac_status = 'V'
and vac_keyemp   = num;end;
$body$
language plpgsql
;
