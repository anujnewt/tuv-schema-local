-- dmap_object_gen_tag : type : table name : dercorp_cat_personas_total_tab
set search_path = usrdrc,oracle,dmap_extension,public;
create table "dercorp_cat_personas_total_tab"  (
person_id numeric,
nombre varchar(4000),
id_catalogo_valor numeric,
id_catalogo numeric
) ;
