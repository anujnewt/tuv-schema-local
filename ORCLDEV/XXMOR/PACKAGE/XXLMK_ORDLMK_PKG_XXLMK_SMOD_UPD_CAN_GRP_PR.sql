create or replace procedure xxmor.xxlmk_ordlmk_pkg_xxlmk_smod_upd_can_grp_pr (piingrupo_canal integer, piincanal integer, piinindex integer, piinnetwork integer, piinsky integer, piinizzi integer, pistupdated_by varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
update xxlmk_smod_conf_cans_tab c
set ind_orden = piinindex,
ind_network = piinnetwork,
ind_sky = piinsky,
ind_izzi = piinizzi,
fec_actualizacion = clock_timestamp(),
c.cve_actualizado_por = pistupdated_by
where c.id_grupo = piingrupo_canal
and c.num_canal = piincanal;end;
$body$
language plpgsql
;
