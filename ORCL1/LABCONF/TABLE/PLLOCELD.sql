-- dmap_object_gen_tag : type : table name : plloceld
set search_path = labconf,oracle,dmap_extension,public;
create table "plloceld"  (
cel_keyhoj varchar(5),
cel_keycol varchar(10),
cel_keycon varchar(10),
cel_fbase varchar(250),
cel_freal varchar(250),
cel_fpres varchar(250),
cel_fesp varchar(250),
cel_msknu1 varchar(15),
cel_msknu2 varchar(15),
cel_islock numeric(1)
) ;
