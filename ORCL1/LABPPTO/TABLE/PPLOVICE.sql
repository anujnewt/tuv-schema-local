-- dmap_object_gen_tag : type : table name : pplovice
set search_path = labppto,oracle,dmap_extension,public;
create table "pplovice"  (
vic_keycia varchar(4) not null,
vic_keyvic numeric(38) not null,
vic_descri varchar(60) not null,
vic_nomres varchar(35) not null,
vic_keyame numeric(38) not null
) ;
-- dmap_object_gen_tag : type : alter table name : pplovice
set search_path = labppto,oracle,dmap_extension,public;
alter table pplovice alter column vic_keycia set not null;
-- dmap_object_gen_tag : type : alter table name : pplovice
set search_path = labppto,oracle,dmap_extension,public;
alter table pplovice alter column vic_keyvic set not null;
-- dmap_object_gen_tag : type : alter table name : pplovice
set search_path = labppto,oracle,dmap_extension,public;
alter table pplovice alter column vic_descri set not null;
-- dmap_object_gen_tag : type : alter table name : pplovice
set search_path = labppto,oracle,dmap_extension,public;
alter table pplovice alter column vic_nomres set not null;
-- dmap_object_gen_tag : type : alter table name : pplovice
set search_path = labppto,oracle,dmap_extension,public;
alter table pplovice alter column vic_keyame set not null;
