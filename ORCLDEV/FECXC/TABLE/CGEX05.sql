-- dmap_object_gen_tag : type : table name : cgex05
set search_path = fecxc,oracle,dmap_extension,public;
create table "cgex05"  (
cgecbat numeric(38) not null,
cgeclin numeric(38) not null,
cgexdoc varchar(12) not null,
cgexfec timestamp not null,
cge27cod char(2) not null,
cge1cod char(5) not null,
cge5cod varchar(5) not null,
cgexmon numeric not null,
moncod char(2) not null,
cgextcm numeric not null,
cgm1id numeric(38),
cgm1im char(4) not null,
cgm1cd varchar(100) not null,
cgextip char(1) not null,
cgexeli char(1) not null,
cgexrf1 varchar(12),
cgexrf2 varchar(12),
timestamp timestamp
) ;
-- dmap_object_gen_tag : type : alter table name : cgex05
set search_path = fecxc,oracle,dmap_extension,public;
alter table cgex05 add primary key (cgecbat,cgeclin);
-- dmap_object_gen_tag : type : alter table name : cgex05
set search_path = fecxc,oracle,dmap_extension,public;
alter table cgex05 alter column cgecbat set not null;
-- dmap_object_gen_tag : type : alter table name : cgex05
set search_path = fecxc,oracle,dmap_extension,public;
alter table cgex05 alter column cgeclin set not null;
-- dmap_object_gen_tag : type : alter table name : cgex05
set search_path = fecxc,oracle,dmap_extension,public;
alter table cgex05 alter column cgexdoc set not null;
-- dmap_object_gen_tag : type : alter table name : cgex05
set search_path = fecxc,oracle,dmap_extension,public;
alter table cgex05 alter column cgexfec set not null;
-- dmap_object_gen_tag : type : alter table name : cgex05
set search_path = fecxc,oracle,dmap_extension,public;
alter table cgex05 alter column cge27cod set not null;
-- dmap_object_gen_tag : type : alter table name : cgex05
set search_path = fecxc,oracle,dmap_extension,public;
alter table cgex05 alter column cge1cod set not null;
-- dmap_object_gen_tag : type : alter table name : cgex05
set search_path = fecxc,oracle,dmap_extension,public;
alter table cgex05 alter column cge5cod set not null;
-- dmap_object_gen_tag : type : alter table name : cgex05
set search_path = fecxc,oracle,dmap_extension,public;
alter table cgex05 alter column cgexmon set not null;
-- dmap_object_gen_tag : type : alter table name : cgex05
set search_path = fecxc,oracle,dmap_extension,public;
alter table cgex05 alter column moncod set not null;
-- dmap_object_gen_tag : type : alter table name : cgex05
set search_path = fecxc,oracle,dmap_extension,public;
alter table cgex05 alter column cgextcm set not null;
-- dmap_object_gen_tag : type : alter table name : cgex05
set search_path = fecxc,oracle,dmap_extension,public;
alter table cgex05 alter column cgm1im set not null;
-- dmap_object_gen_tag : type : alter table name : cgex05
set search_path = fecxc,oracle,dmap_extension,public;
alter table cgex05 alter column cgm1cd set not null;
-- dmap_object_gen_tag : type : alter table name : cgex05
set search_path = fecxc,oracle,dmap_extension,public;
alter table cgex05 alter column cgextip set not null;
-- dmap_object_gen_tag : type : alter table name : cgex05
set search_path = fecxc,oracle,dmap_extension,public;
alter table cgex05 alter column cgexeli set not null;
-- dmap_object_gen_tag : type : alter table name : cgex05
set search_path = fecxc,oracle,dmap_extension,public;
alter table cgex05 add constraint fk_cgex05_ccm001 foreign key (moncod) references ccm001(moncod) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : cgex05
set search_path = fecxc,oracle,dmap_extension,public;
alter table cgex05 add constraint fk_cgex05_cge005 foreign key (cge1cod,cge5cod) references cge005(cge1cod,cge5cod) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : cgex05
set search_path = fecxc,oracle,dmap_extension,public;
alter table cgex05 add constraint fk_cgex05_cge027 foreign key (cge27cod) references cge027(cge27cod) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : cgex05
set search_path = fecxc,oracle,dmap_extension,public;
alter table cgex05 add constraint fk_cgex05_cgex04 foreign key (cgecbat) references cgex04(cgecbat) on delete no action not deferrable initially immediate;
