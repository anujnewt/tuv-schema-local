-- dmap_object_gen_tag : type : table name : cge027
set search_path = fecxc,oracle,dmap_extension,public;
create table "cge027"  (
cge27cod char(2) not null,
cge27nom varchar(40) not null,
cgm1id numeric(38) not null,
cgm1im char(4) not null,
cgm1cd varchar(100) not null,
timestamp timestamp
) ;
-- dmap_object_gen_tag : type : alter table name : cge027
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge027 add primary key (cge27cod);
-- dmap_object_gen_tag : type : alter table name : cge027
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge027 alter column cge27cod set not null;
-- dmap_object_gen_tag : type : alter table name : cge027
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge027 alter column cge27nom set not null;
-- dmap_object_gen_tag : type : alter table name : cge027
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge027 alter column cgm1id set not null;
-- dmap_object_gen_tag : type : alter table name : cge027
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge027 alter column cgm1im set not null;
-- dmap_object_gen_tag : type : alter table name : cge027
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge027 alter column cgm1cd set not null;
