-- dmap_object_gen_tag : type : table name : cge010
set search_path = fecxc,oracle,dmap_extension,public;
create table "cge010"  (
cge1cod char(5) not null,
cge10cod numeric(38) not null,
cge10nbd varchar(40) not null,
cge10usc varchar(30),
cge10psc varchar(30),
cge10act char(1) not null,
cge9cod numeric(38) not null,
cge17cod numeric(38) not null,
cge18con numeric(38) not null,
ts_rversion timestamp
) ;
-- dmap_object_gen_tag : type : alter table name : cge010
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge010 add primary key (cge1cod,cge10cod);
-- dmap_object_gen_tag : type : alter table name : cge010
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge010 alter column cge1cod set not null;
-- dmap_object_gen_tag : type : alter table name : cge010
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge010 alter column cge10cod set not null;
-- dmap_object_gen_tag : type : alter table name : cge010
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge010 alter column cge10nbd set not null;
-- dmap_object_gen_tag : type : alter table name : cge010
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge010 alter column cge10act set not null;
-- dmap_object_gen_tag : type : alter table name : cge010
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge010 alter column cge9cod set not null;
-- dmap_object_gen_tag : type : alter table name : cge010
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge010 alter column cge17cod set not null;
-- dmap_object_gen_tag : type : alter table name : cge010
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge010 alter column cge18con set not null;
-- dmap_object_gen_tag : type : alter table name : cge010
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge010 add constraint fk_cge010_cge001 foreign key (cge1cod) references cge001(cge1cod) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : cge010
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge010 add constraint fk_cge010_cge009 foreign key (cge9cod) references cge009(cge9cod) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : cge010
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge010 add constraint fk_cge010_cge018 foreign key (cge17cod,cge18con) references cge018(cge17cod,cge18con) on delete no action not deferrable initially immediate;
