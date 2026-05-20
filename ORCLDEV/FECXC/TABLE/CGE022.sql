-- dmap_object_gen_tag : type : table name : cge022
set search_path = fecxc,oracle,dmap_extension,public;
create table "cge022"  (
cge1cod char(5) not null,
cge15cod char(4) not null,
cge22fec timestamp not null,
cge10cod numeric(38) not null,
cge16con numeric(38) not null,
cge14fec timestamp not null,
cge14usr varchar(30) not null,
timestamp timestamp
) ;
-- dmap_object_gen_tag : type : alter table name : cge022
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge022 add primary key (cge1cod,cge15cod,cge22fec);
-- dmap_object_gen_tag : type : alter table name : cge022
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge022 alter column cge1cod set not null;
-- dmap_object_gen_tag : type : alter table name : cge022
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge022 alter column cge15cod set not null;
-- dmap_object_gen_tag : type : alter table name : cge022
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge022 alter column cge22fec set not null;
-- dmap_object_gen_tag : type : alter table name : cge022
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge022 alter column cge10cod set not null;
-- dmap_object_gen_tag : type : alter table name : cge022
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge022 alter column cge16con set not null;
-- dmap_object_gen_tag : type : alter table name : cge022
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge022 alter column cge14fec set not null;
-- dmap_object_gen_tag : type : alter table name : cge022
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge022 alter column cge14usr set not null;
-- dmap_object_gen_tag : type : alter table name : cge022
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge022 add constraint fk_cge022_cge014 foreign key (cge1cod,cge15cod) references cge014(cge1cod,cge15cod) on delete no action not deferrable initially immediate;
