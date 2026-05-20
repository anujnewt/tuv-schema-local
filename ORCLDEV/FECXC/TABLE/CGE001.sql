-- dmap_object_gen_tag : type : table name : cge001
set search_path = fecxc,oracle,dmap_extension,public;
create table "cge001"  (
cge1cod char(5) not null,
cge1des varchar(40) not null,
cge1dbl varchar(30),
cge1bdi varchar(30),
cge1bdc varchar(30),
cge1rep varchar(50),
cge1tel1 varchar(15),
cge1tel2 varchar(15),
cge1fax varchar(15),
cge1mail varchar(40),
ts_rversion timestamp
) ;
-- dmap_object_gen_tag : type : alter table name : cge001
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge001 add primary key (cge1cod);
-- dmap_object_gen_tag : type : alter table name : cge001
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge001 alter column cge1cod set not null;
-- dmap_object_gen_tag : type : alter table name : cge001
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge001 alter column cge1des set not null;
