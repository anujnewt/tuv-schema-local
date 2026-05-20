-- dmap_object_gen_tag : type : table name : ppmapcias
set search_path = labppto,oracle,dmap_extension,public;
create table "ppmapcias"  (
map_keycia varchar(3),
map_ciamap varchar(3) not null
) ;
-- dmap_object_gen_tag : type : alter table name : ppmapcias
set search_path = labppto,oracle,dmap_extension,public;
alter table ppmapcias alter column map_ciamap set not null;
