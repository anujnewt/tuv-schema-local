create or replace procedure usrdrc.dercorp_poderes_pkg_insert_documentums_ep_pr ( pinid_ep_fk numeric ,pstdesc_title varchar ,pstid_documentcve varchar ,pstfec_rec varchar ,pstfec_ent varchar ,pinid_ep inout numeric ,pstouterror inout varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
pinnum_created_by numeric;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
select num_last_updated_by into strict pinnum_created_by from pendium_escritura_poder_tab where id_ep_pk = pinid_ep_fk;
insert into pendium_documentums_ep_tab(
id_ep_fk
,desc_title
,id_documentcve
,ind_status
,fec_rec
,fec_ent
,num_last_update_login
,fec_creation_date
,num_last_updated_by
,fec_last_update_date)
values (
pinid_ep_fk
,pstdesc_title
,pstid_documentcve
,1
,pstfec_rec
,pstfec_ent
,pinnum_created_by
,clock_timestamp()
,pinnum_created_by
,clock_timestamp()
)
returning id_doc_ep_pk into pinid_ep;
exception
when others then
pstouterror := sqlerrm;end;
$body$
language plpgsql
;
