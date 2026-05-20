-- dmap_object_gen_tag : type : table name : glcocaes
set search_path = usrsiho,oracle,dmap_extension,public;
create table "glcocaes"  (
cae_keyest varchar(2),
cae_desest varchar(40),
cae_aux001 varchar(10),
cae_aux002 varchar(10),
cae_fecmod timestamp(0),
cae_keyusu numeric(10)
) ;
