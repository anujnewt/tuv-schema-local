-- dmap_object_gen_tag : type : table name : nmwkhism
set search_path = labconf,oracle,dmap_extension,public;
create table "nmwkhism"  (
his_keypro numeric(5),
his_keyemp numeric(10),
his_keycon varchar(3),
his_codimp varchar(2),
his_keyper varchar(7),
his_cantid decimal(16, 2),
his_import decimal(16, 2),
his_idepcc varchar(15)
) ;
