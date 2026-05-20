-- dmap_object_gen_tag : type : table name : cuentas
set search_path = labprod,oracle,dmap_extension,public;
create table "cuentas"  (
proceso numeric(38),
periodo varchar(7),
nomina numeric(38),
compania varchar(4),
concepto varchar(3),
cuenta varchar(20),
cuentacos varchar(20)
) ;
