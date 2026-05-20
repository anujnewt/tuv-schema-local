-- dmap_object_gen_tag : type : table name : cge014
set search_path = fecxc,oracle,dmap_extension,public;
create table "cge014"  (
cge1cod char(5) not null,
cge15cod char(4) not null,
cge16con numeric(38) not null,
cge10cod numeric(38) not null,
cge14fec timestamp not null,
cge14usr varchar(30) not null,
cge14ccn varchar(50) not null,
ts_rversion timestamp
) ;
-- dmap_object_gen_tag : type : alter table name : cge014
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge014 add primary key (cge1cod,cge15cod);
-- dmap_object_gen_tag : type : alter table name : cge014
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge014 alter column cge1cod set not null;
-- dmap_object_gen_tag : type : alter table name : cge014
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge014 alter column cge15cod set not null;
-- dmap_object_gen_tag : type : alter table name : cge014
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge014 alter column cge16con set not null;
-- dmap_object_gen_tag : type : alter table name : cge014
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge014 alter column cge10cod set not null;
-- dmap_object_gen_tag : type : alter table name : cge014
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge014 alter column cge14fec set not null;
-- dmap_object_gen_tag : type : alter table name : cge014
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge014 alter column cge14usr set not null;
-- dmap_object_gen_tag : type : alter table name : cge014
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge014 alter column cge14ccn set not null;
-- dmap_object_gen_tag : type : alter table name : cge014
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge014 add constraint fk_cge014_cge001 foreign key (cge1cod) references cge001(cge1cod) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : cge014
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge014 add constraint fk_cge014_cge010 foreign key (cge1cod,cge10cod) references cge010(cge1cod,cge10cod) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : cge014
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge014 add constraint fk_cge014_cge015 foreign key (cge15cod) references cge015(cge15cod) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : cge014
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge014 add constraint fk_cge014_cge016 foreign key (cge15cod,cge16con) references cge016(cge15cod,cge16con) on delete no action not deferrable initially immediate;
