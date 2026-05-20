-- dmap_object_gen_tag : type : table name : glcoqrys
set search_path = usrsiho,oracle,dmap_extension,public;
create table "glcoqrys"  (
qry_keycno varchar(8),
qry_querys varchar(2000),
qry_idepcc varchar(15),
qry_impdet numeric(5)
) ;
