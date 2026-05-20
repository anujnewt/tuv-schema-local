create or replace procedure usrdrc.dercorp_poderes_pkg_update_revoca_ep_pr ( pinid_revoca_ep_pk numeric ,pinind_razonrevoca numeric ,pstdes_razonrevoca varchar ,pinid_escriturarevoca_fk numeric ,pinid_documentumrevoca numeric ,pstfec_revoca varchar ,pstdes_textorevoca varchar ,pstdesc_apendicerevoca varchar ,pinnum_last_updated_by numeric ,pstouterror inout varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
update pendium_revoca_ep_tab
set    ind_razonrevoca       =  pinind_razonrevoca
,des_razonrevoca       =  pstdes_razonrevoca
,id_escriturarevoca_fk =  pinid_escriturarevoca_fk
,id_documentumrevoca   =  pinid_documentumrevoca
,fec_revoca            =  pstfec_revoca
,des_textorevoca       =  pstdes_textorevoca
,desc_apendicerevoca   =  pstdesc_apendicerevoca
,num_last_updated_by   =  pinnum_last_updated_by
,fec_last_update_date  =  clock_timestamp()
where id_revoca_ep_pk        =  pinid_revoca_ep_pk;
/* commit; */
exception when others
then
pstouterror := sqlerrm;end;
$body$
language plpgsql
;
