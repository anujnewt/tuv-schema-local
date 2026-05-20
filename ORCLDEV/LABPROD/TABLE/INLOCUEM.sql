-- dmap_object_gen_tag : type : table name : inlocuem
set search_path = labprod,oracle,dmap_extension,public;
create table "inlocuem"  (
cue_keyemp numeric(5),
cue_rfcemp varchar(14),
cue_fecdis timestamp(0),
cue_keycur varchar(8),
cue_keygpo numeric(5),
cue_status varchar(2),
cue_fecsta timestamp(0),
cue_ca1aux varchar(10),
cue_ca2aux varchar(10),
cue_ca3aux varchar(10)
) ;
