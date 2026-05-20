-- dmap_object_gen_tag : type : table name : cgx001
set search_path = fecxc,oracle,dmap_extension,public;
create table "cgx001"  (
cgpbat numeric(38) not null,
cgpmes numeric(38) not null,
cgppmf numeric(38) not null,
cgpuac numeric(38),
cgpumc numeric(38),
cgpano numeric(38) not null,
cgmloc varchar(2) not null,
cgmfun varchar(2),
cgppma numeric(38) not null,
bdcorp varchar(40),
cg5f52 numeric(38),
cgpnpe numeric(38),
cgppea numeric(38),
cgpupc numeric(38),
cgpppa numeric(38),
cgxori varchar(2),
cgxsub varchar(2),
cgpvpk char(1),
cgpdpf char(1),
cgpsgr numeric(38),
cg13gr numeric(38),
cgpttc char(1) not null,
cgpftc varchar(10) not null,
tipval char(1) not null,
cgmasi char(1),
cgx1av numeric(38),
cgx1ac numeric(38),
cgx1ii char(4),
cgx1if varchar(100),
cgx1i2 char(4),
cgx1i3 varchar(100),
cgx1gi char(4),
cgx1gf varchar(100),
cgx1g2 char(4),
cgx1g3 varchar(100),
cgx1se char(1),
timestamp timestamp
) ;
-- dmap_object_gen_tag : type : alter table name : cgx001
set search_path = fecxc,oracle,dmap_extension,public;
alter table cgx001 alter column cgpbat set not null;
-- dmap_object_gen_tag : type : alter table name : cgx001
set search_path = fecxc,oracle,dmap_extension,public;
alter table cgx001 alter column cgpmes set not null;
-- dmap_object_gen_tag : type : alter table name : cgx001
set search_path = fecxc,oracle,dmap_extension,public;
alter table cgx001 alter column cgppmf set not null;
-- dmap_object_gen_tag : type : alter table name : cgx001
set search_path = fecxc,oracle,dmap_extension,public;
alter table cgx001 alter column cgpano set not null;
-- dmap_object_gen_tag : type : alter table name : cgx001
set search_path = fecxc,oracle,dmap_extension,public;
alter table cgx001 alter column cgmloc set not null;
-- dmap_object_gen_tag : type : alter table name : cgx001
set search_path = fecxc,oracle,dmap_extension,public;
alter table cgx001 alter column cgppma set not null;
-- dmap_object_gen_tag : type : alter table name : cgx001
set search_path = fecxc,oracle,dmap_extension,public;
alter table cgx001 alter column cgpttc set not null;
-- dmap_object_gen_tag : type : alter table name : cgx001
set search_path = fecxc,oracle,dmap_extension,public;
alter table cgx001 alter column cgpftc set not null;
-- dmap_object_gen_tag : type : alter table name : cgx001
set search_path = fecxc,oracle,dmap_extension,public;
alter table cgx001 alter column tipval set not null;
