-- dmap_object_gen_tag : type : table name : cge004
set search_path = fecxc,oracle,dmap_extension,public;
create table "cge004"  (
cge1cod char(5) not null,
cge3cod numeric(38) not null,
cge4val varchar(100) not null,
ts_rversion timestamp
) ;
-- dmap_object_gen_tag : type : alter table name : cge004
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge004 add primary key (cge1cod,cge3cod);
-- dmap_object_gen_tag : type : alter table name : cge004
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge004 alter column cge1cod set not null;
-- dmap_object_gen_tag : type : alter table name : cge004
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge004 alter column cge3cod set not null;
-- dmap_object_gen_tag : type : alter table name : cge004
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge004 alter column cge4val set not null;
-- dmap_object_gen_tag : type : alter table name : cge004
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge004 add constraint fk_cge004_cge001 foreign key (cge1cod) references cge001(cge1cod) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : cge004
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge004 add constraint fk_cge004_cge003 foreign key (cge3cod) references cge003(cge3cod) on delete no action not deferrable initially immediate;
