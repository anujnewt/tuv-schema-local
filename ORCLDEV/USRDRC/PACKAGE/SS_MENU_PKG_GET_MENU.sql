create or replace  function  usrdrc.ss_menu_pkg_get_menu (param_rol_id numeric) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
liinidmenu numeric;
menu_string text;
var_id_rol_menu integer;
var_id_seccion integer;
var_texto varchar(50);
var_id_parent integer;
var_nombre_seccion varchar(100);
var_url varchar(100);
xx_elem record;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
select
id_menu into strict liinidmenu
from
ss_rol_tab
where
id_rol = param_rol_id
;
menu_string:= null;/* dmap converted statement start */
menu_string :=  concat(menu_string, 'd = new dTree(''d'');' , 'd.config.useCookies = false;' , 'd.config.useCookies = false;' , 'd.config.inOrder = true;' , 'd.config.useIcons = true;') ;/* dmap converted statement end *//* dmap converted statement start */
menu_string :=  concat(menu_string, 'd.add(0,-1,''Inicio'',''../../jsp/home/content.jsp'','''',''contentFrame'');') ;/* dmap converted statement end *//* dmap converted statement start */
for xx_elem in (
select
mnu.id_menu_element,
mnu.id_menu_element_parent,
mnu.nom_name,
sec.nom_name sec_name,
mnu.id_section,
sec.des_url,
mnu.des_target
from
ss_menu_element_tab mnu
left join ss_section_tab sec on sec.id_section = mnu.id_section
where
mnu.id_menu = liinidmenu
and
mnu.atributo1 = 1  --habilitado
order by
mnu.id_order
--mnu.id_menu_element
)
loop
menu_string :=  concat(menu_string, 'd.add(' , coalesce(xx_elem.id_menu_element,'')  , ',' , coalesce(xx_elem.id_menu_element_parent,'0') , ',' , '''' , coalesce(xx_elem.nom_name, xx_elem.sec_name) , ''',' , '''' , coalesce(xx_elem.des_url,'') , ''',' , '''' , coalesce(null,'') , ''',' , '''' , xx_elem.des_target , ''');') ;/* dmap converted statement end */
end loop;
menu_string := concat(menu_string ,   'document.write(d);');
menu_string := concat(menu_string ,   'd.openAll();');
return menu_string;end;
$body$
language plpgsql
;
