-- dmap_object_gen_tag : type : table name : bmb2_pruebasabc
set search_path = pppt,oracle,dmap_extension,public;
create table "bmb2_pruebasabc"  (
idpruebaabc numeric(38) not null,
nombre varchar(50)
) ;
-- dmap_object_gen_tag : type : alter table name : bmb2_pruebasabc
set search_path = pppt,oracle,dmap_extension,public;
alter table bmb2_pruebasabc alter column idpruebaabc set not null;
