-- dmap_object_gen_tag : type : view name : dercorp_menu_vw
set search_path = usrdrc,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "dercorp_menu_vw"  ("id_menu", "id_menu_element", "is_enabled", "id_rol", "nom_menu", "id_menu_element_parent") as with recursive cte as (
select sm.id_menu,sm.id_menu_element,sm.atributo1 as is_enabled,(select id_rol
from   ss_rol_tab
where  id_menu = sm.id_menu) as id_rol,case when 1>1 then '&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp'||sm.nom_name
else '<b>'||sm.nom_name||'</b>'
end as nom_menu,sm.id_menu_element_parent
from   ss_menu_element_tab sm
--where  sm.id_menu = 2
where sm.id_menu_element_parent = 0
union all
select sm.id_menu,sm.id_menu_element,sm.atributo1 as is_enabled,(select id_rol
from   ss_rol_tab
where  id_menu = sm.id_menu) as id_rol,case when (c.level+1)>1 then '&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp'||sm.nom_name
else '<b>'||sm.nom_name||'</b>'
end as nom_menu,sm.id_menu_element_parent
from   ss_menu_element_tab sm
join cte c on (c.id_menu_element = sm.id_menu_element_parent)
) select * from cte;/* dmap converted statement end */
-- estimed cost of view [ dercorp_menu_vw ]: 1.60;
