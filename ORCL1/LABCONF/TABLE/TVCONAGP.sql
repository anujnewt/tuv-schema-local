-- dmap_object_gen_tag : type : table name : tvconagp
set search_path = labconf,oracle,dmap_extension,public;
create table "tvconagp"  (
agp_numagr numeric(38) not null,
agp_keycon varchar(3) not null,
agp_desagp varchar(50)
) ;
-- dmap_object_gen_tag : type : alter table name : tvconagp
set search_path = labconf,oracle,dmap_extension,public;
alter table tvconagp alter column agp_numagr set not null;
-- dmap_object_gen_tag : type : alter table name : tvconagp
set search_path = labconf,oracle,dmap_extension,public;
alter table tvconagp alter column agp_keycon set not null;
