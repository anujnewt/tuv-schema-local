create or replace  function  labconf.calculoisn_fecha_mov (ws_nom_rep varchar,ws_key_per varchar) returns timestamp(0) as $body$
declare
-- pgv moved types start
-- pgv moved types end
wd_fec_mov timestamp(0);
begin 

-- package does not have global variables
--dmap conversion comment: gtt declaration added
select per_fecfin into strict wd_fec_mov
from labconf.nmloperi
where per_keypro in (select ran_keypro from labconf.glwkrang where ran_nomrep = ws_nom_rep)
and per_keyper = ws_key_per  limit 1;
return wd_fec_mov;end;
$body$
language plpgsql
stable;
