-- dmap_object_gen_tag : type : table name : tmpconrec
set search_path = usrsiho,oracle,dmap_extension,public;
create table "tmpconrec"  (
rec_keypro numeric(5),
rec_keyper varchar(7),
rec_keynom numeric(5),
rec_keycon varchar(3),
rec_codimp varchar(2),
rec_numrec varchar(10),
rec_agrupa varchar(10),
rec_secuen varchar(10),
rec_subtpo numeric(5),
rec_strcon varchar(300)
) ;
