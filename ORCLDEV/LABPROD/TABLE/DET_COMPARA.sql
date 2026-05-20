-- dmap_object_gen_tag : type : table name : det_compara
set search_path = labprod,oracle,dmap_extension,public;
create table "det_compara"  (
id_comp numeric(38),
cve_cuenta varchar(20),
importe decimal(14, 2)
) ;
