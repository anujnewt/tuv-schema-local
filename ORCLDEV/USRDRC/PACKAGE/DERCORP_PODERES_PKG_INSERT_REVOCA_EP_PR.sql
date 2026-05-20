create or replace procedure usrdrc.dercorp_poderes_pkg_insert_revoca_ep_pr ( pinid_opoder_ep_fk numeric ,pinid_ep_fk numeric ,pinid_apod_ep_fk numeric ,pinind_razonrevoca numeric ,pstdes_razonrevoca varchar ,pinid_escriturarevoca_fk varchar ,pinid_documentumrevoca varchar ,pstfec_revoca varchar ,pstdes_textorevoca varchar ,pstdesc_apendicerevoca varchar ,pinid_revoca_ep inout numeric ,pstouterror inout varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
insert into pendium_revoca_ep_tab(id_opoder_ep_fk
,id_ep_fk
,id_apod_ep_fk
,ind_razonrevoca
,des_razonrevoca
,id_escriturarevoca_fk
,id_documentumrevoca
,fec_revoca
,des_textorevoca
,desc_apendicerevoca
,ind_status)
values (
pinid_opoder_ep_fk
,pinid_ep_fk
,pinid_apod_ep_fk
,pinind_razonrevoca
,pstdes_razonrevoca
,pinid_escriturarevoca_fk
,pinid_documentumrevoca
,pstfec_revoca
,pstdes_textorevoca
,pstdesc_apendicerevoca
,1
)
returning id_revoca_ep_pk into pinid_revoca_ep;
exception
when others then
pstouterror := sqlerrm;end;
$body$
language plpgsql
;
