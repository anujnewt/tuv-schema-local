-- dmap_object_gen_tag : type : table name : nmloproc_sdw
set search_path = usrsiho,oracle,dmap_extension,public;
create table "nmloproc_sdw"  (
marca_act varchar(2),
cmd varchar(15),
old_pro_keypro numeric(5),
old_pro_despro varchar(20),
old_pro_keycia varchar(4),
new_pro_keycia varchar(4),
new_pro_keypro numeric(5),
new_pro_despro varchar(20),
orderid1 timestamp(0),
orderid2 numeric(10) not null
) ;
-- dmap_object_gen_tag : type : alter table name : nmloproc_sdw
set search_path = usrsiho,oracle,dmap_extension,public;
alter table nmloproc_sdw add constraint pk_nmloproc_sdw primary key (orderid2);
-- dmap_object_gen_tag : type : alter table name : nmloproc_sdw
set search_path = usrsiho,oracle,dmap_extension,public;
alter table nmloproc_sdw alter column orderid2 set not null;
