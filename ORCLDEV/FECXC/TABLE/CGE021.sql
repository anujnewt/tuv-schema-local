-- dmap_object_gen_tag : type : table name : cge021
set search_path = fecxc,oracle,dmap_extension,public;
create table "cge021"  (
cge20cod numeric(38) not null,
cge1cod char(5) not null,
cge15cod char(4) not null,
cge21fec timestamp not null,
timestamp timestamp
) ;
-- dmap_object_gen_tag : type : alter table name : cge021
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge021 add primary key (cge20cod,cge1cod,cge15cod);
-- dmap_object_gen_tag : type : alter table name : cge021
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge021 alter column cge20cod set not null;
-- dmap_object_gen_tag : type : alter table name : cge021
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge021 alter column cge1cod set not null;
-- dmap_object_gen_tag : type : alter table name : cge021
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge021 alter column cge15cod set not null;
-- dmap_object_gen_tag : type : alter table name : cge021
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge021 alter column cge21fec set not null;
-- dmap_object_gen_tag : type : alter table name : cge021
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge021 add constraint fk_cge021_cge001 foreign key (cge1cod) references cge001(cge1cod) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : cge021
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge021 add constraint fk_cge021_cge015 foreign key (cge15cod) references cge015(cge15cod) on delete no action not deferrable initially immediate;
