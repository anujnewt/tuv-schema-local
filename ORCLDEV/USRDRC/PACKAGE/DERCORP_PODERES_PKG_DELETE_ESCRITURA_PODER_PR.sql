create or replace procedure usrdrc.dercorp_poderes_pkg_delete_escritura_poder_pr (pstresultado inout varchar ,pinid_ep_pk numeric ,psinnum_last_updated_by numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
update pendium_escritura_poder_tab
set    ind_status             =   0
,num_last_updated_by    =   psinnum_last_updated_by
,fec_last_update_date   =   clock_timestamp()
where  id_ep_pk               =   pinid_ep_pk;
/* commit; */
exception when others
then
pstresultado := sqlerrm;end;
$body$
language plpgsql
;
