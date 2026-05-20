-- dmap_object_gen_tag : type : type name : array_tblob
set search_path = xxmor,oracle,dmap_extension,public;
create type "array_tblob"  as (array_tblob bytea[255]);
