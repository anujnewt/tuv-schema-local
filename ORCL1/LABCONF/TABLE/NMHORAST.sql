-- dmap_object_gen_tag : type : table name : nmhorast
set search_path = labconf,oracle,dmap_extension,public;
create table "nmhorast"  (
hor_nohor numeric(38) not null,
hor_enthor1 char(5) not null,
hor_salhor1 char(5) not null,
hor_enthor2 char(5) not null,
hor_salhor2 char(5) not null
) ;
-- dmap_object_gen_tag : type : alter table name : nmhorast
set search_path = labconf,oracle,dmap_extension,public;
alter table nmhorast add primary key (hor_nohor);
-- dmap_object_gen_tag : type : alter table name : nmhorast
set search_path = labconf,oracle,dmap_extension,public;
alter table nmhorast alter column hor_nohor set not null;
-- dmap_object_gen_tag : type : alter table name : nmhorast
set search_path = labconf,oracle,dmap_extension,public;
alter table nmhorast alter column hor_enthor1 set not null;
-- dmap_object_gen_tag : type : alter table name : nmhorast
set search_path = labconf,oracle,dmap_extension,public;
alter table nmhorast alter column hor_salhor1 set not null;
-- dmap_object_gen_tag : type : alter table name : nmhorast
set search_path = labconf,oracle,dmap_extension,public;
alter table nmhorast alter column hor_enthor2 set not null;
-- dmap_object_gen_tag : type : alter table name : nmhorast
set search_path = labconf,oracle,dmap_extension,public;
alter table nmhorast alter column hor_salhor2 set not null;
