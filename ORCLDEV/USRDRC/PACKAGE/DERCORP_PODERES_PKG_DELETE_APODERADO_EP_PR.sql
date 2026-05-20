create or replace procedure usrdrc.dercorp_poderes_pkg_delete_apoderado_ep_pr ( pinid_ep_pk numeric ,psinnum_last_updated_by numeric ,pstouterror inout numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
update pendium_apoderado_ep_tab
set   ind_status          =  0,
num_last_updated_by =  psinnum_last_updated_by
where id_ep_fk       =  pinid_ep_pk;
/* commit; */
exception when others
then
pstouterror := sqlerrm;end;
$body$
language plpgsql
;
