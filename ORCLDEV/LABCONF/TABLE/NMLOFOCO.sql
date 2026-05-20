-- dmap_object_gen_tag : type : table name : nmlofoco
set search_path = labconf,oracle,dmap_extension,public;
create table "nmlofoco"  (
foc_keyfor varchar(16),
foc_forcon varchar(3),
foc_nomfoc varchar(20),
foc_aplica varchar(1),
foc_numsec numeric(5),
foc_ideuno varchar(2),
foc_varuno varchar(40),
foc_operad varchar(2),
foc_idedos varchar(2),
foc_vardos varchar(40),
foc_opeaux varchar(2),
foc_parabi varchar(15),
foc_parcer varchar(15)
) ;
