-- dmap_object_gen_tag : type : table name : cget03
set search_path = fecxc,oracle,dmap_extension,public;
create table "cget03"  (
cgecbat numeric(38) not null,
cgeclin numeric(38) not null,
cgexori char(2) not null,
cgexsub char(2) not null,
cgexrf1 varchar(12),
cgexrf2 varchar(12),
cgextip varchar(1) not null,
cgexmon numeric not null,
cgextcm numeric not null,
cgexdes varchar(30),
moncod char(2) not null,
cgm1id numeric(38) not null,
cgm1im char(4) not null,
cgm1cd varchar(100) not null,
timestamp timestamp
) ;
-- dmap_object_gen_tag : type : alter table name : cget03
set search_path = fecxc,oracle,dmap_extension,public;
alter table cget03 add primary key (cgecbat,cgeclin);
-- dmap_object_gen_tag : type : alter table name : cget03
set search_path = fecxc,oracle,dmap_extension,public;
alter table cget03 alter column cgecbat set not null;
-- dmap_object_gen_tag : type : alter table name : cget03
set search_path = fecxc,oracle,dmap_extension,public;
alter table cget03 alter column cgeclin set not null;
-- dmap_object_gen_tag : type : alter table name : cget03
set search_path = fecxc,oracle,dmap_extension,public;
alter table cget03 alter column cgexori set not null;
-- dmap_object_gen_tag : type : alter table name : cget03
set search_path = fecxc,oracle,dmap_extension,public;
alter table cget03 alter column cgexsub set not null;
-- dmap_object_gen_tag : type : alter table name : cget03
set search_path = fecxc,oracle,dmap_extension,public;
alter table cget03 alter column cgextip set not null;
-- dmap_object_gen_tag : type : alter table name : cget03
set search_path = fecxc,oracle,dmap_extension,public;
alter table cget03 alter column cgexmon set not null;
-- dmap_object_gen_tag : type : alter table name : cget03
set search_path = fecxc,oracle,dmap_extension,public;
alter table cget03 alter column cgextcm set not null;
-- dmap_object_gen_tag : type : alter table name : cget03
set search_path = fecxc,oracle,dmap_extension,public;
alter table cget03 alter column moncod set not null;
-- dmap_object_gen_tag : type : alter table name : cget03
set search_path = fecxc,oracle,dmap_extension,public;
alter table cget03 alter column cgm1id set not null;
-- dmap_object_gen_tag : type : alter table name : cget03
set search_path = fecxc,oracle,dmap_extension,public;
alter table cget03 alter column cgm1im set not null;
-- dmap_object_gen_tag : type : alter table name : cget03
set search_path = fecxc,oracle,dmap_extension,public;
alter table cget03 alter column cgm1cd set not null;
-- dmap_object_gen_tag : type : alter table name : cget03
set search_path = fecxc,oracle,dmap_extension,public;
alter table cget03 add constraint fk_cget03_cgem03 foreign key (cgexori,cgexsub) references cgem03(cgexori,cgexsub) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : cget03
set search_path = fecxc,oracle,dmap_extension,public;
alter table cget03 add constraint fk_cget03_cget02 foreign key (cgecbat) references cget02(cgecbat) on delete no action not deferrable initially immediate;
