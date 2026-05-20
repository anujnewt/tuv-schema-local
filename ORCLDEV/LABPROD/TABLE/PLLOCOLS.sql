-- dmap_object_gen_tag : type : table name : pllocols
set search_path = labprod,oracle,dmap_extension,public;
create table "pllocols"  (
col_keycol varchar(5),
col_keyrub varchar(5),
col_descol varchar(40),
col_tipcol varchar(1),
col_natcol varchar(1),
col_format varchar(1),
col_consol varchar(1)
) ;
