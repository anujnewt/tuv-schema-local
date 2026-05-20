-- dmap_object_gen_tag : type : table name : nmwkpoli
set search_path = usrsiho,oracle,dmap_extension,public;
create table "nmwkpoli"  (
pol_keypro numeric(5),
pol_numcta varchar(20),
pol_descta varchar(30),
pol_impcar decimal(16, 2),
pol_impabo decimal(16, 2),
pol_keycia varchar(2),
pol_keypol varchar(10),
pol_keycon varchar(3),
pol_codacu numeric(10),
pol_import decimal(16, 2),
pol_keyver numeric(5)
) ;
