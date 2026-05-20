-- dmap_object_gen_tag : type : table name : ps_tpw_msgxconcs
set search_path = labconf,oracle,dmap_extension,public;
create table "ps_tpw_msgxconcs"  (
msgs_keypro numeric(38),
msgs_keyper varchar(7),
msgs_keycon char(3),
msgs_tipocon numeric(5)
) ;
