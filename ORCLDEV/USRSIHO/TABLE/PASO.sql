-- dmap_object_gen_tag : type : table name : paso
set search_path = usrsiho,oracle,dmap_extension,public;
create table "paso"  (
pas_modulo varchar(20),
pas_nomrep varchar(15),
pas_idepcc varchar(15),
pas_keyusu numeric(10),
pas_variab varchar(10),
pas_observ varchar(40)
) ;
