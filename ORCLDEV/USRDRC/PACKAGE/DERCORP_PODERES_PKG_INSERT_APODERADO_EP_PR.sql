create or replace procedure usrdrc.dercorp_poderes_pkg_insert_apoderado_ep_pr ( pinid_opoder_ep_fk numeric ,pinid_ep_fk numeric ,pinid_empl_fk numeric ,pstdesc_nom_empl varchar ,pinind_tipoapoderado numeric ,pstdesc_tipoapoderado varchar ,pinnum_created_by numeric ,pstdes_grupo varchar ,pinid_grupo_fk numeric ,pstind_aprevoca varchar ,pstdesc_revoca varchar ,pinind_status numeric ,pinid_apod_ep inout numeric ,pstouterror inout varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
insert into pendium_apoderado_ep_tab(
id_opoder_ep_fk
,id_ep_fk
,id_empl_fk
,desc_nom_empl
,ind_tipoapoderado
,desc_tipoapoderado
,ind_status
,num_created_by
,des_grupo
,id_grupo_fk
,ind_aprevoca
,desc_revoca )
values (
pinid_opoder_ep_fk
,pinid_ep_fk
,pinid_empl_fk
,pstdesc_nom_empl
,pinind_tipoapoderado
,pstdesc_tipoapoderado
,pinind_status
,pinnum_created_by
,pstdes_grupo
,pinid_grupo_fk
,pstind_aprevoca
,pstdesc_revoca)
returning id_apod_ep_pk into pinid_apod_ep;
exception
when others then
pstouterror := sqlerrm;end;
$body$
language plpgsql
;
