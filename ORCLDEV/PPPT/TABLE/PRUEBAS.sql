-- dmap_object_gen_tag : type : table name : pruebas
set search_path = pppt,oracle,dmap_extension,public;
create table "pruebas"  (
idprueba numeric(38) not null,
prueba varchar(50),
bincluye numeric(1),
bpondera numeric(1),
bperfila numeric(1),
binterpreta numeric(1),
secuencia numeric(38),
activa numeric(1),
descripcion varchar(4000),
bautoservicio numeric(1)
) ;
-- dmap_object_gen_tag : type : alter table name : pruebas
set search_path = pppt,oracle,dmap_extension,public;
alter table pruebas alter column idprueba set not null;
