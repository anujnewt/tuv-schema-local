-- dmap_object_gen_tag : type : table name : cge016
set search_path = fecxc,oracle,dmap_extension,public;
create table "cge016"  (
cge15cod char(4) not null,
cge16con numeric(38) not null,
cge16ver numeric(38) not null,
cge16mej numeric(38) not null,
cge16cor numeric(38) not null,
cge16for varchar(12) not null,
cge16doc char(1) not null,
cge16man char(1) not null,
cge16fec timestamp,
cge16not varchar(250),
ts_rversion timestamp
) ;
-- dmap_object_gen_tag : type : alter table name : cge016
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge016 add primary key (cge15cod,cge16con);
-- dmap_object_gen_tag : type : alter table name : cge016
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge016 alter column cge15cod set not null;
-- dmap_object_gen_tag : type : alter table name : cge016
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge016 alter column cge16con set not null;
-- dmap_object_gen_tag : type : alter table name : cge016
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge016 alter column cge16ver set not null;
-- dmap_object_gen_tag : type : alter table name : cge016
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge016 alter column cge16mej set not null;
-- dmap_object_gen_tag : type : alter table name : cge016
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge016 alter column cge16cor set not null;
-- dmap_object_gen_tag : type : alter table name : cge016
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge016 alter column cge16for set not null;
-- dmap_object_gen_tag : type : alter table name : cge016
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge016 alter column cge16doc set not null;
-- dmap_object_gen_tag : type : alter table name : cge016
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge016 alter column cge16man set not null;
-- dmap_object_gen_tag : type : alter table name : cge016
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge016 add constraint fk_cge016_cge015 foreign key (cge15cod) references cge015(cge15cod) on delete no action not deferrable initially immediate;
