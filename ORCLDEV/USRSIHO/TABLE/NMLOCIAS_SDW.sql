-- dmap_object_gen_tag : type : table name : nmlocias_sdw
set search_path = usrsiho,oracle,dmap_extension,public;
create table "nmlocias_sdw"  (
marca_act varchar(2),
cmd varchar(15),
old_cia_keycia varchar(16),
old_cia_descia varchar(40),
new_cia_keycia varchar(16),
new_cia_descia varchar(40),
orderid1 timestamp(0),
orderid2 numeric(10) not null
) ;
-- dmap_object_gen_tag : type : alter table name : nmlocias_sdw
set search_path = usrsiho,oracle,dmap_extension,public;
alter table nmlocias_sdw add constraint pk_nmlocias_sdw primary key (orderid2);
-- dmap_object_gen_tag : type : alter table name : nmlocias_sdw
set search_path = usrsiho,oracle,dmap_extension,public;
alter table nmlocias_sdw alter column orderid2 set not null;
