-- dmap_object_gen_tag : type : table name : puestopruebasgeneral
set search_path = pppt,oracle,dmap_extension,public;
create table "puestopruebasgeneral"  (
idpuesto numeric(38) not null,
idprueba numeric(38) not null,
peso numeric(38)
) ;
-- dmap_object_gen_tag : type : alter table name : puestopruebasgeneral
set search_path = pppt,oracle,dmap_extension,public;
alter table puestopruebasgeneral alter column idpuesto set not null;
-- dmap_object_gen_tag : type : alter table name : puestopruebasgeneral
set search_path = pppt,oracle,dmap_extension,public;
alter table puestopruebasgeneral alter column idprueba set not null;
