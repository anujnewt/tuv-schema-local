-- dmap_object_gen_tag : type : table name : nmwkpoli2
set search_path = labprod,oracle,dmap_extension,public;
create table "nmwkpoli2"  (
pol_keypro numeric(38),
pol_numcta varchar(30),
pol_descta varchar(30),
pol_impcar decimal(16, 2),
pol_impabo decimal(16, 2),
pol_keycia varchar(2),
pol_keypol varchar(10),
pol_keycon varchar(3),
pol_codacu numeric(38),
pol_import decimal(16, 2),
pol_keyver numeric(38)
) ;
