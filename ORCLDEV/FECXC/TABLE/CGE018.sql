-- dmap_object_gen_tag : type : table name : cge018
set search_path = fecxc,oracle,dmap_extension,public;
create table "cge018"  (
cge17cod numeric(38) not null,
cge18con numeric(38) not null,
cge18ver varchar(30) not null,
ts_rversion timestamp
) ;
-- dmap_object_gen_tag : type : alter table name : cge018
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge018 add primary key (cge17cod,cge18con);
-- dmap_object_gen_tag : type : alter table name : cge018
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge018 alter column cge17cod set not null;
-- dmap_object_gen_tag : type : alter table name : cge018
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge018 alter column cge18con set not null;
-- dmap_object_gen_tag : type : alter table name : cge018
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge018 alter column cge18ver set not null;
-- dmap_object_gen_tag : type : alter table name : cge018
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge018 add constraint fk_cge018_cge017 foreign key (cge17cod) references cge017(cge17cod) on delete no action not deferrable initially immediate;
