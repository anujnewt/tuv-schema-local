-- dmap_object_gen_tag : type : table name : cge024
set search_path = fecxc,oracle,dmap_extension,public;
create table "cge024"  (
cge24cod numeric(38) not null,
cge24nom varchar(40) not null,
ts_rversion timestamp
) ;
-- dmap_object_gen_tag : type : alter table name : cge024
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge024 add primary key (cge24cod);
-- dmap_object_gen_tag : type : alter table name : cge024
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge024 alter column cge24cod set not null;
-- dmap_object_gen_tag : type : alter table name : cge024
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge024 alter column cge24nom set not null;
