-- dmap_object_gen_tag : type : table name : cge011
set search_path = fecxc,oracle,dmap_extension,public;
create table "cge011"  (
cge11cod numeric(38) not null,
cge11des varchar(40) not null,
cge11can numeric(38) not null,
ts_rversion timestamp
) ;
-- dmap_object_gen_tag : type : alter table name : cge011
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge011 add primary key (cge11cod);
-- dmap_object_gen_tag : type : alter table name : cge011
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge011 alter column cge11cod set not null;
-- dmap_object_gen_tag : type : alter table name : cge011
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge011 alter column cge11des set not null;
-- dmap_object_gen_tag : type : alter table name : cge011
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge011 alter column cge11can set not null;
