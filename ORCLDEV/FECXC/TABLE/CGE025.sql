-- dmap_object_gen_tag : type : table name : cge025
set search_path = fecxc,oracle,dmap_extension,public;
create table "cge025"  (
cge24cod numeric(38) not null,
cge15cod char(4) not null,
cge16con numeric(38) not null,
cge19con numeric(38) not null,
timestamp timestamp
) ;
-- dmap_object_gen_tag : type : alter table name : cge025
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge025 add primary key (cge24cod,cge15cod,cge16con,cge19con);
-- dmap_object_gen_tag : type : alter table name : cge025
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge025 alter column cge24cod set not null;
-- dmap_object_gen_tag : type : alter table name : cge025
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge025 alter column cge15cod set not null;
-- dmap_object_gen_tag : type : alter table name : cge025
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge025 alter column cge16con set not null;
-- dmap_object_gen_tag : type : alter table name : cge025
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge025 alter column cge19con set not null;
-- dmap_object_gen_tag : type : alter table name : cge025
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge025 add constraint fk_cge025_cge019 foreign key (cge15cod,cge16con,cge19con) references cge019(cge15cod,cge16con,cge19con) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : cge025
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge025 add constraint fk_cge025_cge024 foreign key (cge24cod) references cge024(cge24cod) on delete no action not deferrable initially immediate;
