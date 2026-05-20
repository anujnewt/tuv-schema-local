-- dmap_object_gen_tag : type : table name : nmreltab
set search_path = labprod,oracle,dmap_extension,public;
create table "nmreltab"  (
rel_keypro numeric(3),
rel_idetab varchar(5),
rel_essind varchar(1)
) ;
