create or replace procedure xxmor.xxlmk_ordlmk_pkg_xxlmk_smod_add_can_grp_pr (piingrupo_canal integer, piincanal integer, piinindex integer, piinnetwork integer, piinsky integer, piinizzi integer, pistcreated_by varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
lincount_cfg_ncans integer;
linperc_dist decimal(5,2);
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
update xxlmk_smod_conf_cans_tab
set ind_orden = ind_orden + 1
where id_grupo = piingrupo_canal
and ind_orden >= piinindex;
insert into xxlmk_smod_conf_cans_tab(num_canal, id_grupo, ind_network, ind_sky, ind_izzi, ind_orden, fec_creacion, cve_creado_por)
values (piincanal, piingrupo_canal, piinnetwork, piinsky, piinizzi, piinindex, clock_timestamp(), pistcreated_by);
select coalesce(max(g.num_cans), 0) + 1
into strict lincount_cfg_ncans
from xxlmk_smod_grp_ncans_tab g
where g.id_grupo = piingrupo_canal;
insert into xxlmk_smod_grp_ncans_tab(id_grupo, num_cans, fec_creacion, cve_creado_por, fec_actualizacion, cve_actualizado_por)
values (piingrupo_canal, lincount_cfg_ncans, clock_timestamp(), pistcreated_by, clock_timestamp(), pistcreated_by);
linperc_dist := 100 / lincount_cfg_ncans;
for counter in 1..lincount_cfg_ncans
loop
insert into xxlmk_smod_ncans_dist_tab(id_grupo, num_cans, num_can, num_porc_dist, fec_creacion, cve_creado_por, fec_actualizacion, cve_actualizado_por)
values (piingrupo_canal, lincount_cfg_ncans, counter, linperc_dist, clock_timestamp(), pistcreated_by, clock_timestamp(), pistcreated_by);
end loop;end;
$body$
language plpgsql
;
