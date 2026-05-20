CREATE OR REPLACE FORCE NONEDITIONABLE VIEW "USRDRC"."DERCORP_MENU_VW" ("ID_MENU", "ID_MENU_ELEMENT", "IS_ENABLED", "ID_ROL", "NOM_MENU", "ID_MENU_ELEMENT_PARENT") AS 
  SELECT sm.id_menu,
       sm.id_menu_element,
       sm.atributo1 AS is_enabled,
       (SELECT id_rol
        FROM   ss_rol_tab
        WHERE  id_menu = sm.id_menu) AS id_rol,
        CASE WHEN LEVEL>1 THEN '&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp'||sm.nom_name
        ELSE '<b>'||sm.nom_name||'</b>'
        END as nom_menu,
        sm.id_menu_element_parent
FROM   ss_menu_element_tab sm
--WHERE  sm.id_menu = 2
START WITH sm.id_menu_element_parent = 0
CONNECT BY PRIOR sm.id_menu_element= sm.id_menu_element_parent;
