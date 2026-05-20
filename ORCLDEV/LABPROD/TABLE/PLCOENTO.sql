-- dmap_object_gen_tag : type : table name : plcoento
set search_path = labprod,oracle,dmap_extension,public;
create table "plcoento"  (
ent_keyusu numeric(10) not null,
ent_cveent varchar(60) default ';;;;;',
ent_modulo numeric(5) default 1
) ;
-- dmap_object_gen_tag : type : alter table name : plcoento
set search_path = labprod,oracle,dmap_extension,public;
alter table plcoento alter column ent_keyusu set not null;
