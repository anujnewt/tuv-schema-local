-- dmap_object_gen_tag : type : table name : cge026
set search_path = fecxc,oracle,dmap_extension,public;
create table "cge026"  (
cge1cod char(5) not null,
cge20cod numeric(38) not null,
cge24cod numeric(38) not null,
timestamp timestamp
) ;
-- dmap_object_gen_tag : type : alter table name : cge026
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge026 add primary key (cge1cod,cge20cod,cge24cod);
-- dmap_object_gen_tag : type : alter table name : cge026
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge026 alter column cge1cod set not null;
-- dmap_object_gen_tag : type : alter table name : cge026
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge026 alter column cge20cod set not null;
-- dmap_object_gen_tag : type : alter table name : cge026
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge026 alter column cge24cod set not null;
-- dmap_object_gen_tag : type : alter table name : cge026
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge026 add constraint fk_cge026_cge001 foreign key (cge1cod) references cge001(cge1cod) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : cge026
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge026 add constraint fk_cge026_cge024 foreign key (cge24cod) references cge024(cge24cod) on delete no action not deferrable initially immediate;
