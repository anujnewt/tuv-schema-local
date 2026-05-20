-- dmap_object_gen_tag : type : table name : inlocurs
set search_path = labprod,oracle,dmap_extension,public;
create table "inlocurs"  (
cur_keycur varchar(8),
cur_descur varchar(40),
cur_descor varchar(16),
cur_tipcur varchar(2),
cur_subtip varchar(3),
cur_fecvig timestamp(0),
cur_objesp varchar(1),
cur_objgen varchar(1),
cur_observ varchar(40),
cur_nu1aux varchar(10),
cur_nu2aux varchar(10),
cur_nu3aux varchar(10)
) ;
