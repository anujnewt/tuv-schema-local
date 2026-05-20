-- dmap_object_gen_tag : type : table name : menus_siho
set search_path = usrsiho,oracle,dmap_extension,public;
create table "menus_siho"  (
men_keyusu numeric(5),
men_idefun varchar(15),
men_desfun varchar(60)
) ;
