-- dmap_object_gen_tag : type : table name : cgex04
set search_path = fecxc,oracle,dmap_extension,public;
create table "cgex04"  (
cgecbat numeric(38) not null,
cge1cod char(5) not null,
cge5cod varchar(5) not null,
cgexdoc varchar(12) not null,
cgexusr varchar(30) not null,
cgexfec timestamp not null,
cgexmon numeric not null,
moncod char(2) not null,
cgextcm numeric not null,
cgexmic char(1) not null,
ctdtip char(1) not null,
cgexdes varchar(30) not null,
cgm1id numeric(38),
cgm1im char(4) not null,
cgm1cd varchar(100) not null,
cge27cod char(2),
timestamp timestamp
) ;
-- dmap_object_gen_tag : type : alter table name : cgex04
set search_path = fecxc,oracle,dmap_extension,public;
alter table cgex04 add primary key (cgecbat);
-- dmap_object_gen_tag : type : alter table name : cgex04
set search_path = fecxc,oracle,dmap_extension,public;
alter table cgex04 alter column cgecbat set not null;
-- dmap_object_gen_tag : type : alter table name : cgex04
set search_path = fecxc,oracle,dmap_extension,public;
alter table cgex04 alter column cge1cod set not null;
-- dmap_object_gen_tag : type : alter table name : cgex04
set search_path = fecxc,oracle,dmap_extension,public;
alter table cgex04 alter column cge5cod set not null;
-- dmap_object_gen_tag : type : alter table name : cgex04
set search_path = fecxc,oracle,dmap_extension,public;
alter table cgex04 alter column cgexdoc set not null;
-- dmap_object_gen_tag : type : alter table name : cgex04
set search_path = fecxc,oracle,dmap_extension,public;
alter table cgex04 alter column cgexusr set not null;
-- dmap_object_gen_tag : type : alter table name : cgex04
set search_path = fecxc,oracle,dmap_extension,public;
alter table cgex04 alter column cgexfec set not null;
-- dmap_object_gen_tag : type : alter table name : cgex04
set search_path = fecxc,oracle,dmap_extension,public;
alter table cgex04 alter column cgexmon set not null;
-- dmap_object_gen_tag : type : alter table name : cgex04
set search_path = fecxc,oracle,dmap_extension,public;
alter table cgex04 alter column moncod set not null;
-- dmap_object_gen_tag : type : alter table name : cgex04
set search_path = fecxc,oracle,dmap_extension,public;
alter table cgex04 alter column cgextcm set not null;
-- dmap_object_gen_tag : type : alter table name : cgex04
set search_path = fecxc,oracle,dmap_extension,public;
alter table cgex04 alter column cgexmic set not null;
-- dmap_object_gen_tag : type : alter table name : cgex04
set search_path = fecxc,oracle,dmap_extension,public;
alter table cgex04 alter column ctdtip set not null;
-- dmap_object_gen_tag : type : alter table name : cgex04
set search_path = fecxc,oracle,dmap_extension,public;
alter table cgex04 alter column cgexdes set not null;
-- dmap_object_gen_tag : type : alter table name : cgex04
set search_path = fecxc,oracle,dmap_extension,public;
alter table cgex04 alter column cgm1im set not null;
-- dmap_object_gen_tag : type : alter table name : cgex04
set search_path = fecxc,oracle,dmap_extension,public;
alter table cgex04 alter column cgm1cd set not null;
-- dmap_object_gen_tag : type : alter table name : cgex04
set search_path = fecxc,oracle,dmap_extension,public;
alter table cgex04 add constraint fk_cgex04_cge005 foreign key (cge1cod,cge5cod) references cge005(cge1cod,cge5cod) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : cgex04
set search_path = fecxc,oracle,dmap_extension,public;
alter table cgex04 add constraint fk_cgex04_cge027 foreign key (cge27cod) references cge027(cge27cod) on delete no action not deferrable initially immediate;
