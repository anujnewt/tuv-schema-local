create or replace procedure usrdrc.dercorp_panel_control_pkg_update_new_menu_pr ( pstmenuelement varchar,pinidmenu numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
lstmenuelement varchar(100);
linmenuelement numeric;
lincountmenu  numeric;
linmaxidelem  numeric;
lstnommenu    varchar(1000);
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
--select count(distinct id_menu) into  lincountmenu
--from ss_menu_element_tab;
--lincountmenu := lincountmenu -1;
/* select max(id_menu_element) into linmaxidelem
from ss_menu_element_tab;
linmaxidelem := linmaxidelem -12;
*/
begin
lstmenuelement := replace(pstmenuelement,'chk_','');
-- linmenuelement := linmaxidelem +to_number(lstmenuelement); --(lincountmenu*12)+to_number(lstmenuelement);
--argu
select nom_name into strict lstnommenu
from ss_menu_element_tab
where id_menu = 1
and id_menu_element = lstmenuelement;
exception
when others then
linmenuelement:= 0;
end;
/* update ss_menu_element_tab
set    atributo1        = 1
where  id_menu_element  = linmenuelement;
*/
--argu
update ss_menu_element_tab
set    atributo1        = 1
where  nom_name = lstnommenu
and id_menu = pinidmenu;end;
$body$
language plpgsql
;
