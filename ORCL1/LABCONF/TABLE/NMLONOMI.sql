-- dmap_object_gen_tag : type : table name : nmlonomi
set search_path = labconf,oracle,dmap_extension,public;
create table "nmlonomi"  (
nom_keynom numeric(5) not null,
nom_destip varchar(40) not null
) ;
-- dmap_object_gen_tag : type : alter table name : nmlonomi
set search_path = labconf,oracle,dmap_extension,public;
alter table nmlonomi add constraint nmnomi01 unique (nom_keynom);
-- dmap_object_gen_tag : type : alter table name : nmlonomi
set search_path = labconf,oracle,dmap_extension,public;
alter table nmlonomi alter column nom_keynom set not null;
-- dmap_object_gen_tag : type : alter table name : nmlonomi
set search_path = labconf,oracle,dmap_extension,public;
alter table nmlonomi alter column nom_destip set not null;
