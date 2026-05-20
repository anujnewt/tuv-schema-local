create or replace procedure usrdrc.dercorp_poderes_pkg_update_documentums_ep_pr ( pinid_doc_ep_fk numeric ,pstdesc_title varchar ,pstid_documentcve varchar ,psinnum_last_updated_by numeric ,pstfec_rec varchar ,pstfec_ent varchar ,pstouterror inout varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
update pendium_documentums_ep_tab
set   desc_title            =   pstdesc_title
,id_documentcve        =   pstid_documentcve
,num_last_updated_by   =   psinnum_last_updated_by
,fec_last_update_date  =   clock_timestamp()
,fec_rec               =   pstfec_rec
,fec_ent               =   pstfec_ent
where   id_doc_ep_pk          =   pinid_doc_ep_fk;
/* commit; */
exception
when others then
pstouterror := sqlerrm;end;
$body$
language plpgsql
;
