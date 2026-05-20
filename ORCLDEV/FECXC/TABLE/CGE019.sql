-- dmap_object_gen_tag : type : table name : cge019
set search_path = fecxc,oracle,dmap_extension,public;
create table "cge019"  (
cge15cod char(4) not null,
cge16con numeric(38) not null,
cge19con numeric(38) not null,
cge19dad numeric(38),
cge19nom varchar(60) not null,
cge19tip char(1) not null,
cge19inf varchar(255),
cge19lab varchar(100) not null,
cge19lnk varchar(255) not null,
cge19sec numeric(38),
ts_rversion timestamp
) ;
-- dmap_object_gen_tag : type : alter table name : cge019
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge019 add primary key (cge15cod,cge16con,cge19con);
-- dmap_object_gen_tag : type : alter table name : cge019
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge019 alter column cge15cod set not null;
-- dmap_object_gen_tag : type : alter table name : cge019
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge019 alter column cge16con set not null;
-- dmap_object_gen_tag : type : alter table name : cge019
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge019 alter column cge19con set not null;
-- dmap_object_gen_tag : type : alter table name : cge019
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge019 alter column cge19nom set not null;
-- dmap_object_gen_tag : type : alter table name : cge019
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge019 alter column cge19tip set not null;
-- dmap_object_gen_tag : type : alter table name : cge019
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge019 alter column cge19lab set not null;
-- dmap_object_gen_tag : type : alter table name : cge019
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge019 alter column cge19lnk set not null;
-- dmap_object_gen_tag : type : alter table name : cge019
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge019 add constraint fk_cge019_cge016 foreign key (cge15cod,cge16con) references cge016(cge15cod,cge16con) on delete no action not deferrable initially immediate;
