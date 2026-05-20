-- dmap_object_gen_tag : type : table name : cge002
set search_path = fecxc,oracle,dmap_extension,public;
create table "cge002"  (
cge1cod char(5) not null,
cgm1idd numeric(38) not null,
cgm1imd char(4) not null,
cgm1cdd varchar(100) not null,
cgm1idc numeric(38) not null,
cgm1imc char(4) not null,
cgm1cdc varchar(100) not null,
timestamp timestamp
) ;
-- dmap_object_gen_tag : type : alter table name : cge002
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge002 add primary key (cge1cod);
-- dmap_object_gen_tag : type : alter table name : cge002
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge002 alter column cge1cod set not null;
-- dmap_object_gen_tag : type : alter table name : cge002
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge002 alter column cgm1idd set not null;
-- dmap_object_gen_tag : type : alter table name : cge002
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge002 alter column cgm1imd set not null;
-- dmap_object_gen_tag : type : alter table name : cge002
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge002 alter column cgm1cdd set not null;
-- dmap_object_gen_tag : type : alter table name : cge002
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge002 alter column cgm1idc set not null;
-- dmap_object_gen_tag : type : alter table name : cge002
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge002 alter column cgm1imc set not null;
-- dmap_object_gen_tag : type : alter table name : cge002
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge002 alter column cgm1cdc set not null;
-- dmap_object_gen_tag : type : alter table name : cge002
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge002 add constraint fk_cge002_cge001 foreign key (cge1cod) references cge001(cge1cod) on delete no action not deferrable initially immediate;
