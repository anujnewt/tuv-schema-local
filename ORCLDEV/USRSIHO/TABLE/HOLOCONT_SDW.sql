-- dmap_object_gen_tag : type : table name : holocont_sdw
set search_path = usrsiho,oracle,dmap_extension,public;
create table "holocont_sdw"  (
marca_act varchar(2),
cmd varchar(15),
old_con_keyemp numeric(10),
old_con_fecini timestamp(0),
old_con_fecven timestamp(0),
old_con_keydep varchar(16),
old_con_keypue varchar(16),
new_con_keyemp numeric(10),
new_con_fecini timestamp(0),
new_con_fecven timestamp(0),
new_con_keydep varchar(16),
new_con_keypue varchar(16),
orderid1 timestamp(0),
orderid2 numeric(10) not null
) ;
-- dmap_object_gen_tag : type : alter table name : holocont_sdw
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holocont_sdw add constraint pk_holocont_sdw primary key (orderid2);
-- dmap_object_gen_tag : type : alter table name : holocont_sdw
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holocont_sdw alter column orderid2 set not null;
