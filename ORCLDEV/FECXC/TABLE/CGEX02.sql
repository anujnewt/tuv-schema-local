-- dmap_object_gen_tag : type : table name : cgex02
set search_path = fecxc,oracle,dmap_extension,public;
create table "cgex02"  (
cgecbat numeric(38) not null,
cgexfec timestamp not null,
cge1cod char(5) not null,
cge5cod varchar(5) not null,
cge1eaf char(5) not null,
cgexdes varchar(30) not null,
cge5saf char(5) not null,
cgexusr varchar(30) not null,
cgexdeb numeric not null,
cgexcre numeric not null,
cgexdoc varchar(12) not null,
cgexmon numeric not null,
moncod char(2) not null,
cgextcm numeric not null,
cgexeli char(1) not null,
timestamp timestamp
) ;
-- dmap_object_gen_tag : type : alter table name : cgex02
set search_path = fecxc,oracle,dmap_extension,public;
alter table cgex02 add primary key (cgecbat);
-- dmap_object_gen_tag : type : alter table name : cgex02
set search_path = fecxc,oracle,dmap_extension,public;
alter table cgex02 alter column cgecbat set not null;
-- dmap_object_gen_tag : type : alter table name : cgex02
set search_path = fecxc,oracle,dmap_extension,public;
alter table cgex02 alter column cgexfec set not null;
-- dmap_object_gen_tag : type : alter table name : cgex02
set search_path = fecxc,oracle,dmap_extension,public;
alter table cgex02 alter column cge1cod set not null;
-- dmap_object_gen_tag : type : alter table name : cgex02
set search_path = fecxc,oracle,dmap_extension,public;
alter table cgex02 alter column cge5cod set not null;
-- dmap_object_gen_tag : type : alter table name : cgex02
set search_path = fecxc,oracle,dmap_extension,public;
alter table cgex02 alter column cge1eaf set not null;
-- dmap_object_gen_tag : type : alter table name : cgex02
set search_path = fecxc,oracle,dmap_extension,public;
alter table cgex02 alter column cgexdes set not null;
-- dmap_object_gen_tag : type : alter table name : cgex02
set search_path = fecxc,oracle,dmap_extension,public;
alter table cgex02 alter column cge5saf set not null;
-- dmap_object_gen_tag : type : alter table name : cgex02
set search_path = fecxc,oracle,dmap_extension,public;
alter table cgex02 alter column cgexusr set not null;
-- dmap_object_gen_tag : type : alter table name : cgex02
set search_path = fecxc,oracle,dmap_extension,public;
alter table cgex02 alter column cgexdeb set not null;
-- dmap_object_gen_tag : type : alter table name : cgex02
set search_path = fecxc,oracle,dmap_extension,public;
alter table cgex02 alter column cgexcre set not null;
-- dmap_object_gen_tag : type : alter table name : cgex02
set search_path = fecxc,oracle,dmap_extension,public;
alter table cgex02 alter column cgexdoc set not null;
-- dmap_object_gen_tag : type : alter table name : cgex02
set search_path = fecxc,oracle,dmap_extension,public;
alter table cgex02 alter column cgexmon set not null;
-- dmap_object_gen_tag : type : alter table name : cgex02
set search_path = fecxc,oracle,dmap_extension,public;
alter table cgex02 alter column moncod set not null;
-- dmap_object_gen_tag : type : alter table name : cgex02
set search_path = fecxc,oracle,dmap_extension,public;
alter table cgex02 alter column cgextcm set not null;
-- dmap_object_gen_tag : type : alter table name : cgex02
set search_path = fecxc,oracle,dmap_extension,public;
alter table cgex02 alter column cgexeli set not null;
