-- dmap_object_gen_tag : type : table name : tmppprepgen
set search_path = labppto,oracle,dmap_extension,public;
create table "tmppprepgen"  (
tmp_keycia varchar(4),
tmp_keyver numeric(38),
tmp_keycon numeric(38),
tmp_descon varchar(35),
tmp_ene decimal(20, 2),
tmp_feb decimal(20, 2),
tmp_mar decimal(20, 2),
tmp_abr decimal(20, 2),
tmp_may decimal(20, 2),
tmp_jun decimal(20, 2),
tmp_jul decimal(20, 2),
tmp_ago decimal(20, 2),
tmp_sep decimal(20, 2),
tmp_oct decimal(20, 2),
tmp_nov decimal(20, 2),
tmp_dic decimal(20, 2),
fecha_proc varchar(6),
hora_proc varchar(6)
) ;
