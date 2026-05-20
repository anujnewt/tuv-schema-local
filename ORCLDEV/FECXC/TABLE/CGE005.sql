-- dmap_object_gen_tag : type : table name : cge005
set search_path = fecxc,oracle,dmap_extension,public;
create table "cge005"  (
cge1cod char(5) not null,
cge5cod varchar(5) not null,
cge5des varchar(40) not null,
cge5res varchar(40),
cge5tel varchar(15),
cge5fax varchar(15),
cge5mai varchar(50),
ts_rversion timestamp
) ;
-- dmap_object_gen_tag : type : alter table name : cge005
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge005 add primary key (cge1cod,cge5cod);
-- dmap_object_gen_tag : type : alter table name : cge005
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge005 alter column cge1cod set not null;
-- dmap_object_gen_tag : type : alter table name : cge005
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge005 alter column cge5cod set not null;
-- dmap_object_gen_tag : type : alter table name : cge005
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge005 alter column cge5des set not null;
-- dmap_object_gen_tag : type : alter table name : cge005
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge005 add constraint fk_cge005_cge001 foreign key (cge1cod) references cge001(cge1cod) on delete no action not deferrable initially immediate;
