create or replace  function  xxmor.xxlmk_ordlmk_pkg_xxlmk_can_dur_exept_conf_fun (piinid_ajus integer, piinid_grupo integer, piinnum_brek_nom_time integer) returns numeric as $body$
declare
-- pgv moved types start
-- pgv moved types end
ldtini  timestamp(0);
ldtfin  timestamp(0);
lindur  integer;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
begin
select  adc.num_dur_conf
into strict    lindur
from    xxlmk_ajus_dur_conf_grp_tab adc
where   id_ajuste_breaks = piinid_ajus
and     id_grupo = piinid_grupo
and     num_break_time = piinnum_brek_nom_time;
exception
when others then
begin
select  num_duracion
into strict    lindur
from    xxlmk_grupos_canales_tab gc
where   gc.id_grupo = piinid_grupo;
exception
when others then
lindur := 0;
end;
end;
return lindur;end;
$body$
language plpgsql
stable;
