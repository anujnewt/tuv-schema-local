-- dmap_object_gen_tag : type : table name : cge012
set search_path = fecxc,oracle,dmap_extension,public;
create table "cge012"  (
cge1cod char(5) not null,
cge12deu char(5) not null,
cge12por numeric not null,
ts_rversion timestamp
) ;
-- dmap_object_gen_tag : type : alter table name : cge012
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge012 add primary key (cge1cod,cge12deu);
-- dmap_object_gen_tag : type : alter table name : cge012
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge012 alter column cge1cod set not null;
-- dmap_object_gen_tag : type : alter table name : cge012
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge012 alter column cge12deu set not null;
-- dmap_object_gen_tag : type : alter table name : cge012
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge012 alter column cge12por set not null;
-- dmap_object_gen_tag : type : alter table name : cge012
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge012 add constraint fk_cge012_cge001 foreign key (cge1cod) references cge001(cge1cod) on delete no action not deferrable initially immediate;
