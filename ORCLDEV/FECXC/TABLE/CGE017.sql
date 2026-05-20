-- dmap_object_gen_tag : type : table name : cge017
set search_path = fecxc,oracle,dmap_extension,public;
create table "cge017"  (
cge17cod numeric(38) not null,
cge17nom varchar(40) not null,
cge17fab varchar(40) not null,
ts_rversion timestamp
) ;
-- dmap_object_gen_tag : type : alter table name : cge017
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge017 add primary key (cge17cod);
-- dmap_object_gen_tag : type : alter table name : cge017
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge017 alter column cge17cod set not null;
-- dmap_object_gen_tag : type : alter table name : cge017
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge017 alter column cge17nom set not null;
-- dmap_object_gen_tag : type : alter table name : cge017
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge017 alter column cge17fab set not null;
