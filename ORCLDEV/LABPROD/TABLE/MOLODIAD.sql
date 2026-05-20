-- dmap_object_gen_tag : type : table name : molodiad
set search_path = labprod,oracle,dmap_extension,public;
create table "molodiad"  (
dia_keyemp numeric(10),
dia_keycon varchar(10),
dia_diader numeric(10),
dia_fecini timestamp(0),
dia_feccad timestamp(0),
dia_diaant decimal(10, 2),
dia_keyusu numeric(10),
dia_fecact timestamp(0),
dia_diasal decimal(10, 2),
dia_numani numeric(10)
) ;
