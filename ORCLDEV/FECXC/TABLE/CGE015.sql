-- dmap_object_gen_tag : type : table name : cge015
set search_path = fecxc,oracle,dmap_extension,public;
create table "cge015"  (
cge15cod char(4) not null,
cge15nom varchar(40) not null,
cge15url varchar(60),
ts_rversion timestamp
) ;
-- dmap_object_gen_tag : type : alter table name : cge015
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge015 add primary key (cge15cod);
-- dmap_object_gen_tag : type : alter table name : cge015
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge015 alter column cge15cod set not null;
-- dmap_object_gen_tag : type : alter table name : cge015
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge015 alter column cge15nom set not null;
