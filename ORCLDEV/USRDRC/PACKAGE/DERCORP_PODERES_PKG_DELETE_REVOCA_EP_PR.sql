create or replace procedure usrdrc.dercorp_poderes_pkg_delete_revoca_ep_pr (pinid_revoca_ep_pk numeric ,pstouterror inout numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
update pendium_revoca_ep_tab
set   ind_status      = 0
where id_revoca_ep_pk  = pinid_revoca_ep_pk;
/* commit; */
exception when others
then
pstouterror := sqlerrm;end;
$body$
language plpgsql
;
