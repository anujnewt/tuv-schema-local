-- dmap_object_gen_tag : type : table name : nmlococo
set search_path = labconf,oracle,dmap_extension,public;
create table "nmlococo"  (
coc_keycfg varchar(5),
coc_etqcol varchar(16),
coc_numcol numeric(5),
coc_numren numeric(5),
coc_keycon varchar(3)
) ;
