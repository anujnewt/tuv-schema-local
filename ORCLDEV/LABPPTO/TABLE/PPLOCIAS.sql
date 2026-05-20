-- dmap_object_gen_tag : type : table name : pplocias
set search_path = labppto,oracle,dmap_extension,public;
create table "pplocias"  (
cia_keycia varchar(4) not null,
cia_descri varchar(60) not null
) ;
-- dmap_object_gen_tag : type : alter table name : pplocias
set search_path = labppto,oracle,dmap_extension,public;
alter table pplocias alter column cia_keycia set not null;
-- dmap_object_gen_tag : type : alter table name : pplocias
set search_path = labppto,oracle,dmap_extension,public;
alter table pplocias alter column cia_descri set not null;
