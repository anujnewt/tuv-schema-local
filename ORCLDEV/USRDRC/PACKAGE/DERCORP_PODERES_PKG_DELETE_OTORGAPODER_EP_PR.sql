create or replace procedure usrdrc.dercorp_poderes_pkg_delete_otorgapoder_ep_pr (pstresultado inout varchar ,pinid_ep_fk numeric ,psinnum_last_updated_by numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
update pendium_otorgapoder_ep_tab
set    ind_status            =   0
,num_last_updated_by   =   psinnum_last_updated_by
,fec_last_update_date  =   clock_timestamp()
where   id_ep_fk       =   pinid_ep_fk;
/* commit; */
exception
when others then
pstresultado := sqlerrm;end;
$body$
language plpgsql
;
