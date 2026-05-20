-- dmap_object_gen_tag : type : table name : ppto_tmp
set search_path = labppto,oracle,dmap_extension,public;
create table "ppto_tmp"  (
tmp_keycia varchar(4),
tmp_keyver numeric(38),
tmp_keyemp numeric(38),
tmp_keycon numeric(38),
mes decimal(38, 2),
tmp_ene decimal(20, 2),
fecha_proc varchar(6),
hora_proc varchar(6)
) ;
