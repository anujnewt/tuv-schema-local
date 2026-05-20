-- dmap_object_gen_tag : type : table name : glcofval
set search_path = labconf,oracle,dmap_extension,public;
create table "glcofval"  (
fva_keyfmt varchar(10),
fva_val001 varchar(16),
fva_val002 varchar(16),
fva_keyent varchar(14),
fva_valent varchar(255),
fva_numren numeric(5),
fva_numcol numeric(5)
) ;
