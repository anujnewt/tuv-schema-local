create or replace procedure xxmor.xxlmk_ordlmk_pkg_xxlmk_smod_del_can_grp_pr (piingrupo_canal integer, piincanal integer) as $body$
declare
-- pgv moved types start
-- pgv moved types end
linindex integer;
lincount_cfg_ncans integer;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
select c.ind_orden
into strict linindex
from xxlmk_smod_conf_cans_tab c
where c.id_grupo = piingrupo_canal
and c.num_canal = piincanal;
delete from xxlmk_smod_conf_cans_tab c
where c.id_grupo = piingrupo_canal
and c.num_canal = piincanal;
update xxlmk_smod_conf_cans_tab c
set ind_orden = ind_orden - 1
where c.id_grupo = piingrupo_canal
and c.ind_orden > linindex;
select max(g.num_cans)
into strict lincount_cfg_ncans
from xxlmk_smod_grp_ncans_tab g
where g.id_grupo = piingrupo_canal;
delete from xxlmk_smod_ncans_dist_tab n
where n.id_grupo = piingrupo_canal
and n.num_cans = lincount_cfg_ncans;
delete from xxlmk_smod_grp_ncans_tab n
where n.id_grupo = piingrupo_canal
and n.num_cans = lincount_cfg_ncans;end;
$body$
language plpgsql
;
