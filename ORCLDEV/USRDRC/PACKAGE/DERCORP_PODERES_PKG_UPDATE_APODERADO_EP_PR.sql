create or replace procedure usrdrc.dercorp_poderes_pkg_update_apoderado_ep_pr ( pinid_apod_ep_pk numeric ,pinind_tipoapoderado numeric ,pstdesc_tipoapoderado varchar ,pstnum_last_updated_by varchar ,pstouterror inout varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
update pendium_apoderado_ep_tab
set    ind_tipoapoderado     =    pinind_tipoapoderado
,desc_tipoapoderado    =    pstdesc_tipoapoderado
,num_last_updated_by   =    pstnum_last_updated_by
,fec_last_update_date  =    clock_timestamp()
where id_apod_ep_pk          =    pinid_apod_ep_pk;
/* commit; */
exception when others
then
pstouterror := sqlerrm;end;
$body$
language plpgsql
;
