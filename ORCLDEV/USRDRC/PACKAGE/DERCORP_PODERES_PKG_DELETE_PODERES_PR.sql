create or replace procedure usrdrc.dercorp_poderes_pkg_delete_poderes_pr ( pinidpoder numeric ,pinidempresa numeric ,pstouterror inout varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
begin
update  dercorp_poderes_tab
set     id_status  = 0
where   id_poder = pinidpoder
and     id_empresa = pinidempresa;
/* commit; */
exception when others
then
pstouterror := sqlerrm;
end;end;
$body$
language plpgsql
;
