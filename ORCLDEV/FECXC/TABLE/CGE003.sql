-- dmap_object_gen_tag : type : table name : cge003
set search_path = fecxc,oracle,dmap_extension,public;
create table "cge003"  (
cge3cod numeric(38) not null,
cge3des varchar(30) not null,
cge3tip char(1) not null,
cge3lon numeric(38) not null,
cge3dec numeric(38),
cge3obl char(1) not null,
timestamp timestamp
) ;
-- dmap_object_gen_tag : type : alter table name : cge003
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge003 add primary key (cge3cod);
-- dmap_object_gen_tag : type : alter table name : cge003
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge003 alter column cge3cod set not null;
-- dmap_object_gen_tag : type : alter table name : cge003
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge003 alter column cge3des set not null;
-- dmap_object_gen_tag : type : alter table name : cge003
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge003 alter column cge3tip set not null;
-- dmap_object_gen_tag : type : alter table name : cge003
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge003 alter column cge3lon set not null;
-- dmap_object_gen_tag : type : alter table name : cge003
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge003 alter column cge3obl set not null;
