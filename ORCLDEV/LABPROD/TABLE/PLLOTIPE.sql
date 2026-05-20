-- dmap_object_gen_tag : type : table name : pllotipe
set search_path = labprod,oracle,dmap_extension,public;
create table "pllotipe"  (
tip_keytip numeric(2),
tip_destip varchar(20),
tip_period numeric(5),
tip_perbas numeric(10),
tip_agrega varchar(2)
) ;
