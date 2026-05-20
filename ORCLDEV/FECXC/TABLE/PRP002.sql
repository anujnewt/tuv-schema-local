-- dmap_object_gen_tag : type : table name : prp002
set search_path = fecxc,oracle,dmap_extension,public;
create table "prp002"  (
prp2per numeric(38) not null,
prp2form varchar(1) not null,
prp2est numeric(38),
prp7ide numeric(38) not null,
prp2sub numeric(38) not null,
prp2tipo char(1),
prp2can numeric(38) not null,
prp2fec timestamp not null,
prp2fecf timestamp not null,
prp2fece timestamp,
prp2fecr timestamp not null,
prp2fecl timestamp not null,
prpconci numeric(38),
prpconce numeric(38),
prpconct numeric(38),
prpconex numeric(38),
prpconaj numeric(38) not null,
prp2nap numeric(38),
cge1cod char(5) not null,
cge5cod varchar(5) not null,
prp2npr numeric(38),
prp2nep numeric(38),
timestamp timestamp,
prp2mce numeric(38)
) ;
-- dmap_object_gen_tag : type : alter table name : prp002
set search_path = fecxc,oracle,dmap_extension,public;
alter table prp002 add primary key (prp2per);
-- dmap_object_gen_tag : type : alter table name : prp002
set search_path = fecxc,oracle,dmap_extension,public;
alter table prp002 alter column prp2per set not null;
-- dmap_object_gen_tag : type : alter table name : prp002
set search_path = fecxc,oracle,dmap_extension,public;
alter table prp002 alter column prp2form set not null;
-- dmap_object_gen_tag : type : alter table name : prp002
set search_path = fecxc,oracle,dmap_extension,public;
alter table prp002 alter column prp7ide set not null;
-- dmap_object_gen_tag : type : alter table name : prp002
set search_path = fecxc,oracle,dmap_extension,public;
alter table prp002 alter column prp2sub set not null;
-- dmap_object_gen_tag : type : alter table name : prp002
set search_path = fecxc,oracle,dmap_extension,public;
alter table prp002 alter column prp2can set not null;
-- dmap_object_gen_tag : type : alter table name : prp002
set search_path = fecxc,oracle,dmap_extension,public;
alter table prp002 alter column prp2fec set not null;
-- dmap_object_gen_tag : type : alter table name : prp002
set search_path = fecxc,oracle,dmap_extension,public;
alter table prp002 alter column prp2fecf set not null;
-- dmap_object_gen_tag : type : alter table name : prp002
set search_path = fecxc,oracle,dmap_extension,public;
alter table prp002 alter column prp2fecr set not null;
-- dmap_object_gen_tag : type : alter table name : prp002
set search_path = fecxc,oracle,dmap_extension,public;
alter table prp002 alter column prp2fecl set not null;
-- dmap_object_gen_tag : type : alter table name : prp002
set search_path = fecxc,oracle,dmap_extension,public;
alter table prp002 alter column prpconaj set not null;
-- dmap_object_gen_tag : type : alter table name : prp002
set search_path = fecxc,oracle,dmap_extension,public;
alter table prp002 alter column cge1cod set not null;
-- dmap_object_gen_tag : type : alter table name : prp002
set search_path = fecxc,oracle,dmap_extension,public;
alter table prp002 alter column cge5cod set not null;
