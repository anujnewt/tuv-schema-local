-- dmap_object_gen_tag : type : table name : cge013
set search_path = fecxc,oracle,dmap_extension,public;
create table "cge013"  (
cge13cod numeric(38) not null,
cge13des varchar(40) not null,
cge13mar varchar(40) not null,
cge13ver varchar(20) not null,
ts_rversion timestamp
) ;
-- dmap_object_gen_tag : type : alter table name : cge013
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge013 add primary key (cge13cod);
-- dmap_object_gen_tag : type : alter table name : cge013
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge013 alter column cge13cod set not null;
-- dmap_object_gen_tag : type : alter table name : cge013
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge013 alter column cge13des set not null;
-- dmap_object_gen_tag : type : alter table name : cge013
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge013 alter column cge13mar set not null;
-- dmap_object_gen_tag : type : alter table name : cge013
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge013 alter column cge13ver set not null;
