-- dmap_object_gen_tag : type : table name : nmloapov
set search_path = labprod,oracle,dmap_extension,public;
create table "nmloapov"  (
apo_keyemp numeric(10),
apo_tipmov varchar(1),
apo_fecmov timestamp(0),
apo_mesliq varchar(6),
apo_apovol decimal(12, 6)
) ;
