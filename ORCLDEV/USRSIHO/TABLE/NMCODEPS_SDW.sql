-- dmap_object_gen_tag : type : table name : nmcodeps_sdw
set search_path = usrsiho,oracle,dmap_extension,public;
create table "nmcodeps_sdw"  (
marca_act varchar(2),
cmd varchar(15),
old_dep_keydep varchar(16),
old_dep_desdep varchar(40),
new_dep_keydep varchar(16),
new_dep_desdep varchar(40),
orderid1 timestamp(0),
orderid2 numeric(10) not null
) ;
-- dmap_object_gen_tag : type : alter table name : nmcodeps_sdw
set search_path = usrsiho,oracle,dmap_extension,public;
alter table nmcodeps_sdw add constraint pk_nmcodeps_sdw primary key (orderid2);
-- dmap_object_gen_tag : type : alter table name : nmcodeps_sdw
set search_path = usrsiho,oracle,dmap_extension,public;
alter table nmcodeps_sdw alter column orderid2 set not null;
