create or replace  function  xxmor.xxlmk_ordlmk_pkg_xxlmk_can_dur_exept_fmt_fun (piinid_ajus integer, piinid_grupo integer, piinnum_brek_nom_time integer) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
lindur  integer;
lstdur  varchar(10);
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
lindur := xxlmk_ordlmk_pkg_xxlmk_can_dur_exept_conf_fun(piinid_ajus, piinid_grupo, piinnum_brek_nom_time);
lstdur := to_char(to_timestamp(lindur,'sssss'), 'hh24:mi:ss');
return lstdur;end;
$body$
language plpgsql
stable;
