-- dmap_object_gen_tag : type : table name : glcodocu
set search_path = labprod,oracle,dmap_extension,public;
create table "glcodocu"  (
doc_keydoc numeric(10),
doc_keytab varchar(18),
doc_campo1 varchar(16),
doc_campo2 varchar(16),
doc_keyuno varchar(16),
doc_keydos varchar(16),
doc_fecact timestamp(0),
doc_keyusu numeric(10)
) ;
