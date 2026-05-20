-- dmap_object_gen_tag : type : table name : nmtarjet
set search_path = labconf,oracle,dmap_extension,public;
create table "nmtarjet"  (
tar_keyemp numeric(38) not null,
tar_nohor numeric(38) not null,
tar_nodes numeric(38) not null
) ;
-- dmap_object_gen_tag : type : alter table name : nmtarjet
set search_path = labconf,oracle,dmap_extension,public;
alter table nmtarjet add primary key (tar_keyemp);
-- dmap_object_gen_tag : type : alter table name : nmtarjet
set search_path = labconf,oracle,dmap_extension,public;
alter table nmtarjet alter column tar_keyemp set not null;
-- dmap_object_gen_tag : type : alter table name : nmtarjet
set search_path = labconf,oracle,dmap_extension,public;
alter table nmtarjet alter column tar_nohor set not null;
-- dmap_object_gen_tag : type : alter table name : nmtarjet
set search_path = labconf,oracle,dmap_extension,public;
alter table nmtarjet alter column tar_nodes set not null;
