-- dmap_object_gen_tag : type : table name : encsolact
set search_path = usrsiho,oracle,dmap_extension,public;
create table "encsolact"  (
esa_numsol numeric(10),
esa_keydep varchar(16),
esa_nomresp varchar(60),
esa_fecsol timestamp(0),
esa_fecgra timestamp(0),
esa_fecair timestamp(0),
esa_observ varchar(255),
esa_obscar varchar(255),
esa_keyusu varchar(20),
esa_stssol numeric(10),
esa_cdcori varchar(16),
esa_desori varchar(60)
) ;
