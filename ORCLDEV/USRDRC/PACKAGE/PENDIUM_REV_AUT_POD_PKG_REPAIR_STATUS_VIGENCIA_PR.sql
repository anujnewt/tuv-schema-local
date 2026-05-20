create or replace procedure usrdrc.pendium_rev_aut_pod_pkg_repair_status_vigencia_pr () as $body$
declare
-- pgv moved types start
-- pgv moved types end
lfec_fin timestamp(0);
max_indice integer;
indice integer;
indiceaux integer;
desc_apod_poder text;
desc_apod_esc text;
apoderados_cur cursor for
select
apod.id_apod_ep_pk
,apod.id_opoder_ep_fk
,apod.id_ep_fk
,apod.desc_nom_empl
,poder.fec_vigenciafin
from pendium_apoderado_ep_tab apod
inner join pendium_otorgapoder_ep_tab poder on apod.id_opoder_ep_fk = poder.id_opoder_ep_pk
inner join pendium_escritura_poder_tab esc on esc.id_ep_pk = poder.id_ep_fk
where poder.num_vigenciatipo in (1,2,3)
and poder.ind_status = 1
and to_timestamp(poder.fec_vigenciafin,'DD/MM/YYYY, HH24:MI:SS') < clock_timestamp()
and apod.ind_status in (2)
and apod.desc_revoca like '<label style="color:red;">V</label> Mandato Termino por Vigencia%';
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
/******* aplicar revocaciones *********/
for i in apoderados_cur
loop
select desc_apoderados into strict desc_apod_esc
from pendium_escritura_poder_tab
where id_ep_pk = i.id_ep_fk;/* dmap converted statement start */
desc_apod_esc := replace(desc_apod_esc , concat(i.desc_nom_empl, '<br /> <br />') , concat(i.desc_nom_empl, ' <label style="color:red;">V</label><br /> <br />')) ;/* dmap converted statement end *//* dmap converted statement start */
desc_apod_esc := replace(desc_apod_esc , concat(i.desc_nom_empl, '<br />') , concat(i.desc_nom_empl, ' <label style="color:red;">V</label><br />')) ;/* dmap converted statement end */
update pendium_escritura_poder_tab set desc_apoderados = desc_apod_esc  where id_ep_pk = i.id_ep_fk;
/* commit; */
end loop;end;
$body$
language plpgsql
;
