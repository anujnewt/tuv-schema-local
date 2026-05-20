create or replace procedure usrdrc.dercorp_panel_control_pkg_update_menu_pr ( pstmenuelement varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
lstmenuelement varchar(100);
linmenuelement numeric;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
begin
lstmenuelement := replace(pstmenuelement,'chk_','');
linmenuelement := (lstmenuelement)::numeric;
exception
when others then
linmenuelement:= 0;
end;
update ss_menu_element_tab
set    atributo1        = 1
where  id_menu_element  = linmenuelement;end;
$body$
language plpgsql
;
