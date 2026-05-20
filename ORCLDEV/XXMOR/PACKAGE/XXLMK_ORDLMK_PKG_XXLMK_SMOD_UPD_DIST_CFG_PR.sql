create or replace procedure xxmor.xxlmk_ordlmk_pkg_xxlmk_smod_upd_dist_cfg_pr (piingrupo_canal integer, piinnum_cans integer, piinindex integer, piinpercentage numeric, pistupdated_by varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
update xxlmk_smod_ncans_dist_tab c
set num_porc_dist = piinpercentage,
fec_actualizacion = clock_timestamp(),
c.cve_actualizado_por = pistupdated_by
where c.id_grupo = piingrupo_canal
and c.num_cans = piinnum_cans
and c.num_can = piinindex;end;
$body$
language plpgsql
;
