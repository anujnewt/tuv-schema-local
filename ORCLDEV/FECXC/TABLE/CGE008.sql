-- dmap_object_gen_tag : type : table name : cge008
set search_path = fecxc,oracle,dmap_extension,public;
create table "cge008"  (
cge1cod char(5) not null,
cge7cod numeric(38) not null,
cge10cod numeric(38) not null,
cge8tip char(1) not null,
cge8lon numeric(38) not null,
cge8rin numeric(38),
cge8rsu numeric(38),
cge8mas varchar(20) not null,
ts_rversion timestamp
) ;
-- dmap_object_gen_tag : type : alter table name : cge008
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge008 add primary key (cge1cod,cge7cod,cge10cod);
-- dmap_object_gen_tag : type : alter table name : cge008
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge008 alter column cge1cod set not null;
-- dmap_object_gen_tag : type : alter table name : cge008
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge008 alter column cge7cod set not null;
-- dmap_object_gen_tag : type : alter table name : cge008
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge008 alter column cge10cod set not null;
-- dmap_object_gen_tag : type : alter table name : cge008
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge008 alter column cge8tip set not null;
-- dmap_object_gen_tag : type : alter table name : cge008
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge008 alter column cge8lon set not null;
-- dmap_object_gen_tag : type : alter table name : cge008
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge008 alter column cge8mas set not null;
-- dmap_object_gen_tag : type : alter table name : cge008
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge008 add constraint fk_cge008_cge001 foreign key (cge1cod) references cge001(cge1cod) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : cge008
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge008 add constraint fk_cge008_cge007 foreign key (cge7cod) references cge007(cge7cod) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : cge008
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge008 add constraint fk_cge008_cge010 foreign key (cge1cod,cge10cod) references cge010(cge1cod,cge10cod) on delete no action not deferrable initially immediate;
