-- dmap_object_gen_tag : type : table name : holocusi
set search_path = usrsiho,oracle,dmap_extension,public;
create table "holocusi"  (
cus_keyemp numeric(10) not null,
cus_keypue varchar(16) not null,
cus_keycen varchar(16) not null,
cus_porcen numeric(10),
cus_keysec varchar(4),
cus_import decimal(16, 2)
) ;
-- dmap_object_gen_tag : type : alter table name : holocusi
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holocusi alter column cus_keyemp set not null;
-- dmap_object_gen_tag : type : alter table name : holocusi
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holocusi alter column cus_keypue set not null;
-- dmap_object_gen_tag : type : alter table name : holocusi
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holocusi alter column cus_keycen set not null;
