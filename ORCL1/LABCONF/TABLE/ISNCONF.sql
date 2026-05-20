-- dmap_object_gen_tag : type : table name : isnconf
set search_path = labconf,oracle,dmap_extension,public;
create table "isnconf"  (
idconfig numeric(10),
con_anio numeric(4),
con_keyent varchar(2),
con_keycon varchar(3),
con_tipcon numeric(10),
con_tipope varchar(1)
) ;
