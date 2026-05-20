-- dmap_object_gen_tag : type : table name : nmdescan
set search_path = labconf,oracle,dmap_extension,public;
create table "nmdescan"  (
des_nodes numeric(38) not null,
des_desca1 char(16) not null,
des_desca2 char(16) not null
) ;
-- dmap_object_gen_tag : type : alter table name : nmdescan
set search_path = labconf,oracle,dmap_extension,public;
alter table nmdescan add primary key (des_nodes);
-- dmap_object_gen_tag : type : alter table name : nmdescan
set search_path = labconf,oracle,dmap_extension,public;
alter table nmdescan alter column des_nodes set not null;
-- dmap_object_gen_tag : type : alter table name : nmdescan
set search_path = labconf,oracle,dmap_extension,public;
alter table nmdescan alter column des_desca1 set not null;
-- dmap_object_gen_tag : type : alter table name : nmdescan
set search_path = labconf,oracle,dmap_extension,public;
alter table nmdescan alter column des_desca2 set not null;
